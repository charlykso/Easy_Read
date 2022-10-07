using System;
using API.DataAccess;
using API.Models;
using API.Repo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    // [Authorize(Roles = "Admin")]
    public class BookController : ControllerBase
    {
        private IConfiguration _iConfig;
        private readonly IBook? _iBook;
        public BookController(IBook iBook, IConfiguration iConfig)
        {
            _iBook = iBook;
            _iConfig = iConfig;
        }

        //api/book/GetBooks
        //api/book/GetAllBooks?sort=desc or asc&by=Title or price or pub_date&pageNumber=1&pageSize=5
        [HttpGet("GetAllBooks")]
        public ActionResult GetAllBooks(string sort, string by, int? pageNumber, int? pageSize)
        {
            var currentPageNumber = pageNumber?? 1;
            var currentPageSize = pageSize?? 5; 
            try
            {
                var book = _iBook!.GetAllBooks().ToList();


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

        //api/book/GetBook/Id
        [HttpGet("GetBook/{Id}")]
        public ActionResult GetBook(int Id)
        {
            try
            {
                var book = _iBook!.GetBook(Id);

                return Ok(book);
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

        //api/book/CreateBook
        [HttpPost("CreateBook")]
        public ActionResult CreateBook([FromForm] BookModel newBook)
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
                var mainBody = StringEncryption.EncryptString(key, newBook.Body!);
                book.Body = mainBody;
                book.AuthorId = newBook.AuthorId;
                book.Created_at = DateTime.Now;
                book.YearOf_Publication = newBook.YearOf_Publication;

                _iBook!.CreateBook(book);
                return Ok("Book created successfuly!");
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


        //api/book/UpdateBook/Id
        [HttpPut("UpdateBook/{Id}")]
        public ActionResult UpdateBook(int Id, [FromForm] UpdateBookModel editBook)
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

                var book = new Book();
                book.Title = editBook.Title;
                book.Sub_Title = editBook.Sub_Title;
                book.Publisher = editBook.Publisher;
                book.ISBN_Number = editBook.ISBN_Number;
                book.Price = editBook.Price;
                book.Front_Cover_Img_url = first_filePath;
                book.Back_Cover_Img_url = second_filePath;
                book.Body = StringEncryption.EncryptString(_iConfig["Enc: key"], editBook.Body!);
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

        //api/book/DeleteBook/Id
        [HttpDelete("DeleteBook/{Id}")]
        public ActionResult DeleteBook(int Id)
        {
            try
            {
                var book = _iBook!.GetBook(Id);
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