using FromzaEMR.DalLayer;
using FromzaEMR.Security;
using FromzaEMR.Services.MarketingReferral.DTOs;
using FromzaEMR.Services.Utilities.DTOs;
using System;

namespace FromzaEMR.Services.MarketingReferral
{
    public interface IMarketingReferralService
    {
        object GetInvoice(MarketingReferralDbContext marketingReferralDbContext, DateTime fromDate, DateTime toDate);
        object GetBillDetails(MarketingReferralDbContext marketingReferralDbContext,int billTransactionId);
        object GetReferralScheme(MarketingReferralDbContext marketingReferralDbContext);
        object GetReferringParty(MarketingReferralDbContext marketingReferralDbContext);
        object GetReferringPartyGroup(MarketingReferralDbContext marketingReferralDbContext);
        object GetReferringOrganizationList(MarketingReferralDbContext marketingReferralDbContext);
        object GetAlreadyAddedCommission(MarketingReferralDbContext marketingReferralDbContext, int billTransactionId);
        object GetMarketingreferralDetailReport(MarketingReferralDbContext marketingReferralDbContext, DateTime fromDate, DateTime toDate, int? ReferralComissionId);
        object DeleteReferralCommission(MarketingReferralDbContext marketingReferralDbContext, int ReferralCommissionId);
        object AddNewReferralComission(RbacUser currentUser, ReferralCommission_DTO referralCommission_DTO, MarketingReferralDbContext marketingReferralDbContext);
        object AddNewReferringOrganization(RbacUser currentUser, ReferringOrganization_DTO referringOrganization_DTO, MarketingReferralDbContext marketingReferralDbContext);
        object AddNewReferringParty(RbacUser currentUser, ReferringParty_DTO referringParty_DTO, MarketingReferralDbContext marketingReferralDbContext);
        object UpdateReferringOrganization(RbacUser currentUser, ReferringOrganization_DTO referringOrganization_DTO, MarketingReferralDbContext marketingReferralDbContext);
        object UpdateReferringParty(RbacUser currentUser, ReferringParty_DTO referringParty_DTO, MarketingReferralDbContext marketingReferralDbContext);
        object UpdateActivateDeactivateOrganization( ReferringOrganization_DTO referringOrganization_DTO, RbacUser currentUser, MarketingReferralDbContext marketingReferralDbContext);
        object ActivateDeactivateParty(ReferringParty_DTO referringParty_DTO, RbacUser currentUser, MarketingReferralDbContext marketingReferralDbContext);

    }
}

