using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Clinic.Models.PatientModel
{
    public class PatientReportModel : Clinic.Models.UtilityModel.UtilityModel
    {
        public Int64 ID { get; set; }
        public Int64 PatientID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MRN { get; set; }
        public DateTime? InitialCallDate { get; set; }
        public string InitialCallDateStr { get; set; }
        public string InitialCallAnswer { get; set; }
        public DateTime? SecondCallDate { get; set; }
        public string SecondCallAnswer { get; set; }
        public DateTime? ThirdCallDate { get; set; }
        public string ThirdCallAnswer { get; set; }
        public string HRAStatus { get; set; }
        public string IsMemberEligible { get; set; }
        public DateTime? HRACompletedDate { get; set; }
        public string LivioNurseVisit { get; set; }
        public DateTime? NurseVisitScheduleDate { get; set; }
        public DateTime? NurseVisitCompletionDate { get; set; }
        public Int64 SerialNo { get; set; }

        public static string GetPatientSurveyReportByPatientID_SP = "SP_GetPatientSurveyReportByPatientID";
        public static string AddPatientSurveyReport_SP = "SP_AddPatientSurveyReport";
        public static string GetAllSurveyReportForList_SP = "SP_GetAllSurveyReportForList";
        public static string GetPatientDataByPatientID_SP = "SP_GetPatientShortDataByPatientID";

        public Int64 SavePatientReportDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", ID);
            parameters.Add("@FirstName", FirstName);
            parameters.Add("@LastName", @LastName);
            parameters.Add("@MRN", MRN);
            parameters.Add("@InitialCallDate", InitialCallDate);
            parameters.Add("@InitialCallAnswer", InitialCallAnswer);
            parameters.Add("@SecondCallDate", SecondCallDate);
            parameters.Add("@SecondCallAnswer", SecondCallAnswer);
            parameters.Add("@ThirdCallDate", ThirdCallDate);
            parameters.Add("@ThirdCallAnswer", ThirdCallAnswer);
            parameters.Add("@HRAStatus", HRAStatus);
            parameters.Add("@IsMemberEligible", IsMemberEligible);
            parameters.Add("@HRACompletedDate", HRACompletedDate);
            parameters.Add("@LivioNurseVisit", LivioNurseVisit);
            parameters.Add("@NurseVisitScheduleDate", NurseVisitScheduleDate);
            parameters.Add("@NurseVisitCompletionDate", NurseVisitCompletionDate);

            DBManager.CreateUpdateData(AddPatientSurveyReport_SP, parameters, out RecordID);

            return RecordID;
        }

        internal PatientReportModel GetPatientDataByPatientId()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientID);
            return TransformPatientDataByPatientID(DBManager.GetData(GetPatientDataByPatientID_SP, parameters));
        }

        private PatientReportModel TransformPatientDataByPatientID(DataTable dataTable)
        {
            PatientReportModel obj = new PatientReportModel();

            if (dataTable.Rows.Count > 0)
            {
                obj.ID = Convert.ToInt64(dataTable.Rows[0]["PatientID"]);
                obj.FirstName = Convert.ToString(dataTable.Rows[0]["FirstName"]);
                obj.LastName = Convert.ToString(dataTable.Rows[0]["LastName"]);
                obj.MRN = Convert.ToString(dataTable.Rows[0]["MRNNumber"]);
            }

            return obj;
        }

        private PatientReportModel TransformPatientReportByPatientID(DataTable dataTable)
        {
            PatientReportModel obj = new PatientReportModel();
            if (dataTable.Rows.Count > 0)
            {
                obj.ID = Convert.ToInt64(dataTable.Rows[0]["ID"]);
                obj.PatientID = Convert.ToInt64(dataTable.Rows[0]["PatientID"]);
                obj.FirstName = Convert.ToString(dataTable.Rows[0]["FirstName"]);
                obj.LastName = Convert.ToString(dataTable.Rows[0]["LastName"]);
                obj.MRN = Convert.ToString(dataTable.Rows[0]["MRN"]);
                obj.InitialCallDate = (dataTable.Rows[0]["InitialCallDate"] != null) ? Convert.ToDateTime(dataTable.Rows[0]["InitialCallDate"]) : (DateTime?)null;
                obj.InitialCallAnswer = Convert.ToString(dataTable.Rows[0]["InitialCallAnswer"]);
                obj.SecondCallDate = (dataTable.Rows[0]["SecondCallDate"] != null) ? Convert.ToDateTime(dataTable.Rows[0]["SecondCallDate"]) : (DateTime?)null;
                obj.SecondCallAnswer = Convert.ToString(dataTable.Rows[0]["SecondCallAnswer"]);
                obj.ThirdCallDate = (dataTable.Rows[0]["ThirdCallDate"] != null) ? Convert.ToDateTime(dataTable.Rows[0]["ThirdCallDate"]) : (DateTime?)null;
                obj.ThirdCallAnswer = Convert.ToString(dataTable.Rows[0]["ThirdCallAnswer"]);
                obj.HRAStatus = Convert.ToString(dataTable.Rows[0]["HRAStatus"]);
                obj.IsMemberEligible = Convert.ToString(dataTable.Rows[0]["IsMemberEligible"]);
                obj.HRACompletedDate = (dataTable.Rows[0]["HRACompletedDate"] != null) ? Convert.ToDateTime(dataTable.Rows[0]["HRACompletedDate"]) : (DateTime?)null;
                obj.LivioNurseVisit = Convert.ToString(dataTable.Rows[0]["LivioNurseVisit"]);
                obj.NurseVisitScheduleDate = (dataTable.Rows[0]["NurseVisitScheduleDate"] != null) ? Convert.ToDateTime(dataTable.Rows[0]["NurseVisitScheduleDate"]) : (DateTime?)null;
                obj.NurseVisitCompletionDate = (dataTable.Rows[0]["NurseVisitCompletionDate"] != null) ? Convert.ToDateTime(dataTable.Rows[0]["NurseVisitCompletionDate"]) : (DateTime?)null;
            }

            return obj;
        }

        public List<PatientReportModel> GetAllSurveyReport_ForList()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", CurrentPage);
            parameters.Add("@NumberOfRecords", NumberOfRecords);
            parameters.Add("@OrderBy", OrderBy);
            parameters.Add("@HRAStatus", HRAStatus);
            parameters.Add("@InitialCallAnswer", InitialCallAnswer);
            if (InitialCallAnswer != "")
                GetAllSurveyReportForList_SP = "SP_GetAllSurveyReportInitialCallForList";
            if (HRAStatus != "")
                GetAllSurveyReportForList_SP = "SP_GetAllSurveyReportHRAForList";
            if (InitialCallAnswer != "" && HRAStatus != "")
                GetAllSurveyReportForList_SP = "SP_GetAllSurveyReportHRACallForList";
            return TransformSurveryReportDataForList(DBManager.GetData(GetAllSurveyReportForList_SP, parameters));
        }

        private List<PatientReportModel> TransformSurveryReportDataForList(DataTable dataTable)
        {
            List<PatientReportModel> listmodel = new List<PatientReportModel>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    PatientReportModel obj = new PatientReportModel();
                    obj.SerialNo = Convert.ToInt64(item["Number"]);
                    obj.ID = Convert.ToInt64(item["ID"]);
                    obj.PatientID = Convert.ToInt64(item["PatientID"]);
                    obj.FirstName = Convert.ToString(item["FirstName"]);
                    obj.LastName = Convert.ToString(item["LastName"]);
                    obj.MRN = Convert.ToString(item["MRNNumber"]);
                    obj.InitialCallDateStr = (item["InitialCallDate"] != DBNull.Value) ? (String.Format("{0:MM/dd/yyyy}", (item["InitialCallDate"]))) : null;
                    obj.InitialCallDate = (item["InitialCallDate"] != DBNull.Value) ? Convert.ToDateTime(item["InitialCallDate"]) : (DateTime?)null;
                    obj.InitialCallAnswer = Convert.ToString(item["InitialCallAnswer"]);
                    //obj.SecondCallDate = (item["SecondCallDate"] != null) ? Convert.ToDateTime(item["SecondCallDate"]) : (DateTime?)null;
                    //obj.SecondCallAnswer = Convert.ToString(item["SecondCallAnswer"]);
                    //obj.ThirdCallDate = (item["ThirdCallDate"] != null) ? Convert.ToDateTime(item["ThirdCallDate"]) : (DateTime?)null;
                    //obj.ThirdCallAnswer = Convert.ToString(item["ThirdCallAnswer"]);
                    obj.HRAStatus = Convert.ToString(item["HRAStatus"]);
                    obj.IsMemberEligible = Convert.ToString(item["IsMemberEligible"]);
                    //obj.HRACompletedDate = (item["HRACompletedDate"] != DBNull.Value) ? Convert.ToDateTime(item["HRACompletedDate"]) : (DateTime?)null;
                    //obj.LivioNurseVisit = Convert.ToString(item["LivioNurseVisit"]);
                    //obj.NurseVisitScheduleDate = (item["NurseVisitScheduleDate"] != DBNull.Value) ? Convert.ToDateTime(item["NurseVisitScheduleDate"]) : (DateTime?)null;
                    //obj.NurseVisitCompletionDate = (item["NurseVisitCompletionDate"] != DBNull.Value) ? Convert.ToDateTime(item["NurseVisitCompletionDate"]) : (DateTime?)null;
                    obj.TotalCount = Convert.ToInt32(item["TotalCount"]);
                    listmodel.Add(obj);
                }
            }
            return listmodel;
        }

    }
}