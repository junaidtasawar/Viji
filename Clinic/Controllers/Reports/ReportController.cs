using Clinic.Controllers.Utility;
using Clinic.Models.PatientModel;
using Clinic.Models.ReportModel;
using ClinicBO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web.Mvc;


namespace Clinic.Controllers.Reports
{
    public class ReportController : Controller
    {
        // GET: Report
        public ActionResult PatientReport()
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

        public JsonResult GetPatientList(int? page, int? limit, string sortBy, string direction, string searchString = null, string FromDate = null, string ToDate = null, string CCMTimeSpan = null, bool IsBillable = false)
        {
            try
            {
                ReportModel model = new ReportModel();
                model.CurrentPage = page != null ? page.Value : 1;
                model.NumberOfRecords = limit != null ? limit.Value : 10;
                model.SearchString = searchString == null ? "" : searchString;
                model.FromDate = (FromDate != "") ? Convert.ToDateTime(FromDate) : (DateTime?)null;
                model.ToDate = (ToDate != "") ? Convert.ToDateTime(ToDate) : (DateTime?)null;
                model.CCMTimeSpan = (CCMTimeSpan == "") ? 0 : Convert.ToInt32(CCMTimeSpan);
                model.IsBillable = IsBillable;
                var records = model.GetPatientReportForList_SP();//new GridModel().GetPlayers(page, limit, sortBy, direction, searchString, out total);
                int total = records.Count > 0 ? records.FirstOrDefault().TotalCount : 0;

                return Json(new { records, total }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
            }
            return Json(null, JsonRequestBehavior.AllowGet);
        }

        public void PdfSharpConvert(string html, string filepath)
        {
            //Byte[] res = null;
            //using (MemoryStream ms = new MemoryStream())
            //{
            //    var pdf = TheArtOfDev.HtmlRenderer.PdfSharp.PdfGenerator.GeneratePdf(html, PdfSharp.PageSize.A4);
            //    pdf.Save(ms);
            //    res = ms.ToArray();
            //}
            //
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
            catch(Exception ex)
            {
                Console.WriteLine("PDF Generation Error");
            }
        }

        public FileResult GenerateIndividualCCMReport(string PatientID = null, string FromDate = null, string ToDate = null, string CCMTimeSpan = null, bool IsBillable = false)
        {
            PatientModel patientModel = new PatientModel();
            patientModel.PatientID = Convert.ToInt64(PatientID);
            patientModel = patientModel.GetPatientDetailsByPatientID();
            if (patientModel.ClinicName != null)
            {
                string body = string.Empty;
                body = string.Empty;
                body = System.IO.File.ReadAllText(Server.MapPath("~/Template/CCMNote.html"));
                body = body.Replace("_ClinicName", patientModel.ClinicName);
                body = body.Replace("_PatientName", patientModel.FirstName + " " + patientModel.LastName + "," + patientModel.CellNumber);
                body = body.Replace("_CurrentDate", DateTime.Now.ToShortDateString());
                body = body.Replace("_DOB", patientModel.DOBStr);
                body = body.Replace("_MRNNumber", patientModel.MRNNumber);
                body = body.Replace("_Address", patientModel.Address);
                body = body.Replace("_ContactNo", patientModel.CellNumber);

                patientModel.CCMModelList = patientModel.getCCMNoteByPatinetID(patientModel.PatientID, FromDate, ToDate, IsBillable);
                if (patientModel.CCMModelList.Count > 0)
                {
                    StringBuilder ccmreport = new StringBuilder();
                    ccmreport.Append(@"<table border='1'>
                                            <tr>
                                                <td style='border:1px solid black;font-size: 10px;padding:5px;' colspan='4'>CCM Canned Notes</td>
                                            </tr>
                                            <tr>
                                                <td width='10%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Time</td>
                                                <td width='50%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Notes</td>
                                                <td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Posted By</td>
                                                <td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;border-right:1px solid black;'>Minutes</td>
                                            </tr>");
                    foreach (var item in patientModel.CCMModelList)
                    {
                        ccmreport.Append(@"<tr>
                                             <td width='10%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.CCMDate.ToShortDateString() + "</td>" +
                                                "<td width='50%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.Description + "</td>" +
                                                "<td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.CreatedByName + "</td>" +
                                                "<td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;font-size: 10px;'>" + item.Timespent + "</td>" +
                                          "</tr>");
                    }
                    ccmreport.Append(@"<tr>
                                        <td width='10%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;' colspan='2'></td>
                                        <td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Total Minutes:</td>
                                        <td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;font-size: 10px;'>" + patientModel.CCMModelList[0].TotalMinute + "</td>" +
                                       "</tr>" +
                                        "<tr>" +
                                            "<td width='10%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;' colspan='2'></td>" +
                                            "<td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Billable Minutes</td>" +
                                            "<td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;border-right:1px solid black;'>" + patientModel.CCMModelList[0].TotalMinute + "</td>" +
                                        "</tr></table>");

                    body = body.Replace("_CCMNoteReport", ccmreport.ToString());

                    bool folder_exists = Directory.Exists(Server.MapPath("~/uploads"));
                    if (!folder_exists)
                        Directory.CreateDirectory(Server.MapPath("~/uploads"));
                    string targetFolder = Server.MapPath("~/uploads");
                    Array.ForEach(Directory.GetFiles(Server.MapPath("/uploads")), System.IO.File.Delete);
                    string filename = getFilePath(targetFolder, patientModel);// targetFolder + "//" + patientModel.FirstName + " " + patientModel.LastName + ".pdf";
                    PdfSharpConvert(body, filename);
                }
            }
            string FolderPathToZip = string.Empty;
            if (Environment.OSVersion.Platform == PlatformID.Unix)
                FolderPathToZip = Server.MapPath("~/uploads") + "//CCMIndividualReport.zip";
            else
                FolderPathToZip = Server.MapPath("~/uploads") + "\\CCMIndividualReport.zip";
            
            try
            {
                string[] files = Directory.GetFiles(Server.MapPath("/uploads"));
                using (var archive = ZipFile.Open(FolderPathToZip, ZipArchiveMode.Create))
                {
                    foreach (var fPath in files)
                    {
                        archive.CreateEntryFromFile(fPath, Path.GetFileName(fPath));
                    }
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine("Unable to zip");
            }
            
            return File(FolderPathToZip, "application/zip");
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

        public ActionResult DownloadBillableReport(int? page, int? limit, string FromDate = null, string ToDate = null, bool IsBillable = false)
        {
            ReportModel model = new ReportModel();
            model.CurrentPage = page != null ? page.Value : 1;
            model.NumberOfRecords = limit != null ? limit.Value : 10;
            model.FromDate = Convert.ToDateTime(DateTime.ParseExact(FromDate, "mm/dd/yy", CultureInfo.InvariantCulture));
            model.ToDate = Convert.ToDateTime(DateTime.ParseExact(ToDate, "mm/dd/yy", CultureInfo.InvariantCulture));
            model.IsBillable = IsBillable;
            
            List<ReportModel> listReportModel = new List<ReportModel>();
            listReportModel = model.GetPatientBillableReport();
            string body = string.Empty;
            body = string.Empty;
            body = System.IO.File.ReadAllText(Server.MapPath("~/Report/BillingReportIndividual.html"));
            if (listReportModel.Count > 0)
            {
                StringBuilder billingrpt = new StringBuilder();
                billingrpt.Append(@"<table border='1'>
                                            <tr>
                                                <td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Patient Name</td>
                                                <td width='10%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>MRN</td>
                                                <td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>Monthly Billable Time</td>
                                                <td width='50%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;border-right:1px solid black;'>Problems</td>
                                            </tr>");
                foreach (var item in listReportModel)
                {
                    billingrpt.Append(@"<tr>
                                             <td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.PatientName + "</td>" +
                                            "<td width='10%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.MRNNumber + "</td>" +
                                            "<td width='20%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;font-size: 10px;'>" + item.TotalMinute + "</td>" +
                                            "<td width='50%' style='padding:5px;border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;font-size: 10px;'>" + item.Diagnosis + "</td>" +
                                      "</tr>");
                }
                billingrpt.Append(@"</table>");

                body = body.Replace("_BillingIndividualReport", billingrpt.ToString());
                bool folder_exists = Directory.Exists(Server.MapPath("~/BillingReport"));
                if (!folder_exists)
                    Directory.CreateDirectory(Server.MapPath("~/BillingReport"));
                Array.ForEach(Directory.GetFiles(Server.MapPath("/BillingReport")), System.IO.File.Delete);
                string filename = string.Empty;
                if (Environment.OSVersion.Platform == PlatformID.Unix)
                    filename = Server.MapPath("~/BillingReport") + "//" + "BillingReportIndividual.pdf";
                else
                    filename = Server.MapPath("~/BillingReport") + "\\" + "BillingReportIndividual.pdf";

                PdfSharpConvert(body, filename);
            }
            else
            {
                string filename = string.Empty;
                if (Environment.OSVersion.Platform == PlatformID.Unix)
                    filename = Server.MapPath("~/BillingReport") + "//" + "BillingReportIndividual.pdf";
                else
                    filename = Server.MapPath("~/BillingReport") + "\\" + "BillingReportIndividual.pdf";
                if (System.IO.File.Exists(filename))
                {
                    System.IO.File.Delete(filename);
                }
            }

            string FolderPathToZip = string.Empty;
            if (Environment.OSVersion.Platform == PlatformID.Unix)
                FolderPathToZip = Server.MapPath("~/BillingReport") + "//BillingReport.zip";
            else
                FolderPathToZip = Server.MapPath("~/BillingReport") + "\\BillingReport.zip";
            string[] files = Directory.GetFiles(Server.MapPath("/BillingReport"));
            using (var archive = ZipFile.Open(FolderPathToZip, ZipArchiveMode.Create))
            {
                foreach (var fPath in files)
                {
                    archive.CreateEntryFromFile(fPath, Path.GetFileName(fPath));
                }
            }

            return File(FolderPathToZip, "application/zip");
        }
    }
}
