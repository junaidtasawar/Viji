using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Clinic.Models
{
    public class VitalModel : UtilityModel.UtilityModel
    {
        public Int64 VitalID { get; set; }
        public string BloodSuger { get; set; }
        public string BloodPressure { get; set; }
        public string Height { get; set; }
        public string Pain { get; set; }
        public string Respiration { get; set; }
        public string Temperature { get; set; }
        public string Weight { get; set; }
        public string Pulse { get; set; }
        public Int64 PatientID { get; set; }
        public Int64 LoginUserID { get; set; }

        public static string InsertVitalData_SP = "SP_AddVitalData";
        public static string GetVitalDataForList_SP = "SP_GetVitalDataForList";
        public static string GetVitalDetailsByVitalID_SP = "sp_GetVitalDetailsByVitalID";

        internal long SaveVitalDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@VitalID", VitalID);
            parameters.Add("@PatientID", PatientID);
            parameters.Add("@BloodPressure", BloodPressure);
            parameters.Add("@Height", Height);
            parameters.Add("@Pain", Pain);
            parameters.Add("@Respiration", Respiration);
            parameters.Add("@Temperature", Temperature);
            parameters.Add("@Weight", Weight);
            parameters.Add("@Pulse", Pulse);
            parameters.Add("@BloodSuger", BloodSuger);

            DBManager.CreateUpdateData(InsertVitalData_SP, parameters, out RecordID);
            return RecordID;
        }

        public List<VitalModel> GetVitalData_ForList()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", CurrentPage);
            parameters.Add("@NumberOfRecords", NumberOfRecords);
            parameters.Add("@OrderBy", OrderBy);
            parameters.Add("@PatientID", PatientID);
            return TransformVitalData(DBManager.GetData(GetVitalDataForList_SP, parameters));
        }

        private List<VitalModel> TransformVitalData(DataTable dataTable)
        {
            List<VitalModel> patientVitalList = new List<VitalModel>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    VitalModel obj = new VitalModel();
                    obj.VitalID = Convert.ToInt64(item["VitalID"]);
                    obj.BloodPressure = (item["BloodPressure"] == DBNull.Value) ? 0.ToString() : Convert.ToString(item["BloodPressure"]);
                    obj.Pulse = (item["Pulse"] == DBNull.Value) ? 0.ToString() : Convert.ToString(item["Pulse"]);
                    obj.Temperature = (item["Temperature"] == DBNull.Value) ? 0.ToString() : Convert.ToString(item["Temperature"]);
                    obj.Height = (item["Height"] == DBNull.Value) ? 0.ToString() : Convert.ToString(item["Height"]);
                    obj.Weight = (item["Weight"] == DBNull.Value) ? 0.ToString() : Convert.ToString(item["Weight"]);
                    obj.Pain = (item["Pain"] == DBNull.Value) ? 0.ToString() : Convert.ToString(item["Pain"]);
                    obj.Respiration = (item["Respiration"] == DBNull.Value) ? 0.ToString() : Convert.ToString(item["Respiration"]);
                    obj.BloodSuger = (item["BloodSuger"] == DBNull.Value) ? 0.ToString() : Convert.ToString(item["BloodSuger"]);
                    obj.TotalCount = Convert.ToInt32(item["TotalCount"]);
                    patientVitalList.Add(obj);
                }
            }
            return patientVitalList;
        }

        internal VitalModel GetVitalDetailsByVitalID()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@VitalID", VitalID);
            return TransformVitalDetailByVitalID(DBManager.GetData(GetVitalDetailsByVitalID_SP, parameters));
        }

        private VitalModel TransformVitalDetailByVitalID(DataTable dataTable)
        {
            VitalModel model = new VitalModel();
            if (dataTable.Rows.Count > 0)
            {
                model.VitalID = Convert.ToInt64(dataTable.Rows[0]["VitalID"]);
                model.PatientID = Convert.ToInt64(dataTable.Rows[0]["PatientID"]);
                model.BloodPressure = (dataTable.Rows[0]["BloodPressure"] == DBNull.Value) ? 0.ToString() : Convert.ToString(dataTable.Rows[0]["BloodPressure"]);
                model.Pulse = (dataTable.Rows[0]["Pulse"] == DBNull.Value) ? 0.ToString() : Convert.ToString(dataTable.Rows[0]["Pulse"]);
                model.Temperature = (dataTable.Rows[0]["Temperature"] == DBNull.Value) ? 0.ToString() : Convert.ToString(dataTable.Rows[0]["Temperature"]);
                model.Height = (dataTable.Rows[0]["Height"] == DBNull.Value) ? 0.ToString() : Convert.ToString(dataTable.Rows[0]["Height"]);
                model.Weight = (dataTable.Rows[0]["Weight"] == DBNull.Value) ? 0.ToString() : Convert.ToString(dataTable.Rows[0]["Weight"]);
                model.Pain = (dataTable.Rows[0]["Pain"] == DBNull.Value) ? 0.ToString() : Convert.ToString(dataTable.Rows[0]["Pain"]);
                model.Respiration = (dataTable.Rows[0]["Respiration"] == DBNull.Value) ? 0.ToString() : Convert.ToString(dataTable.Rows[0]["Respiration"]);
                model.BloodSuger = (dataTable.Rows[0]["BloodSuger"] == DBNull.Value) ? 0.ToString() : Convert.ToString(dataTable.Rows[0]["BloodSuger"]);
            }
            return model;
        }
    }
}