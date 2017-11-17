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
    public partial class frmThuNgan : Form
    {
        public frmThuNgan()
        {
            InitializeComponent();
            this.MaximizeBox = false;
        }

        private void ttmiDoiThongTin_Click(object sender, EventArgs e)
        {
            frmDoiThongTinTaiKhoan f = new frmDoiThongTinTaiKhoan();
            f.ShowDialog();
        }

        private void tsmiThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void thanhToánToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmThanhToan f = new frmThanhToan();
            f.ShowDialog();
        }

        private void đăngKýKHTTToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmDangKyKHTT f = new frmDangKyKHTT();
            f.ShowDialog();
        }
    }
}
