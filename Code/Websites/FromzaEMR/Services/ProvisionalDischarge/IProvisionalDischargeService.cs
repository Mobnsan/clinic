using FromzaEMR.DalLayer;
using FromzaEMR.Security;
using FromzaEMR.Services.ProvisionalDischarge.DTO;

namespace FromzaEMR.Services.ProvisionalDischarge
{
    public interface IProvisionalDischargeService
    {
        object PostProvisionalDischarge(BillingDbContext billingDbContext,ProvisionalDischarge_DTO provisionalDischarge, RbacUser currentUser);
        object PostPayProvisional(BillingDbContext billingDbContext,string postDataString, RbacUser currentUser, string connString);
        object DiscardProvisionalItems(BillingDbContext billingDbContext,DiscardProvisionalItems_DTO discardProvisionalItems, RbacUser currentUser);
        object GetProvisionalDischargeList(BillingDbContext billingDbContext);
        object GetProvisionalDischargeItems(BillingDbContext billingDbContext, int patientId, int schemeId, int patientVisitId);
    }
}

