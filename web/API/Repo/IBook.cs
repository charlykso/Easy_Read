using API.Models;

namespace API.Repo
{
    public interface IBook
    {
        public Task<IEnumerable<Book>> GetAllBooks();
        public Task<Book> GetBook(int Id);
        public void CreateBook(Book NewBook);
        public void UpdateBook(int Id, Book EditBook);
        public void DeleteBook(int Id);
    }
}