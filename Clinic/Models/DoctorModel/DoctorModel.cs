using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Clinic.Models.DoctorModel
{
    public class DoctorModel : Clinic.Models.UtilityModel.UtilityModel
    {
        public Int64 SerialNo { get; set; }
        public Int64 DoctorID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Specility { get; set; }
        public string PhoneNo { get; set; }
        public string Email { get; set; }
        public string WebAddress { get; set; }
        public bool IsActive { get; set; }
        public long LoginUserID { get; set; }
        //public List<SelectListItem> Doctors { get; set; }
        //public int[] DoctorsIds { get; set; }

        private static string GetDoctorDataForList_SP = "SP_GetDoctorData_Forlist";
        private static string SaveDoctorDetails_SP = "SP_InsertDoctorData";
        private static string GetDoctorDetailsByDoctorID_SP = "SP_GetDoctorDetailsByDoctorID";
       // private static string GetDoctorsNameIDsByPatientID_SP = "SP_GetDoctorsNameIDsByPatientID";

        internal List<DoctorModel> GetDoctorData_ForList()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", CurrentPage);
            parameters.Add("@NumberOfRecords", NumberOfRecords);
            parameters.Add("@OrderBy", OrderBy);
            return TransformDoctorDataForList(DBManager.GetData(GetDoctorDataForList_SP, parameters));
        }

        private List<DoctorModel> TransformDoctorDataForList(DataTable data)
        {
            List<DoctorModel> doctorList = new List<DoctorModel>();
            if (data.Rows.Count > 0)
            {
                doctorList = (from DataRow row in data.Rows
                              select new DoctorModel()
                              {
                                  SerialNo = row.Field<Int64>("NUMBER"),
                                  DoctorID = row.Field<Int64>("DoctorID"),
                                  Name = row.Field<string>("Name"),
                                  Address = row.Field<string>("Address"),
                                  Specility = row.Field<string>("Specility"),
                                  PhoneNo = row.Field<string>("PhoneNo"),
                                  WebAddress = row.Field<string>("WebAddress"),
                                  Email = row.Field<string>("Email"),
                                  TotalCount = row.Field<int>("TotalCount")
                              }).ToList();
            }
            return doctorList;
        }

        internal DoctorModel GetDoctorDetailsByDoctorID()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@DoctorID", DoctorID);
            return TransformDoctorIDDetailsByDoctorID(DBManager.GetData(GetDoctorDetailsByDoctorID_SP, parameters));
        }

        private DoctorModel TransformDoctorIDDetailsByDoctorID(DataTable dataTable)
        {
            DoctorModel obj = new DoctorModel();
            return obj = (from DataRow row in dataTable.Rows
                          select new DoctorModel()
                          {
                              DoctorID = row.Field<Int64>("DoctorID"),
                              Name = row.Field<string>("Name"),
                              Address = row.Field<string>("Address"),
                              Specility = row.Field<string>("Specility"),
                              PhoneNo = row.Field<string>("PhoneNo"),
                              WebAddress = row.Field<string>("WebAddress"),
                              Email = row.Field<string>("Email")
                          }).FirstOrDefault();
        }

        internal Int64 SaveDoctorDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@DoctorID", DoctorID);
            parameters.Add("@Name", Name);
            parameters.Add("@Address", Address);
            parameters.Add("@PhoneNo", PhoneNo);
            parameters.Add("@Specility", Specility);
            parameters.Add("@WebAddress", WebAddress);
            parameters.Add("@Email", Email);
            parameters.Add("@CreatedBy", CreatedBy);
            parameters.Add("@IsActive", IsActive);
            DBManager.CreateUpdateData(SaveDoctorDetails_SP, parameters, out RecordID);
            return RecordID;
        }

        //internal List<SelectListItem> PopulateDoctors()
        //{
        //    List<SelectListItem> items = new List<SelectListItem>();
        //    items = TransformDoctors(DBManager.GetData(GetDoctorsNameIDsByPatientID_SP));
        //    //string constr = ConfigurationManager.ConnectionStrings["Constring"].ConnectionString;
        //    //using (SqlConnection con = new SqlConnection(constr))
        //    //{
        //    //    string query = "SELECT FruitName, FruitId FROM Fruits";
        //    //    using (SqlCommand cmd = new SqlCommand(query))
        //    //    {
        //    //        cmd.Connection = con;
        //    //        con.Open();
        //    //        using (SqlDataReader sdr = cmd.ExecuteReader())
        //    //        {
        //    //            while (sdr.Read())
        //    //            {
        //    //                items.Add(new SelectListItem
        //    //                {
        //    //                    Text = sdr["FruitName"].ToString(),
        //    //                    Value = sdr["FruitId"].ToString()
        //    //                });
        //    //            }
        //    //        }
        //    //        con.Close();
        //    //    }
        //    //}

        //    return items;
        //}

        //private List<SelectListItem> TransformDoctors(DataTable dataTable)
        //{
        //    List<SelectListItem> items = new List<SelectListItem>();
        //    if (dataTable.Rows.Count > 0)
        //    {
        //        for (int i = 0; i < dataTable.Rows.Count; i++)
        //        {
        //            SelectListItem userinfo = new SelectListItem();
        //            userinfo.Text = dataTable.Rows[i]["Name"].ToString();
        //            userinfo.Value = dataTable.Rows[i]["DoctorID"].ToString();
        //            items.Add(userinfo);
        //        }
        //    }
        //    return items;
        //}
    }
}