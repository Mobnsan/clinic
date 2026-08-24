using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FromzaEMR.ServerModel
{
    public class CoreCFGLookupModel
    {
        [Key]
        public int LookUpId { get; set; }
        public string ModuleName { get; set; }
        public string LookUpName { get; set; }
        public string LookupDataJson { get; set; }
        public string Description { get; set; }
    }
}

