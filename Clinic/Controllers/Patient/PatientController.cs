using Clinic.Controllers.Utility;
using Clinic.Models;
using Clinic.Models.LoginModel;
using Clinic.Models.PatientModel;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace Clinic.Controllers.Patient
{
    public class PatientController : Controller
    {
        //public ActionResult Index()
        //{
        //    if (Session["User"] != null)
        //    {
        //        try
        //        {
        //            return View();
        //        }
        //        catch (Exception ex)
        //        {
        //            UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
        //        }
        //    }
        //    return Redirect("/Authentication/Login");
        //}

        public ActionResult Index(string ClinicName)
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

        public string SavePatientDetails(PatientModel model)
        {
            Int64 RecordID = 0;
            if (Session["User"] != null)
            {
                LoginModel usermodel = new LoginModel();
                usermodel = (LoginModel)Session["User"];
                model.CreatedBy = usermodel.ID;
                model.IsActive = true;
                if (model.ClinicName != null)
                {
                    model.ClinicName.TrimEnd(model.ClinicName[model.ClinicName.Length - 1]);
                    string cName = model.ClinicName.TrimEnd();
                    bool res = cName.Contains(",");
                    if (res)
                        model.ClinicName = cName.Remove(cName.Length - 1, 1);
                    else
                        model.ClinicName = cName;
                }

                if (model.DoctorsName != null)
                {
                    string doctor = model.DoctorsName.TrimEnd();
                    bool res1 = doctor.Contains(",");
                    if (res1)
                        model.DoctorsName = doctor.Remove(doctor.Length - 1, 1);
                    else
                        model.DoctorsName = doctor;
                }

                RecordID = model.SavePatientDetails();
            }
            return "";
        }

        public ActionResult MedicationView()
        {
            if (Session["User"] != null)
            {
                try
                {
                    return PartialView("MedicationView");
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public ActionResult VitalView()
        {
            if (Session["User"] != null)
            {
                try
                {
                    return PartialView("VitalView");
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public ActionResult AllergyView(string PatientID)
        {
            if (Session["User"] != null)
            {
                try
                {
                    AllergyModel model = new AllergyModel();
                    model.PatientID = Convert.ToInt64(PatientID);
                    model = model.GetAllergyDetailsByPatientID_SP();
                    return PartialView("AllergyView", model);
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public ActionResult DiagnosisView()
        {
            if (Session["User"] != null)
            {
                try
                {
                    return PartialView("DiagnosisView");
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public ActionResult PatientMaster(string PatientID, string ClinicName)
        {
            if (Session["User"] != null)
            {
                PatientModel model = new PatientModel();

                try
                {
                    if (PatientID != null)
                    {
                        model.ClinicName = ClinicName;
                        model.PatientID = Convert.ToInt64(PatientID);
                        model = model.GetPatientDetailsByPatientID();
                        return View(model);
                    }
                    if (ClinicName != null)
                    {
                        model.ClinicName = ClinicName;
                    }
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
                return View(model);
            }
            return Redirect("/Authentication/Login");
        }

        public ActionResult PatientReport(string PatientID)
        {
            if (Session["User"] != null)
            {
                PatientModel model = new PatientModel();

                try
                {
                    if (PatientID != null)
                    {
                        model.PatientID = Convert.ToInt64(PatientID);
                        model = model.GetPatientDetailsByPatientID();
                        return View(model);
                    }
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
                return View(model);
            }
            return Redirect("/Authentication/Login");
        }

        public ActionResult AddVitalForm(string VitalID)
        {
            if (Session["User"] != null)
            {
                try
                {
                    if (VitalID != null)
                    {
                        PatientModel patinetModel = new PatientModel();
                        VitalModel model = new VitalModel();
                        model.VitalID = Convert.ToInt64(VitalID);
                        patinetModel.vitalModel = model.GetVitalDetailsByVitalID();
                        return PartialView("AddVitalForm", patinetModel);
                    }
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return PartialView("AddVitalForm");
        }

        [HttpPost]
        public Int64 SaveMedicationDetails(MedicationModel model)/*string PatientId, string Medication, string RxNorms, string Diagnosis, string RefillAllowed, string Quantity, string StartDateStr, string EndDateStr, string OrderGeneratedBy, string Provider, string Status, string Comments, string MedicationID*/
        {

            Int64 RecordID = 0;
            RecordID = model.SaveMedicationDetails();
            return RecordID;
        }

        public ActionResult AddMedicationForm(string MedicationID)
        {
            if (Session["User"] != null)
            {
                try
                {
                    if (MedicationID != null)
                    {
                        PatientModel model = new PatientModel();
                        MedicationModel medicationModel = new MedicationModel();
                        medicationModel.MedicationID = Convert.ToInt64(MedicationID);
                        model.medicationModel = medicationModel.GetMedicationDetailsByMedicationID();
                        return PartialView("AddMedicationForm", model);
                    }
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return PartialView("AddMedicationForm");
        }

        public ActionResult AddDiagnosisForm(string DiagnosisID)
        {
            if (Session["User"] != null)
            {
                try
                {
                    if (DiagnosisID != null)
                    {
                        PatientModel patientModel = new PatientModel();
                        DiagnosisModel model = new DiagnosisModel();
                        model.DiagnosisID = Convert.ToInt64(DiagnosisID);
                        patientModel.diagnosisModel = model.GetDiagnosisDetailsByDiagnosisID();
                        return PartialView("AddDiagnosisForm", patientModel);
                    }
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return PartialView("AddDiagnosisForm");
        }

        public ActionResult AddAllergyForm(string AllergyID)
        {
            if (Session["User"] != null)
            {
                try
                {
                    if (AllergyID != null)
                    {
                        PatientModel model = new PatientModel();
                        AllergyModel allergyModel = new AllergyModel();
                        allergyModel.AllergyID = Convert.ToInt64(AllergyID);
                        model.allergyModel = allergyModel.GetAllergyDetailsByPatientID_SP();
                        return PartialView("AddAllergyForm", model);
                    }
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return PartialView("AddAllergyForm");
        }

        public ActionResult PatientIndividualProfile(Int64 PatientID)
        {
            if (Session["User"] != null)
            {
                try
                {
                    PatientModel model = new PatientModel();
                    model.PatientID = PatientID;

                    model = model.GetPatientDataByPatientId();
                    return View(model);
                }
                catch (Exception ex)
                {
                    UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
                }
            }
            return Redirect("/Authentication/Login");
        }

        public Int64 SaveDiagnosisDetails(DiagnosisModel model)
        {
            Int64 RecordID = 0;
            RecordID = model.SaveDiagnosisDetails();
            return RecordID;
        }

        public string UpdatePatientStatus(string PatientId, string StatusName)
        {
            PatientModel model = new PatientModel();
            model.UpdatePatientStatus(Convert.ToInt64(PatientId), StatusName);
            return "";
        }

        public string SaveVitalDetails(VitalModel model)
        {
            Int64 RecordID = model.SaveVitalDetails();
            return "";
        }

        [HttpPost]
        public Int64 SaveAllergyDetails(AllergyModel model)
        {
            Int64 RecordID = model.SaveAllergyDetails();
            return RecordID;
        }

        public ActionResult PatientPreferenceForm(string PatientPreferenceID)
        {
            return PartialView("PatientPreferenceForm");
        }

        [HttpPost]
        public Int64 SavePatientPreference(PatientPreferenceModel model)
        {
            Int64 RecordID = model.SavePatientPreferenceDetails();
            return RecordID;
        }

        public void DownloadExcelFile()
        {
            PatientModel model = new PatientModel();
            List<PatientModel> viewModel = new List<PatientModel>();
            LoginModel usermodel = new LoginModel();
            usermodel = (LoginModel)Session["User"];
            model.LoginUserID = usermodel.ID;

            viewModel = model.GetRPMBillingReport();

            ExcelPackage Ep = new ExcelPackage();
            ExcelWorksheet Sheet = Ep.Workbook.Worksheets.Add("MarksheetExcel");
            Sheet.Cells["A1"].Value = "PatientID";
            Sheet.Cells["B1"].Value = "LastName";
            Sheet.Cells["C1"].Value = "FirstName";
            Sheet.Cells["D1"].Value = "Concatenated name";
            Sheet.Cells["E1"].Value = "Medicaid or Medicare";
            Sheet.Cells["F1"].Value = "Medicare/Medicaid number";
            Sheet.Cells["G1"].Value = "Gender";
            Sheet.Cells["H1"].Value = "DOB";
            Sheet.Cells["I1"].Value = "Age";
            Sheet.Cells["J1"].Value = "Name";
            Sheet.Cells["K1"].Value = "Practice";
            Sheet.Cells["L1"].Value = "RPM Interaction Time";
            Sheet.Cells["M1"].Value = "Total Days of Readings";
            Sheet.Cells["N1"].Value = "Device";
            Sheet.Cells["O1"].Value = "99453 Date of Service";
            Sheet.Cells["P1"].Value = "Diagnosis Code";
            Sheet.Cells["Q1"].Value = "99454 Billable";
            Sheet.Cells["R1"].Value = "99457 Billable";
            Sheet.Cells["S1"].Value = "99458 Billable";
            Sheet.Cells["T1"].Value = "99459 Billable";

            int row = 2;
            foreach (var item in viewModel)
            {
                Sheet.Cells[string.Format("A{0}", row)].Value = item.PatientID;
                Sheet.Cells[string.Format("B{0}", row)].Value = item.LastName;
                Sheet.Cells[string.Format("C{0}", row)].Value = item.FirstName;
                Sheet.Cells[string.Format("D{0}", row)].Value = item.FullName;
                Sheet.Cells[string.Format("E{0}", row)].Value = item.Medicareid;
                Sheet.Cells[string.Format("F{0}", row)].Value = item.MedicareNumber;
                Sheet.Cells[string.Format("G{0}", row)].Value = item.GenderStr;
                Sheet.Cells[string.Format("H{0}", row)].Value = item.DOBStr;
                Sheet.Cells[string.Format("I{0}", row)].Value = item.Age;
                Sheet.Cells[string.Format("J{0}", row)].Value = item.DoctorsName;
                Sheet.Cells[string.Format("K{0}", row)].Value = item.Practice;
                Sheet.Cells[string.Format("L{0}", row)].Value = item.RPMInteractionTime;
                Sheet.Cells[string.Format("M{0}", row)].Value = item.TotalDaysReadings;
                Sheet.Cells[string.Format("N{0}", row)].Value = item.DeviceID;
                Sheet.Cells[string.Format("O{0}", row)].Value = item.DeviceReceivedDateStr;
                Sheet.Cells[string.Format("P{0}", row)].Value = item.DiagnosisCode;
                Sheet.Cells[string.Format("Q{0}", row)].Value = item.Billable454;
                Sheet.Cells[string.Format("R{0}", row)].Value = item.Billable457;
                Sheet.Cells[string.Format("S{0}", row)].Value = item.Billable458;
                Sheet.Cells[string.Format("T{0}", row)].Value = item.Billable459;
                row++;
            }
            Sheet.Cells["A:AZ"].AutoFitColumns();
            Response.Clear();
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment: filename=" + $"MarksheetExcel_{DateTime.Now.Ticks.ToString()}.xlsx");
            Response.BinaryWrite(Ep.GetAsByteArray());
            Response.End();
        }

       
        public JsonResult GetAllPatientDetails_ForList(int? page, int? limit, string sortBy, string direction, string searchString = null, string clinicName = null, string FirstName = null, string LastName = null)
        {
            try
            {
                PatientModel model = new PatientModel();
                LoginModel usermodel = new LoginModel();
                usermodel = (LoginModel)Session["User"];
                model.ClinicName = clinicName;
                model.FirstName = FirstName;
                model.LastName = LastName;
                model.LoginUserID = usermodel.ID;
                model.CurrentPage = 1;
                model.NumberOfRecords = 10;
                model.OrderBy = string.Format("{0} {1}", sortBy, direction);
                var records = model.GetPatientData_ForList();
                int total = records.Count > 0 ? records.FirstOrDefault().TotalCount : 0;

                return Json(new { records, total }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetAllAllergiesDetails_ForList(int? page, int? limit, string sortBy, string direction, string searchString = null, string patientID = null)
        {
            try
            {
                PatientModel model = new PatientModel();
                LoginModel usermodel = new LoginModel();
                AllergyModel allergyModel = new AllergyModel();
                usermodel = (LoginModel)Session["User"];
                allergyModel.LoginUserID = usermodel.ID;
                allergyModel.PatientID = Convert.ToInt64(patientID);
                allergyModel.CurrentPage = page.Value;
                allergyModel.NumberOfRecords = limit.Value;
                allergyModel.OrderBy = string.Format("{0} {1}", sortBy, direction);
                allergyModel.PatientID = Convert.ToInt64(patientID);
                model.listAllergyModel = allergyModel.GetAllergiesData_ForList();
                var records = model.listAllergyModel;
                int total = records.Count > 0 ? records.FirstOrDefault().TotalCount : 0;

                return Json(new { records, total }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetAllMedicationDetails_ForList(int? page, int? limit, string sortBy, string direction, string searchString = null, string patientID = null)
        {
            try
            {
                MedicationModel model = new MedicationModel();
                model.CurrentPage = page.Value;
                model.NumberOfRecords = limit.Value;
                model.OrderBy = string.Format("{0} {1}", sortBy, direction);
                model.PatientID = Convert.ToInt64(patientID);
                var records = model.GetMedicationData_ForList();
                int total = records.Count > 0 ? records.FirstOrDefault().TotalCount : 0;

                return Json(new { records, total }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetAllDiagnosisDetails_ForList(int? page, int? limit, string sortBy, string direction, string searchString = null, string patientID = null)
        {
            try
            {
                PatientModel model = new PatientModel();
                DiagnosisModel diagnosisModel = new DiagnosisModel();
                diagnosisModel.CurrentPage = page.Value;
                diagnosisModel.NumberOfRecords = limit.Value;
                diagnosisModel.OrderBy = string.Format("{0} {1}", sortBy, direction);
                diagnosisModel.PatientID = Convert.ToInt64(patientID);
                model.listDiagnosisModel = diagnosisModel.GetDiagnosisData_ForList();
                var records = model.listDiagnosisModel;
                int total = records.Count > 0 ? records.FirstOrDefault().TotalCount : 0;

                return Json(new { records, total }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetAllVitalDetails_ForList(int? page, int? limit, string sortBy, string direction, string searchString = null, string patientID = null)
        {
            try
            {
                VitalModel model = new VitalModel();
                PatientModel patinetModel = new PatientModel();
                model.CurrentPage = page.Value;
                model.NumberOfRecords = limit.Value;
                model.OrderBy = string.Format("{0} {1}", sortBy, direction);
                model.PatientID = Convert.ToInt64(patientID);
                patinetModel.listVitalModel = model.GetVitalData_ForList();
                var records = patinetModel.listVitalModel;
                int total = records.Count > 0 ? records.FirstOrDefault().TotalCount : 0;

                return Json(new { records, total }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }
    }
}