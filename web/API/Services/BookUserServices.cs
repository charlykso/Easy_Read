using System;
using API.Models;
using API.Repo;
using Microsoft.EntityFrameworkCore;

namespace API.Services
{
    public class BookUserServices : IBook_User
    {
        private readonly EasyReaderDBContext? _easyReaderDBContext;
        public BookUserServices(EasyReaderDBContext easyReaderDBContext)
        {
            _easyReaderDBContext = easyReaderDBContext;
        }
        public void CreatePayment(Book_User newBookPayment)
        {
            try
            {
                var payment = _easyReaderDBContext!.Book_Users.Add(newBookPayment);
                _easyReaderDBContext.SaveChanges();
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public void DeletePayment(int Id)
        {
            try
            {
                var payment = _easyReaderDBContext!.Book_Users.Find(Id);

                if (payment != null)
                {
                    _easyReaderDBContext.Remove(payment);
                    _easyReaderDBContext.SaveChanges();
                }
                Console.WriteLine($"No payment found with the id {Id}");
            }
            catch (System.Exception ex)
            {
                
                Console.WriteLine(ex.Message);
            }
        }

        public IEnumerable<Book_User> GetAllPayments()
        {
            var payments = _easyReaderDBContext!.Book_Users
                                                .Include(buk => buk.Book)
                                                .Include(usa => usa.User);
            if (payments is null)
            {
                if (payments!.Count() == 0)
                {
                    Console.WriteLine("No payment registered in the database");
                    return null!;
                }
                Console.WriteLine("Please fill in valid information");
                return null!;
            }
            return payments;
        }

        public Book_User GetSinglePayment(int Id)
        {
            try
            {
                var payment = _easyReaderDBContext!.Book_Users.Where(bu => bu.Id == Id)
                                                                .Include(usa => usa.User)
                                                                .Include(buk => buk.Book)
                                                                .First();
                if (payment is null)
                {
                    Console.WriteLine($"No payment found with the id {Id}");
                    return null!;
                }
                return payment;
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null!;
            }
        }

        public void UpdatePayment(int Id, Book_User editBookPayment)
        {
            try
            {
                var payment = _easyReaderDBContext!.Book_Users.Find(Id);

                if (payment is null)
                {
                    Console.WriteLine($"No payment found with the id {Id}");
                }
                _easyReaderDBContext.Book_Users.Attach(payment!);
                _easyReaderDBContext.SaveChanges();
                Console.WriteLine("Payment Updated successfuly");
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}