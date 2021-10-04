using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;


namespace Clinic.Models.PatientModel
{
    public class PatientModel : Clinic.Models.UtilityModel.UtilityModel
    {
        public Int64 SerialNo { get; set; }
        public Int64 PatientID { get; set; }
        public string MRNNumber { get; set; }
        public string CustomPatientID { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public DateTime DOB { get; set; }
        public string DOBStr { get; set; }
        public int Gender { get; set; }
        public string GenderStr { get; set; }
        public string ClinicName { get; set; }
        public string Ethnicity { get; set; }
        public string Races { get; set; }
        public string PrimaryLanguage { get; set; }
        public string SecondaryLanguage { get; set; }
        public string Address { get; set; }
        public string CityName { get; set; }
        public string StateName { get; set; }
        public string Zipcode { get; set; }
        public string CountryName { get; set; }
        public string WorkPhone { get; set; }
        public string HomePhone { get; set; }
        public string CellNumber { get; set; }
        public string Email { get; set; }
        public string DriverLicenseID { get; set; }
        public bool DriverLicenseState { get; set; }
        public string MaritalStatus { get; set; }
        public string SSN { get; set; }
        public string GuardianName { get; set; }
        public string StatusName { get; set; }
        public string DoctorsName { get; set; }
        public string Comments { get; set; }
        public string PrimaryContactNumber { get; set; }
        public string AlternateContactNumber { get; set; }

        public string DeviceID { get; set; }
        public DateTime DeviceReceivedDate { get; set; }
        public string DeviceReceivedDateStr { get; set; }

        public int? LowBPLimit { get; set; }
        public int? HighBPLimit { get; set; }
        public int? LowGlucoseLimit { get; set; }
        public int? HighGlucoseLimit { get; set; }

        public string EmergencyName1 { get; set; }
        public string EmergencyRelationship1 { get; set; }
        public string EmergencyPhoneNo1 { get; set; }
        public string EmergencyName2 { get; set; }
        public string EmergencyRelationship2 { get; set; }
        public string EmergencyPhoneNo2 { get; set; }
        public bool IsActive { get; set; }


        public int Age { get; set; }
        public string FullName { get; set; }
        public string TimeSpentstr { get; set; }
        public Insurance insurance { get; set; }
        public Int64 LoginUserID { get; set; }
        public string inputTimeSpent { get; set; }

        public AllergyModel allergyModel { get; set; }
        public List<AllergyModel> listAllergyModel { get; set; }

        public VitalModel vitalModel { get; set; }
        public List<VitalModel> listVitalModel { get; set; }


        public MedicationModel medicationModel { get; set; }
        public List<MedicationModel> listMedicationModel { get; set; }

        public DiagnosisModel diagnosisModel { get; set; }
        public List<DiagnosisModel> listDiagnosisModel { get; set; }
        public string SearchFirstName { get; set; }
        public string SearchLastName { get; set; }
        public Int64 CCMNoteID { get; set; }

        public List<ClinicBO.CCMNoteModel> CCMModelList = new List<ClinicBO.CCMNoteModel>();

        public string Medicareid { get; set; }
        public string MedicareNumber { get; set; }
        public string Practice { get; set; }
        public string RPMInteractionTime { get; set; }
        public int TotalDaysReadings { get; set; }
        public string DeviceMonth { get; set; }
        public string DiagnosisCode { get; set; }
        public string Billable454 { get; set; }
        public string Billable457 { get; set; }
        public string Billable458 { get; set; }
        public string Billable459 { get; set; }

        public string DeviceName { get; set; }
        public bool IsDeviceActive { get; set; }


        public static string SavePatientDetails_SP = "SP_InsertPatientData";
        // public static string GetPatientProfileData_SP = "SP_GetPatientProfileData";
        public static string GetPatientDataByPatientID_SP = "SP_GetPatientDataByPatientID";
        public static string UpdateStatusOnPatientID_SP = "SP_UpdateStatusOnPatientID";
        public static string GetPatientDetailsByPatientID_SP = "SP_GetPatientDetailsByPatientID";
        public static string GetCCMNoteReportByPatientID_SP = "SP_GetCCMNoteReportByPatientID";
        public static string GetRPMBillingReport_SP = "SP_GetRPMBillingReport";
        public static string GetPatientData_Forlist_SP = "SP_GetPatientData_Forlist1";

        #region Patient List, By ID, Save, Status Update
        public List<PatientModel> GetPatientData_ForList()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@ClinicName", ClinicName);
            parameters.Add("@FirstName", FirstName);
            parameters.Add("@LastName", LastName);
            parameters.Add("@CurrentPage", 1);
            parameters.Add("@NumberOfRecords", 10);
            parameters.Add("@OrderBy", OrderBy);
            parameters.Add("@LoginUserID", LoginUserID);
            DataSet ds = DBManager.GetDataSet(GetPatientData_Forlist_SP, parameters);
            return TransformPatientData(ds);
            //return TransformPatientData(DBManager.GetData("SP_GetPatientData_Forlist1", parameters));
        }

        public List<PatientModel> TransformPatientData(DataSet dataSet)
        {
            List<PatientModel> patientList = new List<PatientModel>();
            int totalCount = 0;

            if (dataSet.Tables.Count > 0)
            {
                if (dataSet.Tables[0].Rows.Count > 0)
                {
                    totalCount = Convert.ToInt32(dataSet.Tables[0].Rows[0]["TotalCount"]);
                }
                if (dataSet.Tables[1].Rows.Count > 0)
                {
                    DataTable dataTable = dataSet.Tables[1];

                    if (dataTable.Rows.Count > 0)
                    {
                        foreach (var item in dataTable.AsEnumerable())
                        {
                            PatientModel obj = new PatientModel();
                            obj.SerialNo = Convert.ToInt64(item["Number"]);
                            obj.PatientID = Convert.ToInt64(item["PatientID"]);
                            obj.FullName = Convert.ToString(item["Name"]);
                            obj.Address = Convert.ToString(item["address"]);
                            obj.GenderStr = Convert.ToString(item["Gender"]);
                            obj.MRNNumber = Convert.ToString(item["MRNNumber"]);
                            obj.DOBStr = Convert.ToString(item["DOB"]);
                            obj.Age = (item["Age"] == DBNull.Value) ? 0 : Convert.ToInt32(item["Age"]);
                            obj.CellNumber = Convert.ToString(item["MobileNumber"]);
                            obj.TotalCount = totalCount;
                            obj.DoctorsName = Convert.ToString(item["DoctorsName"]);
                            obj.TimeSpentstr = (item["TotalMinute"].ToString());
                            obj.StatusName = Convert.ToString(item["StatusName"]);
                            obj.DeviceID = (item["DeviceId"] == DBNull.Value) ? string.Empty : item["DeviceId"].ToString();
                            obj.DeviceName = (item["DeviceName"] == DBNull.Value) ? string.Empty : item["DeviceName"].ToString();
                            obj.IsDeviceActive = (item["IsDeviceActive"] == DBNull.Value) ? false : Convert.ToBoolean(item["IsDeviceActive"]);
                            patientList.Add(obj);
                        }
                    }
                }
            }
            //patientList = (from DataRow row in data.Rows
            //               select new PatientModel()
            //               {
            //                   PatientID = row.Field<Int64>("PatientID"),
            //                   FullName = row.Field<string>("Name"),
            //                   GenderStr = row.Field<string>("Gender"),
            //                   DOBStr = row.Field<string>("DOB"),
            //                   BloodGroup = row.Field<string>("BloodGroup"),
            //                   age = row.Field<int>("age"),
            //                   Address = row.Field<string>("Address"),
            //                   TimeSpentstr = row.Field<string>("TimeSpent"),
            //                   TotalCount = row.Field<int>("TotalCount"),
            //                   DoctorsName = row.Field<string>("DoctorsName"),
            //                   StatusName = row.Field<string>("StatusName")           
            //               }).ToList();  

            return patientList;
        }

        public Int64 SavePatientDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientID);
            parameters.Add("@FirstName", FirstName);
            parameters.Add("@MiddleName", MiddleName);
            parameters.Add("@LastName", LastName);
            parameters.Add("@Gender", Gender);
            parameters.Add("@DOBStr", DOBStr);
            parameters.Add("@MobileNumber", CellNumber);
            parameters.Add("@AddressLine1", Address);
            parameters.Add("@CityID", CityName);
            parameters.Add("@CountryID", CountryName);
            parameters.Add("@StateID", StateName);
            parameters.Add("@Pincode", Zipcode);
            parameters.Add("@ClinicName", ClinicName);
            parameters.Add("@DoctorsName", DoctorsName);
            parameters.Add("@StatusName", StatusName);
            parameters.Add("@MRNNumber", MRNNumber);
            parameters.Add("@Email", Email);
            parameters.Add("@PrimaryContactNumber", PrimaryContactNumber);
            parameters.Add("@AlternateContactNumber", AlternateContactNumber);
            parameters.Add("@PrimaryLanguage", PrimaryLanguage);
            parameters.Add("@SecondaryLanguage", SecondaryLanguage);
            parameters.Add("@Ethnicity", Ethnicity);
            parameters.Add("@MaritalStatus", MaritalStatus);
            parameters.Add("@EmergencyName1", EmergencyName1);
            parameters.Add("@EmergencyRelationship1", EmergencyRelationship1);
            parameters.Add("@EmergencyPhoneNo1", EmergencyPhoneNo1);
            parameters.Add("@EmergencyName2", EmergencyName2);
            parameters.Add("@EmergencyRelationship2", EmergencyRelationship2);
            parameters.Add("@EmergencyPhoneNo2", EmergencyPhoneNo2);
            parameters.Add("@DriverLicenseID", DriverLicenseID);
            parameters.Add("@DriverLicenseState", DriverLicenseState);
            parameters.Add("@Races", Races);
            parameters.Add("@HomePhone", HomePhone);
            parameters.Add("@WorkPhone", WorkPhone);
            parameters.Add("@SSN", SSN);
            parameters.Add("@GuardianName", GuardianName);
            parameters.Add("@InsuranceName", insurance.Name);
            parameters.Add("@InsurancePlanName", insurance.PlanName);
            parameters.Add("@InsuranceStartDate", insurance.StartDate);
            parameters.Add("@InsuranceEndDate", insurance.EndDate);
            parameters.Add("@InsuranceMemberID", insurance.MemberID);
            parameters.Add("@InsuranceGroupID", insurance.GroupID);
            parameters.Add("@CreatedBy", CreatedBy);
            parameters.Add("@IsActive", IsActive);
            parameters.Add("@Comments", Comments);
            parameters.Add("@CustomPatientID", CustomPatientID);
            parameters.Add("@DeviceID", DeviceID);
            parameters.Add("@DeviceReceivedDateStr", DeviceReceivedDateStr);
            parameters.Add("@LowBPLimit", LowBPLimit);
            parameters.Add("@HighBPLimit", HighBPLimit);
            parameters.Add("@LowGlucoseLimit", LowGlucoseLimit);
            parameters.Add("@HighGlucoseLimit", HighGlucoseLimit);

            DBManager.CreateUpdateData(SavePatientDetails_SP, parameters, out RecordID);
            return RecordID;
        }

        public int UpdatePatientStatus(Int64 PatientID, string StatusName)
        {
            int i = 0;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientID);
            parameters.Add("@StatusName", StatusName);
            i = DBManager.CreateUpdate(UpdateStatusOnPatientID_SP, parameters);
            if (i > 0)
            {
                return i;
            }
            return 0;
        }

        internal PatientModel GetPatientDataByPatientId()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientID);
            return TransformPatientDataByPatientID(DBManager.GetData(GetPatientDataByPatientID_SP, parameters));
        }

        private PatientModel TransformPatientDataByPatientID(DataTable dataTable)
        {
            PatientModel obj = new PatientModel();

            if (dataTable.Rows.Count > 0)
            {
                obj.PatientID = Convert.ToInt64(dataTable.Rows[0]["PatientID"]);
                obj.FullName = Convert.ToString(dataTable.Rows[0]["Name"]);
                obj.Address = Convert.ToString(dataTable.Rows[0]["address"]);
                obj.Gender = Convert.ToInt32(dataTable.Rows[0]["Gender"]);
                obj.GenderStr = (obj.Gender == 1) ? "Male" : "Female";
                obj.MRNNumber = Convert.ToString(dataTable.Rows[0]["MRNNumber"]);
                obj.DOBStr = Convert.ToString(dataTable.Rows[0]["DOB"]);
                obj.Age = (dataTable.Rows[0]["Age"] == DBNull.Value) ? 0 : Convert.ToInt32(dataTable.Rows[0]["Age"]);
                obj.CellNumber = Convert.ToString(dataTable.Rows[0]["MobileNumber"]);
                obj.CCMNoteID = (dataTable.Rows[0]["CCMNoteID"] != DBNull.Value) ? Convert.ToInt64(dataTable.Rows[0]["CCMNoteID"]) : 0;
                obj.Ethnicity = dataTable.Rows[0]["Ethnicity"].ToString();
                obj.ClinicName = dataTable.Rows[0]["ClinicName"].ToString();
                obj.DoctorsName = dataTable.Rows[0]["DoctorsName"].ToString();
                obj.GuardianName = dataTable.Rows[0]["GuardianName"].ToString();
                obj.MaritalStatus = dataTable.Rows[0]["MaritalStatus"].ToString();
                obj.CityName = dataTable.Rows[0]["City"].ToString();
                obj.StateName = dataTable.Rows[0]["State"].ToString();
                obj.CountryName = dataTable.Rows[0]["COUNTRY"].ToString();
                obj.StatusName = dataTable.Rows[0]["StatusName"].ToString();
                obj.Email = dataTable.Rows[0]["Email"].ToString();
                obj.PrimaryContactNumber = dataTable.Rows[0]["PrimaryContactNumber"].ToString();
                obj.AlternateContactNumber = dataTable.Rows[0]["AlternateContactNumber"].ToString();
                obj.PrimaryLanguage = dataTable.Rows[0]["PrimaryLanguage"].ToString();
                obj.SecondaryLanguage = dataTable.Rows[0]["SecondaryLanguage"].ToString();
                obj.MaritalStatus = dataTable.Rows[0]["MaritalStatus"].ToString();
                obj.Races = dataTable.Rows[0]["Races"].ToString();
                obj.HomePhone = dataTable.Rows[0]["HomePhone"].ToString();
                obj.WorkPhone = dataTable.Rows[0]["CellPhone"].ToString();
                obj.Comments = dataTable.Rows[0]["Comments"].ToString();
                obj.DriverLicenseID = dataTable.Rows[0]["DriverLicenseID"].ToString();
                if (dataTable.Rows[0]["DriverLicenseState"] != DBNull.Value)
                    obj.DriverLicenseState = Convert.ToBoolean(dataTable.Rows[0]["DriverLicenseState"]);
                obj.SSN = dataTable.Rows[0]["SSN"].ToString();
                obj.DeviceID = Convert.ToString(dataTable.Rows[0]["DeviceId"]);
                if (dataTable.Rows[0]["DeviceReceivedDate"] != DBNull.Value)
                    obj.DeviceReceivedDateStr = String.Format("{0:MM/dd/yyyy}", dataTable.Rows[0]["DeviceReceivedDate"]);
                if (dataTable.Rows[0]["LowBPLimit"] != DBNull.Value)
                    obj.LowBPLimit = Convert.ToInt32(dataTable.Rows[0]["LowBPLimit"]);
                else
                    obj.LowBPLimit = null;
                if (dataTable.Rows[0]["HighBPLimit"] != DBNull.Value)
                    obj.HighBPLimit = Convert.ToInt32(dataTable.Rows[0]["HighBPLimit"]);
                else
                    obj.HighBPLimit = null;
                if (dataTable.Rows[0]["LowGlucoseLimit"] != DBNull.Value)
                    obj.LowGlucoseLimit = Convert.ToInt32(dataTable.Rows[0]["LowGlucoseLimit"]);
                else
                    obj.LowGlucoseLimit = null;
                if (dataTable.Rows[0]["HighGlucoseLimit"] != DBNull.Value)
                    obj.HighGlucoseLimit = Convert.ToInt32(dataTable.Rows[0]["HighGlucoseLimit"]);
                else
                    obj.HighGlucoseLimit = null;
            }

            return obj;
        }
        #endregion

        internal PatientModel GetPatientDetailsByPatientID()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@PatientID", PatientID);
            return TransformPatientDetailByPatientID(DBManager.GetData(GetPatientDetailsByPatientID_SP, parameters));
        }

        private PatientModel TransformPatientDetailByPatientID(DataTable dataTable)
        {
            PatientModel obj = new PatientModel();
            if (dataTable.Rows.Count > 0)
            {
                obj.PatientID = Convert.ToInt64(dataTable.Rows[0]["PatientID"]);
                obj.FirstName = Convert.ToString(dataTable.Rows[0]["FirstName"]);
                obj.MRNNumber = Convert.ToString(dataTable.Rows[0]["MRNNumber"]);
                obj.MiddleName = Convert.ToString(dataTable.Rows[0]["MiddleName"]);
                obj.LastName = Convert.ToString(dataTable.Rows[0]["LastName"]);
                obj.Address = Convert.ToString(dataTable.Rows[0]["Address"]);
                obj.Gender = (dataTable.Rows[0]["Gender"] == DBNull.Value) ? 0 : Convert.ToInt32(dataTable.Rows[0]["Gender"]);
                obj.GenderStr = (obj.Gender == 1) ? "Male" : ((obj.Gender == 0) ? "Select" : "Female");
                obj.DOBStr = String.Format("{0:MM/dd/yyyy}", dataTable.Rows[0]["DOB"]);
                obj.Age = (dataTable.Rows[0]["Age"] == DBNull.Value) ? 0 : Convert.ToInt32(dataTable.Rows[0]["Age"]);
                obj.CellNumber = Convert.ToString(dataTable.Rows[0]["MobileNumber"]);
                obj.ClinicName = Convert.ToString(dataTable.Rows[0]["ClinicName"]);
                obj.CityName = Convert.ToString(dataTable.Rows[0]["City"]);
                obj.StateName = Convert.ToString(dataTable.Rows[0]["State"]);
                obj.CountryName = Convert.ToString(dataTable.Rows[0]["Country"]);
                obj.Zipcode = Convert.ToString(dataTable.Rows[0]["PostalCode"]);
                obj.Ethnicity = dataTable.Rows[0]["Ethnicity"].ToString();
                obj.DoctorsName = Convert.ToString(dataTable.Rows[0]["DoctorsName"]);
                obj.StatusName = Convert.ToString(dataTable.Rows[0]["StatusName"]);
                obj.Email = Convert.ToString(dataTable.Rows[0]["Email"]);
                obj.PrimaryContactNumber = Convert.ToString(dataTable.Rows[0]["PrimaryContactNumber"]);
                obj.AlternateContactNumber = Convert.ToString(dataTable.Rows[0]["AlternateContactNumber"]);
                obj.PrimaryLanguage = Convert.ToString(dataTable.Rows[0]["PrimaryLanguage"]);
                obj.SecondaryLanguage = Convert.ToString(dataTable.Rows[0]["SecondaryLanguage"]);
                obj.Ethnicity = Convert.ToString(dataTable.Rows[0]["Ethnicity"]);
                obj.GuardianName = dataTable.Rows[0]["GuardianName"].ToString();
                obj.MaritalStatus = Convert.ToString(dataTable.Rows[0]["MaritalStatus"]);
                obj.Races = dataTable.Rows[0]["Races"].ToString();
                obj.HomePhone = dataTable.Rows[0]["HomePhone"].ToString();
                obj.WorkPhone = dataTable.Rows[0]["CellPhone"].ToString();
                obj.Comments = dataTable.Rows[0]["Comments"].ToString();
                obj.DriverLicenseID = dataTable.Rows[0]["DriverLicenseID"].ToString();
                if (dataTable.Rows[0]["DriverLicenseState"].ToString() != "")
                    obj.DriverLicenseState = Convert.ToBoolean(dataTable.Rows[0]["DriverLicenseState"]);
                obj.SSN = dataTable.Rows[0]["SSN"].ToString();
                obj.CustomPatientID = dataTable.Rows[0]["CustomPatientID"].ToString();
                obj.EmergencyName1 = Convert.ToString(dataTable.Rows[0]["EmergencyName1"]);
                obj.EmergencyPhoneNo1 = Convert.ToString(dataTable.Rows[0]["EmergencyPhoneNo1"]);
                obj.EmergencyRelationship1 = Convert.ToString(dataTable.Rows[0]["EmergencyRelationship1"]);
                obj.EmergencyName2 = Convert.ToString(dataTable.Rows[0]["EmergencyName2"]);
                obj.EmergencyPhoneNo2 = Convert.ToString(dataTable.Rows[0]["EmergencyPhoneNo2"]);
                obj.EmergencyRelationship2 = Convert.ToString(dataTable.Rows[0]["EmergencyRelationship2"]);
                obj.DeviceID = Convert.ToString(dataTable.Rows[0]["DeviceId"]);
                if (dataTable.Rows[0]["DeviceReceivedDate"] != DBNull.Value)
                    obj.DeviceReceivedDateStr = String.Format("{0:MM/dd/yyyy}", dataTable.Rows[0]["DeviceReceivedDate"]);
                if (dataTable.Rows[0]["LowBPLimit"] != DBNull.Value)
                    obj.LowBPLimit = Convert.ToInt32(dataTable.Rows[0]["LowBPLimit"]);
                else
                    obj.LowBPLimit = null;
                if (dataTable.Rows[0]["HighBPLimit"] != DBNull.Value)
                    obj.HighBPLimit = Convert.ToInt32(dataTable.Rows[0]["HighBPLimit"]);
                else
                    obj.HighBPLimit = null;
                if (dataTable.Rows[0]["LowGlucoseLimit"] != DBNull.Value)
                    obj.LowGlucoseLimit = Convert.ToInt32(dataTable.Rows[0]["LowGlucoseLimit"]);
                else
                    obj.LowGlucoseLimit = null;
                if (dataTable.Rows[0]["HighGlucoseLimit"] != DBNull.Value)
                    obj.HighGlucoseLimit = Convert.ToInt32(dataTable.Rows[0]["HighGlucoseLimit"]);
                else
                    obj.HighGlucoseLimit = null;
            }
            return obj;
        }

        public List<ClinicBO.CCMNoteModel> getCCMNoteByPatinetID(Int64 PatientID, string FromDate = null, string ToDate = null, bool IsBillable = false)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            try
            {
                parameters.Add("@PatientID", PatientID);
                parameters.Add("@FromDate", (FromDate != "") ? Convert.ToDateTime(DateTime.ParseExact(FromDate, "mm/dd/yy", CultureInfo.InvariantCulture)) : (DateTime?)null);
                parameters.Add("@ToDate", (ToDate != "") ? Convert.ToDateTime(DateTime.ParseExact(ToDate, "mm/dd/yy", CultureInfo.InvariantCulture)) : (DateTime?)null);
                parameters.Add("@IsBillable", IsBillable);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Get CCM Notes by ID DB Error");
            }

            return TransformCCMNoteReportDescriptions(DBManager.GetData(GetCCMNoteReportByPatientID_SP, parameters));
        }

        private List<ClinicBO.CCMNoteModel> TransformCCMNoteReportDescriptions(DataTable dataTable)
        {
            List<ClinicBO.CCMNoteModel> listmodel = new List<ClinicBO.CCMNoteModel>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    ClinicBO.CCMNoteModel obj = new ClinicBO.CCMNoteModel();
                    obj.CCMNoteID = Convert.ToInt64(item["CCMNoteID"]);
                    obj.Description = item["Description"].ToString();
                    obj.CCMDate = Convert.ToDateTime(item["CCMDate"]);
                    obj.TotalMinute = item["TotalMinute"].ToString();
                    obj.Timespent = item["Timespent"].ToString();
                    obj.CreatedByName = item["CreatedBy"].ToString();
                    listmodel.Add(obj);
                }
            }
            return listmodel;
        }

        public List<PatientModel> GetRPMBillingReport()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@LoginUserID", LoginUserID);
            return TransformRPMReportDescriptions(DBManager.GetData(GetRPMBillingReport_SP, parameters));
        }

        private List<PatientModel> TransformRPMReportDescriptions(DataTable dataTable)
        {
            List<PatientModel> patientList = new List<PatientModel>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    PatientModel obj = new PatientModel();
                    obj.PatientID = Convert.ToInt64(item["PatientID"]);
                    obj.FullName = Convert.ToString(item["LastName"]);
                    obj.FirstName = Convert.ToString(item["FirstName"]);
                    obj.LastName = Convert.ToString(item["Concatenated name"]);
                    obj.Medicareid = Convert.ToString(item["MedicareId"]);
                    obj.MedicareNumber = Convert.ToString(item["Medicaidnumber"]);
                    obj.GenderStr = Convert.ToString(item["Gender"]);
                    obj.DOBStr = Convert.ToString(item["DOB"]);
                    if (item["Age"] != DBNull.Value)
                        obj.Age = Convert.ToInt32(item["Age"]);
                    obj.DoctorsName = Convert.ToString(item["Name"]);
                    obj.DeviceID = Convert.ToString(item["DeviceID"]);
                    obj.Practice = Convert.ToString(item["Practice"]);
                    obj.RPMInteractionTime = Convert.ToString(item["RPMInteractionTime"]);
                    obj.TotalDaysReadings = Convert.ToInt32(item["TotalDaysReadings"]);
                    obj.DeviceID = Convert.ToString(item["DeviceId"]);
                    obj.DeviceReceivedDateStr = Convert.ToString(item["DateofService453"]);
                    obj.DiagnosisCode = Convert.ToString(item["DiagnosisCode"]);
                    obj.Billable454 = Convert.ToString(item["Billable454"]);
                    obj.Billable457 = Convert.ToString(item["Billable457"]);
                    obj.Billable458 = Convert.ToString(item["Billable458"]);
                    obj.Billable459 = Convert.ToString(item["Billable459"]);
                    patientList.Add(obj);
                }
            }
            return patientList;
        }

       
    }
}