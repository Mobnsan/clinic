using System;
using FromzaEMR.ServerModel;

namespace FromzaEMR.ServerModel
{
    public class VerificationViewModel
    {
        public int VerificationId { get; set; }
        public EmployeeModel VerifiedBy { get; set; }
        public DateTime VerifiedOn { get; set; }
        public int CurrentVerificationLevel { get; set; }
        public string VerificationStatus { get; set; }
        public string VerificationRemarks { get; set; }

    }
}
