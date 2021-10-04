using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Clinic.Models.CommonModel
{
    public class CommonModel
    {
        public long CityID { get; set; }
        public string CityName { get; set; }

        public long StateID { get; set; }
        public string StateName { get; set; }

        public long CountryID { get; set; }
        public string CountryName { get; set; }

        public long ClinicID { get; set; }
        public string ClinicName { get; set; }

        public long DoctorID { get; set; }
        public string DoctorName { get; set; }

        public string SearchString { get; set; }
        public Int64 LoginUserID { get; set; }



        public static string GetCityData_SP = "SP_GetCityData";
        public static string GetStateData_SP = "SP_GetStateData";
        public static string GetCountryData_SP = "SP_GetCountryData";

        public static string GetCountryDataAutocomplete_SP = "SP_GetCountryDataAutocomplete";
        public static string GetCityDataAutocomplete_SP = "SP_GetCityDataAutocomplete";
        public static string GetStateDataAutocomplete_SP = "SP_GetStateDataAutocomplete";
        public static string GetClinicDataAutocomplete_SP = "SP_GetClinicDataAutocomplete";
        private static string GetDoctorDataAutoComplete_SP = "SP_GetDoctorDataAutoComplete";

        public DataTable GetCityData()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@StateID", StateID);
            return DBManager.GetData(GetCityData_SP, parameters);
        }

        public DataTable GetStateData()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CountryID", CountryID);
            return DBManager.GetData(GetStateData_SP, parameters);
        }

        public DataTable GetCountryData()
        {
            return DBManager.GetData(GetCountryData_SP);
        }

        public List<CommonModel> GetCountries()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@SearchString", SearchString);
            return TransfromCountriesData(DBManager.GetData(GetCountryDataAutocomplete_SP, parameters));
        }

        public List<CommonModel> TransfromCountriesData(DataTable data)
        {
            List<CommonModel> countryList = new List<CommonModel>();

            foreach (var item in data.AsEnumerable())
            {
                CommonModel model = new CommonModel();
                model.CountryID = Convert.ToInt64(item["CountryID"]);
                model.CountryName = Convert.ToString(item["Country"]);
                countryList.Add(model);
            }
            return countryList;
        }

        public List<CommonModel> GetStates()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@SearchString", SearchString);
            return TransfromStatesData(DBManager.GetData(GetStateDataAutocomplete_SP, parameters));
        }

        public List<CommonModel> TransfromStatesData(DataTable data)
        {
            List<CommonModel> countryList = new List<CommonModel>();

            foreach (var item in data.AsEnumerable())
            {
                CommonModel model = new CommonModel();
                model.StateID = Convert.ToInt64(item["RegionID"]);
                model.StateName = Convert.ToString(item["Region"]);
                countryList.Add(model);
            }
            return countryList;
        }

        public List<CommonModel> GetCities()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@SearchString", SearchString);
            return TransfromCitiesData(DBManager.GetData(GetCityDataAutocomplete_SP, parameters));
        }

        public List<CommonModel> TransfromCitiesData(DataTable data)
        {
            List<CommonModel> countryList = new List<CommonModel>();

            foreach (var item in data.AsEnumerable())
            {
                CommonModel model = new CommonModel();
                model.CityID = Convert.ToInt64(item["CityID"]);
                model.CityName = Convert.ToString(item["CityName"]);
                countryList.Add(model);
            }
            return countryList;
        }

        public List<CommonModel> GetClinic()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@SearchString", SearchString);
            parameters.Add("@LoginUserID", LoginUserID);
            return TransfromClinicData(DBManager.GetData(GetClinicDataAutocomplete_SP, parameters));
        }

        public List<CommonModel> TransfromClinicData(DataTable data)
        {
            List<CommonModel> clinicList = new List<CommonModel>();

            foreach (var item in data.AsEnumerable())
            {
                CommonModel model = new CommonModel();
                //model.ClinicID = Convert.ToInt64(item["ClinicID"]);
                model.ClinicName = Convert.ToString(item["Name"]);
                clinicList.Add(model);
            }
            return clinicList;
        }

        internal List<CommonModel> GetDoctors()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@SearchString", SearchString);
            return TransfromDoctorsData(DBManager.GetData(GetDoctorDataAutoComplete_SP, parameters));
        }

        private List<CommonModel> TransfromDoctorsData(DataTable data)
        { 
            List<CommonModel> doctorList = new List<CommonModel>();

            foreach (var item in data.AsEnumerable())
            {
                CommonModel model = new CommonModel();
                model.DoctorID = Convert.ToInt64(item["DoctorID"]);
                model.DoctorName = Convert.ToString(item["Name"]);
                doctorList.Add(model);
            }
            return doctorList;
        }
    }
}