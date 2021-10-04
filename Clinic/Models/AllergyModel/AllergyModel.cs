using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Clinic.Models
{
    public class AllergyModel : Clinic.Models.UtilityModel.UtilityModel
    {
        public Int64 AllergyID { get; set; }
        public Int64 PatientID { get; set; }
        public Int64 LoginUserID { get; set; }
        public string Type { get; set; }
        public string Agent { get; set; }
        public string SNOMED { get; set; }
        public string Reaction1 { get; set; }
        public string Serverity { get; set; }
        public string Source { get; set; }
        public string Status { get; set; }
        public Int64 SerialNo { get; set; }

        public static string SaveAllergyDetails_SP = "SP_InsertAllergyDetails";
        public static string GetAllergyDetailByAllergyID_SP = "GetAllergyDetailsByAllergyID_SP";
        public static string GetAllergyDataForList_SP = "SP_GetAllergyDataForList";
        internal long SaveAllergyDetails()          
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientID);
            parameters.Add("@AllergyID", AllergyID);
            parameters.Add("@Type", Type);
            parameters.Add("@Agent", Agent);
            parameters.Add("@SNOMED", SNOMED);
            parameters.Add("@Reaction1", Reaction1);
            parameters.Add("@Serverity", Serverity);
            parameters.Add("@Source", Source);
            parameters.Add("@Status", Status);
            DBManager.CreateUpdateData(SaveAllergyDetails_SP, parameters, out RecordID);
            return RecordID;
        }

        internal AllergyModel GetAllergyDetailsByPatientID_SP()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@AllergyID", AllergyID);
            return TransformAllergyDetailByPatientID(DBManager.GetData(GetAllergyDetailByAllergyID_SP, parameters));
        }

        private AllergyModel TransformAllergyDetailByPatientID(DataTable dataTable)
        {
            AllergyModel model = new AllergyModel();
            if (dataTable.Rows.Count > 0)
            {
                model.AllergyID = Convert.ToInt64(dataTable.Rows[0]["AllergyID"]);
                model.PatientID = Convert.ToInt64(dataTable.Rows[0]["PatientID"]);
                model.Type = dataTable.Rows[0]["Type"].ToString();
                model.Agent = dataTable.Rows[0]["Agent"].ToString();
                model.SNOMED = dataTable.Rows[0]["SNOMED"].ToString();
                model.Serverity = dataTable.Rows[0]["Severity"].ToString();
                model.Source = dataTable.Rows[0]["Source"].ToString();
                model.Status = dataTable.Rows[0]["Status"].ToString();
                model.Reaction1 = Convert.ToString(dataTable.Rows[0]["Reaction"]);
            }
            return model;
        }

        public List<AllergyModel> GetAllergiesData_ForList()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", CurrentPage);
            parameters.Add("@NumberOfRecords", NumberOfRecords);
            parameters.Add("@PatientID", PatientID);
            DataTable dt = DBManager.GetData(GetAllergyDataForList_SP, parameters);
            return TransformAllergyData(dt);
        }

        private List<AllergyModel> TransformAllergyData(DataTable dataTable)
        {
            List<AllergyModel> allergyList = new List<AllergyModel>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    AllergyModel obj = new AllergyModel();
                    obj.SerialNo = Convert.ToInt64(item["Number"]);
                    obj.AllergyID = Convert.ToInt64(item["AllergyID"]);
                    obj.Type = Convert.ToString(item["Type"]);
                    obj.Agent = Convert.ToString(item["Agent"]);
                    obj.SNOMED = Convert.ToString(item["SNOMED"]);
                    obj.Serverity = Convert.ToString(item["Severity"]);
                    obj.Source = Convert.ToString(item["Source"]);
                    obj.Status = Convert.ToString(item["Status"]);
                    obj.TotalCount = Convert.ToInt32(item["TotalCount"]);
                    obj.Reaction1 = Convert.ToString(item["Reaction"]);
                    allergyList.Add(obj);
                }
            }
            return allergyList;
        }
    }
}