using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Clinic.Models.LoginModel
{
    public class LoginModel
    {
        public long ID { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public string Gender { get; set; }
        public string token { get; set; }

        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string EmailID { get; set; }
        public string MobileNumber { get; set; }
        public string  FullName { get; set; }
        public string NewPassword { get; set; }
        public string ClinicName { get; set; }

        public static string AuthorizeUserProc = "SP_AuthorizeUser";
        public static string ResetPasswordProc = "SP_ResetPassword";
        public static string AddUserProc = "SP_CreateUser";
        public static string ForgotUsernamePassword_SP = "SP_ForgotUsernamePassword";
        public static string ChangeUserPassword_SP = "SP_ChangeUserPassword";

        public LoginModel Authorise()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@UserName", UserName != null ? UserName.ToLower() : "");
            parameters.Add("@Password", Password);
            DataTable DT_User = DBManager.GetData(AuthorizeUserProc, parameters);
            return Transform(DT_User);
        }

        private LoginModel Transform(DataTable data)
        {
            LoginModel obj = new LoginModel();
            if (data.Rows.Count > 0)
            {
                obj.ID = Convert.ToInt64(data.Rows[0]["UserID"]);
                obj.FirstName = Convert.ToString(data.Rows[0]["FirstName"]);
                obj.LastName = Convert.ToString(data.Rows[0]["LastName"]);
                obj.FullName = obj.FirstName + " " + obj.LastName;
                obj.EmailID = Convert.ToString(data.Rows[0]["EmailID"]);
                obj.UserName = Convert.ToString(data.Rows[0]["UserName"]);
                obj.ClinicName = Convert.ToString(data.Rows[0]["ClinicName"]);
            }
            return obj;
        }
        public Int64 addUser()
        {
            string password = CommonUtility.GenerateRandomNumericCode(8);
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@FirstName", FirstName);
            parameters.Add("@MiddleName", MiddleName);
            parameters.Add("@LastName", LastName);
            parameters.Add("@EmailID", EmailID);
            parameters.Add("@Username", UserName);
            parameters.Add("@password", password);

            RecordID = DBManager.CreateUpdate(AddUserProc, parameters);
            // DBManager.CreateUpdateDataAndGetRecordID(CreateAnimal, parameters, out RecordID);
            return RecordID;
        }

        public Int64 ResetPassword()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@Username_EmailID", EmailID);
            parameters.Add("@Password", Password);
            DBManager.CreateUpdateDataAndGetRecordID(ResetPasswordProc, parameters, out RecordID);
            return RecordID;
        }

        public LoginModel GetForgotPasswordDetails()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@Username", UserName);
            return TransformForgotPasswordDetails(DBManager.GetData(ForgotUsernamePassword_SP, parameters));
        }

        public LoginModel TransformForgotPasswordDetails(DataTable data)
        {
            LoginModel obj = new LoginModel();
            if (data != null && data.Rows.Count > 0)
            {
                obj.ID = Convert.ToInt64(data.Rows[0]["UserID"]);
                obj.UserName = Convert.ToString(data.Rows[0]["Username"]);
                obj.Password = Convert.ToString(data.Rows[0]["Password"]);
                obj.EmailID = Convert.ToString(data.Rows[0]["EmailID"]);
            }
            return obj;
        }

        public Int64 ChangeUserPassword()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@UserID", ID);
            parameters.Add("@NewPassword", NewPassword);
            parameters.Add("@Password", Password);
            DBManager.CreateUpdateDataAndGetRecordID(ChangeUserPassword_SP, parameters, out RecordID);
            return RecordID;
        }
    }
}