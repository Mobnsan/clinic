using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FromzaEMR.ServerModel
{
    public class EmpDueAmountModel
    {
        [Key]
        public int EmployeeDueId { get; set; }
        public int EmployeeId { get; set; }
        public double? LatestDueAmount { get; set; }
        public DateTime LatestTransactionDate { get; set; }
        [NotMapped]
        public double? PendingReceiveAmount { get; set; }
        [NotMapped]
        public double? PendingOutgoingUser { get; set; }
        [NotMapped]
        public double? PendingOutgoingAccount { get; set; }
    }
}

