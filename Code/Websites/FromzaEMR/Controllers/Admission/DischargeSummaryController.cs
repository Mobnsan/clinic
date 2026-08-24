using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using FromzaEMR.Core.Configuration;
using FromzaEMR.ServerModel;
using FromzaEMR.DalLayer;
using System.Data.Entity;
using Microsoft.Extensions.Options;
using FromzaEMR.Utilities;
using FromzaEMR.CommonTypes;
using FromzaEMR.Core.Caching;
using FromzaEMR.Security;
using FromzaEMR.Controllers.Billing;

namespace FromzaEMR.Controllers
{
    public class DischargeSummaryController : CommonController
    {
        double cacheExpMinutes;//= 5;//this should come from configuration later on.

        public DischargeSummaryController(IOptions<MyConfiguration> _config) : base(_config)
        {
            cacheExpMinutes = _config.Value.CacheExpirationMinutes;
        }

        //[HttpGet]
        //public string Get(string reqType,
        //    int patientId, int patientVisitId,
        //    string admissionStatus, int wardId,
        //    int bedFeatureId, int ipVisitId,
        //    int bedId)
        //{
        //    FromzaHTTPResponse<object> responseData = new FromzaHTTPResponse<object>();
        //    try
        //    {
        //        AdmissionDbContext dbContext = new AdmissionDbContext(base.connString);
        //        MasterDbContext masterDbContext = new MasterDbContext(base.connString);



        //        if (reqType == "getADTList")
        //        {
        //            return "1vcncncvn";
        //        }
        //    }
        //    catch(Exception ex)
        //    {
        //        return "vcvbcnvn";
        //    }       
        //}
    }
}
