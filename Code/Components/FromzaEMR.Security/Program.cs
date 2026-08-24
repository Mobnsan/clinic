using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;


namespace FromzaEMR.Security
{
    class Program
    {
        static string connStr = ConfigurationManager.ConnectionStrings["RBAC_Connection"].ConnectionString;

        public static void Main(string[] args)
        {
            TestRoutes();
             
        }


        static void TestRoutes()
        {

            RbacDbContext dbContext = new RbacDbContext(connStr);

            List<FromzaRoute> allUserRoutes = RBAC.GetRoutesForUser(11);

            //below works fine..
            //List<RbacUser> allUsers = dbContext.Users.ToList();
            //List<RbacApplication> applications = dbContext.Applications.ToList();
            //List<RbacPermission> permissions = dbContext.Permissions.ToList();
            //List<RbacRole> roles = dbContext.Roles.ToList();
            //List<FromzaRoute> routes = dbContext.Routes.ToList();
            //List<UserRoleMap> userrolemaps = dbContext.UserRoleMaps.ToList();
            //List<RolePermissionMap> rolePermMaps = dbContext.RolePermissionMaps.ToList();
        }

        public static List<FromzaRoute> GetAllRoutes()
        {
            List<FromzaRoute> retList = new List<FromzaRoute>();
            retList.Add(new FromzaRoute() { DisplayName = "Dashboard", RouteId = 1, ParentRouteId = null });
            retList.Add(new FromzaRoute() { DisplayName = "Appointment", RouteId = 1, ParentRouteId = null });
            retList.Add(new FromzaRoute() { DisplayName = "Clinical", RouteId = 1, ParentRouteId = null });


            return retList;
        }

    }
}

