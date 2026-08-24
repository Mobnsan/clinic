using FromzaEMR.CommonTypes;
using FromzaEMR.Core.Configuration;
using FromzaEMR.DalLayer;
using FromzaEMR.Enums;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace FromzaEMR.Controllers.Patient
{
    public class PatientDashboardController : Controller
    {
       
        private readonly string connString = null;
        private PatientDbContext patientDbContext;
        public FromzaHTTPResponse<object> responseData = new FromzaHTTPResponse<object>();
        public PatientDashboardController(IOptions<MyConfiguration> _config)
        {
            connString = _config.Value.Connectionstring;
            patientDbContext = new PatientDbContext(connString);
        }
        public async Task<IActionResult> GetPatientDashboardCardSummaryCalculation(DateTime FromDate, DateTime ToDate)
        {
            try
            {
                List<SqlParameter> paramList = new List<SqlParameter>()  {
                            new SqlParameter("@FromDate", FromDate),
                            new SqlParameter("@ToDate", ToDate)
            };
                DataSet dataSet = await Task.Run(() => DALFunctions.GetDatasetFromStoredProc("SP_Dashboard_PAT_CardSummaryCalculation", paramList, patientDbContext));

                var results = new
                {
                    Patients = dataSet.Tables[0],
                    Doctors = dataSet.Tables[1],
                    Appointments = dataSet.Tables[2],
                    ReAdmission = dataSet.Tables[3]
                };
                responseData.Results = results;
                responseData.Status = ENUM_FromzaHttpResponseText.OK;
            }
            catch (Exception ex)
            {
                System.IO.File.WriteAllText(@"C:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\dashboard_error.txt", ex.ToString());
                System.IO.File.WriteAllText(@"C:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\dashboard_error.txt", ex.ToString());
                responseData.Status = ENUM_FromzaHttpResponseText.Failed;
                responseData.ErrorMessage = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
            }
            return Ok(responseData);
        }

        public async Task<IActionResult> GetPatientCountByDay(DateTime FromDate, DateTime ToDate)
        {
            try
            {
                List<SqlParameter> paramList = new List<SqlParameter>()  {
                            new SqlParameter("@FromDate", FromDate),
                            new SqlParameter("@ToDate", ToDate)
            };
                DataTable result = await Task.Run(() => DALFunctions.GetDataTableFromStoredProc("SP_Dashboard_PAT_PatientCountByDay", paramList, patientDbContext));
                responseData.Results = result;
                responseData.Status = ENUM_FromzaHttpResponseText.OK;
            }
            catch (Exception ex)
            {
                System.IO.File.WriteAllText(@"C:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\dashboard_error.txt", ex.ToString());
                responseData.Status = ENUM_FromzaHttpResponseText.Failed;
                responseData.ErrorMessage = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
            }
            return Ok(responseData);
        }

        public async Task<IActionResult> GetAverageTreatmentCostbyAgeGroup(DateTime FromDate, DateTime ToDate)
        {
            try
            {
                List<SqlParameter> paramList = new List<SqlParameter>()  {
                            new SqlParameter("@FromDate", FromDate),
                            new SqlParameter("@ToDate", ToDate)
            };
                DataTable result = await Task.Run(() => DALFunctions.GetDataTableFromStoredProc("SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup", paramList, patientDbContext));
                responseData.Results = result;
                responseData.Status = ENUM_FromzaHttpResponseText.OK;
            }
            catch (Exception ex)
            {
                System.IO.File.WriteAllText(@"C:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\dashboard_error.txt", ex.ToString());
                responseData.Status = ENUM_FromzaHttpResponseText.Failed;
                responseData.ErrorMessage = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
            }
            return Ok(responseData);
        }
        public async Task<IActionResult> GetDepartmentWiseAppointment(DateTime FromDate, DateTime ToDate)
        {
            try
            {
                List<SqlParameter> paramList = new List<SqlParameter>()  {
                            new SqlParameter("@FromDate", FromDate),
                            new SqlParameter("@ToDate", ToDate)
            };
                DataTable result = await Task.Run(() => DALFunctions.GetDataTableFromStoredProc("SP_Dashboard_PAT_DepartmentWiseAppointment", paramList, patientDbContext));
                responseData.Results = result;
                responseData.Status = ENUM_FromzaHttpResponseText.OK;
            }
            catch (Exception ex)
            {
                System.IO.File.WriteAllText(@"C:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\dashboard_error.txt", ex.ToString());
                responseData.Status = ENUM_FromzaHttpResponseText.Failed;
                responseData.ErrorMessage = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
            }
            return Ok(responseData);
        }
        public async Task<IActionResult> GetPAtVisitByMembership(DateTime FromDate, DateTime ToDate)
        {
            try
            {
                List<SqlParameter> paramList = new List<SqlParameter>()  {
                            new SqlParameter("@FromDate", FromDate),
                            new SqlParameter("@ToDate", ToDate)
            };
                DataTable result = await Task.Run(() => DALFunctions.GetDataTableFromStoredProc("SP_Dashboard_PAT_VisitByMembership", paramList, patientDbContext));
                responseData.Results = result;
                responseData.Status = ENUM_FromzaHttpResponseText.OK;
            }
            catch (Exception ex)
            {
                System.IO.File.WriteAllText(@"C:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\dashboard_error.txt", ex.ToString());
                responseData.Status = ENUM_FromzaHttpResponseText.Failed;
                responseData.ErrorMessage = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
            }
            return Ok(responseData);
        }
        public async Task<IActionResult> GetPatientDistributionBasedOnRank(DateTime FromDate, DateTime ToDate, int? DepartmentId)
        {
            try
            {
                List<SqlParameter> paramList = new List<SqlParameter>()  {
                            new SqlParameter("@FromDate", FromDate),
                            new SqlParameter("@ToDate", ToDate),
                            new SqlParameter("@DepartmentId", (object)DepartmentId ?? DBNull.Value)
            };
                DataTable result = await Task.Run(() => DALFunctions.GetDataTableFromStoredProc("SP_Dashboard_PAT_PatientDistributionBasedOnRank", paramList, patientDbContext));
                responseData.Results = result;
                responseData.Status = ENUM_FromzaHttpResponseText.OK;
            }
            catch (Exception ex)
            {
                System.IO.File.WriteAllText(@"C:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\dashboard_error.txt", ex.ToString());
                responseData.Status = ENUM_FromzaHttpResponseText.Failed;
                responseData.ErrorMessage = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
            }
            return Ok(responseData);
        }
        public async Task<IActionResult> GetHospitalManagement(DateTime FromDate, DateTime ToDate)
        {
            try
            {
                List<SqlParameter> paramList = new List<SqlParameter>()  {
                            new SqlParameter("@FromDate", FromDate),
                            new SqlParameter("@ToDate", ToDate)
            };
                DataTable result = await Task.Run(() => DALFunctions.GetDataTableFromStoredProc("SP_Dashboard_PAT_HospitalManagement", paramList, patientDbContext));
                responseData.Results = result;
                responseData.Status = ENUM_FromzaHttpResponseText.OK;
            }
            catch (Exception ex)
            {
                System.IO.File.WriteAllText(@"C:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\dashboard_error.txt", ex.ToString());
                responseData.Status = ENUM_FromzaHttpResponseText.Failed;
                responseData.ErrorMessage = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
            }
            return Ok(responseData);
        }
    }
}

