﻿using System;
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
        static List<TangPham> lstTangPham = new List<TangPham>();
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
                sanPham.HinhAnh = "~/image-product/product_icon.jpg";
            }
            sanPham.ThongTinChiTiet = txtThongTinSP.Text;
            int MaSanPham = SanPham.ThemSanPham(sanPham);
            if (MaSanPham != -1)
            {
                foreach (TangPham tp in lstTangPham)
                {
                    tp.MaSanPham = MaSanPham;
                    TangPham.ThemTangPham(tp);
                }
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

        protected void btnThemTangPham_Click(object sender, EventArgs e)
        {
            TangPham tangPham = new TangPham();

            if (txtTenTangPham.Text == "")
            {
                lblTenTangPham.Text = "Chưa nhập tên tặng phẩm";
                return;
            }
            else
            {
                tangPham.TenTangPham = txtTenTangPham.Text;
                lblTenTangPham.Text = "";
            }

            if (txtDiemThuongYC.Text == "")
            {
                lblDiemThuongYC.Text = "Chưa nhập điểm thưởng yêu cầu";
                return;
            }
            else
            {
                int i;
                if (int.TryParse(txtDiemThuongYC.Text, out i))
                {
                    tangPham.DiemThuongYC = int.Parse(txtDiemThuongYC.Text);
                    lblDiemThuongYC.Text = "";
                }
                else
                {
                    lblDiemThuongYC.Text = "Điểm thưởng chỉ chứa số";
                    return;
                }
            }

            if (txtSoLuongTP.Text == "")
            {
                lblSoLuongTP.Text = "Chưa nhập số lượng tặng phẩm";
                return;
            }
            else
            {
                int i;
                if (int.TryParse(txtSoLuongTP.Text, out i))
                {
                    tangPham.SoLuongTP = tangPham.SoLuongConLai = int.Parse(txtSoLuongTP.Text);
                    lblSoLuongTP.Text = "";
                }
                else
                {
                    lblSoLuongTP.Text = "Số lượng tặng phẩm chỉ chứa số";
                    return;
                }
            }

            if (txtSoLuongToiDa.Text == "")
            {
                lblSoLuongTPToiDa.Text = "Chưa nhập số lượng tặng phẩm tối đa";
                return;
            }
            else
            {
                int i;
                if (int.TryParse(txtSoLuongToiDa.Text, out i))
                {
                    if (i <= tangPham.SoLuongTP)
                    {
                        tangPham.SoLuongToiDa = int.Parse(txtSoLuongToiDa.Text);
                        lblSoLuongTPToiDa.Text = "";
                    }
                    else
                    {
                        lblSoLuongTPToiDa.Text = "Số lượng tặng phẩm tối đa phải nhỏ hơn hoặc bằng số lượng tặng phẩm";
                        return;
                    }
                }
                else
                {
                    lblSoLuongTPToiDa.Text = "Số lượng tặng phẩm tối đa chỉ chứa số";
                    return;
                }
            }

            if (fileUploadTP.PostedFile != null)
            {
                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(Server.MapPath("Path_Gift.xml"));
                XmlElement xmlPath = (XmlElement)xmlDoc.SelectSingleNode("/PATH_GIFT");
                string savePath = MapPath(xmlPath.InnerText.Trim() + fileUploadTP.PostedFile.FileName);
                fileUploadTP.PostedFile.SaveAs(savePath);
                tangPham.HinhAnh = xmlPath.InnerText.Trim() + fileUploadTP.PostedFile.FileName;
            }
            else
            {
                tangPham.HinhAnh = "~/image-gift/gift-icon.gif";
            }

            lstTangPham.Add(tangPham);

            txtDiemThuongYC.Text = "";
            txtSoLuongToiDa.Text = "";
            txtSoLuongTP.Text = "";
            txtTenTangPham.Text = "";
            lblDiemThuongYC.Text = "";
            lblHinhAnhTP.Text = "";
            lblSoLuongTP.Text = "";
            lblSoLuongTPToiDa.Text = "";
            lblTenTangPham.Text = "";
        }        
    }
}