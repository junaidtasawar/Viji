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

namespace Clinic.Controllers.Clinic
{
    public class ClinicController : BaseController
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

        public ActionResult ClinicMaster(string ClinicID)
        {
            if (Session["User"] != null)
            {
                try
                {
                    if (ClinicID != null)
                    {
                        ClinicModel model = new ClinicModel();
                        APIResponse apiResponse = new APIResponse();
                        var client = new RestClient(String.Concat(_apiUrl, "api/Clinic/GetClinicDetailsById?clinicId=" + ClinicID));
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
                            model = (ClinicModel)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(ClinicModel));
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

        public ActionResult ClinicMasterForm()
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

        [HttpPost]
        public string SaveClinicDetails(ClinicModel model)
        {
            Int64 recordId = -1;
            APIResponse apiResponse = new APIResponse();
            LoginModel usermodel = new LoginModel();
            usermodel = (LoginModel)Session["User"];
            model.CreatedBy = usermodel.ID;
            model.IsActive = true;

            try
            {
                var client = new RestClient(String.Concat(_apiUrl, "api/Clinic/SaveClinicDetails"));
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

            return (recordId > 0) ? recordId.ToString() : string.Empty;
        }

        [HttpGet]
        public JsonResult GetAllClinicDetails_ForList(int? page, int? limit, string sortBy, string direction, string searchString = null)
        {
            try
            {
                LoginModel usermodel = new LoginModel();
                usermodel = (LoginModel)Session["User"];
                userId = usermodel.ID;

                APIResponse apiResponse = new APIResponse();
                var client = new RestClient(String.Concat(_apiUrl, "api/Clinic/GetClinicList?page=" + page.Value + "&limit=" + limit.Value + "&LoginUserID=" + usermodel.ID));
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
                    var records = (List<ClinicModel>)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(List<ClinicModel>));
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

        //[HttpPost]
        //public string DeleteClinicDetails(string ClinicID)
        //{
        //    ClinicModel obj = new ClinicModel();
        //    obj.ClinicID = Convert.ToInt64(ClinicID);
        //    obj.DeleteClinicDetails();
        //    return "";
        //}
    }
}