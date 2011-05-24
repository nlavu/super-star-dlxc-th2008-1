using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Xml.Linq;

namespace ShoppingHere
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            //trạng thái đăng nhập
            Session["IsLogin"] = 0;
            // id user
            Session["Id"] = 0;
            // tên đăng nhập
            Session["Username"] = "username";
            // quyền truy xuất
            Session["Authentication"] = "KhachHang";            
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {
            //trạng thái đăng nhập
            Session["IsLogin"] = 0;
        }
    }
}