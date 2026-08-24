using FromzaEMR.CommonTypes;
using FromzaEMR.DalLayer;
using FromzaEMR.Security;
using FromzaEMR.ServerModel;
using FromzaEMR.Services.DispensaryTransfer;
using FromzaEMR.Utilities;
using FromzaEMR.ViewModel.DispensaryTransfer;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FromzaEMR.Controllers.Dispensary
{
    [RequestFormSizeLimit(valueCountLimit: 1000000, Order = 1)]
    [FromzaDataFilter()]
    [Route("api/[controller]")]
    public class DispensaryTransferController : Controller
    {
        #region Fields
        private IDispensaryTransferService _dispensaryTransferService;
        public FromzaHTTPResponse<object> responseData = new FromzaHTTPResponse<object>();
        #endregion

        #region CTOR
        public DispensaryTransferController(IDispensaryTransferService dispensaryTransferService)
        {
            _dispensaryTransferService = dispensaryTransferService;
        }
        #endregion

        #region Methods

        [HttpGet("{StoreId}")]
        public async Task<IActionResult> Get([FromRoute] int StoreId)
        {
            try
            {
                responseData.Results = await _dispensaryTransferService.GetAllTransactionByStoreId(StoreId);
                responseData.Status = "OK";
            }
            catch (Exception ex)
            {
                responseData.Status = "Failed";
                responseData.ErrorMessage = ex.Message + " exception details:" + ex.ToString();
            }
            return Ok(responseData);
        }

        [HttpGet("GetAllStoresForTransfer")]
        public IActionResult GetAllStoresForTransfer()
        {
            try
            {
                responseData.Results = _dispensaryTransferService.GetAllStoresForTransfer();
                responseData.Status = "OK";
            }
            catch (Exception ex)
            {
                responseData.Status = "Failed";
                responseData.ErrorMessage = ex.Message + " exception details:" + ex.ToString();
            }
            return Ok(responseData);
        }


        [HttpGet("GetDispensariesStock/{DispensaryId}")]
        public async Task<IActionResult> GetDispensariesStock([FromRoute] int DispensaryId)
        {
            try
            {
                responseData.Results = await _dispensaryTransferService.GetAllDispensaryStocks(DispensaryId);
                responseData.Status = "OK";
            }
            catch (Exception ex)
            {
                responseData.Status = "Failed";
                responseData.ErrorMessage = ex.Message + " exception details:" + ex.ToString();
            }
            return Ok(responseData);
        }

        [HttpPost]
        public IActionResult Post([FromBody] List<StockTransferModel> transferedStock)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                if (transferedStock != null)
                {
                    var currentUser = HttpContext.Session.Get<RbacUser>("currentuser");
                    var TransferResponse = _dispensaryTransferService.TransferStock(transferedStock, currentUser);
                    responseData.Results = TransferResponse;
                    responseData.Status = "OK";
                }
            }
            catch (Exception ex)
            {
                responseData.Status = "Failed";
                responseData.ErrorMessage = ex.Message + " exception details:" + ex.ToString();
            }
            return Ok(responseData);
        }

        #endregion
    }
}

