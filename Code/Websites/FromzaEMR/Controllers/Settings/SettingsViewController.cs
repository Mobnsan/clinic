using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using FromzaEMR.Core.Configuration;
using Microsoft.AspNetCore.Http;
using FromzaEMR.Utilities;
using FromzaEMR.Security;

//review:25Jan'17-sudarshan: check if ViewData["ConnectionString"] is needed or not in respective cshtml, remove from here if not needed.
namespace FromzaEMR.Controllers
{
    public class SettingsViewController : Controller
    {
        private readonly string connString = null;
        public SettingsViewController(IOptions<MyConfiguration> _config)
        {
            connString = _config.Value.Connectionstring;

        }
        ////Return view with provided matching urlfullpath & viewpath
        //public IActionResult GetView(string urlFullPath, string viewPath)
        //{
        //    //Get Valid Route List for logged in user
        //    List<FromzaRoute> validRouteList = HttpContext.Session.Get<List<FromzaRoute>>("validRouteList");
        //    if (validRouteList != null || validRouteList.Count > 0)
        //    {
        //        List<FromzaRoute> validRoutes = validRouteList.Where(a => a.UrlFullPath == urlFullPath).ToList();
        //        if (validRoutes != null && validRoutes.Count > 0)
        //        {
        //            //Return view for valid user
        //            return View(viewPath);
        //        }
        //        else
        //        {
        //            //Return content with message for unauthorized user
        //            return Content("<div>Page Not Found</div><router-outlet></router-outlet>");
        //        }
        //    }
        //    else
        //    {
        //        //Return content with message for unauthorized user
        //        return Content("<div>Page Not Found</div><router-outlet></router-outlet>");
        //    }
        //}
        [FromzaViewFilter("settings-view")]
        public IActionResult SettingsMain()
        {
            try
            {
                //remove below connection string if not needed in cshtml page.
                ViewData["ConnectionString"] = connString;
                return View("SettingsMain");                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }       
        public IActionResult UserAdd()
        {
            try
            {
                //remove below connection string if not needed in cshtml page.
                ViewData["ConnectionString"] = connString;               
                return View("UserAdd");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }       
        public IActionResult ApplicationAdd()
        {
            try
            {
                //remove below connection string if not needed in cshtml page.
                ViewData["ConnectionString"] = connString;
                return View("ApplicationAdd");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }       
        //public IActionResult RoleManagement()
        //{
        //    try
        //    {
        //        //remove below connection string if not needed in cshtml page.
        //        ViewData["ConnectionString"] = connString;
        //        return View("RoleManagement");
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
        [FromzaViewFilter("settings-departmentsmanage-view")]
        public IActionResult DepartmentsManage()
        {
            try
            {          
                return View("DepartmentsManage");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("settings-radiologymanage-view")]
        public IActionResult RadiologyManage()
        {
            try
            {                
                return View("RadiologyManage");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("settings-adtmanage-view")]
        public IActionResult ADTManage()
        {
            try
            {               
                return View("ADTManage");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("settings-employeemanage-view")]
        public IActionResult EmployeeManage()
        {
            try
            {
                //return View("EmployeeManage");
                return View("EmployeeManage");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("ssettings-securitymanage-view")]
        public IActionResult SecurityManage()
        {
            try
            {                
                return View("SecurityManage");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public IActionResult BillingManage()
        {
            try
            {
                return View("BillingManage");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [FromzaViewFilter("settings-geolocationmanage-view")]
        public IActionResult GeolocationManage()
        {
            try
            {
                return View("GeolocationManage");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [FromzaViewFilter("settings-clinicalmanage-view")]
        public IActionResult ClinicalManage()
        {
            try
            {
                return View("ClinicalManage");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }




    }
}

