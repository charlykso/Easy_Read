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
        public void CreateAuthor(Author NewAuthor)
        {
            try
            {
                var author = _easyReaderDBContext!.Authors.Add(NewAuthor);
                _easyReaderDBContext.SaveChanges();
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }

        public void DeleteAuthor(int Id)
        {
            try
            {
                var author = _easyReaderDBContext!.Authors.Find(Id);
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

        public IEnumerable<Author> GetAllAuthors()
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
                return authors;
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public Author GetAuthor(int Id)
        {
            try
            {
                var author = _easyReaderDBContext!.Authors.Where(a => a.Id == Id)
                                                            .Include(b => b.Books)
                                                            .First();
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

        public void UpdateAuthor(int Id, Author EditAuthor)
        {
            try
            {
                var author = _easyReaderDBContext!.Authors.Find(Id);

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