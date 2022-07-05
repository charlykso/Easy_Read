using API.Models;
using API.Repo;
using Microsoft.EntityFrameworkCore;

namespace API.Services
{
    public class UserServices : IUser
    {
        private readonly EasyReaderDBContext? _easyReaderDBContext;
        public UserServices(EasyReaderDBContext easyReaderDBContext)
        {
            _easyReaderDBContext = easyReaderDBContext;
        }

        public string CheckEmail(string Email)
        {
            try
            {
                var emailExist = _easyReaderDBContext!.Users.FirstOrDefault(e => 
                e.Email!.ToLower() == Email.ToLower());

                if (emailExist is null)
                {
                    return("Not Exist");
                }else{
                    return("Exist");
                }
            }
            catch (System.Exception ex)
            {
                
                return(ex.Message);
            }
        }

        public string CheckPhone(string Phone_no)
        {
            try
            {
                var phone_noExist = _easyReaderDBContext!.Users.FirstOrDefault(p => 
                p.Phone_no == Phone_no);

                if (phone_noExist is null)
                {
                    return("Not Exist");
                }else{
                    return("Exist");
                }
            }
            catch (System.Exception ex)
            {
                
                return(ex.Message);
            }
        }

        public void CreateUser(User NewUser)
        {
            try
            {
                var user = _easyReaderDBContext!.Users.Add(NewUser);
                _easyReaderDBContext.SaveChanges();
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }

        public void DeleteUser(int Id)
        {
            try
            {
                var user = _easyReaderDBContext!.Users.Find(Id);
                if (user != null)
                {
                    _easyReaderDBContext.Remove(user);
                    _easyReaderDBContext.SaveChanges();
                }
                Console.WriteLine($"No user found with the id {Id}");
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }

        public IEnumerable<User> GetAllUsers()
        {
            try
            {
                var users = _easyReaderDBContext!.Users
                                                .Include(bu => bu.Book_User);
                if (users is null)
                {
                    if (users!.Count() == 0)
                    {
                        Console.WriteLine("No user registered in the database");
                        return null!;
                    }
                    Console.WriteLine("Please fill in valid information");
                    return null!;
                }
                var myUser = users!.ThenInclude(b => b.Book);
                return myUser!;
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public User GetUser(int Id)
        {
            try
            {
                var user = _easyReaderDBContext!.Users.Where(a => a.Id == Id)
                                                        .Include(bu => bu.Book_User)
                                                        .First();
                if (user is null)
                {
                    Console.WriteLine($"No user found with the id {Id}");
                    return null!;
                }
                // var myUser = user!.ThenInclude(b => b.Book);
                return user;
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public void UpdateUser(int Id, User EditUser)
        {
            try
            {
                var user = _easyReaderDBContext!.Users.Find(Id);
                if (user is null)
                {
                    Console.WriteLine($"No user found with the id {Id}");
                }
                _easyReaderDBContext.Users.Attach(user!);
                _easyReaderDBContext.SaveChanges();
                Console.WriteLine("User Updated successfuly");
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }
    }
}