using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class SanPham
    {
        #region Member Variables
        int _maSanPham = int.MinValue;

        string _tenSanPham = string.Empty;

        int _soLuongSP = int.MinValue;

        int _soLuongTon = int.MinValue;

        float _donGia = float.MinValue;

        int _diemThuong = int.MinValue;

        DateTime _thoiGianBD_Ban = DateTime.Now;

        DateTime _thoiGianKT_Ban = DateTime.Now;

        DateTime _thoiGianBD_NhanHang = DateTime.Now;

        DateTime _thoiGianKT_NhanHang = DateTime.Now;

        int _maNguoiNhap = int.MinValue;

        int _maDanhMuc = int.MinValue;

        string _hinhAnh = string.Empty;

        string _thongTinChiTiet = string.Empty;

        #endregion

        #region Properties

        public int MaSanPham
        {
            get { return _maSanPham; }
            set { _maSanPham = value; }
        }

        public string TenSanPham
        {
            get { return _tenSanPham; }
            set { _tenSanPham = value; }
        }

        public int SoLuongSP
        {
            get { return _soLuongSP; }
            set { _soLuongSP = value; }
        }

        public int SoLuongTon
        {
            get { return _soLuongTon; }
            set { _soLuongTon = value; }
        }

        public float DonGia
        {
            get { return _donGia; }
            set { _donGia = value; }
        }

        public int DiemThuong
        {
            get { return _diemThuong; }
            set { _diemThuong = value; }
        }

        public DateTime ThoiGianBD_Ban
        {
            get { return _thoiGianBD_Ban; }
            set { _thoiGianBD_Ban = value; }
        }

        public DateTime ThoiGianKT_Ban
        {
            get { return _thoiGianKT_Ban; }
            set { _thoiGianKT_Ban = value; }
        }

        public DateTime ThoiGianBD_NhanHang
        {
            get { return _thoiGianBD_NhanHang; }
            set { _thoiGianBD_NhanHang = value; }
        }

        public DateTime ThoiGianKT_NhanHang
        {
            get { return _thoiGianKT_NhanHang; }
            set { _thoiGianKT_NhanHang = value; }
        }

        public int MaNguoiNhap
        {
            get { return _maNguoiNhap; }
            set { _maNguoiNhap = value; }
        }

        public int MaDanhMuc
        {
            get { return _maDanhMuc; }
            set { _maDanhMuc = value; }
        }

        public string HinhAnh
        {
            get { return _hinhAnh; }
            set { _hinhAnh = value; }
        }

        public string ThongTinChiTiet
        {
            get { return _thongTinChiTiet; }
            set { _thongTinChiTiet = value; }
        }
        #endregion

        #region Medthods
        public static int ThemSanPham(SanPham sp)
        {
            int res;
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@tensanpham", sp.TenSanPham));
                lstParam.Add(new SqlParameter("@soluongsp", sp.SoLuongSP));
                lstParam.Add(new SqlParameter("@soluongton", sp.SoLuongTon));
                lstParam.Add(new SqlParameter("@dongia", sp.DonGia));
                lstParam.Add(new SqlParameter("@diemthuong", sp.DiemThuong));
                lstParam.Add(new SqlParameter("@thoigianbd_ban", sp.ThoiGianBD_Ban));
                lstParam.Add(new SqlParameter("@thoigiankt_ban", sp.ThoiGianKT_Ban));
                lstParam.Add(new SqlParameter("@thoigianbd_nhanhang", sp.ThoiGianBD_NhanHang));
                lstParam.Add(new SqlParameter("@thoigiankt_nhanhang", sp.ThoiGianKT_NhanHang));
                lstParam.Add(new SqlParameter("@manguoinhap", sp.MaNguoiNhap));
                lstParam.Add(new SqlParameter("@madanhmuc", sp.MaDanhMuc));
                lstParam.Add(new SqlParameter("@hinhanh", sp.HinhAnh));
                lstParam.Add(new SqlParameter("@thongtinchitiet", sp.ThongTinChiTiet));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spThemSanPham", lstParam);
            }
            catch (Exception e)
            {
                res = -1;
                throw e;
            }

            return res;
        }

        public static SanPham LaySanPhamTheoMa(int masanpham)
        {
            SanPham sp = new SanPham();
            try
            {
                SqlParameter param = new SqlParameter("@masanpham", masanpham);

                DataTable dt = SqlDataAccessHelper.ExecuteQuery("spLaySanPhamTheoMa", param);

                DataRow dr = dt.Rows[0];

                sp.MaSanPham = int.Parse(dr["MaSanPham"].ToString());
                sp.HinhAnh = dr["HinhAnh"].ToString();
                sp.DiemThuong = int.Parse(dr["DiemThuong"].ToString());
                sp.DonGia = float.Parse(dr["DonGia"].ToString());
                sp.MaDanhMuc = int.Parse(dr["MaDanhMuc"].ToString());
                sp.MaNguoiNhap = int.Parse(dr["MaNguoiNhap"].ToString());
                sp.SoLuongSP = int.Parse(dr["MaSanPham"].ToString());
                sp.SoLuongTon = int.Parse(dr["SoLuongTon"].ToString());
                sp.TenSanPham = dr["TenSanPham"].ToString();
                sp.ThoiGianBD_Ban = DateTime.Parse(dr["ThoiGianBD_Ban"].ToString());
                sp.ThoiGianKT_Ban = DateTime.Parse(dr["ThoiGianKT_Ban"].ToString());
                sp.ThongTinChiTiet = dr["ThongTinChiTiet"].ToString();

                DateTime result;
                if (DateTime.TryParse(dr["ThoiGianBD_NhanHang"].ToString(), out result))
                    sp.ThoiGianBD_NhanHang = DateTime.Parse(dr["ThoiGianBD_NhanHang"].ToString());
                if (DateTime.TryParse(dr["ThoiGianKT_NhanHang"].ToString(), out result))
                    sp.ThoiGianKT_NhanHang = DateTime.Parse(dr["ThoiGianKT_NhanHang"].ToString());

            }
            catch (Exception e)
            {
            }

            return sp;
        }
        #endregion
    }
}
