using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading;
using Microsoft.AspNetCore.Mvc;
using FromzaEMR.Security;
using FromzaEMR.Utilities;
using Microsoft.Extensions.Options;
using FromzaEMR.Core.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net;
using System.IO;

namespace FromzaEMR.Controllers
{
    public class HomeController : Controller
    {

        private readonly string connString = null;
        public HomeController(IOptions<MyConfiguration> _config)
        {
            connString = _config.Value.Connectionstring;

        }

        public IActionResult Index()
        {
            //ViewData["token"] = TempData["token"]; // TempData is being set from AccountController Login Action
            return View();
        }
        //move it out of patientcontroller to Maincontroller or something..
        public IActionResult AppMain()
        {
            try
            {
                RbacUser currentUser = HttpContext.Session.Get<RbacUser>("currentuser");
                ViewData["currentuser"] = currentUser;
                //getting only the root level routes for this view.//set getHierarchy = true for AppMain (special condition.)
                ViewData["validroutes"] = RBAC.GetRoutesForUser(currentUser.UserId, getHiearrchy: true);
                return View();
            }
            catch (Exception ex)
            {
                //throw ex;
                //Redirect to Login page If user is not login                           
                return RedirectToAction("Login", "Account");
            }
        }
        public IActionResult ChangePassword()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public FileStreamResult GetUserManual()
        {
            FileStream usrManual = new FileStream("wwwroot\\fileuploads\\FromzaEMR_UserManual.pdf", FileMode.Open);
            return new FileStreamResult(usrManual,"application/pdf");
        }


    }
}
