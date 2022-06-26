using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace API.Models
{
    public class Book
    {
        public int Id {get; set;}

        [Required]
        [MaxLength(50)]
        public String? Title {get; set;}

        [Required]
        [MaxLength(50)]
        public String? Sub_Title {get; set;}

        [Required]
        public DateTime YearOf_Publication {get; set;}

        [Required]
        [MaxLength(50)]
        public String? ISBN_Number {get; set;}

        [Required]        
        [MaxLength(50)]
        public String? Publisher {get; set;}

        [NotMapped]
        public IFormFile? Front_Cover_Img {get; set;}

        public String? Front_Cover_Img_url {get; set;}

        [NotMapped]
        public IFormFile? Back_Cover_Img {get; set;}

        public String? Back_Cover_Img_url {get; set;}

        [Required]
        [Column(TypeName = "nvarchar(MAX)")]
        public String? Body {get; set;}

        [Required]
        public double Price {get; set;}

        public DateTime Created_at {get; set;}

        public DateTime Updated_at { get; set; }

        public int? AuthorId { get; set; }
        public Author? Author { get; set; }

        public List<Book_User>? Book_User { get; set; }


    }
}