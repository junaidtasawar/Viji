using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using ClinicBO;

namespace ClinicDAL
{
    public class ClinicDAL
    {
        private static string SaveClinicDetails_SP = "SP_InsertClinicData";
        private static string GetClinicDataForList_SP = "SP_GetClinicData_Forlist";
        private static string GetClinicDetailsByClinicID_SP = "SP_GetClinicDetailsByClinicID";
        private static string DeleteClinicDetailsByID = "SP_DeleteClinicDetailsByID";
        public static string GetClinic = "SP_GetClinicData";

        public DataTable Get()
        {
            DataTable DT_Clinic = new DataTable();
            DT_Clinic = DBManager.GetData(GetClinic);
            if (DT_Clinic.Rows.Count > 0)
                return DT_Clinic;
            else
                return null;
        }

        internal long SaveClinicDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@ClinicID", ClinicID);
            parameters.Add("@Name", Name);
            parameters.Add("@Address", Address);
            parameters.Add("@CreatedBy", CreatedBy);
            parameters.Add("@IsActive", IsActive);
            DBManager.CreateUpdateData(SaveClinicDetails_SP, parameters, out RecordID);
            return RecordID;
        }

        internal long DeleteClinicDetails()
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@ClinicID", ClinicID);
            DBManager.CreateUpdateData(DeleteClinicDetailsByID, parameters, out RecordID);
            return RecordID;
        }
        internal List<ClinicModel> GetClinicData_ForList()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CurrentPage", CurrentPage);
            parameters.Add("@NumberOfRecords", NumberOfRecords);
            parameters.Add("@OrderBy", OrderBy);
            return TransformClinicDataForList(DBManager.GetData(GetClinicDataForList_SP, parameters));
        }

        private List<ClinicModel> TransformClinicDataForList(DataTable data)
        {
            List<ClinicModel> clinicList = new List<ClinicModel>();
            if (data.Rows.Count > 0)
            {
                clinicList = (from DataRow row in data.Rows
                              select new ClinicModel()
                              {
                                  SerialNo = row.Field<Int64>("NUMBER"),
                                  ClinicID = row.Field<Int64>("ClinicID"),
                                  Name = row.Field<string>("Name"),
                                  Address = row.Field<string>("Address"),
                                  TotalCount = row.Field<int>("TotalCount")
                              }).ToList();
            }
            return clinicList;
        }

        internal ClinicModel GetClinicDetailsByClinicID()
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
    }
}
