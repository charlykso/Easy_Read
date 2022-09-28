using API.DataAccess;
using API.Models;
using API.Repo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http.Headers;
using Newtonsoft.Json;
using API.Collectives;

namespace API.Controllers
{
  [Route("api/[controller]")]
  [ApiController]
  [Authorize]
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
    }

    //[Authorize(Roles = "Admin")]
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

    //[Authorize(Roles = "Admin")]
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

    [AllowAnonymous]
    //api/user/verifyUser
    [HttpPost("VerifyUser")]
    public ActionResult VerifyUserPhone([FromForm] UserModel newUser)
    {
      try
      {
        if (ModelState.IsValid)
        {
          //verify the users phone number to see if it's in DB and send verification code if it's not
          var phoneExist = _iUser!.CheckPhone(newUser.Phone_no!);
          if (phoneExist == "Not Exist")
          {
            var code = new VeriffyPhoneNo();
            var dCode = code.verifyPhone(newUser.Phone_no!);

            if (dCode == "Request not sent")
            {
              return BadRequest("Request not sent");
            }
            //if the code is sent return the code
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

    [AllowAnonymous]
    //api/user/createuser
    [HttpPost("CreateUser")]
    public ActionResult CreateUser([FromForm] UserModel newUser)
    {//after verifying the user phone number we create the user and store the details in the DB
      try
      {
        var user = new User();
        user.Firstname = newUser.Firstname;
        user.Lastname = newUser.Lastname;
        user.Email = newUser.Email;
        user.Phone_no = newUser.Phone_no;
        var newUser_password = BCrypt.Net.BCrypt.HashPassword(newUser.Password);
        user.Password = newUser_password;
        if(newUser.Role == null)
        {
          user.Role = " User";
        }else{
          user.Role = newUser.Role;
        }
        user.Created_at = DateTime.Now;

        _iUser!.CreateUser(user);
        //when the user is created generate JWT token for the user and return the token
        var newToken = new GenerateToken(_IConfig);
        var token = newToken.GenerateTokenForUser(user);
        return Ok(token);
      }
      catch (System.Exception ex)
      {
        return BadRequest(ex.Message);
      }
    }

    // [AllowAnonymous]
    //api/user/UpdateUser
    [HttpPut("UpdateUser/{Id}")]
    public ActionResult UpdateUser(int Id, [FromForm]UpdateUserModel editUser)
    {
      try
      {
        if (Id <= 0)
        {
          return BadRequest("invalid Id");
        }
        var user = _iUser!.GetUser(Id);
        if (user is null)
        {
            return NotFound($"No user found with the id {Id}");
        }else
        {
          user.Firstname = editUser.Firstname;
          user.Lastname = editUser.Lastname;
          user.Email = editUser.Email;
          user.Role = editUser.Role;
          user.Updated_at = DateTime.Now;
        }

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
    {//the google auth token is passed through the form
      var token = GetToken.Token;
      try
      {
        //this is the uri
        var request = new HttpRequestMessage(HttpMethod.Get, "https://www.googleapis.com/oauth2/v2/userinfo");
        //create an an instance of IHttpclientFactory
        var client = _ClientFactory.CreateClient();
        //add the auth token to the header
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        //send request and get the respond
        HttpResponseMessage response = await client.SendAsync(request, HttpCompletionOption.ResponseHeadersRead);
        //check if the respond status is successful
        if (response.StatusCode == System.Net.HttpStatusCode.OK)
        {
          //convert the respond to string
          var apiString = await response.Content.ReadAsStringAsync();
          //deserialize it to json object
          var Guser = JsonConvert.DeserializeObject<GoogleAuth>(apiString);
          //Console.WriteLine(Guser!.email);
          //check if the email is in DB
          var userEmail = _iUser!.CheckEmail(Guser!.email!);
          if (userEmail == "NOT EXIST")
          {
            //if it's not in the DB we create a user
            var user = new User();
            user.Email = Guser.email;
            user.Firstname = Guser.given_name;
            user.Lastname = Guser.family_name;
            user.Role = "User";
            user.Created_at = DateTime.Now;
            try
            {
              _iUser.CreateUser(user);
              var newToken = new GenerateToken(_IConfig);
              var JwtToken = newToken.GenerateTokenForSocialUser(user);

              return Ok(new
                    {
                        token = JwtToken,
                        FirstName = user.Firstname,
                        LastName = user.Lastname,
                        Role = user.Role,
                        Email = user.Email,

                    });
            }
            catch (System.Exception ex1)
            {
              return BadRequest(ex1.Message);
            }
          }
          else
          {
            //if the user email is already in the DB, get the user details and generate a signin token for the user
            var newUser = _iUser.GetUserByMail(Guser.email!);
            var newToken = new GenerateToken(_IConfig);
            var JwtToken = newToken.GenerateTokenForSocialUser(newUser);
            
             return Ok(new
                    {
                        token = JwtToken,
                        FirstName = newUser.Firstname,
                        LastName = newUser.Lastname,
                        Role = newUser.Role,
                        Email = newUser.Email,

                    });
          }
        }
        return BadRequest("Unautorized");
      }
      catch (System.Exception ex)
      {
        
        return BadRequest(ex.Message);
      }
       
    }


    [AllowAnonymous]
    //api/user/FacebookAuth
    [HttpPost("FacebookAuth")]
    public async Task<IActionResult> FacebookAuth([FromForm] SocialMediaToken GetToken)
    {
      //get the facebook auth token
      var token = GetToken.Token;
      try
      {
        //set the uri and add the token
        var request = new HttpRequestMessage(HttpMethod.Get, $"https://graph.facebook.com/me?fields=id,name,email&access_token={token}");
        //create an instance of IHttpClientFactory
        var client = _ClientFactory.CreateClient();
        //use the instance of IHttpClientFactory to send the quest and get the response
        HttpResponseMessage response = await client.SendAsync(request, HttpCompletionOption.ResponseHeadersRead);
        //check if the response is success or not
        if (response.StatusCode == System.Net.HttpStatusCode.OK)
        {
          //convert the respone to a string
          var apiString = await response.Content.ReadAsStringAsync();
          //deserialize it to json object
          var Fuser = JsonConvert.DeserializeObject<FacebookAuth>(apiString);
          //Console.WriteLine(Fuser!.email);
          //check if the user email is in DB
          var userEmail = _iUser!.CheckEmail(Fuser!.email!);
          if (userEmail == "NOT EXIST")
          {//split the full name into firstname and lastname
            string fullName = Fuser.name!;
            string[] Name = fullName.Split(" ");
          
            var user = new User();
            user.Email = Fuser.email;
            user.Firstname = Name[0];
            user.Lastname = Name[1];
            user.Role = "User";
            user.Created_at = DateTime.Now;
            try
            {
              _iUser.CreateUser(user);
              var newToken = new GenerateToken(_IConfig);
              var JwtToken = newToken.GenerateTokenForSocialUser(user);

              return Ok(new
                    {
                        token = JwtToken,
                        FirstName = user.Firstname,
                        LastName = user.Lastname,
                        Role = user.Role,
                        Email = user.Email,

                    });
              
            }
            catch (System.Exception ex1)
            {
              
              return BadRequest(ex1.Message);
            }
            
          }
          else
            {
              //if the user email is already in the DB get the user and generate login token
              var newUser = _iUser.GetUserByMail(Fuser.email!);
              var newToken = new GenerateToken(_IConfig);
              var JwtToken = newToken.GenerateTokenForSocialUser(newUser);
              return Ok(JwtToken);
              return Ok(new
                    {
                        token = JwtToken,
                        FirstName = newUser.Firstname,
                        LastName = newUser.Lastname,
                        Role = newUser.Role,
                        Email = newUser.Email,

                    });
            }
        }
        return BadRequest("Unautorized");
      }
      catch (System.Exception ex)
      {
        
        return BadRequest(ex.Message);
      }

    }


    //[Authorize(Roles = "Admin")]
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