using QL_SIEUTHI.DAO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace QL_SIEUTHI
{
    public partial class frmDangNhap : Form
    {
        public frmDangNhap()
        {
            InitializeComponent();
            this.MaximizeBox = false;
        }
        #region Method
       
        void checkTaiKhoan()
        {
            string taiKhoan = txtTenDangNhap.Text;
            string matKhau = txtMatKhau.Text;
            string chucVu = cbChucVu.Text;

            if (taiKhoan == "" && matKhau == "")
            {
                MessageBox.Show("Bạn chưa nhập tài khoản");
                txtTenDangNhap.Focus();
            }
            else if (taiKhoan == "")
            {
                MessageBox.Show("Bạn chưa nhập tài khoản");
                txtTenDangNhap.Focus();
            }
            else if (matKhau == "")
            {
                MessageBox.Show("Bạn chưa nhập mật khẩu");
                txtMatKhau.Focus();
            }
            else if (chucVu == "")
            {
                MessageBox.Show("Bạn chưa chọn chức vụ");
                cbChucVu.Focus();
            }
            else
            {
                if (Login(taiKhoan, matKhau, chucVu))
                {
                    if (chucVu == "Quản lý")
                    {
                        this.Hide();
                        frmQuanLy frm = new frmQuanLy();
                        frm.ShowDialog();
                        this.Show();
                    }
                    else if (chucVu == "Thu ngân")
                    {
                        this.Hide();
                        frmThuNgan frm = new frmThuNgan();
                        frm.ShowDialog();
                        this.Show();
                    }
                    else if (chucVu == "Thủ kho")
                    {
                        this.Hide();
                        frmThuKho frm = new frmThuKho();
                        frm.ShowDialog();
                        this.Show();
                    }

                }
                else
                {
                    MessageBox.Show("Sai tên đăng nhập hoặc mật khẩu", "Thông báo!!!");
                }
            }
        }
        
         bool Login(string taiKhoan, string matKhau, string chucVu)
         {

            return TaiKhoanDAO.Instance.Login(taiKhoan,matKhau,chucVu);
         }
            
       
        #endregion

        #region Event

         private void btnDangNhap_Click(object sender, EventArgs e)
         {
            checkTaiKhoan();
             
         }
         private void frmDangNhap_FormClosing(object sender, FormClosingEventArgs e)
         {
            if (MessageBox.Show("Bạn có muốn thoát chương trình", "Thông báo", MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
            {
                 e.Cancel = true;
            }
         }
        #endregion
    }
}
