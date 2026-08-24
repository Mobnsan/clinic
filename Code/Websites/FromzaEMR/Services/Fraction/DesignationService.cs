using System;
using System.Collections.Generic;
using System.Linq;
using FromzaEMR.DalLayer;
using FromzaEMR.Core.Configuration;
using Microsoft.Extensions.Options;
using FromzaEMR.ServerModel;

namespace FromzaEMR.Services
{
    public class DesignationService : IDesignationService
    {
        public FractionDbContext db;
        private readonly string connString = null;

        public DesignationService(IOptions<MyConfiguration> _config)
        {
            connString = _config.Value.Connectionstring;
            db = new FractionDbContext(connString);
        }

        public List<DesignationModel> ListDesignation()
        {
            //todo:add server side pagination
            var query = db.Designation.ToList();
            return query;
        }

        public DesignationModel AddDesignation(DesignationModel model)
        {
            model.CreatedOn = DateTime.Now;
            db.Designation.Add(model);
            db.SaveChanges();
            return model;
        }

        public DesignationModel UpdateDesignation(DesignationModel model)
        {
            db.Entry(model).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return model;
        }

        public DesignationModel GetDesignation(int id)
        {
            var result = db.Designation.Where(x => x.DesignationId == id).FirstOrDefault();      
            return result;
        }       
    }
}

