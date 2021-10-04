using ClinicBO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ClinicBO
{
    public class CCMModel :UtilityModel
    {

        public Int64 CCMNoteID { get; set; }
        public string CCMNoteText { get; set; }
        public string CCMNoteDescrption { get; set; }
        public DateTime CurrentDateTime { get; set; }
        public string CellNumber { get; set; }

        public Int64 PatientID { get; set; }
        public DateTime CurrentDate { get; set; }
        public string CurrentTime { get; set; }
        public string MinuteSpent { get; set; }
        public string Description { get; set; }
        public bool IsBillable { get; set; }
        public DateTime CCMDate { get; set; }
        public string TotalMinute { get; set; }
        public string Timespent { get; set; }
        public string PatientName { get; set; }
        public string CreatedByName { get; set; }
        public Int64 SerialNo { get; set; }
        public string CCMNoteDate { get; set; }
        public string HdnCCMNoteDescription { get; set; }
        public string PatientStatus { get; set; }
        public bool IsManualInputTime { get; set; }
        public string WellnessCallStatus { get; set; }
        public Int64 CallLogId { get; set; }

        public static string SaveCCMNoteInfoDetails_SP = "InsertCCMNotesInfoData";
        public static string InsertCCMNoteData_SP = "SP_InsertCCMNoteData";
        public static string GetCCMNoteData_SP = "SP_GetCCMNoteData";
        public static string GetCCMNoteDescription_SP = "SP_GetCCMNoteDescription";
        public static string GetCCMNoteMasterData_SP = "SP_GetCCMNoteMasterData";
        public static string GetCCMNoteDataForList_SP = "SP_GetCCMNoteDataForList";
        public static string GetCCMNoteByID = "SP_GetCCMNoteByID";
        public static string InsertCallLog = "SP_InsertCallLogs";


        internal long SaveCCMNoteInfoDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CCMNoteText", CCMNoteText);
            parameters.Add("@CCMNoteDescription", CCMNoteDescrption);
            DBManager.CreateUpdateData(SaveCCMNoteInfoDetails_SP, parameters, out RecordID);
            return RecordID;
        }

        internal List<CCMModel> GetCCMNoteData()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            return TransformCCMNoteData(DBManager.GetData(GetCCMNoteData_SP, parameters));
        }

        private List<CCMModel> TransformCCMNoteData(DataTable dataTable)
        {
            List<CCMModel> ccmnotesList = new List<CCMModel>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    CCMModel obj = new CCMModel();
                    obj.CCMNoteID = Convert.ToInt64(item["CCMNoteInfoId"]);
                    obj.CCMNoteText = Convert.ToString(item["CCMNoteText"]);
                    obj.CCMNoteDescrption = Convert.ToString(item["CCMNoteDescription"]);
                    obj.CurrentDateTime = DateTime.Now;
                    ccmnotesList.Add(obj);
                }
            }
            return ccmnotesList;
        }

        internal string getCCMNoteDescription(CCMModel model)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CCMNoteID", CCMNoteID);
            return TransformCCMNoteDesscription(DBManager.GetData(GetCCMNoteDescription_SP, parameters));
        }

        private string TransformCCMNoteDesscription(DataTable dataTable)
        {
            CCMModel obj = new CCMModel();

            if (dataTable.Rows.Count > 0)
            {
                return Convert.ToString(dataTable.Rows[0]["CCMNoteDescription"]);
            }
            return "";
        }

        internal long SaveCCMDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CCMNoteText", CCMNoteText);
            parameters.Add("@CCMNoteDescription", CCMNoteDescrption);
            DBManager.CreateUpdateData(SaveCCMNoteInfoDetails_SP, parameters, out RecordID);
            return RecordID;
        }
        public Int64 SaveCallLogs(Int64 PatientId, DateTime startTime, DateTime endTime, DateTime duration)
        {

            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientId);
            parameters.Add("@StartTime", startTime);
            parameters.Add("@EndTime", endTime);
            parameters.Add("@Duration", duration);


            DBManager.CreateUpdateData(InsertCallLog, parameters, out RecordID);
            return RecordID;


            //string connection = System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;
            //SqlConnection con = new SqlConnection(connection);
            //SqlCommand cmd = new SqlCommand(InsertCallLog, con);

            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("PatientID", PatientId);
            //cmd.Parameters.AddWithValue("startTime", startTime);
            //cmd.Parameters.AddWithValue("EndTime", endTime);
            //cmd.Parameters.AddWithValue("Duration", duration);

            //con.Open();
            //cmd.ExecuteNonQuery();


            //if (k != 0)
            //{
            //    Data(data.device_id);
            //}
            //con.Close();
        }

        internal long SaveCCMNoteDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CCMNoteID", CCMNoteID);
            parameters.Add("@PatientID", PatientID);
            parameters.Add("@Description", Description);
            parameters.Add("@CCMDate", CurrentDate);
            parameters.Add("@CCMTime", CurrentTime);
            parameters.Add("@TimeSpent", MinuteSpent);
            parameters.Add("@PatientStatus", PatientStatus);
            parameters.Add("@IsBillable", IsBillable);
            parameters.Add("@CreatedBy", CreatedBy);
            parameters.Add("@CallLogId", CallLogId);
            if (!string.IsNullOrEmpty(WellnessCallStatus))
            {
                parameters.Add("@WellnessStatus", WellnessCallStatus);
            }
            DBManager.CreateUpdateData(InsertCCMNoteData_SP, parameters, out RecordID);
            return RecordID;
        }

        internal CCMModel GetCCMDetails()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientID);
            return TransformCCMNoteDetails(DBManager.GetData(GetCCMNoteMasterData_SP, parameters));
        }

        private CCMModel TransformCCMNoteDetails(DataTable dataTable)
        {
            CCMModel obj = new CCMModel();
            if (dataTable.Rows.Count > 0)
            {
                obj.CCMNoteID = Convert.ToInt64(dataTable.Rows[0]["CCMNoteID"]);
                obj.Description = dataTable.Rows[0]["Description"].ToString();
                obj.IsBillable = Convert.ToBoolean(dataTable.Rows[0]["IsBillable"]);
                obj.CCMDate = Convert.ToDateTime(dataTable.Rows[0]["CCMDate"]);
                //CCMTime, TimeSpent, , IsInitialVisti
                //obj.CCMNoteID = Convert.ToInt64(item["CCMNoteInfoId"]);
                //obj.CCMNoteDescrption = Convert.ToString(item["CCMNoteText"]);
                //obj.CCMNoteText = Convert.ToString(item["CCMNoteDescription"]);
                //obj.CurrentDateTime = DateTime.Now;
            }
            return obj;
        }

        public List<CCMModel> GetCCMNoteData_ForList()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", CurrentPage);
            parameters.Add("@NumberOfRecords", NumberOfRecords);
            parameters.Add("@OrderBy", OrderBy);
            parameters.Add("@PatientID", PatientID);
            return TransformCCMNoteForListData(DBManager.GetData(GetCCMNoteDataForList_SP, parameters));
        }

        private List<CCMModel> TransformCCMNoteForListData(DataTable dataTable)
        {
            List<CCMModel> CCMNoteList = new List<CCMModel>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    CCMModel obj = new CCMModel();
                    obj.SerialNo = Convert.ToInt64(item["Number"]);
                    obj.PatientID = Convert.ToInt64(item["PatientID"]);
                    obj.CCMNoteID = Convert.ToInt64(item["CCMNoteID"]);
                    obj.Description = item["Description"].ToString();
                    obj.Timespent = item["TimeSpent"].ToString().Substring(0, 8);
                    obj.CCMNoteDate = item["CCMDate"].ToString();
                    obj.IsBillable = Convert.ToBoolean(item["IsBillable"]);
                    obj.TotalCount = Convert.ToInt32(item["TotalCount"]);
                    obj.PatientName = Convert.ToString(item["PatientName"]);
                    CCMNoteList.Add(obj);
                }
            }
            return CCMNoteList;
        }

        public CCMModel GetCCMDetailsByID()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CCMNoteID", CCMNoteID);
            parameters.Add("@PatientID", PatientID);
            return TransformGetCCMDetailsByID(DBManager.GetData(GetCCMNoteByID, parameters));
        }

        public CCMModel TransformGetCCMDetailsByID(DataTable dataTable)
        {
            CCMModel obj = new CCMModel();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    obj.PatientID = Convert.ToInt64(dataTable.Rows[0]["PatientID"]);
                    obj.CCMNoteID = Convert.ToInt64(dataTable.Rows[0]["CCMNoteID"]);
                    obj.HdnCCMNoteDescription = dataTable.Rows[0]["Description"].ToString();
                    obj.Timespent = dataTable.Rows[0]["TimeSpent"].ToString().Substring(0, 8);
                    obj.CCMDate = Convert.ToDateTime(dataTable.Rows[0]["CCMDate"]);
                    obj.IsBillable = Convert.ToBoolean(dataTable.Rows[0]["IsBillable"]);
                }
            }
            return obj;
        }
    }
}