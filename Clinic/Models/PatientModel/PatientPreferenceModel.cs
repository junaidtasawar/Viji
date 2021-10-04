using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Clinic.Models.PatientModel
{
    public class PatientPreferenceModel
    {
        public Int64 PatientPreferenceID {get;set;}
        public Int64 PatientID { get; set; }
        public string PrimaryCarePhysican { get; set; }
        public string PreferredContactMethod { get; set; }
        public string AlternateEmailAddress { get; set; }
        public bool HIPAANoticePeriod { get; set; }
        public bool ImmunizationRegistryUser { get; set; }
        public bool ImmunicationSharing { get; set; }
        public bool HealthInformationExchange { get; set; }
        public string ReferredByDoctor { get; set; }
        public string FromFriend { get; set; }
        public string FromInternet { get; set; }
        public string Other { get; set; }

        public static string AddPatientPreference_SP = "SP_AddPatientPreference";

        public Int64 SavePatientPreferenceDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientID);
            parameters.Add("@PrimaryCarePhysican",PrimaryCarePhysican);
            parameters.Add("@PreferredContactMethod",PreferredContactMethod);
            parameters.Add("@AlternateEmailAddress",AlternateEmailAddress);
            parameters.Add("@HIPAANoticePeriod",HIPAANoticePeriod);
            parameters.Add("@ImmunizationRegistryUser",ImmunicationSharing);
            parameters.Add("@ImmunicationSharing",ImmunicationSharing);
            parameters.Add("@HealthInformationExchange", HealthInformationExchange);
            parameters.Add("@ReferredByDoctor", ReferredByDoctor);
            parameters.Add("@FromFriend", FromFriend);
            parameters.Add("@FromInternet", FromInternet);
            parameters.Add("@Other", Other);
            DBManager.CreateUpdateData(AddPatientPreference_SP, parameters, out RecordID);
            return RecordID;
        }
    }
}