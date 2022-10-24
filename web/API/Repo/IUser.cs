using API.Models;

namespace API.Repo
{
    public interface IUser
    {
        public Task<IEnumerable<User>> GetAllUsers();
        public Task<User> GetUser(int Id);
        public Task<User> GetUserByMail(string Email);
        public Task<string> CheckEmail(string Email);
        public Task<string> CheckPhone(string Phone_no);
        public void CreateUser(User NewUser);
        public void UpdateUser(int Id, User EditUser);
        public void DeleteUser(int Id);
    }
}