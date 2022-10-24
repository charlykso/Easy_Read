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
        public async void CreateBook(Book NewBook)
        {
            try
            {
                var book= await _easyReaderDBContext!.Books.AddAsync(NewBook);
                _easyReaderDBContext.SaveChanges();
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }

        public async void DeleteBook(int Id)
        {
            try
            {
                var book = await _easyReaderDBContext!.Books.FindAsync(Id);
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

        public async Task<IEnumerable<Book>> GetAllBooks()
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
                await Task.Delay(1000);
                return books;
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public async Task<Book> GetBook(int Id)
        {
            try
            {
                var book = await _easyReaderDBContext!.Books.Where(b => b.Id == Id)
                                                        .Include(buk => buk.Author)
                                                        .FirstAsync();
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

        public async void UpdateBook(int Id, Book EditBook)
        {
            try
            {
                var book = await _easyReaderDBContext!.Books.FindAsync(Id);

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