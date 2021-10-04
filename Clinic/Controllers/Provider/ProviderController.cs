using Clinic.Controllers.Utility;
using Clinic.Models.LoginModel;
using ClinicBO;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace Clinic.Controllers.Provider
{
    public class ProviderController : BaseController
    {
        long userId = 0;

        public ActionResult Index()
        {
            if (Session["User"] != null)
            {
                try
                {
                    return View();
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public ActionResult ProviderMaster(string DoctorID)
        {
            if (Session["User"] != null)
            {
                try
                {
                    if (DoctorID != null)
                    {
                        //DoctorModel model = new DoctorModel();
                        //model.DoctorID = Convert.ToInt64(DoctorID);
                        //model = model.GetDoctorDetailsByDoctorID();
                        //return View(model);
                        DoctorModel model = new DoctorModel();
                        ClinicBO.APIResponse apiResponse = new ClinicBO.APIResponse();
                        var client = new RestClient(String.Concat(_apiUrl, "api/Provider/ProviderMasterById?doctorid=" + DoctorID));
                        var request = new RestRequest("", Method.GET) { RequestFormat = DataFormat.Json };
                        request.AddParameter("Authorization", string.Format("Bearer " + Session["token"].ToString()), ParameterType.HttpHeader);
                        var response = client.Execute<bool>(request);
                        if (response.StatusCode == System.Net.HttpStatusCode.OK && response.Content.Length > 0)
                        {
                            apiResponse = (ClinicBO.APIResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(response.Content, typeof(APIResponse));
                        }

                        if (apiResponse.IsError)
                        {

                        }
                        else
                        {
                            model = (DoctorModel)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(DoctorModel));
                        }

                        return View(model);
                    }
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name, userId);
                }
                return View();
            }
            return Redirect("/Authentication/Login");
        }

        public ActionResult SaveDoctorDetails(DoctorModel model)
        {
            Int64 recordId = -1;
            APIResponse apiResponse = new APIResponse();
            try
            {
                //Int64 RecordID = 0;
                LoginModel usermodel = new LoginModel();
                usermodel = (LoginModel)Session["User"];
                model.CreatedBy = usermodel.ID;
                model.IsActive = true;
                var client = new RestClient(String.Concat(_apiUrl, "api/Provider/SaveDoctorDetails"));
                var request = new RestRequest("", Method.POST) { RequestFormat = DataFormat.Json };
                request.AddParameter("Authorization", string.Format("Bearer " + Session["token"].ToString()), ParameterType.HttpHeader);
                request.AddJsonBody(model);
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
                    recordId = (Int64)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(Int64));
                }

            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name, userId);
            }


            //RecordID = model.SaveDoctorDetails();
            if (recordId > 0)
            {
                model.DoctorID = recordId;
                return View("Index", model);
            }
            return View("Index", model);
        }

        [HttpGet]
        public JsonResult GetAllDoctorDetails_ForList(int? page, int? limit, string sortBy, string direction, string searchString = null)
        {
            try
            {
                DoctorModel model = new DoctorModel();
                //model.CurrentPage = page.Value;
                //model.NumberOfRecords = limit.Value;
                //model.OrderBy = string.Format("{0} {1}", sortBy, direction);
                //var records = model.GetDoctorData_ForList();
                string orderby = " ";
                APIResponse apiResponse = new APIResponse();
                var client = new RestClient(String.Concat(_apiUrl, "api/Provider/GetDoctorList?page=" + page.Value + "&limit=" + limit.Value+ "&Orderby=" + orderby));
                var request = new RestRequest("", Method.GET) { RequestFormat = DataFormat.Json };
                request.AddParameter("Authorization", string.Format("Bearer " + Session["token"].ToString()), ParameterType.HttpHeader);
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
                    var records = (List<DoctorModel>)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(List<DoctorModel>));
                    int total = records.Count > 0 ? records.FirstOrDefault().TotalCount : 0;

                    return Json(new { records, total }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name, userId);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }
    }
}