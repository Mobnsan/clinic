using FromzaEMR.CommonTypes;
using FromzaEMR.Services;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;

namespace FromzaEMR.Controllers.NepaliReceipt
{
    [RequestFormSizeLimit(valueCountLimit: 1000000, Order = 1)]
    [FromzaDataFilter()]
    [Route("api/[controller]")]
    public class NepaliReceiptController : ControllerBase
    {
        private INepaliReceiptService _nepaliReceiptService;
        public FromzaHTTPResponse<object> responseData = new FromzaHTTPResponse<object>();

        public NepaliReceiptController(INepaliReceiptService nepaliReceiptService)
        {
            _nepaliReceiptService = nepaliReceiptService;
        }

        [HttpGet("GetDonationGRView")]
        public async Task<IActionResult> GetDonationGRView(int GoodsReceiptId)
        {
            try
            {
                responseData.Results = await _nepaliReceiptService.GetDonationGRView(GoodsReceiptId);
                responseData.Status = "OK";
            }
            catch (Exception ex)
            {
                responseData.Status = "Failed";
                responseData.ErrorMessage = ex.Message + " exception details:" + ex.ToString();
            }
            return Ok(responseData);
        }
        [HttpGet("GetNepaliRequisitionView")]
        public IActionResult GetNepaliRequisitionView(int RequisitionId, string ModuleType)
        {
            try
            {
                responseData.Results = _nepaliReceiptService.GetNepaliRequisitionView(RequisitionId, ModuleType);
                responseData.Status = "OK";
            }
            catch (Exception ex)
            {
                responseData.Status = "Failed";
                responseData.ErrorMessage = ex.Message + " exception details:" + ex.ToString();
            }
            return Ok(responseData);
        }
        [HttpGet("GetNepaliDispatchView")]
        public IActionResult GetNepaliDispatchView(int DispatchId, int RequisitionId, string ModuleType)
        {
            try
            {
                responseData.Results = _nepaliReceiptService.GetNepaliDispatchView(DispatchId, RequisitionId, ModuleType);
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

