using System;
using API.DataAccess;
using API.Models;
using API.Repo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Authorize(Roles = "Admin")]
    [Route("api/[controller]")]
    [ApiController]
    public class AuthorController : ControllerBase
    {
        private readonly IAuthor? _iAuthor;
        private readonly EasyReaderDBContext? _eRDBContext;
        public AuthorController(IAuthor iAuthor, EasyReaderDBContext? eRDBContext)
        {
            _iAuthor = iAuthor;
            _eRDBContext = eRDBContext;
        }

        //api/Author/GetAllAuthors
        [HttpGet("GetAllAuthors")]
        public async Task<ActionResult> GetAllAuthors()
        {
            try
            {
                var author = await _iAuthor!.GetAllAuthors();
                if (author != null)
                {
                    return Ok(author);
                }
                return Ok("No author created yet.");
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        //api/author/GetAuthor/Id
        [HttpGet("GetAuthor/{Id}")]
        public async Task<ActionResult> GetAuthor(int Id)
        {
            try
            {
                var author = await _iAuthor!.GetAuthor(Id);
                if (author != null)
                {
                    return Ok(author);
                }
                return Ok($"No author witht the id {Id}");
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

        //api/author/CreateAuthor
        [HttpPost("CreateAuthor")]
        public async Task<ActionResult> CraeteAuthor([FromForm] AuthorModel newAuthor)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var phoneExist = _eRDBContext!.Authors.FirstOrDefault(p => p.Phone_no == newAuthor.Phone_no!);
                    if (phoneExist != null)
                    {
                        return BadRequest("Phone number already taken");
                    }
                    else{
                        if (newAuthor.Image != null)
                        {
                            var guid = Guid.NewGuid();
                            var filePath = Path.Combine("wwwroot/images/", guid + ".jpg");
                            var filestream = new FileStream(filePath, FileMode.Create);
                            newAuthor.Image.CopyTo(filestream);

                            var author = new Author();
                            author.Firstname = newAuthor.Firstname;
                            author.Lastname = newAuthor.Lastname;
                            author.Email = newAuthor.Email;
                            author.Date_of_birth = newAuthor.Date_of_birth;
                            author.Phone_no = newAuthor.Phone_no;
                            author.Gender = newAuthor.Gender;
                            author.ImageURL = filePath;
                            var newAuthor_pass = BCrypt.Net.BCrypt.HashPassword(newAuthor.Password);
                            author.Password = newAuthor_pass;
                            author.Created_at = DateTime.Now;

                            _iAuthor!.CreateAuthor(author);
                            await Task.Delay(1000);
                            return Created("Success", new { success = "Author created successfuly!"});
                        }
                        else
                        {
                            return BadRequest("Please enter Author's image");
                        }
                    }
                    
                }else
                {
                    return BadRequest("Please fill your information in correct format");
                }
                
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        //api/author/UpdateAuthor/Id
        [HttpPut("UpdateAuthor/{Id}")]
        public async Task<ActionResult> UpdateAuthor(int Id, [FromForm] UpdateAuthorModel editAuthor)
        {
            try
            {
                if (Id <= 0)
                {
                    return BadRequest("Invalid Id");
                }
                var author = await _iAuthor!.GetAuthor(Id);
                if (author is null)
                {
                    return NotFound($"No author found with the id {Id}");
                }else
                {
                    var guid = Guid.NewGuid();
                    var filePath = Path.Combine("wwwroot/images/", guid + ".jpg");
                    var filestream = new FileStream(filePath, FileMode.Create);
                    editAuthor.Image!.CopyTo(filestream);

                    author.Firstname = editAuthor.Firstname;
                    author.Lastname = editAuthor.Lastname;
                    author.Email = editAuthor.Email;
                    author.Date_of_birth = editAuthor.Date_of_birth;
                    author.Phone_no = editAuthor.Phone_no;
                    author.Gender = editAuthor.Gender;
                    author.ImageURL = filePath;
                    author.Updated_at = DateTime.Now;

                    _iAuthor.UpdateAuthor(Id, author);
                    return Ok("Author updated successfuly!");
                }

            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

        //api/author/DeleteAuthor/Id
        [HttpDelete("DeleteAuthor/{Id}")]
        public async Task<ActionResult> DeleteAuthor(int Id)
        {
            try
            {
                var author = await _iAuthor!.GetAuthor(Id);
                if (author is null)
                {
                    return NotFound($"No author found with the id {Id}");
                }else
                {
                    _iAuthor.DeleteAuthor(Id);
                    return Ok("Author Deleted Successfuly!");
                }
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

    }
}