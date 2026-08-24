using FromzaEMR.ServerModel;
using FromzaEMR.ServerModel.FractionModels;
using FromzaEMR.ServerModel.PharmacyModels;
using FromzaEMR.ViewModel.Pharmacy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FromzaEMR.Services
{
    public interface IFractionPercentService
    {
        List<FractionPercentVM> ListFractionApplicableItems();
        FractionPercentVM AddFractionPercent(FractionPercentModel model);
        FractionPercentVM UpdateFractionPercent(FractionPercentModel model);
        FractionPercentVM GetFractionPercent(int id);
        FractionPercentVM GetFractionPercentByBillPriceId(int id);

    }
}

