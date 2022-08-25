namespace API.Collectives
{
    public class PaymentDetails
    {
        public int id { get; set; }
        public int amount { get; set; }
        public string? status { get; set; }
        public string? currency { get; set; }
    }
}