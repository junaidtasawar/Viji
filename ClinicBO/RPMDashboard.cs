using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicBO
{
    public class RPMDashboard : UtilityModel
    {
        public Int64 RPMReportID { get; set; }
        public string DeviceID { get; set; }
        public Int64 PatientID { get; set; }
        public string PatientName { get; set; }
        public int? BP { get; set; }
        public string BPStr { get; set; }
        public int? Glucose { get; set; }
        public string GlucoseStr { get; set; }
        public string Status { get; set; }
        public string MobileNumber { get; set; }
        public string Notes { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedDateStr { get; set; }
        public string RPMInteractionTime { get; set; }
        public string RemainingBlockTime { get; set; }
        public string MissedReadingDays { get; set; }
        public string WellNessCall { get; set; }
        public long LoginUserID { get; set; }
        public string Clinic1 { get; set; }
        public string Clinic2 { get; set; }
        public string Clinic3 { get; set; }

        public static string GetRPMReportData_Forlist = "SP_GetRPMReportData_Forlist";
        public static string querySetDeviceStatus = "sp_SetDeviceStatus";
        public List<RPMDashboard> GetRPMReportData_ForList(RPMDashboard rpmDashboard)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@Status", rpmDashboard.Status);
            parameters.Add("@CurrentPage", rpmDashboard.CurrentPage);
            parameters.Add("@NumberOfRecords", rpmDashboard.NumberOfRecords);
            parameters.Add("@OrderBy", rpmDashboard.OrderBy);
            parameters.Add("@LoginUserID", rpmDashboard.LoginUserID);
            parameters.Add("@clinic1", rpmDashboard.Clinic1);
            parameters.Add("@clinic2", rpmDashboard.Clinic2);
            parameters.Add("@clinic3", rpmDashboard.Clinic3);
            DataSet ds = DBManager.GetDataSet(GetRPMReportData_Forlist, parameters);
            return GetRPMReportDataList(ds);
        }

        public List<RPMDashboard> GetRPMReportDataList(DataSet ds)
        {
            var messages = new List<RPMDashboard>();
            int totalCount = 0;

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[1].Rows.Count > 0)
                {
                    DataTable dataTable = ds.Tables[1];
                    totalCount = ds.Tables[1].Rows.Count;

                    foreach (var item in dataTable.AsEnumerable())
                    {
                        try
                        {
                            int differenceInDays = 0;

                            if (item["CreatedDate"] != DBNull.Value)
                            {
                                DateTime date = Convert.ToDateTime(item["CreatedDate"]);
                                TimeSpan ts = DateTime.Now - date;
                                differenceInDays = ts.Days;
                            }
                            else
                            {
                                differenceInDays = 0;
                            }

                            item["MissedReadingDays"] = differenceInDays;
                            RPMDashboard obj = new RPMDashboard();
                            obj.RPMReportID = Convert.ToInt64(item["RPMReportID"]);
                            obj.PatientID = Convert.ToInt64(item["PatientID"]);
                            obj.PatientName = item["PatientName"].ToString();
                            obj.DeviceID = item["DeviceID"].ToString();
                            obj.Status = item["Status"].ToString();
                            obj.BPStr = (item["BP"] != DBNull.Value) ? item["BP"].ToString() : "No Reading";
                            obj.GlucoseStr = (item["Glucose"] != DBNull.Value) ? item["Glucose"].ToString() : "No Reading";
                            obj.MobileNumber = (item["MobileNumber"] != DBNull.Value) ? item["MobileNumber"].ToString() : "No Reading";
                            obj.RPMInteractionTime = (item["RPMInteractionTime"] != DBNull.Value) ? item["RPMInteractionTime"].ToString() : "No Reading";
                            obj.RemainingBlockTime = (item["RemainingBlockTime"] != DBNull.Value) ? item["RemainingBlockTime"].ToString() : "No Reading";
                            obj.MissedReadingDays = (item["MissedReadingDays"] != DBNull.Value) ? item["MissedReadingDays"].ToString() : "No Reading";
                            obj.CreatedDateStr = (item["CreatedDate"] != DBNull.Value) ? item["CreatedDate"].ToString() : "No Reading";
                            obj.WellNessCall = item["WellnessCall"].ToString();
                            //obj.TotalCount = totalCount;
                            messages.Add(obj);
                        }
                        catch (Exception)
                        {
                            continue;
                        }
                    }
                }
            }
            return messages;
        }

        public int SetDeviceStatus(string deviceId, string deviceName, bool isActive)
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@deviceId", deviceId);
            parameters.Add("@deviceName", deviceName);
            parameters.Add("@isActive", isActive);
            DBManager.CreateUpdateData(querySetDeviceStatus, parameters, out RecordID);
            return 1;
        }
    }
}

