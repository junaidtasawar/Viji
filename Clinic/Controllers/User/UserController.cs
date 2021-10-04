using Clinic.Controllers.Utility;
using Clinic.Models.LoginModel;
using ClinicBO;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Mvc;

namespace Clinic.Controllers.User
{
    public class UserController : BaseController
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

        public ActionResult AddUser(string UserID)
        {
            if (Session["User"] != null)
            {
                try
                {
                    if (UserID != null)
                    {
                        //UserModel model = new UserModel();
                        //model.UserID = Convert.ToInt64(UserID);
                        //LoginModel usermodel = new LoginModel();
                        //usermodel = (LoginModel)Session["User"];
                        //userId = usermodel.ID;
                        //model = model.GetUserDetailsByUserID();
                        //return View(model);
                        UserModel model = new UserModel();
                        ClinicBO.APIResponse apiResponse = new ClinicBO.APIResponse();
                        var client = new RestClient(String.Concat(_apiUrl, "api/User/GetUserDetailsById?userid=" + UserID));
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
                            model = (UserModel)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(UserModel));
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

        public ActionResult AddUserForm()
        {
            if (Session["User"] != null)
            {
                try
                {
                    return PartialView("AddUserForm");
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public string SaveUserDetails(UserModel model)
        {
            Int64 recordId = -1;
            APIResponse apiResponse = new APIResponse();
            try
            {
              
                LoginModel usermodel = new LoginModel();
                usermodel = (LoginModel)Session["User"];
                model.Password = UtilityController.Encrypt(model.Password, "CCMClinic");
                model.CreatedBy = usermodel.ID;
                userId = usermodel.ID;
                model.IsActive = true;
                if (model.ClinicName != null)
                {
                    var client = new RestClient(String.Concat(_apiUrl, "api/User/SaveUserDetails"));
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
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name, userId);
            }

            return (recordId > 0) ? recordId.ToString() : string.Empty;
            //return "";
        }

        [HttpGet]
        public JsonResult GetAllUserDetails_ForList(int? page, int? limit, string sortBy, string direction, string searchString = null)
        {
            try
            {
                //UserModel model = new UserModel();
                LoginModel usermodel = new LoginModel();
                //model.CurrentPage = page.Value;
                //model.NumberOfRecords = limit.Value;
                usermodel = (LoginModel)Session["User"];
                //model.LoginUserID = usermodel.ID;
                userId = usermodel.ID;
                string orderby = " ";

                APIResponse apiResponse = new APIResponse();
                var client = new RestClient(String.Concat(_apiUrl, "api/User/GetUserList?page=" + page.Value + "&limit=" + limit.Value + "&LoginUserID=" + usermodel.ID + "&Orderby=" + orderby));
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
                    var records = (List<UserModel>)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(List<UserModel>));
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