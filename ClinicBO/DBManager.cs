using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace ClinicBO
{
    public class DBManager
    {
        private static string connString = Convert.ToString(System.Configuration.ConfigurationManager.ConnectionStrings["dbConnection"]);





        public static List<T> GetList<T>(string procedure) where T : new()
        {
            var data = new List<T>();

            using (var conn = new SqlConnection(connString))
            {
                var com = new SqlCommand();
                com.Connection = conn;
                com.CommandType = CommandType.StoredProcedure;

                com.CommandText = procedure;
                var adapt = new SqlDataAdapter();
                adapt.SelectCommand = com;
                var dataset = new DataSet();
                adapt.Fill(dataset);

                //Get each row in the datatable
                foreach (DataRow row in dataset.Tables[0].Rows)
                {
                    //Create a new instance of the specified class
                    var newT = new T();

                    //Iterate each column
                    foreach (DataColumn col in dataset.Tables[0].Columns)
                    {
                        //Get the property to set
                        var property = newT.GetType().GetProperty(col.ColumnName);
                        //Set the value
                        property.SetValue(newT, row[col.ColumnName]);
                    }

                    //Add it to the list
                    data.Add(newT);
                }

                return data;
            }

        }
        
        public static DataTable GetData(string procName)
        {
            DataTable dtResult = new DataTable();
            SqlConnection conn = new SqlConnection(connString);
            SqlDataReader reader = null;
            conn.Open();
            SqlCommand cmd = new SqlCommand(procName);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 0;
            cmd.Connection = conn;
            reader = cmd.ExecuteReader();
            dtResult.Load(reader);
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            return dtResult;
        }

        public static DataTable GetData(string procName, IDictionary<object, object> paramNames)
        {
            DataTable dtResult = new DataTable();
            SqlConnection conn = new SqlConnection(connString);
            SqlDataReader reader = null;
            conn.Open();
            {
                SqlCommand cmd = new SqlCommand(procName);
                cmd.CommandType = CommandType.StoredProcedure;
                if (paramNames != null)
                {
                    foreach (string paramName in paramNames.Keys)
                    {
                        DbParameter param = cmd.CreateParameter();
                        param.ParameterName = paramName;
                        param.Value = paramNames[paramName];
                        cmd.Parameters.Add(param);
                    }
                }
                cmd.CommandTimeout = 0;
                cmd.Connection = conn;
                reader = cmd.ExecuteReader();
                dtResult.Load(reader);
            }
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            return dtResult;
        }

        public static void CreateUpdateData(string procName, IDictionary<object, object> paramNames)
        {
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(procName);
            cmd.Connection = conn;
            cmd.CommandType = CommandType.StoredProcedure;
            if (paramNames != null)
            {
                foreach (string paramName in paramNames.Keys)
                {
                    DbParameter param = cmd.CreateParameter();
                    param.ParameterName = paramName;
                    param.Value = paramNames[paramName];
                    param.Value = paramNames[paramName];
                    cmd.Parameters.Add(param);
                }
            }
            cmd.ExecuteNonQuery();
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }

        public static int CreateUpdate(string procName, IDictionary<object, object> paramNames)
        {
            int ReturnID = -1;
            DataTable dtResult = new DataTable();
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(procName);
            cmd.Connection = conn;
            cmd.CommandType = CommandType.StoredProcedure;
            if (paramNames != null)
            {
                foreach (string paramName in paramNames.Keys)
                {
                    DbParameter param = cmd.CreateParameter();
                    param.ParameterName = paramName;
                    param.Value = paramNames[paramName];
                    cmd.Parameters.Add(param);
                }
            }
            ReturnID = cmd.ExecuteNonQuery();
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            return ReturnID;
        }

        public static void CreateUpdateData(string procName, IDictionary<object, object> paramNames, out Int64 RecordID)
        {
            RecordID = -1;
            DataTable dtResult = new DataTable();
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand(procName);
                cmd.Connection = conn;
                cmd.CommandType = CommandType.StoredProcedure;
                if (paramNames != null)
                {
                    foreach (string paramName in paramNames.Keys)
                    {
                        DbParameter param = cmd.CreateParameter();
                        param.ParameterName = paramName;
                        param.Value = paramNames[paramName];
                        cmd.Parameters.Add(param);
                    }
                }
                RecordID = Convert.ToInt64(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                throw;
            }

            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }

        public static int CreateUpdateDataAndRetrunRowAffectedIF(string procName, IDictionary<object, object> paramNames)
        {
            int NoofRowsAffected = -1;
            DataTable dtResult = new DataTable();
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand(procName);
                cmd.Connection = conn;
                cmd.CommandType = CommandType.StoredProcedure;
                if (paramNames != null)
                {
                    foreach (string paramName in paramNames.Keys)
                    {
                        DbParameter param = cmd.CreateParameter();
                        param.ParameterName = paramName;
                        param.Value = paramNames[paramName];
                        cmd.Parameters.Add(param);
                    }
                }
                NoofRowsAffected = cmd.ExecuteNonQuery();
                return NoofRowsAffected;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }
        }

        public static void CreateUpdateDataAndGetRecordID(string procName, IDictionary<object, object> paramNames, out Int64 RecordID)
        {
            RecordID = -1;
            DataTable dtResult = new DataTable();
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(procName);
            cmd.Connection = conn;
            cmd.CommandType = CommandType.StoredProcedure;
            if (paramNames != null)
            {
                foreach (string paramName in paramNames.Keys)
                {
                    DbParameter param = cmd.CreateParameter();
                    param.ParameterName = paramName;
                    param.Value = paramNames[paramName];
                    cmd.Parameters.Add(param);
                }
            }
            RecordID = Convert.ToInt64(cmd.ExecuteScalar());
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }

        public static List<string> GetAutoCompleteData(string username)
        {
            List<string> result = new List<string>();
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("select DISTINCT Name from DoctorMaster where Name LIKE '%'+@SearchText+'%'", con))
                {
                    con.Open();
                    cmd.Parameters.AddWithValue("@SearchText", username);
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        result.Add(dr["Name"].ToString());
                    }
                    return result;
                }
            }
        }

        public static DataSet GetDataSet(string procName, IDictionary<object, object> paramNames)
        {
            DataSet ds = new DataSet();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                {
                    SqlCommand cmd = new SqlCommand(procName);
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (paramNames != null)
                    {
                        foreach (string paramName in paramNames.Keys)
                        {
                            DbParameter param = cmd.CreateParameter();
                            param.ParameterName = paramName;
                            param.Value = paramNames[paramName];
                            cmd.Parameters.Add(param);
                        }
                    }
                    cmd.CommandTimeout = 0;
                    cmd.Connection = conn;
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = cmd;

                    da.Fill(ds);
                }
            }
            return ds;
        }
    }
}
