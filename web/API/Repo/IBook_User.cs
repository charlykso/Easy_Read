using API.Models;

namespace API.Repo
{
    public interface IBook_User
    {
        public Task<IEnumerable<Book_User>> GetAllPayments();
        public Task<Book_User> GetSinglePayment(int Id);
        public Task<string> CreatePayment(Book_User newBookPayment);
        public Task<string> UpdatePayment(int Id, Book_User editBookPayment);
        public Task<string> DeletePayment(int Id);
    }
}