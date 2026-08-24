using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using FromzaEMR.Core.Configuration;
using FromzaEMR.ServerModel;
using FromzaEMR.DalLayer;
using System.Data.Entity;
using System.Data.SqlClient;
using Microsoft.Extensions.Options;
using Newtonsoft.Json.Linq;
using FromzaEMR.Utilities;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Http.Features;
using FromzaEMR.CommonTypes;
// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace FromzaEMR.Controllers
{

    public class EmployeeViewController : Controller
    {
        private readonly string config = null;
        public EmployeeViewController(IOptions<MyConfiguration> _config)
        {
            config = _config.Value.Connectionstring;

        }

        public IActionResult UserProfile()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("UserProfile");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IActionResult ChangePassword()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("ChangePassword");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        

        public IActionResult ProfileMain()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("ProfileMain");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public IActionResult ChangeProfile()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("ChangeProfile");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
    }
}


