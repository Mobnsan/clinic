using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FromzaEMR.ServerModel;
using FromzaEMR.ServerModel.NotificationModels;

namespace FromzaEMR.DalLayer
{
    public class NotiFicationDbContext : DbContext
    {
        
        public DbSet<NotificationViewModel> Notifications { get; set; }
        public DbSet<VisitModel> PatientVisits { get; set; }

        public NotiFicationDbContext(string conn) : base(conn)
        {
            this.Configuration.LazyLoadingEnabled = true;
            this.Configuration.ProxyCreationEnabled = false;

        }
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<System.Data.Entity.ModelConfiguration.Conventions.OneToManyCascadeDeleteConvention>();
            modelBuilder.Entity<NotificationViewModel>().ToTable("CORE_Notification");
            modelBuilder.Entity<VisitModel>().ToTable("PAT_PatientVisits");
        }
    }
}


