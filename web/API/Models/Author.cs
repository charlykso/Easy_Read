using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace API.Models
{
    public class Author
    {
        public int Id { get; set; }

        [Required]
        [StringLength(50, MinimumLength = 2)]
        [RegularExpression("^([A-Za-z]+).$", ErrorMessage = "Accepted characters(uppercase, lowercase and a dot(.))")]
        public string? Lastname { get; set; }
        
        [Required]
        [StringLength(50, MinimumLength = 2)]
        [RegularExpression("^([A-Za-z]+).$", ErrorMessage = "Accepted characters(uppercase, lowercase and a dot(.))")]
        public string? Firstname { get; set; }

        [Required]
        [EmailAddress(ErrorMessage = "Invalid email address.")]
        [RegularExpression(@"^[^@\s]+@[^@\s]+\.(com|net|org|gov)$", ErrorMessage = "Invalid Email pattern.")]
        [MaxLength(50)]
        public string? Email { get; set; }

        [Required]
        [StringLength(15, MinimumLength = 9)]
        [RegularExpression("^[+][0-9]+$", ErrorMessage = "Invalid phone number partern")]
        public string? Phone_no { get; set; }
        
        [MaxLength(10)]
        public string? Gender { get; set; }

        [Required]
        [MaxLength(100)]
        public string? Password { get; set; }

        public DateTime Date_of_birth { get; set; }

        [NotMapped]
        public IFormFile? Image { get; set; }

        public string? ImageURL { get; set; }

        public DateTime Created_at { get; set; }

        public DateTime Updated_at { get; set; }

        public List<Book>? Books { get; set; }

    }
}