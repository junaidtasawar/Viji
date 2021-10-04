using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Clinic.Models.Dashboard
{
    public class DashboardModel : Clinic.Models.UtilityModel.UtilityModel
    {
        public int TotalClinic { get; set; }
        public int TotalPatient { get; set; }
        public int TotalUser { get; set; }

        public static string GetDashboardData_SP = "SP_GetDashboardData";

        public DashboardModel GetDashboardData()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CreatedBy", CreatedBy);
            return TransformDashboardData(DBManager.GetData(GetDashboardData_SP, parameters));
        }

        public DashboardModel TransformDashboardData(DataTable data)
        {
            DashboardModel obj = new DashboardModel();
            obj.TotalClinic = (data.Rows[0]["TotalClinic"] == DBNull.Value) ? 0 : Convert.ToInt32(data.Rows[0]["TotalClinic"]);
            obj.TotalUser = (data.Rows[0]["TotalUser"] == DBNull.Value) ? 0 : Convert.ToInt32(data.Rows[0]["TotalUser"]);
            obj.TotalPatient = (data.Rows[0]["TotalPatient"] == DBNull.Value) ? 0 : Convert.ToInt32(data.Rows[0]["TotalPatient"]);
            return obj;
        }
    }
}