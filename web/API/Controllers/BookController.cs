using System;
using API.DataAccess;
using API.Models;
using API.Repo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Authorize(Roles = "Admin")]
    [ApiController]
    [Route("api/[controller]")]
    public class BookController : ControllerBase
    {
        private IConfiguration _iConfig;
        private readonly IBook? _iBook;
        public BookController(IBook iBook, IConfiguration iConfig)
        {
            _iBook = iBook;
            _iConfig = iConfig;
        }

        [Authorize]
        //api/book/GetBooks
        //api/book/GetAllBooks?sort=desc or asc&by=Title or price or pub_date&pageNumber=1&pageSize=5
        [HttpGet("GetAllBooks")]
        public async Task<ActionResult> GetAllBooks(string sort, string by, int? pageNumber, int? pageSize)
        {
            var currentPageNumber = pageNumber?? 1;
            var currentPageSize = pageSize?? 1000;
            try
            {
                var book = await _iBook!.GetAllBooks();


                if (by == "title")
                {
                    switch (sort)
                    {
                        case "desc":
                            return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize).OrderByDescending(b => b.Title));
                        case "asc":
                            return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize).OrderBy(b => b.Title));
                        default:
                            return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize));
                    }
                }else if (by == "price")
                {
                    switch (sort)
                    {
                        case "desc":
                            return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize).OrderByDescending(b => b.Price));
                        case "asc":
                            return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize).OrderBy(b => b.Price));
                        default:
                            return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize));
                    }
                }else if (by == "pub_year")
                {
                    switch (sort)
                    {
                        case "desc":
                            return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize).OrderByDescending(b => b.Publisher));
                        case "asc":
                            return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize).OrderBy(b => b.Publisher));
                        default:
                            return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize));
                    }
                }else
                {
                    switch (sort)
                        {
                            case "desc":
                                return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize).OrderByDescending(b => b.Title));
                            case "asc":
                                return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize).OrderBy(b => b.Title));
                            default:
                                return Ok(book.Skip((currentPageNumber - 1) * currentPageSize).Take(currentPageSize));
                        }
                }  
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }

        }

        [Authorize]
        //api/book/GetBook/Id
        [HttpGet("GetBook/{Id}")]
        public async Task<ActionResult> GetBook(int Id)
        {
            try
            {
                var book = await _iBook!.GetBook(Id);
                // var key = _iConfig["Enc:key"];
                // var mainBody = await StringEncryption.DecryptString(key, book.Body!);
                // Console.WriteLine(mainBody);

                return Ok(new{
                    Title = book.Title,
                    Sub_Title = book.Sub_Title,
                    Publisher = book.Publisher,
                    ISBN_Number = book.ISBN_Number,
                    Price = book.Price,
                    Front_Cover_Img_url = book.Front_Cover_Img_url,
                    Back_Cover_Img_url = book.Back_Cover_Img_url,
                    Body = book.Body,
                    AuthorId = book.AuthorId,
                    Created_at = book.Created_at,
                    YearOf_Publication = book.YearOf_Publication
                });
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

        [Authorize(Roles = "Admin")]
        //api/book/GetSingleBook/Id
        [HttpGet("GetSingleBook/{Id}")]
        public async Task<ActionResult> GetSingleBook(int Id)
        {
            try
            {
                var book = await _iBook!.GetBook(Id);
                var key = _iConfig["Enc:key"];
                var mainBody = await StringEncryption.DecryptString(key, book.Body!);
                // Console.WriteLine(mainBody);

                return Ok(new
                {
                    Title = book.Title,
                    Sub_Title = book.Sub_Title,
                    Publisher = book.Publisher,
                    ISBN_Number = book.ISBN_Number,
                    Price = book.Price,
                    Front_Cover_Img_url = book.Front_Cover_Img_url,
                    Back_Cover_Img_url = book.Back_Cover_Img_url,
                    Body = mainBody,
                    AuthorId = book.AuthorId,
                    Created_at = book.Created_at,
                    Author_name = book.Author!.Lastname + " " +book.Author!.Firstname,
                    YearOf_Publication = book.YearOf_Publication
                });
            }
            catch (System.Exception ex)
            {

                return BadRequest(ex.Message);
            }
        }
        

        [Authorize(Roles = "Admin")]
        //api/book/CreateBook
        [HttpPost("CreateBook")]
        public async Task<ActionResult> CreateBook([FromForm] BookModel newBook)
        {
            try
            {
                var first_guid = Guid.NewGuid();
                var first_filePath = Path.Combine("wwwroot/book_cover/", first_guid + ".jpg");
                var first_filestream = new FileStream(first_filePath, FileMode.Create);
                newBook.Front_Cover_Img!.CopyTo(first_filestream);

                var second_guid = Guid.NewGuid();
                var second_filePath = Path.Combine("wwwroot/book_cover/", second_guid + ".jpg");
                var second_filestream = new FileStream(second_filePath, FileMode.Create);
                newBook.Back_Cover_Img!.CopyTo(second_filestream);

                var book = new Book();
                book.Title = newBook.Title;
                book.Sub_Title = newBook.Sub_Title;
                book.Publisher = newBook.Publisher;
                book.ISBN_Number = newBook.ISBN_Number;
                book.Price = newBook.Price;
                book.Front_Cover_Img_url = first_filePath;
                book.Back_Cover_Img_url = second_filePath;
                var key = _iConfig["Enc:key"];
                var mainBody = await StringEncryption.EncryptString(key, newBook.Body!);
                book.Body = mainBody;
                book.AuthorId = newBook.AuthorId;
                book.Created_at = DateTime.Now;
                book.YearOf_Publication = newBook.YearOf_Publication;

                _iBook!.CreateBook(book);
                await Task.Delay(1000);
                return Ok("Book created successfuly!");
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Authorize(Roles = "Admin")]
        //api/book/UpdateBook/Id
        [HttpPut("UpdateBook/{Id}")]
        public async Task<ActionResult> UpdateBook(int Id, [FromForm] UpdateBookModel editBook)
        {
            try
            {
                var first_guid = Guid.NewGuid();
                var first_filePath = Path.Combine("wwwroot/book_cover", first_guid + ".jpg");
                var first_filestream = new FileStream(first_filePath, FileMode.Create);
                editBook.Front_Cover_Img!.CopyTo(first_filestream);

                var second_guid = Guid.NewGuid();
                var second_filePath = Path.Combine("wwwroot/book_cover", second_guid + ".jpg");
                var second_filestream = new FileStream(second_filePath, FileMode.Create);
                editBook.Back_Cover_Img!.CopyTo(second_filestream);

                var book = await _iBook!.GetBook(Id);
                book.Title = editBook.Title;
                book.Sub_Title = editBook.Sub_Title;
                book.Publisher = editBook.Publisher;
                book.ISBN_Number = editBook.ISBN_Number;
                book.Price = editBook.Price;
                book.Front_Cover_Img_url = first_filePath;
                book.Back_Cover_Img_url = second_filePath;
                book.Body = await StringEncryption.EncryptString(_iConfig["Enc: key"], editBook.Body!);
                book.Updated_at = DateTime.Now;
                book.YearOf_Publication = editBook.YearOf_Publication;

                _iBook!.UpdateBook(Id, book);
                return Ok("Book created successfuly!");
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

        [Authorize(Roles = "Admin")]
        //api/book/DeleteBook/Id
        [HttpDelete("DeleteBook/{Id}")]
        public async Task<ActionResult> DeleteBook(int Id)
        {
            try
            {
                var book = await _iBook!.GetBook(Id);
                if (book is null)
                {
                    return NotFound($"No book found with the id {Id}");
                }else
                {
                    _iBook.DeleteBook(Id);
                    return Ok("Book Deleted Successfuly!");
                }
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
