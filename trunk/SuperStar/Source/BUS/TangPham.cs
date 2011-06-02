using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class TangPham
    {
        #region properties
        int maTangPham = int.MinValue;
        string tenTangPham = String.Empty;
        int diemThuongYC = int.MinValue;
        int soLuongTP = int.MinValue;
        int soLuongToiDa = int.MinValue;
        int soLuongConLai = int.MinValue;
        int maSanPham = int.MinValue;
        string hinhAnh = String.Empty;

        public string HinhAnh
        {
            get { return hinhAnh; }
            set { hinhAnh = value; }
        }
        public int MaSanPham
        {
            get { return maSanPham; }
            set { maSanPham = value; }
        }
        
        public int SoLuongConLai
        {
            get { return soLuongConLai; }
            set { soLuongConLai = value; }
        }       

        public int SoLuongToiDa
        {
            get { return soLuongToiDa; }
            set { soLuongToiDa = value; }
        }
        
        public int SoLuongTP
        {
            get { return soLuongTP; }
            set { soLuongTP = value; }
        }       

        public int DiemThuongYC
        {
            get { return diemThuongYC; }
            set { diemThuongYC = value; }
        }

        public string TenTangPham
        {
            get { return tenTangPham; }
            set { tenTangPham = value; }
        }

        public int MaTangPham
        {
            get { return maTangPham; }
            set { maTangPham = value; }
        }   
        #endregion
        #region method
        /// <summary>
        /// Thêm tặng phẩm
        /// Thu Hà - 27/5/2011
        /// </summary>
        /// <param name="tangPhamDto"></param>
        /// <returns></returns>
        public static int ThemTangPham(TangPham tangPhamDto)
        {
            int res = 0;
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@tentangpham", tangPhamDto.TenTangPham));
                lstParam.Add(new SqlParameter("@diemthuongyc", tangPhamDto.DiemThuongYC));
                lstParam.Add(new SqlParameter("@soluongtp",tangPhamDto.SoLuongTP));
                lstParam.Add(new SqlParameter("@soluongtoida",tangPhamDto.SoLuongToiDa));
                lstParam.Add(new SqlParameter("@soluongconlai",tangPhamDto.SoLuongConLai));
                lstParam.Add(new SqlParameter("@masanpham",tangPhamDto.MaSanPham));
                lstParam.Add(new SqlParameter("@hinhanh",tangPhamDto.HinhAnh));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spThemTangPham", lstParam);
            }
            catch 
            {
                return 0;
            }
            return res;
        }
        /// <summary>
        /// Xóa tặng phẩm
        /// Thu Hà  : 27/5/2011
        /// edit    : 28/5/2011
        /// </summary>        
        /// <returns></returns>	
        public static int XoaTangPham(int maTangPham)
        {
            int res = 0;
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@matangpham", maTangPham));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spXoaTangPham", lstParam);
            }
            catch
            {
                return 0;
            }
            return res;
        }
        /// <summary>
        /// Cập nhật tặng phẩm
        /// Thu Hà  : 27/5/2011
        /// </summary>
        /// <returns></returns>
        public int CapNhatTangPham()
        {
            int res = 0;
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@matangpham", this.MaTangPham));
                lstParam.Add(new SqlParameter("@tentangpham", this.TenTangPham));
                lstParam.Add(new SqlParameter("@diemthuongyc", this.DiemThuongYC));
                lstParam.Add(new SqlParameter("@soluongtp", this.SoLuongTP));
                lstParam.Add(new SqlParameter("@soluongtoida", this.SoLuongToiDa));
                lstParam.Add(new SqlParameter("@soluongconlai", this.SoLuongConLai));
                lstParam.Add(new SqlParameter("@masanpham", this.MaSanPham));
//                lstParam.Add(new SqlParameter("@hinhanh", this.HinhAnh));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spCapNhatTangPham", lstParam);
            }
            catch
            {
                return 0;
            }
            return res;
        }
        /// <summary>
        /// Lấy ds tặng phẩm theo mã sản phẩm
        /// Thu Hà  : 27/5/2011
        /// </summary>
        /// <param name="maSP">Mã sản phẩm</param>
        /// <returns></returns>	
        public static List<TangPham> LayDSTangPhamTheoMaSP(int maSP)
        {
            List<TangPham> lstTangPham = new List<TangPham>();
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@masanpham", maSP));
                
                DataTable dt = new DataTable();
                dt = SqlDataAccessHelper.ExecuteQuery("spLayDSTangPhamTheoMaSP", lstParam);

                foreach (DataRow dtRow in dt.Rows)
                {
                    TangPham tangPham = new TangPham();
                    tangPham.MaTangPham = int.Parse(dtRow["MaTangPham"].ToString());
                    tangPham.TenTangPham = dtRow["TenTangPham"].ToString();
                    tangPham.SoLuongTP = int.Parse(dtRow["SoLuongTP"].ToString());
                    tangPham.SoLuongToiDa = int.Parse(dtRow["SoLuongToiDa"].ToString());
                    tangPham.SoLuongConLai = int.Parse(dtRow["SoLuongConLai"].ToString());
                    tangPham.DiemThuongYC = int.Parse(dtRow["DiemThuongYC"].ToString());
                    tangPham.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    tangPham.HinhAnh = dtRow["HinhAnh"].ToString();

                    lstTangPham.Add(tangPham);
                }
            }
            catch
            {
                lstTangPham = new List<TangPham>();
            }
            return lstTangPham;
        }
        /// <summary>
        /// Lấy tặng phẩm theo mã TP
        /// Thu Hà  : 27/5/2011
        /// </summary>
        /// <param name="maTP"></param>
        /// <returns></returns>	
        public static TangPham LayTangPhamTheoMa(int maTP)
        {
            TangPham tangPham = new TangPham();
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@matangpham",maTP));

                DataTable dt = new DataTable();
                dt = SqlDataAccessHelper.ExecuteQuery("spLayTangPhamTheoMaTP", lstParam);

                if (dt.Rows.Count > 0)
                {
                    DataRow dtRow = dt.Rows[0];

                    tangPham.MaTangPham = int.Parse(dtRow["MaTangPham"].ToString());
                    tangPham.TenTangPham = dtRow["TenTangPham"].ToString();
                    tangPham.SoLuongTP = int.Parse(dtRow["SoLuongTP"].ToString());
                    tangPham.SoLuongToiDa = int.Parse(dtRow["SoLuongToiDa"].ToString());
                    tangPham.SoLuongConLai = int.Parse(dtRow["SoLuongConLai"].ToString());
                    tangPham.DiemThuongYC = int.Parse(dtRow["DiemThuongYC"].ToString());
                    tangPham.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    tangPham.HinhAnh = dtRow["HinhAnh"].ToString();
                }
            }
            catch
            {
                tangPham = new TangPham();
            }
            return tangPham;
        }
        #endregion
    }
}
