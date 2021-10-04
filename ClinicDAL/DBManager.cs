using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace ClinicDAL
{
    public class DBManager
    {
        private static string connString = Convert.ToString(ConfigurationManager.ConnectionStrings["dbConnection"]);

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
    }
}
