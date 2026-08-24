using System.Threading.Tasks;

namespace FromzaEMR.Services
{
    public interface INepaliReceiptService
    {
        Task<DonationGRVm> GetDonationGRView(int GoodsReceiptId);
        NepaliRequisitionVm GetNepaliRequisitionView(int RequisitionId, string ModuleType);
        NepaliDispatchVm GetNepaliDispatchView(int DispatchId, int RequisitionId, string ModuleType);
    }
}

