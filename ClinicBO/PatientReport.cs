using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicBO
{
    public class PatientReport
    {
        public Int64 PatientID { get; set; }
        public string PatientName { get; set; }
        public string BP { get; set; }
        public string CreationDateStr { get; set; }
        public string ClinicName { get; set; }

        public static string GetPatientReadingReport_SP = "sp_GetPatientReadingReport";
        public static string GetCriticalPatientReadingReport = "sp_GetCriticalPatientReadingReport";

        public List<PatientReport> GetSingleReadingReport(Int64 patientId)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientId", patientId);
            return TransformPatientReadingReport(DBManager.GetData(GetPatientReadingReport_SP, parameters));
        }

        public List<PatientReport> GetCriticalReadingReport(Int64 LoginUserId)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@LoginUserId", LoginUserId);
            return TransformCriticalReadingReport(DBManager.GetDataSet(GetCriticalPatientReadingReport, parameters));
        }

        private List<PatientReport> TransformPatientReadingReport(DataTable dataTable)
        {
            List<PatientReport> patientList = new List<PatientReport>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    PatientReport obj = new PatientReport();
                    obj.PatientName = Convert.ToString(item["PatientName"]);
                    obj.BP = Convert.ToString(item["BP"]);
                    obj.CreationDateStr = Convert.ToString(item["created_date"]);
                    patientList.Add(obj);
                }
            }
            return patientList;
        }

        private List<PatientReport> TransformCriticalReadingReport(DataSet dataSet)
        {
            List<PatientReport> patientList = new List<PatientReport>();
            string clinicName = string.Empty;
            if (dataSet.Tables.Count > 0)
            {
                if (dataSet.Tables[0].Rows.Count > 0)
                {
                    clinicName = Convert.ToString(dataSet.Tables[0].Rows[0]["ClinicName"]);
                }
                if (dataSet.Tables[1].Rows.Count > 0)
                {
                    foreach (var item in dataSet.Tables[1].AsEnumerable())
                    {
                        PatientReport obj = new PatientReport();
                        obj.PatientName = Convert.ToString(item["PatientName"]);
                        obj.BP = Convert.ToString(item["BP"]);
                        obj.CreationDateStr = Convert.ToString(item["created_date"]);
                        obj.ClinicName = clinicName;
                        patientList.Add(obj);
                    }
                }
                else
                {
                    PatientReport obj = new PatientReport();
                    obj.ClinicName = clinicName;
                    patientList.Add(obj);
                }
            }

            return patientList;
        }
    }
}
