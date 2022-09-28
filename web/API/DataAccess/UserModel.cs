using System.ComponentModel.DataAnnotations;

namespace API.DataAccess
{
    public class UserModel
    {
        public int Id { get; set; }

        [Required]
        [StringLength(50, MinimumLength = 2)]
        [RegularExpression(@"^([A-Za-z-.']+)$", ErrorMessage = "Last Name not accepted!")]
        public string? Lastname { get; set; }
        
        [Required]
        [StringLength(50, MinimumLength = 2)]
        [RegularExpression(@"^([A-Za-z-.']+)$", ErrorMessage = "First Name not accepted!")]
        public string? Firstname { get; set; }

        [Required]
        [MaxLength(50)]
        [RegularExpression(@"^[^@\s]+@[^@\s]+\.(com|net|org|gov)$", ErrorMessage = "Invalid Email pattern.")]
        public string? Email { get; set; }

        [StringLength(15, MinimumLength = 9)]
        [RegularExpression("^[+][0-9]+$", ErrorMessage = "Invalid phone number partern")]
        public string? Phone_no { get; set; }
        
        [MaxLength(20)]
        public string? Role { get; set; }

        [MaxLength(100)]
        [StringLength(100, MinimumLength = 6)]
        public string? Password { get; set; }

        public DateTime Created_at { get; set; }

        public DateTime Updated_at { get; set; }

    }
}