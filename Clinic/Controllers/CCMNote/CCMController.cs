using Clinic.Controllers.Utility;
using Clinic.Models.LoginModel;
using ClinicBO;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace Clinic.Controllers.CCM_Note
{
    public class CCMController : BaseController
    {
        long userId = 0;

        public ActionResult CCMNote()
        {
            if (Session["User"] != null)
            {
                try
                {
                    List<CCMNoteInfoModel> listmodel = new List<CCMNoteInfoModel>();
                    listmodel = GetCCMNoteInfoDetails();
                    return PartialView("CCMNote", listmodel);
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return PartialView("CCMNote");
        }

        public ActionResult AddNewNoteForm()
        {
            if (Session["User"] != null)
            {
                try
                {
                    return PartialView("AddNewNoteForm");
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        [HttpPost]
        public JsonResult CallLogs(Int64 PatientId, DateTime Startime, DateTime Endtime, DateTime Duration)
        {
            Int64 calllogid = -1;

            CallLogModel cl = new CallLogModel();
            cl.PatientId = PatientId;
            cl.StartTime = Startime;
            cl.EndTime = Endtime;
            cl.Duration = Duration;
            cl.CallLogId = calllogid;

            Int64 recordId = -1;
            APIResponse apiResponse = new APIResponse();
            LoginModel usermodel = new LoginModel();
            usermodel = (LoginModel)Session["User"];
            userId = usermodel.ID;

            try
            {
                var client = new RestClient(String.Concat(_apiUrl, "api/CCM/GetCallLogs"));
                var request = new RestRequest("", Method.POST) { RequestFormat = DataFormat.Json };
                request.AddParameter("Authorization", string.Format("Bearer " + Session["token"].ToString()), ParameterType.HttpHeader);
                request.AddJsonBody(cl);
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
            if (recordId > 0)
            {
                return Json(calllogid, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(string.Empty, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult CCMNoteGrid()
        {
            if (Session["User"] != null)
            {
                try
                {
                    return PartialView("CCMNoteGrid");
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public List<CCMNoteInfoModel> GetCCMNoteInfoDetails()
        {
            try
            {
                APIResponse apiResponse = new APIResponse();
                var client = new RestClient(String.Concat(_apiUrl, "api/CCMNoteInfo/GetCCMNoteInfoDetails"));
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
                    var records = (List<CCMNoteInfoModel>)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(List<CCMNoteInfoModel>));
                    return records;
                }
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
            }

            return null;
        }

        public JsonResult GetCCMNoteInfoDescById(Int64 CCMNoteInfoId)
        {
            string ccmNoteINfoDesc = string.Empty;
            APIResponse apiResponse = new APIResponse();
            var client = new RestClient(String.Concat(_apiUrl, "api/CCMNoteInfo/GetCCMNoteInfoDescById?CCMNoteInfoId=" + CCMNoteInfoId));
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
                ccmNoteINfoDesc = Convert.ToString(apiResponse.Data);
            }

            return new JsonResult { Data = ccmNoteINfoDesc, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        public Int64 InsertCCMNoteInfo(CCMNoteInfoModel model)
        {
            Int64 recordId = -1;
            APIResponse apiResponse = new APIResponse();
            try
            {
                var client = new RestClient(String.Concat(_apiUrl, "api/CCMNoteInfo/InsertCCMNoteInfo"));
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
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
            }

            return recordId;
        }

        [HttpGet]
        public JsonResult GetCCMNoteByPatientID_ForList(int? page, int? limit, string sortBy, string direction, string searchString = null, string patientID = null)
        {
            try
            {
                APIResponse apiResponse = new APIResponse();
                var client = new RestClient(String.Concat(_apiUrl, "api/CCMNote/GetCCMNoteByPatientID?page=" + page.Value + "&limit=" + limit.Value + "&patientId=" + patientID));
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
                    var records = (List<CCMNoteModel>)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(List<CCMNoteModel>));
                    int total = records.Count > 0 ? records.FirstOrDefault().TotalCount : 0;

                    return Json(new { records, total }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void SaveCCMDetails(string CCMNoteID, string PatientId, string datepicker, string timepicker, string inputTimeSpent, string HdnDescription, bool IsBillable, string PatientStatus, string WellnessStatus, string callLogId)
        {
            Int64 userId = 0;
            try
            {
                Int64 recordId = -1;
                APIResponse apiResponse = new APIResponse();
                CCMNoteModel model = new CCMNoteModel();
                if (CCMNoteID != "")
                    model.CCMNoteID = Convert.ToInt64(CCMNoteID);

                model.PatientID = Convert.ToInt64(PatientId);
                if (datepicker != null)
                {
                    DateTime date;
                    if (DateTime.TryParseExact(datepicker, "MM/dd/yy", CultureInfo.InvariantCulture,
                          DateTimeStyles.None, out date))
                    {
                        model.CurrentDate = date;
                        model.CurrentDateStr = date.ToShortDateString();
                    }
                }
                model.CurrentTime = timepicker;
                //DateTime TimeSpent = DateTime.ParseExact(inputTimeSpent, "HH:mm:ss", CultureInfo.InvariantCulture);
                model.MinuteSpent = inputTimeSpent;
                if (HdnDescription.StartsWith(","))
                {
                    model.Description = HdnDescription.Substring(1);
                }
                model.IsBillable = IsBillable;
                model.PatientStatus = PatientStatus;
                model.WellnessCallStatus = WellnessStatus;
                if (Session["User"] != null)
                {
                    LoginModel usermodel = new LoginModel();
                    usermodel = (LoginModel)Session["User"];
                    model.CreatedBy = usermodel.ID;
                    userId = usermodel.ID;
                }
                model.CallLogId = Convert.ToInt64(callLogId);

                var client = new RestClient(String.Concat(_apiUrl, "api/CCMNote/SaveCCMNoteDetails"));
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
        }

        public ActionResult Index(string PatientId, string CcmNoteID, string MobileNumber)
        {
            if (Session["User"] != null)
            {
                try
                {
                    if (PatientId != null)
                    {
                        CCMNoteModel model = new CCMNoteModel();
                        if (CcmNoteID != null)
                        {
                            model.CCMNoteID = Convert.ToInt64(CcmNoteID);
                            model.PatientID = Convert.ToInt64(PatientId);

                            APIResponse apiResponse = new APIResponse();
                            var client = new RestClient(String.Concat(_apiUrl, "api/CCMNote/GetCCMNoteByID?CCMNoteId=" + model.CCMNoteID + "&patientId=" + model.PatientID));
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
                                model = (CCMNoteModel)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(CCMNoteModel));
                            }

                            model.CellNumber = MobileNumber;
                            return View(model);
                        }
                        else
                        {
                            model.CellNumber = MobileNumber;
                            model.PatientID = Convert.ToInt64(PatientId);
                            return View(model);
                        }
                    }

                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public ActionResult CCMNoteForm()
        {
            if (Session["User"] != null)
            {
                try
                {
                    return PartialView("CCMNoteForm");
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }
    }
}