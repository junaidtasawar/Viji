using Clinic.Controllers.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace Clinic.Models
{
    public class MedicationModel : Clinic.Models.UtilityModel.UtilityModel
    {
        public Int64 SerialNo { get; set; }
        public Int64 MedicationID { get; set; }
        public Int64 PatientID { get; set; }
        public string Medication { get; set; }
        public string RxNorms { get; set; }
        public string Diagnosis { get; set; }
        public string Quantity { get; set; }
        public string RefillAllowed { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string MeidcationStartDateStr { get; set; }
        public string MeidcationEndDateStr { get; set; }
        public string Source { get; set; }
        public string OrderGeneratedBy { get; set; }
        public string Provider { get; set; }
        public string Status { get; set; }
        public string Comments { get; set; }
        public string DosaseCount { get; set; }
        public string Measure { get; set; }
        public string Route { get; set; }
        public string Frequency { get; set; }
        public string Instruction { get; set; }

        public static string GetMedicationDetailsByMedicationID_SP = "SP_GetMedicationDetailsByMedicationID";
        public static string GetMedicationDataByPatientID_SP = "SP_GetMedicationDataByPatientID";
        public static string GetMedicationDataForList_SP = "SP_GetMedicationDataForList";
        public static string InsertMedicationData_SP = "SP_AddMedicationData";

        internal List<MedicationModel> GetMedicationData_ForList()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", CurrentPage);
            parameters.Add("@NumberOfRecords", NumberOfRecords);
            parameters.Add("@OrderBy", OrderBy);
            parameters.Add("@PatientID", PatientID);
            return TransformMedicationDataList(DBManager.GetData(GetMedicationDataForList_SP, parameters));
        }

        private List<MedicationModel> TransformMedicationDataList(DataTable data)
        {
            List<MedicationModel> medicationList = new List<MedicationModel>();
            if (data.Rows.Count > 0)
            {
                foreach (var item in data.AsEnumerable())
                {
                    MedicationModel obj = new MedicationModel();
                    obj.SerialNo = Convert.ToInt64(item["Number"]);
                    obj.MedicationID = Convert.ToInt64(item["MedicationID"]);
                    obj.Medication = Convert.ToString(item["Medication"]);
                    obj.RxNorms = Convert.ToString(item["RxNorms"]);
                    obj.Diagnosis = Convert.ToString(item["Diagnosis"]);
                    obj.Quantity = (item["Quantity"] == DBNull.Value) ? 0.ToString() : Convert.ToString(item["Quantity"]);
                    obj.RefillAllowed = Convert.ToString(item["RefillAllowed"]);
                    obj.MeidcationStartDateStr = Convert.ToString(item["StartDate"]);
                    obj.MeidcationEndDateStr = Convert.ToString(item["EndDate"]);
                    obj.Source = Convert.ToString(item["Source"]);
                    obj.OrderGeneratedBy = Convert.ToString(item["OrderGeneratedBy"]);
                    obj.Provider = Convert.ToString(item["Provider"]);
                    obj.Status = Convert.ToString(item["Status"]);
                    obj.Comments = Convert.ToString(item["Comments"]);
                    obj.TotalCount = Convert.ToInt32(item["TotalCount"]);
                    obj.Frequency = Convert.ToString(item["Frequency"]);
                    medicationList.Add(obj);
                }
            }
            return medicationList;
        }

        internal MedicationModel GetMedicationDetailsByMedicationID()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@MedicationID", MedicationID);
            return TransformPatientMedicationData(DBManager.GetData(GetMedicationDetailsByMedicationID_SP, parameters));
        }

        private MedicationModel TransformPatientMedicationData(DataTable dataTable)
        {
            MedicationModel model = new MedicationModel();
            if (dataTable.Rows.Count > 0)
            {
                model.MedicationID = Convert.ToInt64(dataTable.Rows[0]["MedicationID"]);
                model.Medication = Convert.ToString(dataTable.Rows[0]["Medication"]);
                model.RxNorms = Convert.ToString(dataTable.Rows[0]["RxNorms"]);
                model.Diagnosis = Convert.ToString(dataTable.Rows[0]["Diagnosis"]);
                model.Quantity = (dataTable.Rows[0]["Quantity"] == DBNull.Value) ? 0.ToString() : Convert.ToString(dataTable.Rows[0]["Quantity"]);
                model.RefillAllowed = Convert.ToString(dataTable.Rows[0]["RefillAllowed"]);
                model.MeidcationStartDateStr = String.Format("{0:MM/dd/yyyy}", dataTable.Rows[0]["StartDate"]);
                model.MeidcationEndDateStr = String.Format("{0:MM/dd/yyyy}", dataTable.Rows[0]["EndDate"]);
                model.Source = Convert.ToString(dataTable.Rows[0]["Source"]);
                model.OrderGeneratedBy = Convert.ToString(dataTable.Rows[0]["OrderGeneratedBy"]);
                model.Provider = Convert.ToString(dataTable.Rows[0]["Provider"]);
                model.Status = Convert.ToString(dataTable.Rows[0]["Status"]);
                model.Comments = Convert.ToString(dataTable.Rows[0]["Comments"]);
                //model.DosaseCount = dataTable.Rows[0]["DosaseCount"].ToString();
                //model.Route = dataTable.Rows[0]["Route"].ToString();
                //model.Measure = dataTable.Rows[0]["Measure"].ToString();
                //model.Instruction = dataTable.Rows[0]["Instruction"].ToString();
                model.Frequency = dataTable.Rows[0]["Frequency"].ToString();
            }
            return model;
        }

        internal long SaveMedicationDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@MedicationID", MedicationID);
            parameters.Add("@PatientID", PatientID);
            parameters.Add("@Medication", Medication);
            parameters.Add("@RxNorms", RxNorms);
            parameters.Add("@Diagnosis", Diagnosis);
            parameters.Add("@RefillAllowed", RefillAllowed);
            parameters.Add("@Quantity", Quantity);
            parameters.Add("@StartDate", StartDate);
            parameters.Add("@EndDate", EndDate);
            parameters.Add("@Source", Source);
            parameters.Add("@Status", Status);
            parameters.Add("@Provider", Provider);
            parameters.Add("@OrderGeneratedBy", OrderGeneratedBy);
            parameters.Add("@Comments", Comments);
            parameters.Add("@DosaseCount", DosaseCount);
            parameters.Add("@Measure", Measure);
            parameters.Add("@Route", Route);
            parameters.Add("@Frequency", Frequency);
            parameters.Add("@Instruction", Instruction);

            DBManager.CreateUpdateData(InsertMedicationData_SP, parameters, out RecordID);
            return RecordID;
        }

        internal MedicationModel GetPatientMedicationData()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientID);
            return TransformPatientMedicationData(DBManager.GetData(GetMedicationDataByPatientID_SP, parameters));
        }
    }
}