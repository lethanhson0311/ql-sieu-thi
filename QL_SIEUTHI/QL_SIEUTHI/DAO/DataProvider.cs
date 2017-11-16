using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace QL_SIEUTHI.DAO
{
    public class DataProvider
    {
        private static DataProvider instance;

        public static DataProvider Instance
        {
            get { if(instance == null) instance = new DataProvider(); return DataProvider.instance; }
            private set { DataProvider.instance = value; }
        }

        private DataProvider() { }
        private string connectionSTR = @"Data Source=.\SQLEXPRESS;Initial Catalog=DB_SieuThi;Integrated Security=True";

        #region ExcuteQuery
            public DataTable ExcuteQuery(string query, object[] parameter = null)
            {
                DataTable data = new DataTable();
                using (SqlConnection connection = new SqlConnection(connectionSTR))
                {

                    connection.Open();

                    SqlCommand cmd = new SqlCommand(query, connection);
                    if (parameter != null)
                    {
                        string[] listPara = query.Split(' ');
                        int i = 0;
                        foreach (string item in listPara)
                        {
                            if(item.Contains('@'))
                            {
                                cmd.Parameters.AddWithValue(item, parameter[i]);
                                i++;
                            }
                        }
                    }


                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(data);
                    connection.Close();
                }
                return data;
            }
        #endregion

        #region ExcuteNonQuery
            public int ExcuteNonQuery(string query, object[] parameter = null)
            {
                int data = 0;
                using (SqlConnection connection = new SqlConnection(connectionSTR))
                {

                    connection.Open();

                    SqlCommand cmd = new SqlCommand(query, connection);
                    if (parameter != null)
                    {
                        string[] listPara = query.Split(' ');
                        int i = 0;
                        foreach (string item in listPara)
                        {
                            if (item.Contains('@'))
                            {
                                cmd.Parameters.AddWithValue(item, parameter[i]);
                                i++;
                            }
                        }
                    }

                    data = cmd.ExecuteNonQuery();
                   
                    connection.Close();
                }
                return data;
            }
        #endregion

        #region ExcuteScalar
            public object ExcuteScalar(string query, object[] parameter = null)
            {
                object data = 0;
                
                using (SqlConnection connection = new SqlConnection(connectionSTR))
                {

                    connection.Open();

                    SqlCommand cmd = new SqlCommand(query, connection);
                    if (parameter != null)
                    {
                        string[] listPara = query.Split(' ');
                        int i = 0;
                        foreach (string item in listPara)
                        {
                            if (item.Contains('@'))
                            {
                                cmd.Parameters.AddWithValue(item, parameter[i]);
                                i++;
                            }
                        }
                    }


                    data = cmd.ExecuteScalar();
                    connection.Close();
                }
                return data;
            }
        #endregion

    }
}
