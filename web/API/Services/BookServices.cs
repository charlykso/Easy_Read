using System;
using API.Models;
using API.Repo;
using Microsoft.EntityFrameworkCore;

namespace API.Services
{
    public class BookServices : IBook
    {
        private readonly EasyReaderDBContext? _easyReaderDBContext;
        public BookServices(EasyReaderDBContext easyReaderDBContext)
        {
            _easyReaderDBContext = easyReaderDBContext;
        }
        public void CreateBook(Book NewBook)
        {
            try
            {
                var book= _easyReaderDBContext!.Books.Add(NewBook);
                _easyReaderDBContext.SaveChanges();
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }

        public void DeleteBook(int Id)
        {
            try
            {
                var book = _easyReaderDBContext!.Books.Find(Id);
                if (book != null)
                {
                    _easyReaderDBContext.Remove(book);
                    _easyReaderDBContext.SaveChanges();
                }
                Console.WriteLine($"No book found with the id {Id}");
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }

        public IEnumerable<Book> GetAllBooks()
        {
            
            try
            {
                var books = _easyReaderDBContext!.Books
                                                .Include(a => a.Author);
                if (books is null)
                {
                    if (books!.Count() == 0)
                    {
                        Console.WriteLine("No books registered in the database");
                        return null!;
                    }
                    Console.WriteLine("Please fill in valid information");
                    return null!;
                }
                return books;
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public Book GetBook(int Id)
        {
            try
            {
                var book = _easyReaderDBContext!.Books.Where(b => b.Id == Id)
                                                        .Include(buk => buk.Author)
                                                        .First();
                if (book is null)
                {
                    Console.WriteLine($"No book found with the id {Id}");
                    return null!;
                }
                return book;
            }
            catch (System.Exception ex)
            {

                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public void UpdateBook(int Id, Book EditBook)
        {
            try
            {
                var book = _easyReaderDBContext!.Books.Find(Id);

                if (book is null)
                {
                    Console.WriteLine($"No book found with the id {Id}");
                }
                _easyReaderDBContext.Books.Attach(book!);
                _easyReaderDBContext.SaveChanges();
                Console.WriteLine("Book Updated successfuly");
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }
    }
}