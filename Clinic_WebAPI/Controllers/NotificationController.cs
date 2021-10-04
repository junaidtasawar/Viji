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
    //[Authorize]
    public class NotificationController : ApiController
    {
        NotificationModel nm = new NotificationModel();



        [HttpGet]
        [Route("api/Notification/GetNotification")]
        [JwtAuthentication]

        public APIResponse GetNotification(DateTime Afterdate)
        {
            List<NotificationModel> listobj = new List<NotificationModel>();
            APIResponse response = new APIResponse();
            try
            {
                listobj = nm.GetData(Afterdate);
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
      
    }
}
