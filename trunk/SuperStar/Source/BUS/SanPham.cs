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
        /// <summary>
        /// Thêm sản phẩm
        /// Minh Đức - 28/5/2011
        /// </summary>
        /// <param name="sp"></param>
        /// <returns></returns>
        public static int ThemSanPham(SanPham sp)
        {
            int res = 0;
            try
            {
                int maSanPham = 0;
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

                SqlParameter param = new SqlParameter("@masanpham", maSanPham);
                param.Direction = ParameterDirection.Output;
                lstParam.Add(param);

                if (SqlDataAccessHelper.ExecuteNoneQuery("spThemSanPham", lstParam) > 0)
                {
                    res = int.Parse(param.Value.ToString());
                }
            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }

            return res;
        }

        /// <summary>
        /// Lấy sản phẩm theo mã
        /// Minh Đức - 28/5/2011
        /// </summary>
        /// <param name="masanpham"></param>
        /// <returns></returns>
        public static SanPham LaySanPhamTheoMa(int masanpham)
        {
            SanPham sp = new SanPham();
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@masanpham", masanpham));

                DataTable dt = SqlDataAccessHelper.ExecuteQuery("spLaySanPhamTheoMa", lstParam);

                DataRow dr = dt.Rows[0];

                sp.MaSanPham = int.Parse(dr["MaSanPham"].ToString());
                sp.HinhAnh = dr["HinhAnh"].ToString();
                sp.DiemThuong = int.Parse(dr["DiemThuong"].ToString());
                sp.DonGia = float.Parse(dr["DonGia"].ToString());
                sp.MaDanhMuc = int.Parse(dr["MaDanhMuc"].ToString());
                sp.MaNguoiNhap = int.Parse(dr["MaNguoiNhap"].ToString());
                sp.SoLuongSP = int.Parse(dr["SoLuongSP"].ToString());
                sp.SoLuongTon = int.Parse(dr["SoLuongTon"].ToString());
                sp.TenSanPham = dr["TenSanPham"].ToString();
                sp.ThoiGianBD_Ban = DateTime.Parse(dr["ThoiGianBD_Ban"].ToString());
                sp.ThoiGianKT_Ban = DateTime.Parse(dr["ThoiGianKT_Ban"].ToString());
                sp.ThongTinChiTiet = dr["ThongTinChiTiet"].ToString();

                DateTime result;
                if (DateTime.TryParse(dr["ThoiGianBD_NhanHang"].ToString(), out result))
                    sp.ThoiGianBD_NhanHang = DateTime.Parse(dr["ThoiGianBD_NhanHang"].ToString());
                else
                    sp.ThoiGianBD_NhanHang = DateTime.Parse("1/1/1900");

                if (DateTime.TryParse(dr["ThoiGianKT_NhanHang"].ToString(), out result))
                    sp.ThoiGianKT_NhanHang = DateTime.Parse(dr["ThoiGianKT_NhanHang"].ToString());
                else
                    sp.ThoiGianKT_NhanHang = DateTime.Parse("1/1/1900");

            }
            catch (Exception e)
            {
                throw e;
            }

            return sp;
        }

        /// <summary>
        /// Xóa sản phẩm
        /// Minh Đức - 28/5/2011
        /// </summary>
        /// <param name="masanpham"></param>
        /// <returns></returns>
        public static int XoaSanPham(int masanpham)
        {
            int res;
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@masanpham", masanpham));
                res = SqlDataAccessHelper.ExecuteNoneQuery("spXoaSanPham", lstParam);
            }
            catch (Exception e)
            {
                res = -1;
                throw e;
            }
            return res;
        }
        /// <summary>
        /// Cập nhật số lượng ban đầu của sản phẩm
        /// Minh Đức    : 28/5/2011
        /// </summary>
        /// <param name="soluongsp"></param>
        /// <returns></returns>
        public int CapNhatSoLuongBanDau(int soluongsp)
        {
            int res;
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@masanpham", this.MaSanPham));
                lstParams.Add(new SqlParameter("@soluongsp", soluongsp));
                res = SqlDataAccessHelper.ExecuteNoneQuery("spCapNhatSoLuongBanDauSP", lstParams);
            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }

        /// <summary>
        /// Lấy danh sách sản phẩm
        /// Minh Đức    : 28/5/2011
        /// </summary>
        /// <param name="spName">tên rpocedure</param>
        /// <returns></returns>
        public static List<SanPham> LayDsSanPham(string spName)
        {
            List<SanPham> lstSanPham = new List<SanPham>();
            try
            {
                DataTable dt = new DataTable();
                dt = SqlDataAccessHelper.ExecuteQuery(spName);

                foreach (DataRow dr in dt.Rows)
                {
                    SanPham sp = new SanPham();

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
                    else
                        sp.ThoiGianBD_NhanHang = DateTime.Parse("1/1/1900");

                    if (DateTime.TryParse(dr["ThoiGianKT_NhanHang"].ToString(), out result))
                        sp.ThoiGianKT_NhanHang = DateTime.Parse(dr["ThoiGianKT_NhanHang"].ToString());
                    else
                        sp.ThoiGianKT_NhanHang = DateTime.Parse("1/1/1900");

                    lstSanPham.Add(sp);
                }
            }
            catch (Exception e)
            {
                
            }
            return lstSanPham;
        }

        /// <summary>
        /// Lấy danh sách sản phẩm còn thời hạn mua và còn hàng
        /// Minh Đức    : 28/5/2011
        /// </summary>
        /// <param name="spName"></param>
        /// <returns></returns>
        public static List<SanPham> LayDsSanPhamConThoiHanMuaVaConHang()
        {
            return SanPham.LayDsSanPham("spLayDSSanPhamConThoiHanMuaVaConHang");
        }
        /// <summary>
        /// Lấy danh sách sản phẩm hết thời hạn mua hoặc hết hàng
        /// Minh Đức    : 28/5/2011
        /// </summary>
        /// <param name="spName"></param>
        /// <returns></returns>
        public static List<SanPham> LayDsSanPhamHetThoiHanMuaHoacHetHang()
        {
            return SanPham.LayDsSanPham("spLayDSSanPhamHetThoiHanMuaHoacHetHang");
        }

        /// <summary>
        /// Lấy danh sách sản phẩm hot (thời gian bắt đầu bán trong 3 ngày trở lại so với ngày hiện tại)
        /// Minh Đức    : 30/5/2011
        /// </summary>
        /// <returns></returns>
        public static List<SanPham> LayDsSanPhamHot()
        {
            return SanPham.LayDsSanPham("spLayDSSanPhamHot");
        }
        #endregion
    }
}
