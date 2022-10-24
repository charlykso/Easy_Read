namespace API.DataAccess
{
    public class Book_UserModel
    {
        public int? Id { get; set; }

        public int BookId { get; set; }

        public int UserId { get; set; }
        public int Transaction_Id { get; set; }

        public String? Payment_Status { get; set; }

        public DateTime Payment_made_at { get; set; }

        public DateTime Updated_at { get; set; }
    }
}