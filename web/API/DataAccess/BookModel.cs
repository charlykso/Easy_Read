using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace API.DataAccess
{
    public class BookModel
    {
        public int? Id {get; set;}

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

        public IFormFile? Cover_Img {get; set;}

        public String? Cover_Img_url {get; set;}

        [Required]
        [Column(TypeName = "nvarchar(MAX)")]
        public String? Body {get; set;}

        [Required]
        public double Price {get; set;}

        public DateTime Created_at {get; set;}

        public DateTime Updated_at { get; set; } 

        public int? AuthorId { get; set; }

    }
}