using API.DataAccess;
using API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

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

                    return Ok(new
                    {
                        token = token,
                        Id = logUser.Id,
                        Firstname = logUser.Firstname,
                        Lastname = logUser.Lastname,
                        Role = logUser.Role,
                        Email = logUser.Email,
                        Phone = logUser.Phone_no

                    });
                }

                return NotFound("User not found");
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }


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
