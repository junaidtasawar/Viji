using ClinicBO;
using ClinicBO.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace Clinic_WebAPI.Controllers
{
    public class RPMDashboardController : ApiController
    {
        [HttpPost]
        [Route("api/RPMDashboard/GetRPMReportDetails")]
        [JwtAuthentication]
        public APIResponse GetRPMDashboardDetails(RPMDashboard rpmDashboard)
        {
            List<RPMDashboard> listobj = new List<RPMDashboard>();

            APIResponse response = new APIResponse();
            try
            {
                listobj = rpmDashboard.GetRPMReportData_ForList(rpmDashboard);
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
        [Route("api/RPMDashboard/SetDeviceStatus")]
        [JwtAuthentication]
        public APIResponse SetDeviceStatus(string deviceId, string deviceName,bool isActive)
        {
            APIResponse response = new APIResponse();
            try
            {
                RPMDashboard rpmDashboard = new RPMDashboard();
                int isSet = rpmDashboard.SetDeviceStatus(deviceId, deviceName, isActive);
                if (isSet==1)
                {
                    response.IsError = false;
                    response.Data = isSet;
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