using FromzaEMR.ServerModel;
using FromzaEMR.ServerModel.PharmacyModels;
using FromzaEMR.ViewModel.Pharmacy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FromzaEMR.Services
{
    public interface IDesignationService
    {
        List<DesignationModel> ListDesignation();
        DesignationModel AddDesignation(DesignationModel model);
        DesignationModel UpdateDesignation(DesignationModel model);
        DesignationModel GetDesignation(int id);
    }
}

