using Clinic.Controllers.Utility;
using Clinic.Models.Dashboard;
using Clinic.Models.LoginModel;
using Clinic.Models.PatientModel;
using ClinicBO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using RestSharp;
using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Linq;
using System.Net.Http;

namespace Clinic.Controllers
{
    public class HomeController : BaseController
    {
        Int64 userId = -1;

        public JsonResult GetNotifications()
        {
            var notificationRegisterTime = Session["LastUpdated"] != null ? Convert.ToDateTime(Session["LastUpdated"]) : DateTime.Now;
            //NotificationModel NC = new NotificationModel();
            //var list = NC.GetData(notificationRegisterTime);
            Session["LastUpdate"] = DateTime.Now;

            try
            {

                APIResponse apiResponse = new APIResponse();
                var client = new RestClient(String.Concat(_apiUrl, "api/Notification/GetNotification?Afterdate=" + notificationRegisterTime));
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
                    var records = (List<NotificationModel>)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(List<NotificationModel>));
                    //int total = records.Count > 0 ? records.FirstOrDefault().TotalCount : 0;

                    return new JsonResult { Data = records, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                }
            }

            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name, userId);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
            //return new JsonResult { Data = list, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Dashboard()
        {
            LoginModel loginuser = (LoginModel)Session["User"];
            DashboardModel model = new DashboardModel();
            model.CreatedBy = loginuser.ID;
            model = model.GetDashboardData();
            return View(model);
        }

        public ActionResult Pricing()
        {
            if (Session["User"] != null)
            {
                try
                {
                    //EmployeeHub.NotifyCurrentEmployeeInformationToAllClients();

                    return View();
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public ActionResult RPMDashboard()
        {
            if (Session["User"] != null)
            {
                try
                {
                    //EmployeeHub.NotifyCurrentEmployeeInformationToAllClients();

                    return View();
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public JsonResult GetRPMReportDetails_ForList(int? page, int? limit, string sortBy, string direction, string searchString = null, string status = null)
        {
            try
            {
                RPMDashboard rpmModel = new RPMDashboard();
                var records = new List<RPMDashboard>();

                LoginModel usermodel = new LoginModel();
                rpmModel.Status = null;
                rpmModel.CurrentPage = page.Value;
                rpmModel.NumberOfRecords = limit.Value;
                rpmModel.OrderBy = string.Format("{0} {1}", sortBy, direction);
                usermodel = (LoginModel)Session["User"];
                rpmModel.LoginUserID = usermodel.ID;
                if (usermodel.ClinicName != null)
                {
                    string[] clinicList = usermodel.ClinicName.Split(',');
                    for (int i = 0; i < clinicList.Length; i++)
                    {
                        if (i == 0)
                            rpmModel.Clinic1 = clinicList[i].TrimStart();
                        if (i == 1)
                            rpmModel.Clinic2 = clinicList[i].TrimStart();
                        if (i == 2)
                            rpmModel.Clinic3 = clinicList[i].TrimStart();
                    }
                }
                APIResponse apiResponse = new APIResponse();
                var client = new RestClient(String.Concat(_apiUrl, "api/RPMDashboard/GetRPMReportDetails"));
                var request = new RestRequest("", Method.POST) { RequestFormat = DataFormat.Json };
                request.AddParameter("Authorization", string.Format("Bearer " + Session["token"].ToString()), ParameterType.HttpHeader);
                request.AddJsonBody(rpmModel);
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
                    records = (List<RPMDashboard>)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(List<RPMDashboard>));
                }

                //return Json(messages, JsonRequestBehavior.AllowGet);
                //int total = 5;
                //int total = records.Count > 0 ? records.FirstOrDefault().TotalCount : 0;
                //yeh pagination ke leye hai
                int total = records.Count();
                //int recordss = 0;
                if (page.HasValue && limit.HasValue)
                {
                    int start = (page.Value - 1) * limit.Value;
                    records = records.Skip(start).Take(limit.Value).ToList();
                }
                else
                {
                    records = records.ToList();
                }

                //EmployeeHub.NotifyCurrentEmployeeInformationToAllClients();

                return Json(new { records, total }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }

        public FileResult DownloadSingleReadingReport(Int64 PatientID)
        {
            string FolderPathToZip = string.Empty;
            APIResponse apiResponse = new APIResponse();
            LoginModel usermodel = new LoginModel();
            usermodel = (LoginModel)Session["User"];
            List<PatientReport> listobj = new List<PatientReport>();
            userId = usermodel.ID;
            var client = new RestClient(String.Concat(_apiUrl, "api/Report/GetSingleReadingReport?PatientId=" + PatientID));
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
                listobj = (List<PatientReport>)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(List<PatientReport>));

                PatientModel patientModel = new PatientModel();
                patientModel.PatientID = Convert.ToInt64(PatientID);

                patientModel = patientModel.GetPatientDetailsByPatientID();
                if (patientModel.ClinicName != null)
                {
                    string body = string.Empty;
                    body = string.Empty;
                    body = System.IO.File.ReadAllText(Server.MapPath("~/Template/ReadingReport.html"));
                    body = body.Replace("_ClinicName", patientModel.ClinicName);
                    body = body.Replace("_PatientName", patientModel.FirstName + " " + patientModel.LastName);
                    body = body.Replace("_CurrentDate", DateTime.Now.ToShortDateString());
                    body = body.Replace("_DOB", patientModel.DOBStr);
                    body = body.Replace("_MRNNumber", patientModel.MRNNumber);
                    body = body.Replace("_Address", patientModel.Address);
                    body = body.Replace("_ContactNo", patientModel.CellNumber);
                    if (listobj.Count > 0)
                    {
                        StringBuilder ccmreport = new StringBuilder();
                        ccmreport.Append(@"<table border='1' style='margin-top: 25px;'>
                                            <tr>
                                                <td width='50%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Blood Pressure</td>
                                                <td width='50%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Created Date</td>
                                            </tr>");
                        foreach (var item in listobj)
                        {
                            ccmreport.Append(@"<tr>
                                            <td width='50%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.BP + "</td>" +
                                            "<td width='50%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.CreationDateStr + "</td>" +
                                            "</tr>");
                        }
                        ccmreport.Append(@"</table>");

                        body = body.Replace("_ReadingReport", ccmreport.ToString());

                        bool folder_exists = Directory.Exists(Server.MapPath("~/uploads"));
                        if (!folder_exists)
                            Directory.CreateDirectory(Server.MapPath("~/uploads"));
                        string targetFolder = Server.MapPath("~/uploads");
                        Array.ForEach(Directory.GetFiles(Server.MapPath("/uploads")), System.IO.File.Delete);
                        string filename = getFilePath(targetFolder, patientModel);// targetFolder + "//" + patientModel.FirstName + " " + patientModel.LastName + ".pdf";
                        PdfSharpConvert(body, filename);
                    }
                }
            }

            if (Environment.OSVersion.Platform == PlatformID.Unix)
                FolderPathToZip = Server.MapPath("~/uploads") + "//ReadingIndividualReport.zip";
            else
                FolderPathToZip = Server.MapPath("~/uploads") + "\\ReadingIndividualReport.zip";

            string[] files = Directory.GetFiles(Server.MapPath("/uploads"));
            using (var archive = ZipFile.Open(FolderPathToZip, ZipArchiveMode.Create))
            {
                foreach (var fPath in files)
                {
                    archive.CreateEntryFromFile(fPath, Path.GetFileName(fPath));
                }
            }

            return File(FolderPathToZip, "application/zip");
        }

        public void PdfSharpConvert(string html, string filepath)
        {
            try
            {
                StringReader sr = new StringReader(html.ToString());

                Document pdfDoc = new Document(iTextSharp.text.PageSize.A4, 10f, 10f, 10f, 0f);
                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
                    pdfDoc.Open();

                    htmlparser.Parse(sr);
                    pdfDoc.Close();

                    byte[] bytes = memoryStream.ToArray();
                    System.IO.File.WriteAllBytes(filepath, bytes);
                    memoryStream.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("PDF Generation Error");
            }
        }

        private string getFilePath(string targetFolder, PatientModel patientModel)
        {
            switch (Environment.OSVersion.Platform)
            {
                case PlatformID.Unix:
                    return targetFolder + "//" + patientModel.FirstName + " " + patientModel.LastName + ".pdf";

                default:
                    return targetFolder + "\\" + patientModel.FirstName + " " + patientModel.LastName + ".pdf";
            }
        }

        private string getFilePath(string targetFolder, string name)
        {
            switch (Environment.OSVersion.Platform)
            {
                case PlatformID.Unix:
                    return targetFolder + "//" + name + ".pdf";

                default:
                    return targetFolder + "\\" + name + ".pdf";
            }
        }

        [HttpGet]
        public FileResult DownloadCriticalReadingReport()
        {
            string FolderPathToZip = string.Empty;
            List<PatientReport> listobj = new List<PatientReport>();
            APIResponse apiResponse = new APIResponse();
            LoginModel usermodel = new LoginModel();
            usermodel = (LoginModel)Session["User"];
            userId = usermodel.ID;
            var client = new RestClient(String.Concat(_apiUrl, "api/Report/GetCriticalReadingReport?LoginUserId=" + userId));
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
                listobj = (List<PatientReport>)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(List<PatientReport>));

                if (listobj.Count > 0)
                {
                    string body = string.Empty;
                    body = string.Empty;
                    body = System.IO.File.ReadAllText(Server.MapPath("~/Template/CriticalPatientReport.html"));
                    if (userId == 1)
                    {
                        body = body.Replace("_ClinicName", string.Empty);
                    }
                    else
                    {
                        body = body.Replace("_ClinicName", listobj[0].ClinicName);
                    }
                    body = body.Replace("_CurrentDate", DateTime.Now.ToShortDateString());

                    if (listobj.Count > 0)
                    {
                        StringBuilder ccmreport = new StringBuilder();
                        ccmreport.Append(@"<table border='1' style='margin-top: 25px;'>
                                            <tr>
                                                <td width='30%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Patient Name</td>
                                                <td width='40%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Blood Pressure</td>
                                                <td width='30%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Created Date</td>
                                            </tr>");
                        if (listobj.Count > 1)
                        {
                            foreach (var item in listobj)
                            {
                                ccmreport.Append(@"<tr>
                                                <td width='30%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.PatientName + "</td>" +
                                                "<td width='40%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.BP + "</td>" +
                                                "<td width='30%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.CreationDateStr + "</td>" +
                                                "</tr>");
                            }
                        }
                        ccmreport.Append(@"</table>");

                        body = body.Replace("_CriticalPatientReport", ccmreport.ToString());

                        bool folder_exists = Directory.Exists(Server.MapPath("~/uploads"));
                        if (!folder_exists)
                            Directory.CreateDirectory(Server.MapPath("~/uploads"));
                        string targetFolder = Server.MapPath("~/uploads");
                        Array.ForEach(Directory.GetFiles(Server.MapPath("/uploads")), System.IO.File.Delete);
                        string filename = getFilePath(targetFolder, "CriticalPatientReport");
                        PdfSharpConvert(body, filename);
                    }
                }
            }

            if (Environment.OSVersion.Platform == PlatformID.Unix)
                FolderPathToZip = Server.MapPath("~/uploads") + "//CriticalPatientReport.zip";
            else
                FolderPathToZip = Server.MapPath("~/uploads") + "\\CriticalPatientReport.zip";

            string[] files = Directory.GetFiles(Server.MapPath("/uploads"));
            using (var archive = ZipFile.Open(FolderPathToZip, ZipArchiveMode.Create))
            {
                foreach (var fPath in files)
                {
                    archive.CreateEntryFromFile(fPath, Path.GetFileName(fPath));
                }
            }

            return File(FolderPathToZip, "application/zip");
        }

        [HttpGet]
        public FileResult DownloadCallLogReport(Int64 userID)
        {
            string FolderPathToZip = string.Empty;
            List<CallLogModel> callLogs = new List<CallLogModel>();
            APIResponse apiResponse = new APIResponse();

            var client = new RestClient(String.Concat(_apiUrl, "api/Report/GetCallLogReport?UserId=" + userID));
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
                callLogs = (List<CallLogModel>)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(List<CallLogModel>));

                if (callLogs.Count > 0)
                {
                    string body = string.Empty;
                    body = string.Empty;
                    body = System.IO.File.ReadAllText(Server.MapPath("~/Template/CallLogReport.html"));
                    if (userId == 1)
                    {
                        body = body.Replace("_ClinicName", string.Empty);
                    }
                    else
                    {
                        body = body.Replace("_ClinicName", callLogs[0].ClinicName);
                    }
                    body = body.Replace("_CurrentDate", DateTime.Now.ToShortDateString());


                    string totalDuration = string.Empty;
                    StringBuilder ccmreport = new StringBuilder();
                    ccmreport.Append(@"<table border='1' style='margin-top: 25px;'>
                                            <tr>
                                                <td width='25%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Patient Name</td>
                                                <td width='25%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Start Time</td>
                                                <td width='25%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>End Time</td>
                                                <td width='25%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Call Duration</td>
                                            </tr>");
                    if (callLogs.Count > 1)
                    {
                        foreach (var item in callLogs)
                        {
                            totalDuration = item.TotalCallDuration;
                            ccmreport.Append(@"<tr>
                                                 <td width='25%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.PatientName + "</td>" +
                                                "<td width='25%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.StartTime + "</td>" +
                                                "<td width='25%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.EndTime + "</td>" +
                                                "<td width='25%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.Duration + "</td>" +
                                                "</tr>"
                                            );
                        }
                    }

                    ccmreport.Append(@"<tr>
                                            <td width='25%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Total Duration</td>" +
                                           "<td width='50%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px; 'colspan='2'></td>" +
                                           "<td width='25%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;border-right:1px solid black;'>" + totalDuration + "</td>" +
                                           "</tr>");
                    ccmreport.Append(@"</table>");
                    body = body.Replace("_CallLogReport", ccmreport.ToString());

                    bool folder_exists = Directory.Exists(Server.MapPath("~/uploads"));
                    if (!folder_exists)
                        Directory.CreateDirectory(Server.MapPath("~/uploads"));
                    string targetFolder = Server.MapPath("~/uploads");
                    Array.ForEach(Directory.GetFiles(Server.MapPath("/uploads")), System.IO.File.Delete);
                    string filename = getFilePath(targetFolder, "CallLogReport");
                    PdfSharpConvert(body, filename);
                }

                if (Environment.OSVersion.Platform == PlatformID.Unix)
                    FolderPathToZip = Server.MapPath("~/uploads") + "//CallLogReport.zip";
                else
                    FolderPathToZip = Server.MapPath("~/uploads") + "\\CallLogReport.zip";

                string[] files = Directory.GetFiles(Server.MapPath("/uploads"));
                using (var archive = ZipFile.Open(FolderPathToZip, ZipArchiveMode.Create))
                {
                    foreach (var fPath in files)
                    {
                        archive.CreateEntryFromFile(fPath, Path.GetFileName(fPath));
                    }
                }
            }

            return File(FolderPathToZip, "application/zip");
        }

        [HttpPost]
        public JsonResult DeviceDeactive(string deviceId, string deviceName)
        {
            int i = -1;
            using (var httpclient = new HttpClient())
            {
                httpclient.BaseAddress = new Uri("https://api.tenovi.com/api/v1/logistics/activate-device/");
                var device = new Device() { DeviceId = deviceId, DeviceName = deviceName };
                var postTask = httpclient.PostAsJsonAsync<Device>("device", device);

                postTask.Wait();

                var result = postTask.Result;
                if (result.IsSuccessStatusCode)
                {
                    APIResponse apiResponse = new APIResponse();
                    var client = new RestClient(String.Concat(_apiUrl, "api/RPMDashboard/SetDeviceStatus?deviceId=" + deviceId + "&deviceName=" + deviceName + "&isActive=" + false));
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
                        i = (int)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(int));
                    }
                }
            }

            return Json(i, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult DeviceActive(string deviceId, string deviceName)
        {
            int i = -1;
            using (var httpclient = new HttpClient())
            {
                httpclient.BaseAddress = new Uri("https://api.tenovi.com/api/v1/logistics/deactivate-device/");
                var device = new Device() { DeviceId = deviceId, DeviceName = deviceName };
                var postTask = httpclient.PostAsJsonAsync<Device>("device", device);
                postTask.Wait();

                var result = postTask.Result;
                if (result.IsSuccessStatusCode)
                {
                    APIResponse apiResponse = new APIResponse();
                    var client = new RestClient(String.Concat(_apiUrl, "api/RPMDashboard/SetDeviceStatus?deviceId=" + deviceId + "&deviceName=" + deviceName + "&isActive=" + false));
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
                        i = (int)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(int));
                    }
                }
            }

            return Json(i, JsonRequestBehavior.AllowGet);
        }
    }
}
