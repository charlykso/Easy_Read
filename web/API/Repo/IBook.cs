using API.Models;

namespace API.Repo
{
    public interface IBook
    {
        public IEnumerable<Book> GetAllBooks();
        public Book GetBook(int Id);
        public void CreateBook(User NewBook);
        public void UpdateBook(int Id, User EditBook);
        public void DeleteBook(int Id);
    }
}