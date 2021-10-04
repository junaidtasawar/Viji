using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Clinic.Models.CommonModel;
using Clinic.Controllers.Utility;
using System.Reflection;
using Clinic.Models.DoctorModel;
using Clinic.Models.LoginModel;
using RestSharp;
using ClinicBO;
using System.Data;

namespace Clinic.Controllers.Common
{
    public class CommonController : BaseController
    {
        long userId = 0;
        public ActionResult GenderDDL()
        {
            return PartialView("GenderDDL");
        }

        public ActionResult CityDDL()
        {
            return PartialView("CityDDL");
        }

        public ActionResult SNOMEDDDL()
        {
            return PartialView("SNOMEDDDL");
        }

        public ActionResult MaritalStatusDDL()
        {
            return PartialView("MaritalStatusDDL");
        }

        public ActionResult CCMTimeSpanBillingDDL()
        {
            return PartialView("CCMTimeSpanBillingDDL");
        }

        public ActionResult ClinicDDL()
        {
            return PartialView("ClinicDDL");
        }

        public ActionResult StateDDL()
        {
            return PartialView("StateDDL");
        }

        public ActionResult CCMTimeSpanDDL()
        {
            return PartialView("CCMTimeSpanDDL");
        }

        public ActionResult CountryDDL()
        {
            return PartialView("CountryDDL");
        }

        public ActionResult BloodGroupDDL()
        {
            return PartialView("BloodGroupDDL");
        }

        public ActionResult StatusDDL()
        {
            return PartialView("StatusDDL");
        }

        public ActionResult DoctorDDL()
        {
            return PartialView("DoctorDDL");
        }

        public ActionResult AllergyTypeDDL()
        {
            return PartialView("AllergyTypeDDL");
        }

        public ActionResult SeverityDDL()
        {
            return PartialView("SeverityDDL");
        }

        public ActionResult SourceDDL()
        {
            return PartialView("SourceDDL");
        }

        public ActionResult AllergyStatusDDL()
        {
            return PartialView("AllergyStatusDDL");
        }

        public ActionResult RacesDDL()
        {
            return PartialView("RacesDDL");
        }

        public ActionResult EthnicityDDL()
        {
            return PartialView("EthnicityDDL");
        }

		public ActionResult PatientStatusDDL()
		{
			return PartialView("PatientStatusDDL");
		}

		public JsonResult GetCountries(string term)
        {
            try
            {
                CommonModel model = new CommonModel();
                model.SearchString = term;
                List<CommonModel> countryList = model.GetCountries();
                var jsonData = new
                {
                    rows = (from data in countryList
                            select new
                            {
                                i = data.CountryID,
                                cell = new string[] {
                            data.CountryName.ToString(),
                       }
                            }).ToList()
                };
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                return null;
            }
        }

        public JsonResult GetClinic(string term)
        {
            try
            {
                CommonModel model = new CommonModel();
                LoginModel usermodel = new LoginModel();
                usermodel = (LoginModel)Session["User"];
                model.LoginUserID = usermodel.ID;
                model.SearchString = term;
                List<CommonModel> clinicList = model.GetClinic();
                var jsonData = new
                {
                    rows = (from data in clinicList
                            select new
                            {
                                //i = data.ClinicID,
                                cell = new string[] {
                            data.ClinicName.ToString(),
                       }
                            }).ToList()
                };
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                return null;
            }
        }

        public JsonResult GetCities(string term)
        {
            try
            {
                CommonModel model = new CommonModel();
                model.SearchString = term;
                List<CommonModel> cityList = model.GetCities();
                var jsonData = new
                {
                    rows = (from data in cityList
                            select new
                            {
                                i = data.CityID,
                                cell = new string[] {
                            data.CityName.ToString(),
                       }
                            }).ToList()
                };
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                return null;
            }
        }

        public JsonResult GetStates(string term)
        {
            try
            {
                CommonModel model = new CommonModel();
                model.SearchString = term;
                List<CommonModel> stateList = model.GetStates();
                var jsonData = new
                {
                    rows = (from data in stateList
                            select new
                            {
                                i = data.StateID,
                                cell = new string[] {
                            data.StateName.ToString(),
                       }
                            }).ToList()
                };
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                return null;
            }
        }

        public JsonResult GetDoctors(string term)
        {
            CommonModel model = new CommonModel();
            model.SearchString = term;
            List<CommonModel> doctorList = model.GetDoctors();

            var jsonData = new
            {
                rows = (from data in doctorList
                        select new
                        {
                            i = data.DoctorID,
                            cell = new string[] {
                            data.DoctorName.ToString(),
                       }
                        }).ToList()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public ActionResult PartialClinic()
        {
            ClinicModel model = new ClinicModel();

            try
            {
                LoginModel usermodel = new LoginModel();
                usermodel = (LoginModel)Session["User"];
                userId = usermodel.ID;
                APIResponse apiResponse = new APIResponse();
                var client = new RestClient(String.Concat(_apiUrl, "api/Clinic/GetAllClinic?LoginUserID=" + usermodel.ID));
                var request = new RestRequest("", Method.GET) { RequestFormat = DataFormat.Json };
                request.AddParameter("Authorization", string.Format("Bearer " + Session["token"].ToString()), ParameterType.HttpHeader);
                //request.AddJsonBody(model);
                var response = client.Execute<bool>(request);
                if (response.StatusCode == System.Net.HttpStatusCode.OK && response.Content.Length > 0)
                {
                    apiResponse = (APIResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(response.Content, typeof(APIResponse));
                }

                if (apiResponse.IsError)
                {

                }
                else
                {
                    model.DT_Clinic = (DataTable)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(DataTable));
                }
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name, userId);
            }

            return PartialView(model);
        }
    }
}