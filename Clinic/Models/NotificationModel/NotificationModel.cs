using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Clinic.Models.NotificationModel
{
    public class NotificationModel
    {

        public Int64 RPMReportID { get; set; }
        public string DeviceID { get; set; }
        public Int64 PatientID { get; set; }
        public string PatientName { get; set; }
        public int? BP { get; set; }
        public string BPStr { get; set; }
        public DateTime Notification_Time { get; set; }


        public static string GetNotificationData_Forlist = "SP_GetAllNotification";

        public static string RegisterNotification = "SP_RegisterNotifications";



        //internal List<NotificationModel> GetData(DateTime afterdate)
        //{
        //    return DBManager.GetList(GetNotificationData_Forlist);
        //}


    



    }
}