using API.Models;

namespace API.Repo
{
    public interface IBook_User
    {
        public IEnumerable<Book_User> GetAllPayments();
        public Book_User GetSinglePayment(int Id);
        public string CreatePayment(Book_User newBookPayment);
        public string UpdatePayment(int Id, Book_User editBookPayment);
        public string DeletePayment(int Id);
    }
}