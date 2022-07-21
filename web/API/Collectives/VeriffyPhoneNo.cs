using Twilio;
using Twilio.Rest.Api.V2010.Account;

namespace API.Controllers
{
    public class VeriffyPhoneNo
    {
        
        public string verifyPhone(string phoneNo)
        {
            try
            {
                
                string? accountSid = Environment.GetEnvironmentVariable("TWILIO_ACC_SID");
                string? authToken = Environment.GetEnvironmentVariable("TWILIO_AUTH_TOKEN");
                string? TwilioPhone = Environment.GetEnvironmentVariable("TWILIO_PHONE_NO");

                TwilioClient.Init(accountSid, authToken);
                GenerateCode myCode = new GenerateCode();
                var dCode = myCode.generateCode();
                var message = MessageResource.Create(
                    body: dCode,
                    from: new Twilio.Types.PhoneNumber(TwilioPhone),
                    to: new Twilio.Types.PhoneNumber(phoneNo)
                );
    
                if (message.Status.ToString() == "queued")
                {
                    return(dCode!);
                }
    
                return("Request not sent");
            }
            catch (System.Exception ex)
            {
                
                return (ex.Message);
            }
        }
    }
}