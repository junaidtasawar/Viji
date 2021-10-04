using ClinicBO;
using ClinicBO.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace Clinic_WebAPI.Controllers
{

    public class CCMController : ApiController
    {

        [HttpGet]
        [Route("api/CCMNote/GetCCMNoteByPatientID")]
        [JwtAuthentication]
        public APIResponse GetCCMNoteByPatientID(int? page, int? limit, Int64 patientId)
        {
            CCMNoteModel model = new CCMNoteModel();
            APIResponse response = new APIResponse();
            try
            {
                List<CCMNoteModel> listobj = new List<CCMNoteModel>();
                listobj = model.GetCCMNoteByPatientID(page, limit, patientId);
                if (listobj.Count > 0)
                {
                    response.IsError = false;
                    response.Data = listobj;
                    response.ErrorMessage = string.Empty;
                }
                else
                {
                    response.IsError = true;
                    response.Data = null;
                    response.ErrorMessage = "No data found.";
                }
            }
            catch (Exception ex)
            {
                response.IsError = true;
                response.Data = null;
                response.ErrorMessage = ex.Message.ToString();
            }
            return response;
        }

        [HttpPost]
        [Route("api/CCMNote/SaveCCMNoteDetails")]
        [JwtAuthentication]
        public APIResponse SaveCCMNoteDetails(CCMNoteModel obj)
        {
            Int64 CCMNoteID = -1;
            APIResponse response = new APIResponse();
            try
            {
                CCMNoteID = obj.SaveCCMNoteDetails(obj);
                if (CCMNoteID > 0)
                {
                    response.IsError = false;
                    response.Data = CCMNoteID;
                    response.ErrorMessage = string.Empty;
                }
                else
                {
                    response.IsError = true;
                    response.Data = null;
                    response.ErrorMessage = "No data found.";
                }
            }
            catch (Exception ex)
            {
                response.IsError = true;
                response.Data = null;
                response.ErrorMessage = ex.Message.ToString();
            }
            return response;
        }

        [HttpGet]
        [Route("api/CCMNote/GetCCMNoteByID")]
        [JwtAuthentication]
        public APIResponse GetCCMNoteByID(Int64 CCMNoteId, Int64 patientId)
        {
            CCMNoteModel model = new CCMNoteModel();
            APIResponse response = new APIResponse();
            try
            {
                model = model.GetCCMNoteByID(CCMNoteId, patientId);
                if (model != null)
                {
                    response.IsError = false;
                    response.Data = model;
                    response.ErrorMessage = string.Empty;
                }
                else
                {
                    response.IsError = true;
                    response.Data = null;
                    response.ErrorMessage = "No data found.";
                }
            }
            catch (Exception ex)
            {
                response.IsError = true;
                response.Data = null;
                response.ErrorMessage = ex.Message.ToString();
            }
            return response;
        }

        [HttpPost]
        [Route("api/CCM/GetCallLogs")]
        [JwtAuthentication]
        public APIResponse GetCallLogs(CallLogModel cl)
        {
            CCMModel cm = new CCMModel();

            Int64 CCMID = -1;
            APIResponse response = new APIResponse();
            try
            {

                CCMID = cm.SaveCallLogs(cl.PatientId, cl.StartTime, cl.EndTime, cl.Duration);

                if (CCMID > 0)
                {
                    response.IsError = false;
                    response.Data = CCMID;
                    response.ErrorMessage = string.Empty;
                }
                else
                {
                    response.IsError = true;
                    response.Data = null;
                    response.ErrorMessage = "No data found.";
                }
            }
            catch (Exception ex)
            {
                response.IsError = true;
                response.Data = null;
                response.ErrorMessage = ex.Message.ToString();
            }
            return response;
        }
    }
}
