using API.Models;

namespace API.Repo
{
    public interface IBook_User
    {
        public IEnumerable<Book_User> GetAllPayments();
        public Book_User GetSinglePayment(int Id);
        public void CreatePayment(Book_User newBookPayment);
        public void UpdatePayment(int Id, Book_User editBookPayment);
        public void DeletePayment(int Id);
    }
}