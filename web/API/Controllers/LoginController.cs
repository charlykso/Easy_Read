using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using API.DataAccess;
using API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LoginController: ControllerBase
    {
        private readonly IConfiguration? _IConfig;
        private readonly EasyReaderDBContext? _EasyReadContext;
        public LoginController(EasyReaderDBContext EasyReadContext, IConfiguration IConfig)
        {
            _EasyReadContext = EasyReadContext;
            _IConfig = IConfig;
        }

        [AllowAnonymous]
        [HttpPost]
        //api/login
        public IActionResult Login([FromBody] UserLoginModel userLogin)
        {
            try
            {
                var logUser = AuthenticateUser(userLogin);

                if (logUser != null)
                {
                    var newtoken = new GenerateToken(_IConfig!);
                    var token = newtoken.GenerateTokenForUser(logUser);

                    return Ok(token);
                }

                return NotFound("User not found");
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

        // private string GenerateTokenForUser(User user)
        // {
        //     var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_IConfig!["Jwt:Key"]));
        //     var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

        //     var Claims = new[]
        //     {
        //         new Claim(ClaimTypes.NameIdentifier, user!.Id!.ToString()!),
        //         new Claim(ClaimTypes.Name, user!.Firstname!),
        //         new Claim(ClaimTypes.GivenName, user!.Lastname!),
        //         new Claim(ClaimTypes.Role, user!.Role!),
        //         new Claim(ClaimTypes.Email, user!.Email!),
        //         new Claim(ClaimTypes.Hash, user!.Password!)
        //     };
        //     var tokenDescriptor = new SecurityTokenDescriptor
        //     {
        //         Subject = new ClaimsIdentity(Claims),
        //         Expires = DateTime.Now.AddHours(1),
        //         SigningCredentials = credentials,
        //         Issuer = _IConfig["Jwt: Issuer"],
        //         Audience = _IConfig["Jwt: Audience"]
        //     };

        //     var tokenHandler = new JwtSecurityTokenHandler();

        //     var token = tokenHandler.CreateToken(tokenDescriptor);

        //     return new JwtSecurityTokenHandler().WriteToken(token);
        // }

        private User AuthenticateUser(UserLoginModel userLogin)
        {
            try
            {
                var currentUser = _EasyReadContext!.Users.FirstOrDefault(u => 
                u.Phone_no == userLogin.Phone_no);
    
                if (currentUser != null && BCrypt.Net.BCrypt.Verify(userLogin.Password, currentUser.Password))
                {
                    return currentUser;
                }
                Console.WriteLine("User does not exist!");
                return null!;
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
                return null!;
            }
        }
    }
}