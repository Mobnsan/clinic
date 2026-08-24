using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//added this namespace to get [notmapped]
using FromzaEMR.ServerModel.ClinicalModels;

namespace FromzaEMR.ServerModel
{
    public class SurgicalHistory: ProblemList
    {
        [Key]
        public int SurgicalHistoryId { get; set; }
        public string SurgeryType { get; set; }
        public string Note { get; set; }
        public DateTime? SurgeryDate { get; set; }
        public virtual PatientModel Patient { get; set; }

    }
}

