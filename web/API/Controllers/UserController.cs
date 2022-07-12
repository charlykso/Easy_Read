using System;
using API.DataAccess;
using API.Models;
using API.Repo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
  [Route("api/[controller]")]
  [ApiController]
  //[Authorize(Roles = "Admin")]
  public class UserController : ControllerBase
  {
    private readonly IUser? _iUser;
    private readonly IConfiguration _IConfig;
    public UserController(IUser iUser, IConfiguration IConfig)
    {
      _iUser = iUser;
      _IConfig = IConfig;
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