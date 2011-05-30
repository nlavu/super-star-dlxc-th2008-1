using System;
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

namespace SuperStar.Controls
{
    public partial class ucDanhMucSanPham : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DanhMucSanPham danhMucSanPham = new DanhMucSanPham();
            List<DanhMucSanPham> lstDanhMucSanhPham = danhMucSanPham.LayDanhMucSanPham();
            this.grvDanhMucSanPham.DataSource = lstDanhMucSanhPham;
            this.grvDanhMucSanPham.DataBind();
        }
    }
}