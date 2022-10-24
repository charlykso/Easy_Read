using System;

namespace API.DataAccess
{
    public class Payment_Model
    {
        public int User_Id { get; set; }
        public int Book_Id { get; set; }
        public int Transaction_Id { get; set; }
        public string? Email { get; set; }
        public string? Name { get; set; }
        public int Amount { get; set; }
        public string? Status { get; set; }
    }
}
