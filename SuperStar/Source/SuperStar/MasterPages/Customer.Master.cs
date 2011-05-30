using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using BUS;

namespace SuperStar.MasterPages
{
    public partial class Customer : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // kiểm tra đã đăng nhập chưa
            int iDaDangNhap = (Int32)Session["IsLogin"];
            if (iDaDangNhap == 0)
            {
                hpRegister.NavigateUrl = "../DangKy.aspx";
                hpRegister.Text = "REGISTRATION";

                hpLogin.NavigateUrl = "../DangNhap.aspx";
                hpLogin.Text = "LOG IN";
            }
            else
            {
                TaiKhoan taiKhoan = new TaiKhoan();
                taiKhoan = TaiKhoan.LayThongTinTaiKhoanTheoMaTaiKhoan((Int32)Session["Id"]);

                hpRegister.NavigateUrl = "../Index.aspx";   //link về trang cá nhân
                hpRegister.Text = "Hi, "+ taiKhoan.TenTaiKhoan;

                hpLogin.NavigateUrl = "#";
                hpLogin.Text = "LOG OUT";
            }
        }
    }
}
