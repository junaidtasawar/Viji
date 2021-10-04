using Clinic.Controllers.Utility;
using Clinic.Models.LoginModel;
using ClinicBO;
using ClinicBO.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Clinic;

namespace Clinic_WebAPI.Controllers
{
    [AllowAnonymous]
    public class TokenController : ApiController
    {

        [AllowAnonymous]
        public string Get(string username)
        {
            {
                return JwtManager.GenerateToken(username);
            }
            throw new HttpResponseException(HttpStatusCode.Unauthorized);
        }

        //public bool CheckUser(string username, string password)
        //{
        //    // should check in the database
        //    return true;
        //}



        [HttpPost]
        [Route("api/Token/GetLogin")]
        public APIResponse GetLogin(LoginModel lgmodel)
        {
            LoginModel obj = new LoginModel();
            APIResponse response = new APIResponse();
            try
            {
                lgmodel.Password = UtilityController.Encrypt(lgmodel.Password, "CCMClinic");
                lgmodel = lgmodel.Authorise();
                if (lgmodel.UserName !=null )
                {

                    string d =Get(lgmodel.UserName);
                    lgmodel.token = d;
                    response.IsError = false;
                    response.Data = lgmodel;
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
