using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace InstaPhotos
{
    public partial class Default : System.Web.UI.Page
    {
        static string code = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request["code"]) &&  !Page.IsPostBack)
            {
                code = Request["code"].ToString();
                GetInstagramToken();
            }
        }

        public void GetInstagramToken()
        {
            var json = "";
            try
            {
                NameValueCollection parameters = new NameValueCollection();
                parameters.Add("client_id", ConfigurationManager.AppSettings["instagram.clientid"].ToString());
                parameters.Add("client_secret", ConfigurationManager.AppSettings["instagram.clientsecret"].ToString());
                parameters.Add("grant_type", "authorization_code");
                parameters.Add("redirect_uri", ConfigurationManager.AppSettings["instagram.redirecturl"].ToString());
                parameters.Add("code", code);
                WebClient client = new WebClient();
                var result = client.UploadValues("https://api.instagram.com/oauth/access_token", "POST", parameters);
                var response = System.Text.Encoding.Default.GetString(result);
                var jsResult = (JObject)JsonConvert.DeserializeObject(response);
                string accessToken = (string)jsResult["access_token"];
                int id = (int)jsResult["user"]["id"];
                Page.ClientScript.RegisterStartupScript(this.GetType(), "GetToken", "<script>var instagramaccessid=\"" + @"" + id + "" + "\"; var instagramaccesstoken=\"" + @"" + accessToken + "" + "\";</script>");
            }
            catch (Exception ex)
            {
                throw new Exception("Bad Request");
            }
        }
    }
}