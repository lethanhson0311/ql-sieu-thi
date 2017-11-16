using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace QL_SIEUTHI.DAO
{
    public class TaiKhoanDAO
    {
        private static TaiKhoanDAO instance;


        public static TaiKhoanDAO Instance
        {
            get { if (instance == null) instance = new TaiKhoanDAO(); return TaiKhoanDAO.instance; }
            private set { TaiKhoanDAO.instance = value; }
        }

        public bool Login(string taiKhoan, string matkhau, string chuVu)
        {
            string query = "EXEC dbo.usp_Login @TenTaiKhoan , @MatKhau , @ChucVu";
            DataTable result = DataProvider.Instance.ExcuteQuery(query, new object[] {taiKhoan,matkhau,chuVu});

            return result.Rows.Count > 0;
        }
        public void LoadLoaiNhanVien()
        {
            string query = "SELECT *FROM dbo.LoaiNV";
            
        }
        
    }
}
