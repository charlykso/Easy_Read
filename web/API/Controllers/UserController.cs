using System;
using API.DataAccess;
using API.Models;
using API.Repo;
using Google.Apis.Auth;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Google;
using System.Net.Http.Headers;
using Newtonsoft.Json;

namespace API.Controllers
{
  [Route("api/[controller]")]
  [ApiController]
  //[Authorize(Roles = "Admin")]
  public class UserController : ControllerBase
  {
    private readonly IUser? _iUser;
    private readonly IHttpClientFactory _ClientFactory;
    private readonly IConfiguration _IConfig;

    public UserController(IUser iUser, IConfiguration IConfig, IHttpClientFactory ClientFactory)
    {
      _iUser = iUser;
      _IConfig = IConfig;
      _ClientFactory = ClientFactory;
      // _jwtGenerator = new JwtGenerator(_IConfig.GetValue<string>("JwtPrivateSigningKey"));
    }

    //api/user/GetAllUsers
    [HttpGet("GetAllUsers")]
    public ActionResult GetAllUsers()
    {
      try
      {
        var users = _iUser!.GetAllUsers().ToList();

        return Ok(users);
      }
      catch (System.Exception ex)
      {
        return BadRequest(ex.Message);
      }
    }

    //api/user/GetUser/Id
    [HttpGet("GetUser/{Id}")]
    public ActionResult<UserModel> GetUser(int Id)
    {
      try
      {
        var user = _iUser!.GetUser(Id);
        return Ok(user);
      }
      catch (System.Exception ex)
      {
        return BadRequest(ex.Message);
      }
    }

    //api/user/verifyUser
    [HttpPost("VerifyUser")]
    public ActionResult VerifyUserPhone([FromForm] UserModel newUser)
    {
      try
      {
        if (ModelState.IsValid)
        {
          var phoneExist = _iUser!.CheckPhone(newUser.Phone_no!);
          if (phoneExist == "Not Exist")
          {
            var code = new VeriffyPhoneNo();
            var dCode = code.verifyPhone(newUser.Phone_no!);

            if (dCode == "Request not sent")
            {
              return BadRequest("Request not sent");
            }
            return Ok(dCode);
          }
          return BadRequest("The phone number already exist");
        }
        return BadRequest("Invalid input format");
      }
      catch (System.Exception ex)
      {

        return BadRequest(ex.Message);
      }
    }

    //api/user/createuser
    [HttpPost("CreateUser")]
    public ActionResult CreateUser([FromForm] UserModel newUser)
    {
      try
      {
        var user = new User();
        user.Firstname = newUser.Firstname;
        user.Lastname = newUser.Lastname;
        user.Email = newUser.Email;
        user.Phone_no = newUser.Phone_no;
        var newUser_password = BCrypt.Net.BCrypt.HashPassword(newUser.Password);
        user.Password = newUser_password;
        user.Role = newUser.Role;
        user.Created_at = DateTime.Now;

        _iUser!.CreateUser(user);
        var newToken = new GenerateToken(_IConfig);
        var token = newToken.GenerateTokenForUser(user);
        return Ok(token);
      }
      catch (System.Exception ex)
      {

        return BadRequest(ex.Message);
      }
    }

    //api/user/UpdateUser
    [HttpPut("UpdateUser/{Id}")]
    public ActionResult UpdateUser(int Id, [FromBody] UpdateUserModel editUser)
    {
      try
      {
        if (Id <= 0)
        {
          return BadRequest("invalid Id");
        }
        var user = _iUser!.GetUser(Id);
        user.Firstname = editUser.Firstname;
        user.Lastname = editUser.Lastname;
        user.Email = editUser.Email;
        user.Role = editUser.Role;
        var editUser_pass = BCrypt.Net.BCrypt.HashPassword(editUser.Password);
        user.Password = editUser_pass;
        user.Updated_at = DateTime.Now;

        try
        {
          _iUser.UpdateUser(Id, user);
          return Ok(user);
        }
        catch (System.Exception ex1)
        {

          return BadRequest(ex1.Message);
        }
      }
      catch (System.Exception ex)
      {
        return BadRequest(ex.Message);
      }
    }

    [AllowAnonymous]
    //api/user/googleauth
    [HttpPost("GoogleAuth")]
    public async Task<IActionResult> GoogleAuth([FromForm] SocialMediaToken GetToken)
    {
      var token = GetToken.Token;
      try
      {
          var request = new HttpRequestMessage(HttpMethod.Get, "https://www.googleapis.com/oauth2/v2/userinfo");
          var client = _ClientFactory.CreateClient();
          request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
          HttpResponseMessage response = await client.SendAsync(request, HttpCompletionOption.ResponseHeadersRead);
          if (response.StatusCode == System.Net.HttpStatusCode.OK)
          {
              var apiString = await response.Content.ReadAsStringAsync();
              var Guser = JsonConvert.DeserializeObject<GoogleAuth>(apiString);
              Console.WriteLine(Guser!.email);
              var userEmail = _iUser!.CheckEmail(Guser.email!);
              if (userEmail == "NOT EXIST")
              {
                var user = new User();
                user.Email = Guser.email;
                user.Firstname = Guser.given_name;
                user.Lastname = Guser.family_name;
                user.Phone_no = "+2349078563432";
                var gUser_pass = BCrypt.Net.BCrypt.HashPassword(Guser.family_name);
                user.Password = gUser_pass;
                user.Role = "User";
                user.Created_at = DateTime.Now;
                try
                {
                  _iUser.CreateUser(user);
                  var newToken = new GenerateToken(_IConfig);
                  var JwtToken = newToken.GenerateTokenForSocialUser(user);

                  return Ok(JwtToken);
                }
                catch (System.Exception ex1)
                {
                  
                  return BadRequest(ex1.Message);
                }
                
              }
              else
              {
                var newUser = _iUser.GetUserByMail(Guser.email!);
                var newToken = new GenerateToken(_IConfig);
                var JwtToken = newToken.GenerateTokenForSocialUser(newUser);
                return Ok(JwtToken);
              }
          }
          return BadRequest("Unautorized");
      }
      catch (System.Exception ex)
      {
        
        return BadRequest(ex.Message);
      }
       
    }



    //api/user/DeleteUser/Id
    [HttpDelete("DeleteUser/{Id}")]
    public ActionResult DeleteUser(int Id)
    {
      try
      {
        var user = _iUser!.GetUser(Id);


        if (user is null)
        {
          return NotFound($"User with the id {Id} not found");
        }

        try
        {
          _iUser.DeleteUser(Id);
          return Ok("User deleted successfuly");
        }
        catch (System.Exception ex1)
        {

          return NotFound(ex1.Message);
        }
      }
      catch (System.Exception ex)
      {

        return BadRequest(ex.Message);
      }
    }
  }
}