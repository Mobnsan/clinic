using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FromzaEMR.ServerModel
{
    public class MaternityRegisterVM
    {
        public MaternityPatient MaternityPatient { get; set; }
        public List<MaternityRegister> MaternityDetails { get; set; }
    }
}

