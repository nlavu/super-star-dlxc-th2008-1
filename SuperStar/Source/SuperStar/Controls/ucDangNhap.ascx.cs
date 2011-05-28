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

namespace ShoppingHere.Controls
{
    public partial class ucDangNhap : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int IsLogin = (int)Session["IsLogin"];
            if (IsLogin == 1)
            {
                pnlDangNhap.Visible = false;
                //lblTenNguoiDung.Text = (string)Session["Username"];
                //pnlKetQuaDangNhap.Visible = true;
                Response.Redirect("Index.aspx");
            }
            else
            {
                pnlKetQuaDangNhap.Visible = false;
                pnlDangNhap.Visible = true;
            }
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            lblTenNguoiDung.Text = "";
            //pnlDangNhap.Visible = false;
            //pnlKetQuaDangNhap.Visible = true;
            lblLoi1.Text = "";
            lblLoi2.Text = "";
            
            if (txtTenTaiKhoan.Text.Trim() == "")
            {
                //pnlDangNhap.Visible = true;
                lblLoi1.Text = "Chưa nhập tên đăng nhập";
                //pnlKetQuaDangNhap.Visible = false;
                return;
            }
            if (txtMatKhau.Text.Trim() == "")
            {
                //pnlDangNhap.Visible = true;
                lblLoi2.Text = "Chưa nhập mật khẩu";
                //pnlKetQuaDangNhap.Visible = false;
                return;
            }
            
            TaiKhoan tk = TaiKhoan.LayThongTinTaiKhoanTheoTenTaiKhoan(txtTenTaiKhoan.Text.Trim());

            if (tk == null)
            {
                //pnlDangNhap.Visible = true;
                lblLoi1.Text = "Tên đăng nhập không tồn tại";
                //pnlKetQuaDangNhap.Visible = false;
            }
            else
            {
                if (tk.MatKhau.CompareTo(txtMatKhau.Text.Trim()) == 0)
                {
                    Session["IsLogin"] = 1;
                    Session["Id"] = tk.MaTaiKhoan;
                    Session["UserName"] = tk.TenTaiKhoan;

                    if (tk.LoaiTK == 0)
                        Session["Authentication"] = "Admin";
                    if (tk.LoaiTK == 1)
                        Session["Authentication"] = "QuanLy";
                    if (tk.LoaiTK == 2)
                        Session["Authentication"] = "KhachHang";
                    

                    lblTenNguoiDung.Text = tk.TenTaiKhoan;
                    pnlDangNhap.Visible = false;
                    pnlKetQuaDangNhap.Visible = true;

                    
                }
                else
                {
                    //pnlDangNhap.Visible = true;
                    lblLoi2.Text = "Mật khẩu không đúng";
                    //pnlKetQuaDangNhap.Visible = false;
                }
            }
        }
    }
}