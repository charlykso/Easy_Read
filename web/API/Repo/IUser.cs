using API.Models;

namespace API.Repo
{
    public interface IUser
    {
        public IEnumerable<User> GetAllUsers();
        public User GetUser(int Id);
        public string CheckEmail(string Email);
        public void CreateUser(User NewUser);
        public void UpdateUser(int Id, User EditUser);
        public void DeleteUser(int Id);
    }
}