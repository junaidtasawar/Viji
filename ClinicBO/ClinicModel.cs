using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicBO
{
    public class ClinicModel : UtilityModel
    {
        public Int64 SerialNo { get; set; }
        public Int64 ClinicID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public bool IsActive { get; set; }
        public Int64 LoginUserID { get; set; }
        public DataTable DT_Clinic { get; set; }

        private static string GetClinic = "SP_GetClinicData";
        private static string SaveClinicDetails_SP = "SP_InsertClinicData";
        private static string GetClinicDataForList_SP = "SP_GetClinicData_Forlist";
        private static string GetClinicDetailsByClinicID_SP = "SP_GetClinicDetailsByClinicID";
        //private static string DeleteClinicDetailsByID = "SP_DeleteClinicDetailsByID";
        

        public List<ClinicModel> GetClinicData_ForList(int? page, int? limit, long loginUserID)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", page);
            parameters.Add("@NumberOfRecords", limit);
            parameters.Add("@LoginUserID", loginUserID);
            DataSet ds = DBManager.GetDataSet(GetClinicDataForList_SP, parameters);
            return TransformClinicDataForList(ds);
        }

        private List<ClinicModel> TransformClinicDataForList(DataSet dataSet)
        {
            List<ClinicModel> clinicList = new List<ClinicModel>();
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
                    clinicList = (from DataRow row in data.Rows
                                  select new ClinicModel()
                                  {
                                      SerialNo = row.Field<Int64>("NUMBER"),
                                      ClinicID = row.Field<Int64>("ClinicID"),
                                      Name = row.Field<string>("Name"),
                                      Address = row.Field<string>("Address"),
                                      TotalCount = totalCount
                                  }).ToList();
                }
            }
            return clinicList;
        }

        public ClinicModel GetClinicDetailsByClinicID(string ClinicID)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@ClinicID", ClinicID);
            return TransformClinicDetailsByClinicID(DBManager.GetData(GetClinicDetailsByClinicID_SP, parameters));
        }

        private ClinicModel TransformClinicDetailsByClinicID(DataTable dataTable)
        {
            ClinicModel obj = new ClinicModel();
            return obj = (from DataRow row in dataTable.Rows
                          select new ClinicModel()
                          {
                              ClinicID = row.Field<Int64>("ClinicID"),
                              Name = row.Field<string>("Name"),
                              Address = row.Field<string>("Address"),
                          }).FirstOrDefault();
        }

        public Int64 SaveClinicDetails(ClinicModel obj)
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@ClinicID", obj.ClinicID);
            parameters.Add("@Name", obj.Name);
            parameters.Add("@Address", obj.Address);
            parameters.Add("@CreatedBy", obj.CreatedBy);
            parameters.Add("@IsActive", obj.IsActive);
            DBManager.CreateUpdateData(SaveClinicDetails_SP, parameters, out RecordID);
            return RecordID;
        }

        public DataTable Get(long userID)
        {
            DataTable DT_Clinic = new DataTable();
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@LoginUserID", userID);
            DT_Clinic = DBManager.GetData(GetClinic, parameters);
            if (DT_Clinic.Rows.Count > 0)
                return DT_Clinic;
            else
                return null;
        }

        //public long DeleteClinicDetails()
        //{
        //    Int64 RecordID = -1;
        //    Dictionary<object, object> parameters = new Dictionary<object, object>();
        //    parameters.Add("@ClinicID", ClinicID);
        //    DBManager.CreateUpdateData(DeleteClinicDetailsByID, parameters, out RecordID);
        //    return RecordID;
        //}
    }
}
