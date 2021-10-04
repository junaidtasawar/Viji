using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Clinic.Models.PatientModel;

namespace Clinic.Models.ReportModel
{
	public class ReportModel : Clinic.Models.UtilityModel.UtilityModel
	{
		public DateTime? FromDate { get; set; }
		public DateTime? ToDate { get; set; }
		public DateTime? StartDate { get; set; }
		public DateTime? EndDate { get; set; }
		public string PatientName { get; set; }
		public Int64 PatientID { get; set; }
		public Int64 SerialNo { get; set; }
		public string PatienCurrentTime { get; set; }
		public string SpentTime { get; set; }
		public int SortCol { get; set; }
		public int CCMTimeSpan { get; set; }
		public bool IsBillable { get; set; }
		public string Diagnosis { get; set; }
		public TimeSpan? BillingTimeSpan { get; set; }
		public string MRNNumber { get; set; }
		public string CCMNote { get; set; }
		public string ClinicName { get; set; }
		public DateTime DOB { get; set; }
		public string Address { get; set; }
		public string SearchString { get; set; }
		public string TotalMinute { get; set; }
		public string CreatedNameBy { get; set; }

		public List<ClinicBO.CCMNoteModel> CCMModelList = new List<ClinicBO.CCMNoteModel>();
		public static string GetPatientReportDetailForList_SP = "SP_GetPatientReportDetailForList";
		public static string GetBillingReportDetailForList_SP = "SP_GetBillingReportDetailForList";

		internal List<ReportModel> GetPatientReportForList_SP()
		{
			Dictionary<object, object> parameters = new Dictionary<object, object>();
			parameters.Add("@CurrentPage", CurrentPage);
			parameters.Add("@NumberOfRecords", NumberOfRecords);
			parameters.Add("@OrderBy", OrderBy);
			parameters.Add("@FromDate", FromDate);
			parameters.Add("@ToDate", ToDate);
			parameters.Add("@CCMTimeSpan", CCMTimeSpan);
			parameters.Add("@IsBillable", IsBillable);
			if (CCMTimeSpan == 0)
				return TransformPatientReportDetails_ForList(DBManager.GetData("SP_GetAllPatientReportDetailForList", parameters));
			else 
				return TransformPatientReportDetails_ForList(DBManager.GetData(GetPatientReportDetailForList_SP, parameters));
		}

		private List<ReportModel> TransformPatientReportDetails_ForList(DataTable dataTable)
		{
			List<ReportModel> listmodel = new List<ReportModel>();
			if (dataTable.Rows.Count > 0)
			{
				foreach (var item in dataTable.AsEnumerable())
				{
					ReportModel obj = new ReportModel();
					obj.SerialNo = Convert.ToInt64(item["Number"]);
					obj.PatientID = Convert.ToInt64(item["PatientID"]);
					obj.PatientName = item["PatientName"].ToString();
					obj.CCMNote = item["CCMNote"].ToString();
					obj.MRNNumber = item["MRNNumber"].ToString();
					obj.TotalMinute = item["TotalMinute"].ToString();
					obj.TotalCount = Convert.ToInt32(item["TotalCount"]);
					listmodel.Add(obj);
				}
			}
			return listmodel;
		}

		internal List<ReportModel> GetPatientBillableReport()
		{
			Dictionary<object, object> parameters = new Dictionary<object, object>();
			parameters.Add("@CurrentPage", CurrentPage);
			parameters.Add("@NumberOfRecords", NumberOfRecords);
			parameters.Add("@FromDate", FromDate);
			parameters.Add("@ToDate", ToDate);
			parameters.Add("@IsBillable", IsBillable);
			return TransformPatientBillingReportData(DBManager.GetData(GetBillingReportDetailForList_SP, parameters));
		}

		private List<ReportModel> TransformPatientBillingReportData(DataTable dataTable)
		{
			List<ReportModel> listmodel = new List<ReportModel>();
			if (dataTable.Rows.Count > 0)
			{
				foreach (var item in dataTable.AsEnumerable())
				{
					ReportModel obj = new ReportModel();
					obj.PatientID = Convert.ToInt64(item["PatientID"]);
					obj.PatientName = item["PatientName"].ToString();
					obj.MRNNumber = item["MRNNumber"].ToString();
					obj.TotalMinute = item["TotalMinute"].ToString();
					obj.Diagnosis = item["Diagnosis"].ToString();
					listmodel.Add(obj);
				}
			}

			return listmodel;
		}
	}
}