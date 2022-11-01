using API.Models;
using API.Repo;
using Microsoft.EntityFrameworkCore;

namespace API.Services
{
    public class AuthourServices : IAuthor
    {
        private readonly EasyReaderDBContext? _easyReaderDBContext;
        public AuthourServices(EasyReaderDBContext easyReaderDBContext)
        {
            _easyReaderDBContext = easyReaderDBContext;
        }
        public async void CreateAuthor(Author NewAuthor)
        {
            try
            {
                var author = await _easyReaderDBContext!.Authors.AddAsync(NewAuthor);
                _easyReaderDBContext.SaveChanges();
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }

        public async void DeleteAuthor(int Id)
        {
            try
            {
                var author = await _easyReaderDBContext!.Authors.FindAsync(Id);
                if (author != null)
                {
                    _easyReaderDBContext.Remove(author);
                    _easyReaderDBContext.SaveChanges();
                }
                Console.WriteLine($"No author found with the id {Id}");
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }

        public async Task<IEnumerable<Author>> GetAllAuthors()
        {
            try
            {
                var authors = _easyReaderDBContext!.Authors
                                                    .Include(b => b.Books);
                
                if (authors is null)
                {
                    if (authors!.Count() == 0)
                    {
                        Console.WriteLine("No author registered in the database");
                        return null!;
                    }
                    Console.WriteLine("Please fill in valid information");
                    return null!;
                }
                await Task.Delay(2000);
                return authors;
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public async Task<Author> GetAuthor(int Id)
        {
            try
            {
                var author = await _easyReaderDBContext!.Authors.Where(a => a.Id == Id)
                                                            .Include(b => b.Books)
                                                            .FirstAsync();
                if (author is null)
                {
                    Console.WriteLine($"No author found with the id {Id}");
                    return null!;
                }
                return author;
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public async void UpdateAuthor(int Id, Author EditAuthor)
        {
            try
            {
                var author = await _easyReaderDBContext!.Authors.FindAsync(Id);

                if (author is null)
                {
                    Console.WriteLine($"No author found with the id {Id}");
                }
                _easyReaderDBContext.Authors.Attach(author!);
                _easyReaderDBContext.SaveChanges();
                Console.WriteLine("Author Updated successfuly");
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}