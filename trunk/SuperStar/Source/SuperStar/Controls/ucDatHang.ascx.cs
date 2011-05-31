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

namespace SuperStar.Controls
{
    public partial class ucDonDatHang : System.Web.UI.UserControl
    {
        BUS.SanPham g_SanPham = new BUS.SanPham();

        protected void Page_Load(object sender, EventArgs e)
        {
            // kiểm tra đã đăng nhập chưa
            int iDaDangNhap = (Int32)Session["IsLogin"];
            if (iDaDangNhap == 0)
            {
                pnlThongBao.Visible = true;
                panelDatHang.Visible = false;
                pnlKetQuaDatHang.Visible = false;
                return;
                //Response.Redirect("../Index.aspx");
            }
            pnlThongBao.Visible = false;
            pnlKetQuaDatHang.Visible = false;

            int maSanPham = 0;            
            if (int.TryParse((Request.QueryString["maSanPham"]),out maSanPham))
            {
                // sản phẩm
                g_SanPham = BUS.SanPham.LaySanPhamTheoMa(maSanPham);
                lblTenSanPham.Text = g_SanPham.TenSanPham;

                if (!Page.IsPostBack)
                {
                    txtSoLuongMuaSP.Text = "1";
                    lblThanhTien.Text = String.Format("{0:N}", g_SanPham.DonGia);
                    lblTongDiemThuong.Text = g_SanPham.DiemThuong.ToString();
                    lblDiemThuongConLai.Text = g_SanPham.DiemThuong.ToString();

                    // danh sách đại lý
                    // bổ sung spLayDSDaiLy
                    List<DaiLy> lstDaiLy = DaiLy.LayDSDaiLy();
                    dropListDaiLy.DataTextField = "TenDaiLy";
                    dropListDaiLy.DataValueField = "MaDaiLy";
                    dropListDaiLy.DataSource = lstDaiLy;
                    dropListDaiLy.DataBind();

                    // danh sách tặng phẩm

                    List<TangPham> lstTangPham = TangPham.LayDSTangPhamTheoMaSP(maSanPham);
                    dlDanhSachTangPham.DataSource = lstTangPham;
                    dlDanhSachTangPham.DataBind();      
                }
            }
            else
            {

                Response.Redirect("Index.aspx");
            }
        }


        protected void txtSoLuongMuaSP_TextChanged(object sender, EventArgs e)
        {
            int soluong = 0;
            lblLoiSanPham.Text = "";
            if (!int.TryParse(txtSoLuongMuaSP.Text, out soluong))
            {
                lblLoiSanPham.Text = "Số lượng sản phẩm phải là số";
                return;
            }
            if (soluong < 0)
            {
                lblLoiSanPham.Text = "Số lượng sản phẩm phải lớn hơn 0";
                txtSoLuongMuaSP.Focus();
                return;
            }
            if (soluong > g_SanPham.SoLuongTon)
            {
                lblLoiSanPham.Text = "Số lượng sản phẩm phải nhỏ hơn số lượng tồn : " + g_SanPham.SoLuongTon.ToString() ;
                return;
            }
            lblThanhTien.Text = String.Format("{0:N}",g_SanPham.DonGia * soluong);
            lblTongDiemThuong.Text = (g_SanPham.DiemThuong * soluong).ToString();
            //tính lại điểm thưởng còn lại
            lblDiemThuongConLai.Text = (g_SanPham.DiemThuong * soluong).ToString();
        }

        protected void imgButtonThanhToan_Click(object sender, ImageClickEventArgs e)
        {
            // kiểm tra tặng phẩm
            lblLoiChonTP.Text = "";
            List<ChiTietDonDatHang> lstChiTietDDH = new List<ChiTietDonDatHang>();
            int tongDiemThuongYC = 0;
            int tongDiemThuong = int.Parse(lblTongDiemThuong.Text);
            for (int i = 0; i < dlDanhSachTangPham.Items.Count; i++)
            {
                TextBox txtSoLuongTP = dlDanhSachTangPham.Items[i].FindControl("txtSoLuongMuaTP") as TextBox;
                int soluongTP = 0;
                if (!int.TryParse(txtSoLuongTP.Text, out soluongTP))
                {
                    lblLoiChonTP.Text = "Số lượng tặng phẩm phải là số.";
                    txtSoLuongMuaSP.Focus();
                    return;
                }
                if (soluongTP == 0)
                {
                    continue;
                }

                HiddenField hidField = dlDanhSachTangPham.Items[i].FindControl("hidMaTangPham") as HiddenField;
                TangPham tangPham = TangPham.LayTangPhamTheoMa(int.Parse(hidField.Value));

                // kiểm tra số lượng tối đa
                if (soluongTP > tangPham.SoLuongToiDa)
                {
                    lblLoiChonTP.Text = "Số lượng tặng phẩm "+ tangPham.TenTangPham+" phải nhỏ hơn hoặc bằng số lượng tối đa.";
                    txtSoLuongTP.Focus();
                    return;
                }
                // kiểm tra số lượng còn lại
                if (soluongTP > tangPham.SoLuongConLai)
                {
                    lblLoiChonTP.Text = "Số lượng tặng phẩm " + tangPham.TenTangPham + " phải nhỏ hơn hoặc bằng số lượng tồn.";
                    txtSoLuongTP.Focus();
                    return;
                }

                ChiTietDonDatHang ctDDH = new ChiTietDonDatHang();
                ctDDH.MaTangPham = tangPham.MaTangPham;
                ctDDH.SoLuong = soluongTP;
                
                tongDiemThuongYC += tangPham.DiemThuongYC*ctDDH.SoLuong;
                // kiểm tra tổng điểm yêu cầu so với điểm thưởng người mua có
                if (tongDiemThuongYC > tongDiemThuong)
                {
                    lblLoiChonTP.Text = "Số điểm thưởng không đủ để chọn.";
                    txtSoLuongTP.Focus();
                    return;
                }

                lstChiTietDDH.Add(ctDDH);
            }
            
            // insert đơn đặt hàng
            DonDatHang donDatHang = new DonDatHang();           
            donDatHang.NgayDat = DateTime.Now;
            donDatHang.SoLuongDat = int.Parse(txtSoLuongMuaSP.Text);
            donDatHang.TrangThai = 1;
            donDatHang.MaKhachHang = (Int32)Session["Id"];
            donDatHang.MaSanPham = g_SanPham.MaSanPham;
            donDatHang.MaDaiLy = int.Parse(dropListDaiLy.SelectedItem.Value);
            donDatHang.ThanhTien = donDatHang.SoLuongDat * g_SanPham.DonGia;
            donDatHang.NgayNhanHang = g_SanPham.ThoiGianBD_NhanHang;
            if (DonDatHang.ThemDonDatHang(donDatHang) > 0)
            {
                panelDatHang.Visible = false;
                string mess = String.Empty;
                // insert chi tiết tặng phẩm
                foreach (ChiTietDonDatHang ctddh in lstChiTietDDH)
                {
                    ctddh.MaDDH = donDatHang.MaDDH;
                    if (ChiTietDonDatHang.ThemChiTietDonDatHang(ctddh, tongDiemThuong) == 0)
                    {
                        mess += TangPham.LayTangPhamTheoMa(ctddh.MaTangPham).TenTangPham + " - ";
                        continue;
                    }
                }
                //kiểm tra xem thêm chi tiết tặng phẩm có bị lỗi hay hông
                if (mess.Length > 0)
                {
                    pnlKetQuaDatHang.Visible = true;
                    lblKetQuaDatHang.Text = "Không thể chọn các tặng phẩm " + mess + " , bạn có thể cập nhật tặng phẩm.";

                }
                else
                {
                    pnlKetQuaDatHang.Visible = true;
                    lblKetQuaDatHang.Text = "Đơn hàng của bạn đã thêm thành công. <br> Ngày nhận sản phẩm của bạn là từ ngày " +
                                    String.Format("{0:D}",g_SanPham.ThoiGianBD_NhanHang) + " đến ngày " + String.Format("{0:D}", g_SanPham.ThoiGianKT_NhanHang);
                                   
                }
            }
            else
            {
                pnlKetQuaDatHang.Visible = true;
                lblKetQuaDatHang.Text = "Đơn đặt hàng của bạn bị lỗi, bạn hãy thử lại.";
            }
        }

        //protected void dlDanhSachTangPham_ItemDataBound(object sender, DataListItemEventArgs e)
        //{            
        //    HiddenField hidField = e.Item.FindControl("hidMaTangPham") as HiddenField;
        //    TextBox txtSoLuongTP = e.Item.FindControl("txtSoLuongMuaTP") as TextBox;
        //    txtSoLuongTP.TextChanged += new EventHandler(txtSoLuongTP_TextChanged);            
        //}

        //void txtSoLuongTP_TextChanged(object sender, EventArgs e)
        //{
        //    ViewState.Add("dlDsTangPham", dlDanhSachTangPham);
        //    throw new NotImplementedException();
        //}

        //private object KiemTraSoLuongTP(HiddenField hidField, TextBox txtSoLuongTP)
        //{
        //    object o = new object();
        //    if (hidField.Value.CompareTo("") == 0)
        //        return o;
        //    int soluongTP = 0;
        //    if (!int.TryParse(txtSoLuongTP.Text, out soluongTP))
        //    {
        //        return o;
        //    }
        //    TangPham tangPham = TangPham.LayTangPhamTheoMa(int.Parse(hidField.Value));
        //    // kiểm tra số lượng tồn
        //    if (soluongTP > tangPham.SoLuongConLai)
        //    {
        //        lblLoiChonTP.Text = "Số tặng phẩm chọn quá số lượng tồn.";
        //        return o;
        //    }
        //    // kiếm tra số lượng tối đa.
        //    if (soluongTP > tangPham.SoLuongToiDa)
        //    {
        //        lblLoiChonTP.Text = "Số tặng phẩm chọn quá số tối đa.";
        //        return o;
        //    }
        //    // kiểm tra điểm thưởng
        //    throw new NotImplementedException();            
        //}

        //protected void dlDanhSachTangPham_ItemCommand(object source, DataListCommandEventArgs e)
        //{
        //    HiddenField hidField = e.Item.FindControl("hidMaTangPham") as HiddenField;
        //    TextBox txtSoLuongTP = e.Item.FindControl("txtSoLuongMuaTP") as TextBox;
        //}

    }
}