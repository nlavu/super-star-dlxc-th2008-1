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
using System.Collections.Generic;
using System.Xml;
using System.IO;

namespace SuperStar.Controls
{
    public partial class ucThongTinTaiKhoan : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int iDaDangNhap = (Int32)Session["IsLogin"];
            if (iDaDangNhap == 0)
            {
                panelThongTinTaiKhoan.Visible = false;
            }
            else
            {
                int IDUser = (Int32)Session["Id"];
                TaiKhoan taiKhoan = new TaiKhoan();
                taiKhoan = TaiKhoan.LayThongTinTaiKhoanTheoMaTaiKhoan(IDUser);

                lblTenTaiKhoan.Text = taiKhoan.TenTaiKhoan;
                hpThongTinCaNhan.NavigateUrl = "TrangCaNhan.aspx";
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
                hpThongTinCaNhan.NavigateUrl = "../TrangCaNhan.aspx";               
                hpDSDonDatHang.NavigateUrl = "../TrangCaNhan.aspx?type=dsddh";
                
                if (taiKhoan.LoaiTK == 1)
                {
                    lblLoaiTaiKhoan.Text = "Quản Lý";
                    hpDSDonDatHang.Text = "Danh sách đơn hàng";

                    hpQuanLySanPham.Text = "Quản lý sản phẩm";
                    hpQuanLySanPham.NavigateUrl = "../TrangCaNhan.aspx?type=sp";

                    hpQuanLyTaiKhoan.Text = "Quản lý tài khoản";
                    hpQuanLyTaiKhoan.NavigateUrl = "../TrangCaNhan.aspx?type=tk";
                }
                if (taiKhoan.LoaiTK == 2)
                {
                    hpQuanLyTaiKhoan.Visible = false;
                    lblLoaiTaiKhoan.Text = "Đại Lý";
                    hpDSDonDatHang.Text = "Danh sách đơn hàng";
                }
                if (taiKhoan.LoaiTK == 3)
                {
                    hpQuanLyTaiKhoan.Visible = false;
                    lblLoaiTaiKhoan.Text = "Khách Hàng";

                    hpDSDonDatHang.Text = "Đơn hàng của tôi";
                }
            }
        }

        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session["IsLogin"] = 0;
            Session["Id"] = 0;
            Session["Username"] = "username";
            Response.Redirect("Index.aspx");   
        }
    }
}