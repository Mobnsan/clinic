using System.ComponentModel.DataAnnotations;

namespace FromzaEMR.ServerModel.Utilities
{
    public class ProcessConfirmationAuthorityModel
    {
        [Key]
        public int ProcessConfirmationAuthorityId { get; set; }
        public string ProcessToConfirm { get; set; }
        public int PermissionId { get; set; }
        public int RoleId { get; set; }
    }
}

