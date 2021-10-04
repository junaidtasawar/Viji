using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Clinic.Models.UserModel
{
    public class UserModel : Clinic.Models.UtilityModel.UtilityModel
    {
        public Int64 SerialNo { get; set; }
        public Int64 UserID { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public int Gender { get; set; }
        public string EmailID { get; set; }
        public string MobileNumber { get; set; }
        public string AddressLine { get; set; }
        public string CityName { get; set; }
        public string CountryName { get; set; }
        public string StateName { get; set; }
        public string Pincode { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public bool IsActive { get; set; }
        public string ClinicName { get; set; }
        public string GenderStr { get; set; }
        public string FullName { get; set; }
        public long LoginUserID { get; set; }

        private static string SaveUserDetails_SP = "SP_InsertUserData";
        private static string GetUserDataForList_SP = "SP_GetUserData_Forlist";
        private static string GetUserDetailsByUserID_SP = "SP_GetUserDetailsByUserID";

        public Int64 SaveUserDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@UserID", UserID);
            parameters.Add("@FirstName", FirstName);
            parameters.Add("@MiddleName", MiddleName);
            parameters.Add("@LastName", LastName);
            parameters.Add("@Gender", Gender);
            parameters.Add("@EmailID", EmailID);
            parameters.Add("@MobileNumber", MobileNumber);
            parameters.Add("@Address", AddressLine);
            parameters.Add("@CityID", CityName);
            parameters.Add("@CountryID", CountryName);
            parameters.Add("@StateID", StateName);
            parameters.Add("@Pincode", Pincode);
            parameters.Add("@Password", Password);
            parameters.Add("@ClinicName", ClinicName);
            parameters.Add("@Username", Username);
            parameters.Add("@CreatedBy", CreatedBy);
            parameters.Add("@IsActive", IsActive);
            DBManager.CreateUpdateData(SaveUserDetails_SP, parameters, out RecordID);
            return RecordID;
        }

        internal List<UserModel> GetUserData_ForList()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", CurrentPage);
            parameters.Add("@NumberOfRecords", NumberOfRecords);
            parameters.Add("@OrderBy", OrderBy);
            parameters.Add("@LoginUserID", LoginUserID);
            DataSet ds = DBManager.GetDataSet(GetUserDataForList_SP, parameters);
            return TransformUserDataForList(ds);
        }

        private List<UserModel> TransformUserDataForList(DataSet dataSet)
        {
            List<UserModel> userList = new List<UserModel>();
            int totalCount = 0;

            if (dataSet.Tables.Count > 0)
            {
                if (dataSet.Tables[0].Rows.Count > 0)
                {
                    totalCount = Convert.ToInt32(dataSet.Tables[0].Rows[0]["TotalCount"]);
                }
                if (dataSet.Tables[1].Rows.Count > 0)
                {
                    DataTable data = dataSet.Tables[1];
                    userList = (from DataRow row in data.Rows
                                select new UserModel()
                                {
                                    SerialNo = row.Field<Int64>("NUMBER"),
                                    UserID = row.Field<Int64>("UserID"),
                                    FullName = row.Field<string>("Name"),
                                    AddressLine = row.Field<string>("Address"),
                                    MobileNumber = row.Field<string>("MobileNumber"),
                                    GenderStr = row.Field<string>("Gender"),
                                    ClinicName = row.Field<string>("ClinicName"),
                                    TotalCount = totalCount
                                }).ToList();
                }
            }
            return userList;
        }

        internal UserModel GetUserDetailsByUserID()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@UserID", UserID);
            return TransformUserDetailsByUserID(DBManager.GetData(GetUserDetailsByUserID_SP, parameters));
        }

        private UserModel TransformUserDetailsByUserID(DataTable dataTable)
        {
            UserModel obj = new UserModel();
            return obj = (from DataRow row in dataTable.Rows
                          select new UserModel()
                          {
                              UserID = row.Field<Int64>("UserID"),
                              FirstName = row.Field<string>("FirstName"),
                              MiddleName = row.Field<string>("MiddleName"),
                              LastName = row.Field<string>("LastName"),
                              MobileNumber = row.Field<string>("MobileNumber"),
                              EmailID = row.Field<string>("EmailID"),
                              AddressLine = row.Field<string>("Address"),
                              CityName = row.Field<string>("City"),
                              StateName = row.Field<string>("State"),
                              CountryName = row.Field<string>("Country"),
                              Pincode = row.Field<string>("Pincode"),
                              ClinicName = row.Field<string>("ClinicName"),
                              Username = row.Field<string>("Username"),
                              Password = row.Field<string>("Password"),
                              Gender = row.Field<int>("Gender")
                          }).FirstOrDefault();
        }
    }
}