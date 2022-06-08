using API.Models;

namespace API.Repo
{
    public interface IBook_User
    {
        public IEnumerable<Book_User> GetAllUsersAndBooks();
        public Book_User GetUserAndHisBooks(int Id);
        public void CreateBook_User(Book_User NewBook_User);
        public void UpdateBook_User(int Id, Book_User EditBook_User);
        public void DeleteBook_User(int Id);
    }
}