using FromzaEMR.ServerModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FromzaEMR.Services
{
    public interface IActivateInventoryService
    {
        IList<ActivateInventoryDTO> GetAllInventories();
        PHRMStoreModel GetInventory(int id);
    }
}

