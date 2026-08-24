using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using FromzaEMR.Core.Configuration;
using FromzaEMR.Security;
using FromzaEMR.Utilities;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace FromzaEMR.Controllers
{
    public class AdmissionViewController : Controller
    {
        private readonly string config = null;
        public AdmissionViewController(IOptions<MyConfiguration> _config)
        {
            config = _config.Value.Connectionstring;

        }
        // GET: /<controller>/
        [FromzaViewFilter("adt-createadmission-view")]
        public IActionResult AdmissionCreate()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("CreateAdmission");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("adt-admissionsearchpatient-view")]
        public IActionResult AdmissionSearchPatient()
        {
            try
            {
                return View("AdmissionSearchPatient");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("adt-admittedlist-view")]
        public IActionResult AdmittedList()
        {
            try
            {
                return View("AdmittedList");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("adt-dischargedlist-view")]
        public IActionResult DischargedList()
        {
            try
            {
                return View("DischargedList");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("adt-view")]
        public IActionResult Admission()
        {
            try
            {
                return View("Admission");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

