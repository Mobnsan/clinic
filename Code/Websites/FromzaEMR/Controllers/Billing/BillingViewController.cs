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
    public class BillingViewController : Controller
    {
        private readonly string config = null;
        public BillingViewController(IOptions<MyConfiguration> _config)
        {
            config = _config.Value.Connectionstring;

        }

        // GET: /<controller>/
        [FromzaViewFilter("billing-transaction-view")]
        public IActionResult BillingTransaction()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("BillingTransaction");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-counteractivate-view")]
        public IActionResult CounterActivate()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("CounterActivate");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-billorderrequest-view")]
        public IActionResult BillOrderRequest()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("BillOrderRequest");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-billcancellationrequest-view")]
        public IActionResult BillCancellationRequest()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("BillCancellationRequest");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-billrequest-view")]
        public IActionResult BillReturnRequest()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("BillReturnRequest");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-settlements-bill-settlement-view")]
        public IActionResult BillSettlements()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("BillSettlements");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-transactionitem-view")]
        public IActionResult BillingTransactionItem()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("BillingTransactionItem");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-unpaidbills-view")]
        public IActionResult UnpaidBills()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("UnpaidBills");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-duplicatebillprint-view")]
        public IActionResult DuplicateBillPrint()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("DuplicateBillPrint");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-searchpatient-view")]
        public IActionResult BillingSearchPatient()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("BillingSearchPatient");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        //[FromzaViewFilter("billing-deposit-view")]
        //public IActionResult BillingDeposit()
        //{
        //    try
        //    {
        //        ViewData["ConnectionString"] = config;
        //        return View("BillingDeposit");
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
        [FromzaViewFilter("billing-receiptprint-view")]
        public IActionResult ReceiptPrint()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("ReceiptPrint");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-view")]
        public IActionResult Billing()
        {
            try
            {
                return View("Billing");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [FromzaViewFilter("billing-editdoctor-view")]
        public IActionResult EditDoctor()
        {
            try
            {
                ViewData["ConnectionString"] = config;
                return View("EditDoctor");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

