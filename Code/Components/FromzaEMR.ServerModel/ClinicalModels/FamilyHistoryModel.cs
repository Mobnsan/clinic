using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


using FromzaEMR.ServerModel.ClinicalModels;

namespace FromzaEMR.ServerModel
{
    public class FamilyHistory:ProblemList
    {
        [Key]
        public int FamilyProblemId { get; set; }
       
        public string Relationship { get; set; }
        public string Note { get; set; }
        public virtual PatientModel Patient { get; set; }

    }
}

