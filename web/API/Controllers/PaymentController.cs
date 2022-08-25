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
    [ApiController]
    [Route("api/[controller]")]
    public class PaymentController: ControllerBase
    {
        private readonly IBook_User? _IBkUs;
        private readonly IHttpClientFactory _ClientFactory;
        public PaymentController(IBook_User IBkUs, IHttpClientFactory clientFactory)
        {
            _IBkUs = IBkUs;
            _ClientFactory = clientFactory;
        }

        [Authorize(Roles = "Admin")]
        //api/payment/getallpayments
        [HttpGet("getallpayments")]
        public ActionResult GetAllPayments()
        {
            try
            {
                var payments = _IBkUs!.GetAllPayments().ToList();
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

        [Authorize(Roles = "Admin")]
        //api/payment/getpayment/{id}
        [HttpGet("getpayment/{Id}")]
        public ActionResult GetPayment(int Id)
        {
            try
            {
                var payment = _IBkUs!.GetSinglePayment(Id);
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
        public async Task<IActionResult> MakePayment([FromForm] Book_User newpayment, String paymentId)
        {
            try
            {
                var token = "abc-xyz";
                //this is the uri
                var request = new HttpRequestMessage(HttpMethod.Get, 
                $"https://api.flutterwave.com/v3/transactions/{paymentId}/verify");
                //create an an instance of IHttpclientFactory
                var client = _ClientFactory.CreateClient();
                //add the auth token to the header
                request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
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
                    payment.UserId = newpayment.UserId;
                    payment.BookId = newpayment.BookId;
                    payment.Payment_made_at = DateTime.Now;
                    payment.Payment_Status = paymentRes!.status;

                    var res = _IBkUs!.CreatePayment(payment);
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

        [Authorize(Roles = "Admin")]
        //api/payment/updatepayment/{id}
        [HttpPut("UpdatePayment/{Id}")]
        public ActionResult UpdatePayment(int Id, [FromForm] Book_UserModel editPayment)
        {
            try
            {
                var payment = _IBkUs!.GetSinglePayment(Id);
                if (payment != null)
                {
                    var oldPayment = new Book_User();
                    oldPayment.UserId = editPayment.UserId;
                    oldPayment.BookId = editPayment.BookId;
                    oldPayment.Updated_at = DateTime.Now;

                    var res = _IBkUs!.UpdatePayment(Id, oldPayment);
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

        [Authorize(Roles = "Admin")]
        //api/payment/deletepayment/{id}
        [HttpDelete("deletepayment/{Id}")]
        public ActionResult DeletePayment(int Id)
        {
            try
            {
                var payment = _IBkUs!.GetSinglePayment(Id);
                if (payment != null)
                {
                   var res = _IBkUs!.DeletePayment(Id);
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