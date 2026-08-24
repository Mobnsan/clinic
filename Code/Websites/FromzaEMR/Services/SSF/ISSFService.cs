using FromzaEMR.DalLayer;
using FromzaEMR.Security;
using FromzaEMR.ServerModel.PatientModels;
using FromzaEMR.ServerModel.SSFModels;
using FromzaEMR.ServerModel.SSFModels.SSFResponse;
using FromzaEMR.Services.SSF.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Threading.Tasks;

namespace FromzaEMR.Services.SSF
{
    public interface ISSFService
    {
        Task<SSFPatientDetails> GetPatientDetails(SSFDbContext ssfDbContext,string patientNo);
        Task<List<EligibilityResponse>> GetElegibility(SSFDbContext ssfDbContext,string patientNo, string visitDate);
        Task<List<List<Company>>> GetEmployerList(SSFDbContext ssfDbContext, string SSFPatientUUID);
        Task<SSFClaimSubmissionOutput> SubmitClaim(SSFDbContext ssfDbContext, ClaimRoot claimRoot, SSFClaimResponseInfo responseInfo);
        Task<ClaimBookingResponse> BookClaim(SSFDbContext ssfDbContext, ClaimBookingRoot_DTO claimBooking, RbacUser currentUser);
        Task<EmployerRoot> GetClaimDetail(SSFDbContext ssfDbContext, string ClaimUUID);
        Task<object> GetClaimBookingDetail(SSFDbContext ssfDbContext, Int64 claimCode);
        Task<bool> IsClaimed(SSFDbContext sSFDbContext, Int64 claimCode, int patientId); //this will not hit SSF server, Krishna'15thNov'22
        Task<PatientSchemeMapModel> GetSSFPatientDetailLocally(SSFDbContext sSFDbContext, int patientId, int schemeId);
    }
}

