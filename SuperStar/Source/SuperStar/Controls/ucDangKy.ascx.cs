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
using System.Xml;
using System.IO;
using BUS;

namespace SuperStar.Controls
{
    public partial class ucDangKy : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            pnlKetQuaDangKy.Visible = false;
            pnlThongBaoLoi.Visible = false;

            int iDaDangNhap = (Int32)Session["IsLogin"];
            if (iDaDangNhap == 1)
            {
                Response.Redirect("Index.aspx", true);
            }
        }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            TaiKhoan taiKhoan = new TaiKhoan();
            taiKhoan.TenTaiKhoan = txtTenTaiKhoan.Text;
            taiKhoan.MatKhau = txtMatKhau1.Text;
            taiKhoan.LoaiTK = 3;
            
            // thêm tài khoản vào csdl
            if (TaiKhoan.ThemTaiKhoan(taiKhoan) == 0)
            {
                // nếu thất bại
                pnlThongBaoLoi.Visible = true;
                pnlDangKy.Visible = true;
                pnlKetQuaDangKy.Visible = false;
                lblThongBaoLoi.Text = "Đăng ký bị lỗi. Bạn có thể thử lại.";
            }
            else
            {
                // avartar    
                if (fileUpload.PostedFile != null)
                {
                    XmlDocument xmlDoc = new XmlDocument();
                    xmlDoc.Load(Server.MapPath("Path.xml"));
                    XmlElement xmlPath = (XmlElement)xmlDoc.SelectSingleNode("/PATH");
                    string savePath = MapPath(xmlPath.InnerText.Trim() + txtTenTaiKhoan.Text + Path.GetExtension(fileUpload.PostedFile.FileName));
                    fileUpload.PostedFile.SaveAs(savePath);
                }

                // thông tin cá nhân
                KhachHang khachHang = new KhachHang();
                khachHang.HoTen = txtHoTen.Text;
                khachHang.DiaChi = txtDiaChi.Text;
                khachHang.Email = txtEmail.Text;
                khachHang.SoDienThoai = txtEmail.Text;
                khachHang.MaKhachHang = TaiKhoan.LayThongTinTaiKhoanTheoTenTaiKhoan(txtTenTaiKhoan.Text).MaTaiKhoan;

                KhachHang.ThemKhachHang(khachHang);

                pnlThongBaoLoi.Visible = false;
                pnlDangKy.Visible = false;
                pnlKetQuaDangKy.Visible = true;
                lblTenNguoiDung.Text = txtTenTaiKhoan.Text;
            
                Session["IsLogin"] = 1;
                Session["Username"] = txtTenTaiKhoan.Text;
                // quyền truy xuất
                Session["Authentication"] = "KhachHang"; 
            }            
        }

        protected void btnHuy_Click(object sender, EventArgs e)
        {
            Response.Redirect("Index.aspx", true);
        }
    }
}