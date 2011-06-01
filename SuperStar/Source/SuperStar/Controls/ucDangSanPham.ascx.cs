using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BUS;
using System.IO;
using System.Xml;

namespace SuperStar.Controls
{
    public partial class ucDangSanPham : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int DaDangNhap = (Int32)Session["IsLogin"];
            string Authentication = (string)Session["Authentication"];
            if (DaDangNhap == 0 || Authentication.CompareTo("QuanLy") != 0)
            {
                pnlDangSanPham.Visible = false;
                pnlThongBao.Visible = true;
                lblThongBao.Text = "Bạn không đủ quyền truy cập vào khu vực này.";
                hpRedirect.Text = "Click vào đây để về trang chủ";
                hpRedirect.NavigateUrl = "Index.aspx";
                return;
            }
            else
            {
                pnlDangSanPham.Visible = true;
                pnlThongBao.Visible = false;

                List<BUS.DanhMucSanPham> lstDanhMucSP = BUS.DanhMucSanPham.LayDanhMucSanPham();

                this.dropLoaiSanPham.DataValueField = "Ma";
                this.dropLoaiSanPham.DataTextField = "TenLoaiSanPham";
                this.dropLoaiSanPham.DataSource = lstDanhMucSP;
                this.dropLoaiSanPham.DataBind();
            }
        }

        protected void btnDangSanPham_Click(object sender, EventArgs e)
        {
            BUS.SanPham sanPham = new BUS.SanPham();
            sanPham.TenSanPham = txtTenSanPham.Text.Trim();
            sanPham.MaDanhMuc = int.Parse(dropLoaiSanPham.SelectedItem.Value);
            sanPham.DonGia = float.Parse(txtDonGia.Text);
            sanPham.DiemThuong = int.Parse(txtDiemThuong.Text);
            sanPham.SoLuongSP = sanPham.SoLuongTon = int.Parse(txtSoLuong.Text);
            sanPham.MaNguoiNhap = (Int32)Session["Id"];
            sanPham.ThoiGianBD_Ban = DateTime.Parse(dtpThoiGianBDBan.Value);
            sanPham.ThoiGianKT_Ban = DateTime.Parse(dtpThoiGianKTBan.Value);
            sanPham.ThoiGianBD_NhanHang = DateTime.Parse(dtpThoiGianBDNhan.Value);
            sanPham.ThoiGianKT_NhanHang = DateTime.Parse(dtpThoiGianKTNhan.Value);

            if (fileUpload.PostedFile != null)
            {
                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(Server.MapPath("Path_Product.xml"));
                XmlElement xmlPath = (XmlElement)xmlDoc.SelectSingleNode("/PATH");
                string savePath = MapPath(xmlPath.InnerText.Trim() + fileUpload.PostedFile.FileName);
                fileUpload.PostedFile.SaveAs(savePath);
                sanPham.HinhAnh = xmlPath.InnerText.Trim() + fileUpload.PostedFile.FileName;
            }
            else
            {             
                pnlThongBao.Visible = true;
                lblThongBao.Text = "Bạn chưa chọn hình ảnh.";
                return;
            }
            sanPham.ThongTinChiTiet = txtThongTinSP.Text;
            if (BUS.SanPham.ThemSanPham(sanPham)==1)
            {
                pnlDangSanPham.Visible = false;
                pnlThongBao.Visible = true;
                lblThongBao.Text = "Thêm sản phẩm thành công.";

                hpRedirect.Text = "Click vào đây để tiếp tục thêm sản phẩm.";
                hpRedirect.NavigateUrl = "DangSanPham.aspx";
            }
            else
            {
                pnlDangSanPham.Visible = true;
                pnlThongBao.Visible = true;
                lblThongBao.Text = "Thêm sản phẩm  bị lỗi.";
            }
        }

        protected void btnHuy_Click(object sender, EventArgs e)
        {
            Response.Redirect("TrangCaNhan.aspx");
        }
    }
}