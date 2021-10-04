using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Clinic.Models
{
    public class DiagnosisModel : Clinic.Models.UtilityModel.UtilityModel
    {
        public Int64 DiagnosisID { get; set; }
        public Int64 PatientID { get; set; }
        public Int64 LoginUserID { get; set; }
        public string DiagnosisName { get; set; }
        public DateTime? DiagnosisStartDate { get; set; }
        public string DiagnosisStartDateStr { get; set; }

        public DateTime? DiagnosisEndDate { get; set; }
        public string DiagnosisEndDateStr { get; set; }
        public Int64 SerialNo { get; set; }
        public string Source { get; set; }

        public string Status { get; set; }
        public string Occurrence { get; set; }
        public string Comment { get; set; }
        public string SNOMEDCT { get; set; }
        public bool Action { get; set; }


        public static string SaveDiagnosisDetails_SP = "SP_InsertDiagnosisData";
        public static string GetDiagnosisDataForList_SP = "SP_GetDiagnosisDataForList";
        public static string GetDiagnosisDetailsByDiagnosisID_SP = "GetDiagnosisDetailsByDiagnosisID_SP";

        internal long SaveDiagnosisDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@DiagnosisID", DiagnosisID);
            parameters.Add("@PatientID", PatientID);
            parameters.Add("@DiagnosisName", DiagnosisName);
            parameters.Add("@SNOMEDCT", SNOMEDCT);
            parameters.Add("@DiagnosisStartDate", DiagnosisStartDate);
            parameters.Add("@DiagnosisEndDate", DiagnosisEndDate);
            parameters.Add("@Source", Source);
            parameters.Add("@Status", Status);
            parameters.Add("@Occurrence", Occurrence);
            parameters.Add("@Comment", Comment);
            DBManager.CreateUpdateData(SaveDiagnosisDetails_SP, parameters, out RecordID);
            return RecordID;
        }

        internal List<DiagnosisModel> GetDiagnosisData_ForList()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", CurrentPage);
            parameters.Add("@NumberOfRecords", NumberOfRecords);
            parameters.Add("@OrderBy", OrderBy);
            parameters.Add("@PatientID", PatientID);
            return TransformDiagnosisData(DBManager.GetData(GetDiagnosisDataForList_SP, parameters));
        }

        private List<DiagnosisModel> TransformDiagnosisData(DataTable dataTable)
        {
            List<DiagnosisModel> patientDiagnosisList = new List<DiagnosisModel>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    DiagnosisModel obj = new DiagnosisModel();
                    obj.SerialNo = Convert.ToInt64(item["Number"]);
                    obj.DiagnosisID = Convert.ToInt64(item["DiagnosisID"]);
                    obj.DiagnosisName = item["DiagnosisName"].ToString();
                    obj.SNOMEDCT = item["SNOMEDCT"].ToString();
                    obj.DiagnosisStartDateStr = item["DiagnosisStartDate"].ToString();
                    obj.DiagnosisEndDateStr = item["DiagnosisEndDate"].ToString();
                    obj.Source = item["Source"].ToString();
                    obj.Status = item["Status"].ToString();
                    obj.Comment = item["Comment"].ToString();
                    obj.TotalCount = Convert.ToInt32(item["TotalCount"]);
                    patientDiagnosisList.Add(obj);
                }
            }
            return patientDiagnosisList;
        }

        internal DiagnosisModel GetDiagnosisDetailsByDiagnosisID()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@DiagnosisID", DiagnosisID);
            return TransformDiagnosisDetailByDiagnosisID(DBManager.GetData(GetDiagnosisDetailsByDiagnosisID_SP, parameters));
        }

        private DiagnosisModel TransformDiagnosisDetailByDiagnosisID(DataTable dataTable)
        {
            DiagnosisModel model = new DiagnosisModel();
            if (dataTable.Rows.Count > 0)
            {
                model.DiagnosisID = Convert.ToInt64(dataTable.Rows[0]["DiagnosisID"]);
                model.PatientID = Convert.ToInt64(dataTable.Rows[0]["PatientID"]);
                model.DiagnosisName = Convert.ToString(dataTable.Rows[0]["DiagnosisName"]);
                model.SNOMEDCT = Convert.ToString(dataTable.Rows[0]["SNOMEDCT"]);
                model.DiagnosisStartDateStr = String.Format("{0:MM/dd/yyyy}", dataTable.Rows[0]["DiagnosisStartDate"]);
                model.DiagnosisEndDateStr = String.Format("{0:MM/dd/yyyy}", dataTable.Rows[0]["DiagnosisEndDate"]);
                model.Source = Convert.ToString(dataTable.Rows[0]["Source"]);
                model.Status = Convert.ToString(dataTable.Rows[0]["Status"]);
                model.Comment = Convert.ToString(dataTable.Rows[0]["Comment"]);
            }
            return model;
        }
    }
}