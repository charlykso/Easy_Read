using System.ComponentModel.DataAnnotations;

namespace API.Models
{
    public class Book_User
    {
        public int Id { get; set; }
        public double Amount { get; set; }
        public int Transaction_Id { get; set; }
        public int BookId { get; set; }
        public Book? Book { get; set; }
        public int UserId { get; set; }
        public User? User { get; set; }

        [MaxLength(50)]
        public String? Payment_Status { get; set; }

        public DateTime? Payment_made_at { get; set; } = null;

        public DateTime? Updated_at { get; set; } = null;
    }
}