using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ClinicBO
{
    public class NotificationModel
    {

        //public Int64 RPMReportID { get; set; }
        //public string DeviceID { get; set; }
        //public Int64 PatientID { get; set; }
        public string PatientName { get; set; }
        public string BP { get; set; }
        //public string BPStr { get; set; }
        public DateTime Notification_Time { get; set; }


        public static string GetNotificationData_Forlist = "SP_GetAllNotification";

     

      
        //public List<NotificationModel> GetData(DateTime afterdate)
        //{
        //    return DBManager.GetList(GetNotificationData_Forlist);
        //}

        public List<NotificationModel> GetData(DateTime afterdate)
        {
            //return DBManager.GetList(GetNotificationData_Forlist);
            //return DBManager.ExecuteSP<NotificationModel>(GetNotificationData_Forlist);
            List<NotificationModel> criteria = DBManager.GetList<NotificationModel>(GetNotificationData_Forlist);

            return criteria;
        }

    }
}