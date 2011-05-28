using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class KhachHang
    {
        #region Member Variables
        int _maKhachHang = int.MinValue;

        string _hoTen = string.Empty;

        string _diaChi = string.Empty;

        string _email = string.Empty;

        string _soDienThoai = string.Empty;

        #endregion

        #region Properties
        public int MaKhachHang
        {
            get { return _maKhachHang; }
            set { _maKhachHang = value; }
        }

        public string HoTen
        {
            get { return _hoTen; }
            set { _hoTen = value; }
        }

        public string DiaChi
        {
            get { return _diaChi; }
            set { _diaChi = value; }
        }

        public string Email
        {
            get { return _email; }
            set { _email = value; }
        }

        public string SoDienThoai
        {
            get { return _soDienThoai; }
            set { _soDienThoai = value; }
        }
        #endregion

        #region Methods
        /// <summary>
        /// Lấy thông tin khách hàng theo mã
        /// </summary>
        /// <param name="intMaKhachHang"></param>
        /// <returns></returns>
        public static KhachHang LayThongTinKhachHangTheoMa(int intMaKhachHang)
        {
            KhachHang khachHang = new KhachHang();
            try
            {
                DataTable dt = new DataTable();
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@maKhachHang", intMaKhachHang));

                dt = SqlDataAccessHelper.ExecuteQuery("spLayThongTinKhachHangTheoMa", lstParam);

                foreach (DataRow dr in dt.Rows)
                {
                    khachHang._maKhachHang = int.Parse(dr["MaKhachHang"].ToString());
                    khachHang._hoTen = dr["HoTen"].ToString();
                    khachHang._diaChi = dr["DiaChi"].ToString();
                    khachHang._email = dr["Email"].ToString();
                    khachHang._soDienThoai = dr["SoDienThoai"].ToString();
                }
            }

            catch (Exception e)
            {
                khachHang = null;
                throw (e);
            }

            return khachHang;
        }

        /// <summary>
        /// Cập nhật thông tin khách hàng
        /// </summary>
        /// <returns></returns>
        public int CapNhatThongTinTaiKhoanKhachHang()
        {
            int res;
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@makhachhang", this.MaKhachHang));
                lstParam.Add(new SqlParameter("@hoten", this.HoTen));
                lstParam.Add(new SqlParameter("@diachi", this.DiaChi));
                lstParam.Add(new SqlParameter("@email", this.Email));
                lstParam.Add(new SqlParameter("@sodienthoai", this.SoDienThoai));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spCapNhatThongTinTaiKhoanKhachHang", lstParam);
            }
            catch (Exception e)
            {
                throw e;
            }

            return res;
        }
        /// <summary>
        /// Thêm thông tin khách hàng
        /// Thu Hà  : 29/5/2011
        /// </summary>
        /// <returns></returns>
        public static int ThemKhachHang(KhachHang kh)
        {
            int res;
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@makhachhang", kh.MaKhachHang));
                lstParam.Add(new SqlParameter("@hoten", kh.HoTen));
                lstParam.Add(new SqlParameter("@diachi", kh.DiaChi));
                lstParam.Add(new SqlParameter("@email", kh.Email));
                lstParam.Add(new SqlParameter("@sodienthoai", kh.SoDienThoai));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spThemTaiKhoanKhachHang", lstParam);
            }
            catch (Exception e)
            {
                throw e;
            }

            return res;
        }
        #endregion
    }
}
