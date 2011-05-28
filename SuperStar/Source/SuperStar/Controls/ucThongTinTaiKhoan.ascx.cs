﻿using System;
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

namespace ShoppingHere.Controls
{
    public partial class ucThongTinTaiKhoan : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int iDaDangNhap = (Int32)Session["IsLogin"];
            if (iDaDangNhap == 0)
            {
                panelThongTinTaiKhoan.Visible = false;
            }
            else
            {
                int IDUser = (Int32)Session["Id"];
                TaiKhoan taiKhoan = new TaiKhoan();
                taiKhoan = TaiKhoan.LayThongTinTaiKhoanTheoMaTaiKhoan(IDUser);

                lblTenTaiKhoan.Text = taiKhoan.TenTaiKhoan;
                lblMaTaiKhoan.Text = taiKhoan.MaTaiKhoan.ToString();
                if (taiKhoan.LoaiTK == 0)
                    lblLoaiTaiKhoan.Text = "Admin";
                if (taiKhoan.LoaiTK == 1)
                    lblLoaiTaiKhoan.Text = "Quản Lý";
                if (taiKhoan.LoaiTK == 2)
                    lblLoaiTaiKhoan.Text = "Đại Lý";
                if(taiKhoan.LoaiTK == 3)
                    lblLoaiTaiKhoan.Text = "Khách Hàng";
            }
        }

        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session["IsLogin"] = 0;
            Session["Id"] = 0;
            Session["Username"] = "username";
            Response.Redirect("Index.aspx");   
        }
    }
}