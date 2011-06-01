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
    public partial class ucThemTangPham : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int DaDangNhap = (Int32)Session["IsLogin"];
            string Authentication = (string)Session["Authentication"];
            if (DaDangNhap == 0 || Authentication.CompareTo("QuanLy") != 0)
            {
                pnlThongBao.Visible = true;
                lblThongBao.Text = "Bạn không đủ quyền truy cập vào khu vực này.";
                hpRedirect.Text = "Click vào đây để về trang chủ";
                hpRedirect.NavigateUrl = "~/Index.aspx";
                return;
            }
            else
            {
                pnlThongBao.Visible = false;

                List<SanPham> lstSanPham = SanPham.LayDsSanPhamConThoiHanMuaVaConHang();

                this.dropSanPham.DataValueField = "MaSanPham";
                this.dropSanPham.DataTextField = "TenSanPham";
                this.dropSanPham.DataSource = lstSanPham;
                this.dropSanPham.DataBind();
            }
        }

        protected void btnThemTangPham_Click(object sender, EventArgs e)
        {
            TangPham tangPham = new TangPham();

            tangPham.MaSanPham = int.Parse(dropSanPham.SelectedItem.Value);
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
                if (fileUploadTP.PostedFile.FileName == "")
                    savePath += "gift-icon.gif";
                fileUploadTP.PostedFile.SaveAs(savePath);
                tangPham.HinhAnh = xmlPath.InnerText.Trim() + fileUploadTP.PostedFile.FileName;
            }
            else
            {
                tangPham.HinhAnh = "~/image-gift/gift-icon.gif";
            }

            if (TangPham.ThemTangPham(tangPham) != 0)
            {
                pnlThongBao.Visible = true;
                lblThongBao.Text = "Thêm tặng phẩm thành công. Bạn có thể tiếp tục thêm tặng phẩm khác";
            }
            else
            {
                pnlThongBao.Visible = true;
                lblThongBao.Text = "Thêm tặng phẩm thất bại. Bạn có thể thử lại";
            }

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

        protected void btnHuy_Click(object sender, EventArgs e)
        {
            Response.Redirect("TrangCaNhan.aspx");
        }
    }
}