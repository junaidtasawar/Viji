using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicBO
{ 
    public class CallLogModel
    {
        public Int64 CallLogId { get; set; }
        public Int64 PatientId { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public DateTime Duration { get; set; }
        public string PatientName { get; set; }
        public string ClinicName { get; set; }
        public string TotalCallDuration { get; set; }


        public static string GetCallLogs = "SP_GetCallLogs";

        public List<CallLogModel> GetCallLogReport(long userId)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@UserID", userId);
            return TransformCallLog(DBManager.GetDataSet(GetCallLogs, parameters));
        }

        private List<CallLogModel> TransformCallLog(DataSet dataSet)
        {
            List<CallLogModel> callLogList = new List<CallLogModel>();
            string clinicName = string.Empty;
            string totalCallDuration = string.Empty;
            if (dataSet.Tables.Count > 0)
            {
                if (dataSet.Tables[0].Rows.Count > 0)
                {
                    clinicName = Convert.ToString(dataSet.Tables[0].Rows[0]["ClinicName"]);
                }
                if (dataSet.Tables[2].Rows.Count > 0)
                {
                    totalCallDuration = Convert.ToString(dataSet.Tables[2].Rows[0]["TotalCallDuration"]);
                }
                if (dataSet.Tables[1].Rows.Count > 0)
                {
                    foreach (var item in dataSet.Tables[1].AsEnumerable())
                    {
                        CallLogModel obj = new CallLogModel();
                        obj.PatientName = Convert.ToString(item["PatientName"]);
                        obj.StartTime = Convert.ToDateTime(item["StartTime"]);
                        obj.EndTime = Convert.ToDateTime(item["EndTime"]);
                        obj.Duration = Convert.ToDateTime(item["Duration"]);
                        obj.TotalCallDuration = totalCallDuration;
                        obj.ClinicName = clinicName;
                        callLogList.Add(obj);
                    }
                }
                else
                {
                    CallLogModel obj = new CallLogModel();
                    obj.ClinicName = clinicName;
                    callLogList.Add(obj);
                }
            }
            return callLogList;
        }
    }
}
