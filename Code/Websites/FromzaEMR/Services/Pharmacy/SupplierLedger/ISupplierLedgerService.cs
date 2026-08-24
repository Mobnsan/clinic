using FromzaEMR.Security;
using FromzaEMR.ViewModel.Pharmacy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FromzaEMR.Services.Pharmacy.SupplierLedger
{
    public interface ISupplierLedgerService
    {
        Task<GetSupplierLedgerGRDetailsVM> GetSupplierLedgerGRDetails(int supplierId);
        Task<GetPHRMSupplierLedgerVM> GetAllAsync();
        int MakeSupplierLedgerPayment(IList<MakeSupplierLedgerPaymentVM> ledgerTxn, RbacUser currentUser);
    }
}

