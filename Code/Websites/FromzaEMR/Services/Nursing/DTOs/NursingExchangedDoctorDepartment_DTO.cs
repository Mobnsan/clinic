using FromzaEMR.Controllers.Nursing.DTOs;
using System.Collections.Generic;

namespace FromzaEMR.Services.Nursing.DTOs
{
    public class NursingExchangedDoctorDepartment_DTO
    {
        public int PatientVisitId { get; set; }
        public int ExchangedDoctorId { get; set; }
        public string ExchangedDoctorName { get; set; }
        public int ExchangedDepartmentId { get; set; }
        public string ExchangedRemarks { get; set; }
        public List<AddFinalDiagnosis_DTO> DiagnosisList { get; set; }
    }
}

