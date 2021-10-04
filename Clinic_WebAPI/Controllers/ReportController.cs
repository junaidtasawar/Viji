using ClinicBO;
using ClinicBO.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Clinic_WebAPI.Controllers
{
    public class ReportController : ApiController
    {
        [HttpGet]
        [Route("api/Report/GetSingleReadingReport")]
        [JwtAuthentication]

        public APIResponse GetSingleReadingReport(Int64 PatientId)
        {
            PatientReport model = new PatientReport();
            APIResponse response = new APIResponse();
            try
            {
                List<PatientReport> listobj = new List<PatientReport>();
                listobj = model.GetSingleReadingReport(PatientId);
                if (listobj.Count > -1)
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

        [HttpGet]
        [Route("api/Report/GetCriticalReadingReport")]
        [JwtAuthentication]

        public APIResponse GetCriticalReadingReport(Int64 LoginUserId)
        {
            PatientReport model = new PatientReport();
            APIResponse response = new APIResponse();
            try
            {
                List<PatientReport> listobj = new List<PatientReport>();
                listobj = model.GetCriticalReadingReport(LoginUserId);
                if (listobj.Count > -1)
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

        [HttpGet]
        [Route("api/Report/GetCallLogReport")]
        [JwtAuthentication]

        public APIResponse GetCallLogReport(Int64 userId)
        {
            CallLogModel calllog = new CallLogModel();
            APIResponse response = new APIResponse();
            try
            {
                List<CallLogModel> calllogs = new List<CallLogModel>();
                calllogs = calllog.GetCallLogReport(userId);
                if (calllogs.Count > -1)
                {
                    response.IsError = false;
                    response.Data = calllogs;
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
