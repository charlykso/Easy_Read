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

        public async Task<string> CheckEmail(string Email)
        {
            try
            {
                var checkUserEmail = await _easyReaderDBContext!.Users.FirstOrDefaultAsync(e => 
                e.Email!.ToLower() == Email.ToLower());

                if (checkUserEmail is null)
                {
                    return("NOT EXIST");
                }else{
                    return("EXIST");
                }
            }
            catch (System.Exception ex)
            {
                
                return(ex.Message);
            }
        }

        public async Task<User> GetUserByMail(string Email)
        {
            try
            {
                var user = await _easyReaderDBContext!.Users.FirstOrDefaultAsync(e => 
                e.Email!.ToLower() == Email.ToLower());
                if (user is null)
                {
                    return(null!);
                }else{
                    return(user);
                }
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
                return (null!);
            }

        }
        

        public async Task<string> CheckPhone(string Phone_no)
        {
            try
            {
                var phone_noExist = await _easyReaderDBContext!.Users.FirstOrDefaultAsync(p => 
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

        public async void CreateUser(User NewUser)
        {
            try
            {
                var user = await _easyReaderDBContext!.Users.AddAsync(NewUser);
                _easyReaderDBContext.SaveChanges();
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }

        public async void DeleteUser(int Id)
        {
            try
            {
                var user = await _easyReaderDBContext!.Users.FindAsync(Id);
                if (user != null)
                {
                    _easyReaderDBContext.Remove(user);
                    _easyReaderDBContext.SaveChanges();
                }else{
                    Console.WriteLine($"No user found with the id {Id}");
                }
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public async Task<IEnumerable<User>> GetAllUsers()
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
                await Task.Delay(1000);
                return myUser!;
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public async Task<User> GetUser(int Id)
        {
            try
            {
                var user =  _easyReaderDBContext!.Users.Where(a => a.Id == Id)
                                                        .Include(bu => bu.Book_User);
                                                        
                if (user is null)
                {
                    Console.WriteLine($"No user found with the id {Id}");
                    return null!;
                }
                var myUser = await user!.ThenInclude(b => b.Book).FirstOrDefaultAsync();
                // await Task.Delay(2000);
                return myUser!;
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public async void UpdateUser(int Id, User EditUser)
        {
            try
            {
                var user = await _easyReaderDBContext!.Users.FindAsync(Id);
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