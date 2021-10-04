using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicBO
{
    public class CCMNoteModel : UtilityModel
    {
        public Int64 CCMNoteID { get; set; }
        public string CellNumber { get; set; }

        public Int64 PatientID { get; set; }
        public DateTime CurrentDate { get; set; }
        public string CurrentDateStr { get; set; }
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
        
        public static string queryInsertCallLog = "SP_InsertCallLogs";
        public static string GetCCMNoteMasterData_SP = "SP_GetCCMNoteMasterData";

        public static string queryGetCCMNoteByID = "sp_GetCCMNoteByID";
        public static string queryGetCCMNoteByPatientId = "sp_GetCCMNoteByPatientIdForList";
        public static string queryInsertCCMNote = "sp_InsertCCMNote";

        public Int64 SaveCCMNoteDetails(CCMNoteModel model)
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CCMNoteID", model.CCMNoteID);
            parameters.Add("@PatientID", model.PatientID);
            parameters.Add("@Description", model.Description);
            parameters.Add("@CCMDate", model.CurrentDateStr);
            parameters.Add("@CCMTime", model.CurrentTime);
            parameters.Add("@TimeSpent", model.MinuteSpent);
            parameters.Add("@PatientStatus", model.PatientStatus);
            parameters.Add("@IsBillable", model.IsBillable);
            parameters.Add("@CreatedBy", model.CreatedBy);
            parameters.Add("@CallLogId", model.CallLogId);
            if (!string.IsNullOrEmpty(model.WellnessCallStatus))
            {
                parameters.Add("@WellnessStatus", model.WellnessCallStatus);
            }
            DBManager.CreateUpdateData(queryInsertCCMNote, parameters, out RecordID);
            return RecordID;
        }

        public CCMNoteModel GetCCMNoteByID(Int64 CCMNoteId, Int64 patientId)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CCMNoteID", CCMNoteId);
            parameters.Add("@PatientID", patientId);
            return TransformGetCCMDetailsByID(DBManager.GetData(queryGetCCMNoteByID, parameters));
        }

        private CCMNoteModel TransformGetCCMDetailsByID(DataTable dataTable)
        {
            CCMNoteModel obj = new CCMNoteModel();
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

        public Int64 SaveCallLogs(int PatientId, DateTime startTime, DateTime endTime, DateTime duration)
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientId);
            parameters.Add("@StartTime", startTime);
            parameters.Add("@EndTime", endTime);
            parameters.Add("@Duration", duration);
            DBManager.CreateUpdateData(queryInsertCallLog, parameters, out RecordID);
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

        internal CCMNoteModel GetCCMDetails()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientID);
            return TransformCCMNoteDetails(DBManager.GetData(GetCCMNoteMasterData_SP, parameters));
        }

        private CCMNoteModel TransformCCMNoteDetails(DataTable dataTable)
        {
            CCMNoteModel obj = new CCMNoteModel();
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

        public List<CCMNoteModel> GetCCMNoteByPatientID(int? page, int? limit, long patientId)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", page);
            parameters.Add("@NumberOfRecords", limit);
            parameters.Add("@PatientID", patientId);
            return TransformCCMNoteForListData(DBManager.GetData(queryGetCCMNoteByPatientId, parameters));
        }

        private List<CCMNoteModel> TransformCCMNoteForListData(DataTable dataTable)
        {
            List<CCMNoteModel> CCMNoteList = new List<CCMNoteModel>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    CCMNoteModel obj = new CCMNoteModel();
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
    }
}
