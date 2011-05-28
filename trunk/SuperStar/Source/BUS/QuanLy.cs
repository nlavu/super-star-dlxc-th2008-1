using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class QuanLy
    {
        #region Member Variables
        int _maQuanLy = int.MinValue;

        string _hoTen = string.Empty;

        string _diaChi = string.Empty;

        string _email = string.Empty;

        string _soDienThoai = string.Empty;

        #endregion

        #region Properties

        public int MaQuanLy
        {
            get { return _maQuanLy; }
            set { _maQuanLy = value; }
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
        ///hàm thêm, xóa, sửa
        public int CapNhatThongTinTaiKhoanQuanLy()
        {
            int res;
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@maquanly", this.MaQuanLy));
                lstParam.Add(new SqlParameter("@hoten", this.HoTen));
                lstParam.Add(new SqlParameter("@diachi", this.DiaChi));
                lstParam.Add(new SqlParameter("@email", this.Email));
                lstParam.Add(new SqlParameter("@sodienthoai", this.SoDienThoai));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spCapNhatThongTinTaiKhoanQuanLy", lstParam);
            }
            catch (Exception e)
            {
                throw e;
            }

            return res;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="intMaQuanLy"></param>
        /// <returns></returns>        
        public static QuanLy LayThongTinQuanLyTheoMa(int intMaQuanLy)
        {
            QuanLy QuanLy = new QuanLy();
            try
            {
                DataTable dt = new DataTable();
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@maQuanLy", intMaQuanLy));
                dt = SqlDataAccessHelper.ExecuteQuery("spLayThongTinQuanLyTheoMa", lstParam);

                foreach (DataRow dr in dt.Rows)
                {
                    QuanLy._maQuanLy = int.Parse(dr["MaQuanLy"].ToString());
                    QuanLy._hoTen = dr["HoTen"].ToString();
                    QuanLy._diaChi = dr["DiaChi"].ToString();
                    QuanLy._email = dr["Email"].ToString();
                    QuanLy._soDienThoai = dr["SoDienThoai"].ToString();
                }
            }

            catch (Exception e)
            {
                QuanLy = null;
                throw (e);
            }

            return QuanLy;
        }
        #endregion
    }
}
