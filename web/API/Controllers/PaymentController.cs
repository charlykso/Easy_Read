using System;
using System.Net.Http.Headers;
using API.Collectives;
using API.DataAccess;
using API.Models;
using API.Repo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace API.Controllers
{
    [Authorize(Roles = "Admin")]
    [ApiController]
    [Route("api/[controller]")]
    public class PaymentController: ControllerBase
    {
        private readonly IBook_User? _IBkUs;
        private readonly IHttpClientFactory _ClientFactory;
        private readonly IConfiguration _IConfig;
        public PaymentController(IBook_User IBkUs, IHttpClientFactory clientFactory, IConfiguration IConfig)
        {
            _IBkUs = IBkUs;
            _IConfig = IConfig;
            _ClientFactory = clientFactory;
        }

        //api/payment/getallpayments
        [HttpGet("getallpayments")]
        public async Task<ActionResult> GetAllPayments()
        {
            try
            {
                var payments = await _IBkUs!.GetAllPayments();
                if (payments != null)
                {
                    return Ok(payments);
                }
                return Ok("No payment made yet.");
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

        //api/payment/getpayment/{id}
        [HttpGet("getpayment/{Id}")]
        public async Task<ActionResult> GetPayment(int Id)
        {
            try
            {
                var payment = await _IBkUs!.GetSinglePayment(Id);
                if (payment != null)
                {
                    return Ok(payment);
                }
                return Ok($"No payment with the id {Id}");
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

        [AllowAnonymous]
        //api/payment/makepayment
        [HttpPost("makePayment")]
        public async Task<IActionResult> MakePayment([FromForm] Payment_Model newpayment)
        {
            try
            {
                // var token = "FLWSECK_TEST-1e6ad0f6f2577a9db03c1deaabd86937-X";
                //this is the uri
                var request = new HttpRequestMessage(HttpMethod.Get, 
                $"https://api.flutterwave.com/v3/transactions/{newpayment.Transaction_Id}/verify");
                //create an an instance of IHttpclientFactory
                var client = _ClientFactory.CreateClient();
                //add the auth token to the header
                request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", _IConfig["FW_Payment:Secret_key"]);
                //send request and get the respond
                HttpResponseMessage response = await client.SendAsync(request, HttpCompletionOption.ResponseHeadersRead);
                //check if the respond status is successful
                if (response.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    //convert the respond to string
                    var apiString = await response.Content.ReadAsStringAsync();
                    //deserialize it to json object
                    var paymentRes = JsonConvert.DeserializeObject<PaymentDetails>(apiString);
                    
                    var payment = new Book_User();
                    payment.UserId = newpayment.User_Id;
                    payment.BookId = newpayment.Book_Id;
                    payment.Transaction_Id = paymentRes!.data!.id;
                    payment.Payment_made_at = paymentRes!.data!.created_at;
                    payment.Amount = paymentRes!.data!.amount;
                    payment.Payment_Status = paymentRes!.data!.processor_response;

                    var res = await _IBkUs!.CreatePayment(payment);
                    if (res == "success")
                    {
                        return Ok("Payment made successfully!");
                    }
                    return BadRequest("Payment Failed");
                
                }
                return BadRequest("Unautorized");
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

        //api/payment/updatepayment/{id}
        [HttpPut("UpdatePayment/{Id}")]
        public async Task<ActionResult> UpdatePayment(int Id, [FromForm] Book_UserModel editPayment)
        {
            try
            {
                var payment = await _IBkUs!.GetSinglePayment(Id);
                if (payment != null)
                {
                    payment.UserId = editPayment.UserId;
                    payment.BookId = editPayment.BookId;
                    payment.Transaction_Id = editPayment.Transaction_Id;
                    payment.Payment_Status = editPayment.Payment_Status;
                    payment.Updated_at = DateTime.Now;

                    var res = await _IBkUs!.UpdatePayment(Id, payment);
                    if (res == "success")
                    {
                        return Ok("Payment updated successfuly!");
                    }
                    return BadRequest("sorry the payment could not be updated");
                }
                return BadRequest("Sorry payment not found");
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }

        
        //api/payment/deletepayment/{id}
        [HttpDelete("deletepayment/{Id}")]
        public async Task<ActionResult> DeletePayment(int Id)
        {
            try
            {
                var payment = await _IBkUs!.GetSinglePayment(Id);
                if (payment != null)
                {
                   var res = await _IBkUs!.DeletePayment(Id);
                    if (res == "success")
                    {
                        return Ok("Payment deleted successfuly!");
                    }
                    return BadRequest("Payment not deleted!");
                }
                return Ok($"No payment with the id {Id}");
            }
            catch (System.Exception ex)
            {
                
                return BadRequest(ex.Message);
            }
        }
    }
}