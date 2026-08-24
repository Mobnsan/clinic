using FromzaEMR.DalLayer;
using FromzaEMR.Security;
using FromzaEMR.Services.ProcessConfirmation.DTO;

namespace FromzaEMR.Services.ProcessConfirmation
{
    public interface IProcessConfirmationService
    {
        object ConfirmProcess(ProcessConfirmationUserCredentials_DTO processConfirmationUserCredentials);
    }
}

