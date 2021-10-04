using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Http;
using System.Web.Http;
using ClinicBO;
using System.Data;
using ClinicBO.Filters;

namespace Clinic_WebAPI.Controllers
{

    public class ClinicController : ApiController
    {
        ClinicModel clinic = new ClinicModel();

        [HttpGet]
        [Route("api/Clinic/GetAllClinic")]
        [JwtAuthentication]

        public APIResponse GetClinic(long LoginUserID)
        {
            DataTable dt = new DataTable();
            APIResponse response = new APIResponse();
            try
            {
                dt = clinic.Get(LoginUserID);
                if (dt.Rows.Count > 0)
                {
                    response.IsError = false;
                    response.Data = dt;
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
        [Route("api/Clinic/GetClinicList")]
        [JwtAuthentication]

        public APIResponse GetClinicList(int? page, int? limit, long loginUserID)
        {
            List<ClinicModel> listobj = new List<ClinicModel>();
            APIResponse response = new APIResponse();
            try
            {
                listobj = clinic.GetClinicData_ForList(page,limit,loginUserID);
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

        [HttpGet]
        [Route("api/Clinic/GetClinicDetailsById")]
        [JwtAuthentication]

        public APIResponse GetClinicDetailsById(string clinicId)
        {
            ClinicModel obj = new ClinicModel();
            APIResponse response = new APIResponse();
            try
            {
                obj = clinic.GetClinicDetailsByClinicID(clinicId);
                if (obj.ClinicID > 0)
                {
                    response.IsError = false;
                    response.Data = obj;
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
        [Route("api/Clinic/SaveClinicDetails")]
        [JwtAuthentication]

        public APIResponse SaveClinicDetails(ClinicModel obj)
        {
            Int64 ClinicID = -1;
            APIResponse response = new APIResponse();
            try
            {
                ClinicID = clinic.SaveClinicDetails(obj);
                if (ClinicID > 0)
                {
                    response.IsError = false;
                    response.Data = ClinicID;
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
