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
    [JwtAuthentication]
    public class UserController : ApiController
    {
        UserModel um = new UserModel();


        [HttpGet]
        [Route("api/User/GetUserDetailsById")]
        [JwtAuthentication]

        public APIResponse GetUserDetailsById(string userid)
        {
            UserModel obj = new UserModel();
            APIResponse response = new APIResponse();
            try
            {
                obj = um.GetUserDetailsByUserID(userid);
                if (obj.UserID > 0)
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
        [Route("api/User/GetUserList")]
        [JwtAuthentication]

        public APIResponse GetUserList(int? page, int? limit, long loginUserID, string Orderby)
        {
            Orderby = " ";

            List<UserModel> listobj = new List<UserModel>();
            APIResponse response = new APIResponse();
            try
            {
                listobj = um.GetUserData_ForList(page, limit, loginUserID, Orderby);
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
        [Route("api/User/SaveUserDetails")]
        [JwtAuthentication]

        public APIResponse SaveUserDetails(UserModel obj)
        {
            Int64 UserID = -1;
            APIResponse response = new APIResponse();
            try
            {
                UserID = um.SaveUserDetails(obj);
                if (UserID > 0)
                {
                    response.IsError = false;
                    response.Data = UserID;
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
