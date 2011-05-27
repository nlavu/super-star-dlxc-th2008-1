using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class TaiKhoan : SqlDataAccessHelper
    {
        #region Member Variables

        int intMaTaiKhoan = int.MinValue;

        string strTenTaiKhoan = string.Empty;

        string strMatKhau = string.Empty;

        string strAnhDaiDien = string.Empty;

        int intLoaiTK = int.MinValue;

        #endregion

        #region Properties

        public int IntMaTaiKhoan
        {
            get { return intMaTaiKhoan; }
            set { intMaTaiKhoan = value; }
        }

        public string StrTenTaiKhoan
        {
            get { return strTenTaiKhoan; }
            set { strTenTaiKhoan = value; }
        }

        public string StrMatKhau
        {
            get { return strMatKhau; }
            set { strMatKhau = value; }
        }

        public string StrAnhDaiDien
        {
            get { return strAnhDaiDien; }
            set { strAnhDaiDien = value; }
        }

        public int IntLoaiTK
        {
            get { return intLoaiTK; }
            set { intLoaiTK = value; }
        }

        #endregion

        #region method

        //Thêm Tài Khoản :
        public int ThemTaiKhoan()
        {
            int res;
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@tentaikhoan", strTenTaiKhoan));
                lstParams.Add(new SqlParameter("@matkhau", strMatKhau));
                lstParams.Add(new SqlParameter("@anhdaidien", strAnhDaiDien));
                lstParams.Add(new SqlParameter("@loaitk", intLoaiTK));
                res = SqlDataAccessHelper.ExecuteNoneQuery("spThemTaiKhoan", lstParams);

            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }


        //Lấy thông tin tài khoản theo mã tài khoản
        public TaiKhoan LayThongTinTaiKhoanTheoMaTaiKhoan(int intMaTaiKhoan)
        {
            TaiKhoan taiKhoan = new TaiKhoan();
            List<SqlParameter> lstParams = new List<SqlParameter>();
            lstParams.Add(new SqlParameter("@mataikhoan", intMaTaiKhoan));
            try
            {
                DataTable dtTaiKhoan = new DataTable();
                dtTaiKhoan = SqlDataAccessHelper.ExecuteQuery("spLayTaiKhoanTheoMa", lstParams);
                foreach(DataRow dtRow in dtTaiKhoan.Rows)
                {
                    taiKhoan.intMaTaiKhoan = int.Parse(dtRow["MaTaiKhoan"].ToString());
                    taiKhoan.strTenTaiKhoan = dtRow["TenTaiKhoan"].ToString();
                    taiKhoan.strMatKhau = dtRow["MatKhau"].ToString();
                    taiKhoan.strAnhDaiDien = dtRow["AnhDaiDien"].ToString();
                    taiKhoan.intLoaiTK = int.Parse(dtRow["LoaiTK"].ToString());
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return taiKhoan;
        }


        //Lấy thông tin tài khoản theo teen tài khoản
        public TaiKhoan LayThongTinTaiKhoanTheoTenTaiKhoan(int intTenTaiKhoan)
        {
            TaiKhoan taiKhoan = new TaiKhoan();
            List<SqlParameter> lstParams = new List<SqlParameter>();
            lstParams.Add(new SqlParameter("@tentaikhoan", intMaTaiKhoan));
            try
            {
                DataTable dtTaiKhoan = new DataTable();
                dtTaiKhoan = SqlDataAccessHelper.ExecuteQuery("spLayTaiKhoanTheoTen", lstParams);
                foreach(DataRow dtRow in dtTaiKhoan.Rows)
                {
                    taiKhoan.intMaTaiKhoan = int.Parse(dtRow["MaTaiKhoan"].ToString());
                    taiKhoan.strTenTaiKhoan = dtRow["TenTaiKhoan"].ToString();
                    taiKhoan.strMatKhau = dtRow["MatKhau"].ToString();
                    taiKhoan.strAnhDaiDien = dtRow["AnhDaiDien"].ToString();
                    taiKhoan.intLoaiTK = int.Parse(dtRow["LoaiTK"].ToString());
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return taiKhoan;
        }

        #endregion
    }
}
