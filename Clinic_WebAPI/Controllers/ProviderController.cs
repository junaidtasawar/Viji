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
    public class ProviderController : ApiController
    {
        DoctorModel dm = new DoctorModel();


        [HttpGet]
        [Route("api/Provider/ProviderMasterById")]
        [JwtAuthentication]

        public APIResponse ProviderMasterById(string doctorid)
        {
            DoctorModel obj = new DoctorModel();
            APIResponse response = new APIResponse();
            try
            {
                obj = dm.GetDoctorDetailsByDoctorID(doctorid);
                if (obj.DoctorID > 0)
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

        [HttpGet]
        [Route("api/Provider/GetDoctorList")]
        [JwtAuthentication]

        public APIResponse GetDoctorList(int? page, int? limit, string Orderby)
        {
            Orderby = " ";
            List<DoctorModel> listobj = new List<DoctorModel>();
            APIResponse response = new APIResponse();
            try
            {
                listobj = dm.GetDoctorData_ForList(page, limit, Orderby);
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
        [Route("api/Provider/SaveDoctorDetails")]
        [JwtAuthentication]

        public APIResponse SaveDoctorDetails(DoctorModel obj)
        {
            Int64 DoctorID = -1;
            APIResponse response = new APIResponse();
            try
            {
                DoctorID =dm.SaveDoctorDetails(obj);
                if (DoctorID > 0)
                {
                    response.IsError = false;
                    response.Data = DoctorID;
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
