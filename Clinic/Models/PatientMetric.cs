using System;
using System.Collections.Generic;

namespace Clinic.Models
{
    public class PatientMetric
    {
        public string metric { get; set; }
        public string value_1 {get;set;}
        public string value_2 { get; set; }
        public string device_id { get; set; }
        public DateTime created { get; set; }

        public static string SavePatientBPDetails_SP = "SP_InsertPatientMetric";
        public static string UpdatePatientByID_SP = "SP_GetDataFromPatientMetric";

        public Int64 SavePatientBPDetails(PatientMetric obj)
        {
            Int64 PatientID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("metric", obj.metric);
            parameters.Add("value_1", obj.value_1);
            parameters.Add("value_2", obj.value_2);
            parameters.Add("device_id", obj.device_id);
            parameters.Add("created", obj.created);
            DBManager.CreateUpdateData(SavePatientBPDetails_SP, parameters, out PatientID);
            return PatientID;
        }
        public int UpdatePatientData(string device_id)
        {
            int i = 0;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@device_id", device_id);
            i = DBManager.CreateUpdate(UpdatePatientByID_SP, parameters);
            if (i > 0)
            {
                return i;
            }
            return 0;
        }
    }
}
