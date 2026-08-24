using FromzaEMR.CommonTypes;
using FromzaEMR.Controllers.Stickers.DTOs;
using FromzaEMR.Core.Configuration;
using FromzaEMR.DalLayer;
using FromzaEMR.Enums;
using FromzaEMR.Security;
using FromzaEMR.ServerModel;
using FromzaEMR.Utilities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace FromzaEMR.Controllers
{
    [Route("api/[controller]")]
    public class StickersController : CommonController
    {
        private readonly MasterDbContext _masterDbContext;
        FromzaHTTPResponse<object> responseData = new FromzaHTTPResponse<object>();
        public StickersController(IOptions<MyConfiguration> _config) : base(_config)
        {
            _masterDbContext = new MasterDbContext(connString);

        }
        [HttpGet]
        [Route("GetPatientStickerDetails")]
        public string GetPatientStickerDetails(int PatientId)
        {
            FromzaHTTPResponse<List<PatientStickerModel>> responseData = new FromzaHTTPResponse<List<PatientStickerModel>>();
            try
            {
                PatientDbContext patDbContext = new PatientDbContext(connString);
                StickersBL stick = new StickersBL();
                var res = stick.GetPatientStickerDetails(patDbContext, PatientId);
                responseData.Status = "OK";
                responseData.Results = res;
            }
            catch (Exception ex)
            {
                responseData.Status = "Failed";
                responseData.ErrorMessage = ex.Message;
            }
            return FromzaJSONConvert.SerializeObject(responseData);
        }

        [HttpGet]
        [Route("RegistrationStickerSettingsAndData")]
        public IActionResult RegistrationStickerSettingsAndData(int PatientVisitId)
        {         
            Func<object> func = () => GetRegistrationStickerSettingsAndData(PatientVisitId);
            return InvokeHttpGetFunction(func);
        }
        private object GetRegistrationStickerSettingsAndData(int PatientVisitId)
        {
            List<SqlParameter> paramList = new List<SqlParameter>() {
                        new SqlParameter("@PatientVisitId", PatientVisitId)
                    };

            DataSet dataset = DALFunctions.GetDatasetFromStoredProc("SP_VIS_GetVisitStickerSettingsAndData", paramList, _masterDbContext);
            DataTable stickersettings = dataset.Tables[0];
            DataTable stickerdata = dataset.Tables[1];
            StickerSettingsAndData_DTO settingsAndData_DTO = new StickerSettingsAndData_DTO();
            settingsAndData_DTO.StickerSettings = RegistrationStickerSettings_DTO.MapDataTableToSingleObject(stickersettings);
            settingsAndData_DTO.StickerData = VisitStickerData_DTO.MapDataTableToSingleObject(stickerdata);
            return (settingsAndData_DTO);
        }
    }
}

