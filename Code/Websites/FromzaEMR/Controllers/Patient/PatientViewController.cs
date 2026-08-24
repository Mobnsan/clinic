using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using FromzaEMR.Core.Configuration;
using FromzaEMR.Security;
using Microsoft.AspNetCore.Http;
using FromzaEMR.Utilities;
using FromzaEMR.Controllers;

namespace FromzaEMR.Controllers
{
    public class PatientViewController : Controller
    {
        private readonly string connString = null;
        public PatientViewController(IOptions<MyConfiguration> _config)
        {
            connString = _config.Value.Connectionstring;

        }


        [FromzaViewFilter("patient-register-address-view")]
        public IActionResult Address()
        {
            try
            {
                ViewData["ConnectionString"] = connString;
                return View("Address");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [FromzaViewFilter("patient-register-guarantor-view")]
        public IActionResult Guarantor()
        {
            try
            {
                ViewData["ConnectionString"] = connString;
                return View("Guarantor");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("patient-register-insurance-view")]
        public IActionResult Insurance()
        {
            try
            {
                return View("Insurance");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("patient-register-kinemergencycontact-view")]
        public IActionResult KIN()
        {
            try
            {
                return View("KIN");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [FromzaViewFilter("doctors-notes-view")]
        public IActionResult Notes()
        {
            try
            {
                ViewData["ConnectionString"] = connString;
                return View("Notes");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [FromzaViewFilter("patient-register-view")]
        public IActionResult Patient()
        {
            try
            {
                ViewData["ConnectionString"] = connString;
                return View("Patient");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("patient-view")]
        public IActionResult PatientMain()
        {
            try
            {
                return View("PatientMain");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IActionResult RegisterPatientMain()
        {
            try
            {//Nagesh - No need child routes from here, we get all child from security service at client side
                //RbacUser currentUser = HttpContext.Session.Get<RbacUser>("currentuser");
                //List<FromzaRoute> childRoutes = RBAC.GetChildRoutesForUser(currentUser.UserId, urlFullPath: "Patient/RegisterPatient");
                //ViewData["validroutes"] = childRoutes;
                //return this.GetView("Patient", "RegisterPatientMain");
                return View("RegisterPatientMain");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("patient-searchpatient-view")]
        public IActionResult SearchPatient()
        {
            try
            {
                return View("SearchPatient");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

