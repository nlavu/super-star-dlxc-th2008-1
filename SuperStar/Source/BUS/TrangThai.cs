using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class TrangThai
    {
        #region Member Variables
        int _maTrangThai = int.MinValue;

        string _tenTrangThai = string.Empty;

        #endregion

        #region Properties

        public int MaTrangThai
        {
            get { return _maTrangThai; }
            set { _maTrangThai = value; }
        }

        public string TenTrangThai
        {
            get { return _tenTrangThai; }
            set { _tenTrangThai = value; }
        }
        #endregion

        #region Methods
        /// <summary>
        /// Láy trạng thái theo mã
        /// Thu Hà 1/6/2011
        /// </summary>
        /// <param name="matrangthai"></param>
        /// <returns></returns>
        public static TrangThai LayTrangThaiTheoMa(int matrangthai)
        {
            TrangThai trangThai = new TrangThai();
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@matrangthai", matrangthai));

                DataTable dt = new DataTable();
                dt = SqlDataAccessHelper.ExecuteQuery("spLayTrangThaiTheoMa", lstParams);

                if (dt.Rows.Count > 0)
                {
                    DataRow dtRow = dt.Rows[0];

                    trangThai.MaTrangThai = int.Parse(dtRow["MaTrangThai"].ToString());
                    trangThai.TenTrangThai = dtRow["TrangThai"].ToString();
                    
                }
            }
            catch (Exception e)
            {
                trangThai = new TrangThai();
                throw e;
            }
            return trangThai;
        }

        /// <summary>
        /// Lấy ds trạng thái
        /// Thu Ha
        /// 1/6/2011
        /// </summary>
        /// <returns></returns>
        public static List<TrangThai> LayDSTrangThai()
        {
            List<TrangThai> lstTrangThai = new List<TrangThai>();
            try
            {                

                DataTable dt = new DataTable();
                dt = SqlDataAccessHelper.ExecuteQuery("spLayDSTrangThai");

                foreach( DataRow dtRow in dt.Rows)
                {                   
                    TrangThai trangThai = new TrangThai();
                    trangThai.MaTrangThai = int.Parse(dtRow["MaTrangThai"].ToString());
                    trangThai.TenTrangThai = dtRow["TrangThai"].ToString();
                    lstTrangThai.Add(trangThai);
                }
            }
            catch (Exception e)
            {
                lstTrangThai = new List<TrangThai>();
                throw e;
            }
            return lstTrangThai;
        }


        #endregion
    }
}
