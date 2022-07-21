using API.Models;

namespace API.Repo
{
    public interface IUser
    {
        public IEnumerable<User> GetAllUsers();
        public User GetUser(int Id);
        public User GetUserByMail(string Email);
        public string CheckEmail(string Email);
        public string CheckPhone(string Phone_no);
        public void CreateUser(User NewUser);
        public void UpdateUser(int Id, User EditUser);
        public void DeleteUser(int Id);
    }
}