using System;
using Twilio;
using Twilio.Rest.Api.V2010.Account;

namespace API.Controllers
{
    public class VeriffyPhoneNo
    {
        private readonly IConfiguration? _Iconfig;
        public VeriffyPhoneNo(IConfiguration Iconfig)
        {
            _Iconfig = Iconfig;
        }
        public string verifyPhone(string phoneNo)
        {
            TwilioClient.Init(_Iconfig!["TwilioConfig: TwilioSID"], _Iconfig["TwilioConfig: TwilioAuthToken"]);
            GenerateCode myCode = new GenerateCode();
            var dCode = myCode.generateCode().ToString();
            var message = MessageResource.Create(
                body: dCode,
                from: new Twilio.Types.PhoneNumber(_Iconfig["TwilioConfig: TwilioPhoneNo"]),
                to: new Twilio.Types.PhoneNumber("phoneNo")
            );

            if (message.Status.ToString() == "Delivered")
            {
                return(dCode!);
            }

            return("Request not sent");
        }
    }
}