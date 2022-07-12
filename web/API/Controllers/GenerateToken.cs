using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using API.Models;
using Microsoft.IdentityModel.Tokens;

namespace API.Controllers
{
    public class GenerateToken
    {
        private readonly IConfiguration? _IConfig;
        public GenerateToken(IConfiguration IConfig)
        {
            _IConfig = IConfig;
        }
        public String GenerateTokenForUser(User user)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_IConfig!["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var Claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, user!.Id!.ToString()!),
                new Claim(ClaimTypes.Name, user!.Firstname!),
                new Claim(ClaimTypes.GivenName, user!.Lastname!),
                new Claim(ClaimTypes.Email, user!.Email!),
                new Claim(ClaimTypes.Hash, user!.Password!)
            };
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(Claims),
                Expires = DateTime.Now.AddHours(1),
                SigningCredentials = credentials,
                Issuer = _IConfig["Jwt: Issuer"],
                Audience = _IConfig["Jwt: Audience"]
            };

            var tokenHandler = new JwtSecurityTokenHandler();

            var token = tokenHandler.CreateToken(tokenDescriptor);

            return new JwtSecurityTokenHandler().WriteToken(token);

        }
    }
}