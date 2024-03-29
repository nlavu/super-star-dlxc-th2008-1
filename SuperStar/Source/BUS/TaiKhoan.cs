﻿using System;
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

        public int MaTaiKhoan
        {
            get { return intMaTaiKhoan; }
            set { intMaTaiKhoan = value; }
        }

        public string TenTaiKhoan
        {
            get { return strTenTaiKhoan; }
            set { strTenTaiKhoan = value; }
        }

        public string MatKhau
        {
            get { return strMatKhau; }
            set { strMatKhau = value; }
        }

        public string AnhDaiDien
        {
            get { return strAnhDaiDien; }
            set { strAnhDaiDien = value; }
        }

        public int LoaiTK
        {
            get { return intLoaiTK; }
            set { intLoaiTK = value; }
        }

        #endregion

        #region method

        /// <summary>
        /// Thêm Tài Khoản : Vũ
        /// </summary>
        /// <returns></returns>
        public static int ThemTaiKhoan(TaiKhoan taiKhoan)
        {
            int res;
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@tentaikhoan", taiKhoan.TenTaiKhoan));
                lstParams.Add(new SqlParameter("@matkhau", taiKhoan.MatKhau));
                lstParams.Add(new SqlParameter("@anhdaidien", taiKhoan.AnhDaiDien));
                lstParams.Add(new SqlParameter("@loaitk", taiKhoan.LoaiTK));
                res = SqlDataAccessHelper.ExecuteNoneQuery("spThemTaiKhoan", lstParams);

            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }

        public static int CapNhatLoaiTaiKhoan(int maTaiKhoan, int loaiTaiKhoan)
        {
            int res;
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                
                lstParams.Add(new SqlParameter("@mataikhoan", maTaiKhoan));
                lstParams.Add(new SqlParameter("@loaitk", loaiTaiKhoan));
                res = SqlDataAccessHelper.ExecuteNoneQuery("spCapNhatLoaiTaiKhoan", lstParams);

            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }


        /// <summary>
        /// Lấy thông tin tài khoản theo mã tài khoản  : Vũ
        /// </summary>
        /// <param name="intMaTaiKhoan"></param>
        /// <returns></returns>
        public static TaiKhoan LayThongTinTaiKhoanTheoMaTaiKhoan(int maTaiKhoan)
        {
            TaiKhoan taiKhoan = new TaiKhoan();
            List<SqlParameter> lstParams = new List<SqlParameter>();
            lstParams.Add(new SqlParameter("@mataikhoan", maTaiKhoan));
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


        /// <summary>
        /// Lấy thông tin tài khoản theo teen tài khoản : Vũ
        /// </summary>
        /// <param name="intTenTaiKhoan"></param>
        /// <returns></return>
        public static List<TaiKhoan> LayThongTinTaiKhoanTheoLoaiTaiKhoan(int loaitk)
        {
            List<TaiKhoan> lstTaiKhoan = new List<TaiKhoan>();

            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@loaitk", loaitk));

                DataTable dt = new DataTable();
                dt = SqlDataAccessHelper.ExecuteQuery("spLayDSTaiKhoanTheoLoaiTaiKhoan", lstParams);
                
                foreach (DataRow dr in dt.Rows)
                {
                    TaiKhoan tk = new TaiKhoan();

                    tk.MaTaiKhoan = int.Parse(dr["MaTaiKhoan"].ToString());
                    tk.TenTaiKhoan = dr["TenTaiKhoan"].ToString();
                    tk.MatKhau = (dr["MatKhau"].ToString());
                    tk.AnhDaiDien = dr["AnhDaiDien"].ToString();
                    tk.LoaiTK = int.Parse(dr["LoaiTK"].ToString());

                    lstTaiKhoan.Add(tk);
                }
            }
            catch (Exception e)
            {

            }
            return lstTaiKhoan;
        }

        public static TaiKhoan LayThongTinTaiKhoanTheoTenTaiKhoan(string tenTaiKhoan)
        {
            TaiKhoan taiKhoan = new TaiKhoan();
            List<SqlParameter> lstParams = new List<SqlParameter>();
            lstParams.Add(new SqlParameter("@tentaikhoan", tenTaiKhoan));
            try
            {
                DataTable dtTaiKhoan = new DataTable();
                dtTaiKhoan = SqlDataAccessHelper.ExecuteQuery("spLayTaiKhoanTheoTen", lstParams);

                if (dtTaiKhoan.Rows.Count == 0)
                {
                    return null;
                }
                else
                {
                    DataRow dtRow = dtTaiKhoan.Rows[0];
                    taiKhoan.intMaTaiKhoan = int.Parse(dtRow["MaTaiKhoan"].ToString());
                    taiKhoan.strTenTaiKhoan = dtRow["TenTaiKhoan"].ToString();
                    taiKhoan.strMatKhau = dtRow["MatKhau"].ToString();
                    taiKhoan.strAnhDaiDien = dtRow["AnhDaiDien"].ToString();
                    taiKhoan.intLoaiTK = int.Parse(dtRow["LoaiTK"].ToString());
                }
            }
            catch (Exception e)
            {
                return null;
            }
            return taiKhoan;
        }

        #endregion
        
        
    }
}
