using FromzaEMR.Security;
using FromzaEMR.ServerModel;
using FromzaEMR.ViewModel.Dispensary;
using System;
using System.Threading.Tasks;

namespace FromzaEMR.Services.Dispensary
{
    public interface IDispensaryRequisitionService
    {
        Task<GetAllRequisitionVm> GetAllAsync(DateTime FromDate, DateTime ToDate);
        Task<GetAllRequisitionByDispensaryIdVm> GetAllByDispensaryIdAsync(int id, DateTime FromDate, DateTime ToDate);
        Task<GetRequisitionViewVm> GetRequisitionViewByIdAsync(int id);
        Task<GetItemsForRequisitionVm> GetItemsForRequisition(bool IsInsurance);
        Task<int> AddDispensaryRequisition(PHRMStoreRequisitionModel value);
        PHRMStoreRequisitionModel UpdateDispensaryRequisition(PHRMStoreRequisitionModel value);
        Task<RequisitionDispatchToReceive_DTO> GetRequisitionDispatchToReceiveAsync(int RequisitionId);
        Task<int> ReceiveDispatchedStocks(int dispatchId, string receivedRemarks, RbacUser currentUser);
        Task<int> ApproveRequisition(int requisitionId, RbacUser currentUser);
        Task<bool> CancelRequisitionItems(CanceRequisitionItemsQueryModel value, RbacUser currentUser);
    }
}

