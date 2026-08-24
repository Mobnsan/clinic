using System;
using Microsoft.AspNetCore.Mvc;
using FromzaEMR.ServerModel;
using FromzaEMR.Utilities;
using FromzaEMR.CommonTypes;
using FromzaEMR.Services;
using FromzaEMR.Security;
using FromzaEMR.ViewModel;
using FromzaEMR.Core.Configuration;
using Microsoft.Extensions.Options;
using FromzaEMR.DalLayer;

namespace FromzaEMR.Controllers
{
    [Route("api/[controller]")]
    public class InventoryEmailController : CommonController
    {

        public IEmailService _emailService;
        public FromzaHTTPResponse<object> responseData = new FromzaHTTPResponse<object>();

        public InventoryEmailController(IOptions<MyConfiguration> _config, IEmailService emailService) : base(_config)
        {
            _emailService = emailService;
        }

        [HttpGet]
        public IActionResult Get()
        {
            return Ok("hello");
        }
        
        [HttpPost]
        public IActionResult Post([FromBody]EmailViewModel value)
        {
            try
            {                
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var emailList = value.EmailAddress.Split(';');
                value.EmailAddressList = new System.Collections.Generic.List<String>();
                foreach (var email in emailList)
                {
                    value.EmailAddressList.Add(email);
                }

                var apiKey = Environment.GetEnvironmentVariable("SENDGRID_API_KEY") ?? "";

                responseData.Results = _emailService.SendEmail("info@hamshospital.org", value.EmailAddressList,"HAMS HOSPITAL", value.Subject, "", value.Content, apiKey);
                responseData.Status = "OK";
            }
            catch (Exception ex)
            {
                responseData.Status = "Failed";
                responseData.ErrorMessage = ex.Message + " exception details:" + ex.ToString();
            }
            return Ok(responseData);
        }
       
    }
}

