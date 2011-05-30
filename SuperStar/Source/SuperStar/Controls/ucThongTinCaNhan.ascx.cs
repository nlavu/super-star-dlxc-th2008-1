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
using System.Collections.Generic;
using BUS;

namespace SuperStar.Controls
{
    public partial class ucThongTinCaNhan : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int iDaDangNhap = (Int32)Session["IsLogin"];
            if (iDaDangNhap == 0)
            {
                Response.Redirect("DangNhap.aspx");
            }
            else
            {
                int IDUser = (Int32)Session["Id"];
                TaiKhoan taiKhoan = new TaiKhoan();
                taiKhoan = TaiKhoan.LayThongTinTaiKhoanTheoMaTaiKhoan(IDUser);

                lblTenTaiKhoan.Text = taiKhoan.TenTaiKhoan;
                lblMatKhau.Text = taiKhoan.MatKhau;
                
                
                //kiểm tra user có up avatar lên server haykho6ng
                // nếu có thì sử dụng ảnh user, ngược lại dùng ảnh mặc định
                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(Server.MapPath("Path.xml"));
                XmlElement xmlPath = (XmlElement)xmlDoc.SelectSingleNode("/PATH");
                string fileAvatar = MapPath(xmlPath.InnerText.Trim() + taiKhoan.TenTaiKhoan + ".gif");
                if (File.Exists(fileAvatar))
                {
                    imgAvatar.ImageUrl = fileAvatar;
                }
                else
                {
                    imgAvatar.ImageUrl = "../image-user/default.gif";
                }
                

                if (taiKhoan.LoaiTK == 1)
                {
                    QuanLy quanLy = QuanLy.LayThongTinQuanLyTheoMa(IDUser);
                    lblLoaiTaiKhoan.Text = "Quản lý";
                    lblTen.Text = quanLy.HoTen;
                    lblSoDienThoai.Text = quanLy.SoDienThoai;
                    lblDiaChi.Text = quanLy.DiaChi;
                    lblEmail.Text = quanLy.Email;
                    
                }
                if (taiKhoan.LoaiTK == 2)
                {
                    DaiLy daiLy = DaiLy.LayThongTinDaiLyTheoMa(IDUser);
                    lblLoaiTaiKhoan.Text = "Đại lý";
                    lblTen.Text = daiLy.TenDaiLy;
                    lblSoDienThoai.Text = daiLy.SoDienThoai;
                    lblDiaChi.Text = daiLy.DiaChi;
                    lblEmail.Text = daiLy.Email;

                    lblNguoiDaiDien.Visible = true;
                    lblNguoiDaiDien.Text = daiLy.NguoiDaiDien;
                    lblHoTen.Text = "Tên đại lý: ";
                    lblDaiDien.Visible = true;
                    lblDaiDien.Text = "Người đại diện: ";
                }
                if (taiKhoan.LoaiTK == 3)
                {
                    KhachHang khachHang = KhachHang.LayThongTinKhachHangTheoMa(IDUser);
                    lblLoaiTaiKhoan.Text = "Khách hàng";
                    lblTen.Text = khachHang.HoTen;
                    lblSoDienThoai.Text = khachHang.SoDienThoai;
                    lblDiaChi.Text = khachHang.DiaChi;
                    lblEmail.Text = khachHang.Email;
                }
                if (taiKhoan.LoaiTK == 1 || taiKhoan.LoaiTK == 3)
                {
                    lblNguoiDaiDien.Visible = false;
                    lblHoTen.Text = "Họ tên: ";
                    lblDaiDien.Visible = false;
                }
            }
        }
    }
}