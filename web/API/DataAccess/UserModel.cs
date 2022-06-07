using System.ComponentModel.DataAnnotations;

namespace API.DataAccess
{
    public class UserModel
    {
        public int Id { get; set; }

        [Required]
        [MaxLength(50)]
        public string? Lastname { get; set; }
        
        [Required]
        [MaxLength(50)]
        public string? Firstname { get; set; }

        [Required]
        [MaxLength(50)]
        public string? Email { get; set; }

        [Required]
        [MaxLength(15)]
        public string? Phone_no { get; set; }
        
        [MaxLength(20)]
        public string? Role { get; set; }

        [Required]
        [MaxLength(100)]
        public string? Password { get; set; }

        public DateTime Created_at { get; set; }

        public DateTime Updated_at { get; set; }

    }
}