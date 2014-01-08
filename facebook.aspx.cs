using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facebook;

public partial class facebook : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //var client = new FacebookClient();
        //dynamic me = client.Get("totten");
        //Response.Write(me.first_name + "<br/>");
        //var accessToken = "CAAK94iiuEo4BAO5bJ03H0qfYmfxjZCDdQuDLUyM14xOFDdADGt5ue2iZBPIjObIx0J3ZC8qrdRN5OzmKvvQ65asnc1oHGoMtq99PUWlgsWpPcOfeB1bLLvSM8gyrJdAqZBMrjBZCo8IokWamOsGb0ZBJ5brD5OwODKWZCZAFy6s1ZBdNp4DKIBUFYtrE7V4v7WQ4PNB259tEsAAZDZD";
        //var client = new FacebookClient(accessToken);
        //dynamic me = client.Get("me");
        //string aboutMe = me.first_name;
        //if (Session["AccessToken"] != null)
        //{
        //    var accessToken = Session["AccessToken"].ToString();
        //    var client = new FacebookClient(accessToken);
        //    dynamic result = client.Get("me", new { fields = "name,id" });
        //    string name = result.name;
        //    string id = result.id;
        //    Response.Write(name + " and id " + id); 
        ////}
        //if (Request["code"] != null)
        //{
        //    string code = Request["code"].ToString();
        //    foreach (string str in code.Split('&'))
        //    {
        //        string tmp = str.Substring(0,str.IndexOf('='));
        //        if (tmp == "access_token")
        //        {
        //            Response.Write(str.Substring(str.IndexOf('=')+1,str.Length - str.IndexOf('=')-1));
        //        }
        //    }
           
        //}
        if(!IsPostBack)
        {
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string client_id = "771728996176526";
        string url = Request.Url.AbsoluteUri;
        Response.Redirect(String.Format("https://www.facebook.com/dialog/oauth?client_id={0}&redirect_uri={1}&scope=email",client_id,url));
    }

//public class FacebookLogin : IHttpHandler, System.Web.SessionState.IRequiresSessionState
//{

//    public void ProcessRequest(HttpContext context)
//    {
//        var accessToken = context.Request["accessToken"];
//        context.Session["AccessToken"] = accessToken;

//        context.Response.Redirect("/MyUrlHere");
//    }

    
}