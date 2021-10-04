using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Clinic.Models.LoginModel;
using Clinic.Controllers.Utility;
using System.Text.RegularExpressions;
using ClinicBO;
using RestSharp;
using System.Reflection;

namespace Clinic.Controllers.Authentication
{
    public class AuthenticationController : BaseController
    {
        //
        // GET: /Authentication/
        long userId = 0;

        public ActionResult Login()
        {
            return View();
        }
        //public string AuthorizeUser(LoginModel model)
        //{
        //    try
        //    {
        //        model.Password = UtilityController.Encrypt(model.Password, "CCMClinic");
        //        model = model.Authorise();
        //        if (model.UserName != null)
        //        {
        //            Session["User"] = model;
        //            //return RedirectToAction("Index", "Home");
        //            return "1";
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine(ex.Message);
        //    }

        //    return "0";
        //    //return View(model);
        //}


        public string AuthorizeUser(LoginModel model)
        {
            Int64 recordId = -1;

            var model2 = new LoginModel();

            try
            {
                APIResponse apiResponse = new APIResponse();
                var client = new RestClient(String.Concat(_apiUrl, "api/Token/GetLogin"));
                var request = new RestRequest("", Method.POST) { RequestFormat = DataFormat.Json };
                request.AddJsonBody(model);

                var response = client.Execute<bool>(request);
                if (response.StatusCode == System.Net.HttpStatusCode.OK && response.Content.Length > 0)
                {
                    apiResponse = (APIResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(response.Content, typeof(APIResponse));
                }

                if (apiResponse.IsError)
                {

                }
                else
                {
                    model2 = (LoginModel)Newtonsoft.Json.JsonConvert.DeserializeObject(Convert.ToString(apiResponse.Data), typeof(LoginModel));
                }
            }
            catch (Exception ex)
            {
                UtilityController.LogException(ex, MethodBase.GetCurrentMethod().ReflectedType.Name, MethodBase.GetCurrentMethod().Name, userId);

            }
            if (model2!=null)
            {
                Session["User"] = model2;
                Session["Token"] = model2.token;
                //return RedirectToAction("Index", "Home");
                return "1";
            }
            else
            {
                return "0";
            }
            //    //return View(model);
            //}
        }

        public void signout()
        {
            Session["User"] = null;
        }

        public ActionResult ForgotPassword()
        {
            string pass = UtilityController.Decrypt("7QIGM2Z0tmvcpNLjA2lfvQ==", "CCMClinic");
            return View();
        }

        public string GetForgotPasswordDetails(LoginModel model)
        {
            model = model.GetForgotPasswordDetails();

            if (model != null && model.ID > 0)
            {
                UtilityController uController = new UtilityController();

                uController.SendEmail(model.UserName, UtilityController.Decrypt(model.Password, "CCMClinic"), model.EmailID, "Forget Password");
            }
            return null;
        }

        public string ChangeUserPassword(string CurrentPassword, string NewPassword, string ConfirmPassword)
        {
            if (IsValid(NewPassword))
            {

                LoginModel model = (LoginModel)Session["User"];
                LoginModel user = new LoginModel();
                user.Password = UtilityController.Encrypt(CurrentPassword, "CCMClinic");
                user.NewPassword = UtilityController.Encrypt(NewPassword, "CCMClinic");
                user.ID = model.ID;
                Int64 RecordID = user.ChangeUserPassword();
                if (RecordID == -1)
                {
                    return "InvalidPassword";
                }
                else
                {
                    return "0";
                }
            }
            else
            {
                return "PolicyInvalid";
            }
        }

        public bool IsValid(string Password)
        {
            int Minimum_Length = 5;
            int Maximum_Length = 8;
            int Upper_Case_length = 1;
            int Lower_Case_length = 1;
            int NonAlpha_length = 1;
            int Numeric_length = 1;

            if (Password.Length < Minimum_Length)
                return false;
            if (Password.Length > Maximum_Length)
                return false;
            if (UpperCaseCount(Password) < Upper_Case_length)
                return false;
            if (LowerCaseCount(Password) < Lower_Case_length)
                return false;
            if (NumericCount(Password) < Numeric_length)
                return false;
            if (NonAlphaCount(Password) < NonAlpha_length)
                return false;
            return true;
        }
        private int UpperCaseCount(string Password)
        {
            return Regex.Matches(Password, "[A-Z]").Count;
        }

        private int LowerCaseCount(string Password)
        {
            return Regex.Matches(Password, "[a-z]").Count;
        }
        private int NumericCount(string Password)
        {
            return Regex.Matches(Password, "[0-9]").Count;
        }
        private int NonAlphaCount(string Password)
        {
            return Regex.Matches(Password, @"[^0-9a-zA-Z\._]").Count;
        }
    }
}
