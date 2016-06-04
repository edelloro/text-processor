using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text.RegularExpressions;



namespace WebApplication13
{
    /// <summary>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    /// Summary description for WebService1                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    /// </summary>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {

        public class JSONMessage
        {
            private string _key = "";
            private string _payload = "";
            private string _errorMsg = "";

            public string key
            {
                get
                {
                    return _key;
                }
                set
                {
                    _key = value;
                }
            }


            public string payload
            {
                get
                {
                    return _payload;
                }
                set
                {
                    _payload = value;
                }
            }

            public string errorMsg
            {
                get
                {
                    return _errorMsg;
                }
                set
                {
                    _errorMsg = value;
                }
            }

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void HelloJson()
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            JSONMessage p = new JSONMessage();
            p.payload = "eric";
            p.errorMsg = "";
            var retval = js.Serialize(p);
            Context.Response.Write(retval);
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public JSONMessage HelloWorldWithJson(string name)
        {
            JSONMessage p = new JSONMessage();
            p.payload = "test data";
            p.errorMsg = "";
            return p;
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public JSONMessage GetZorkText()
        {
            JSONMessage msg = new JSONMessage();
            string filename = "ZorkI.txt";

            try
            {
                string tmpData = System.IO.File.ReadAllText(Server.MapPath("~/SAMPLEDATA/" + filename));
                tmpData = tmpData.Replace("/r", " ").Replace("/n", " ");
                tmpData = tmpData.Replace("  ", " ").Replace("  ", " ");
                msg.payload = tmpData;
                msg.errorMsg = "";
            }
            catch (Exception ex)
            {
                msg.payload = "AN ERROR OCCURRED LOADING THE DATAFILE [" + filename + "]";
                msg.errorMsg = ex.Message.ToString();
            }
            return msg;
        }



        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<JSONMessage> GetTextStatistics(string paragraph, string filter)
        {

            paragraph = HttpContext.Current.Server.UrlDecode(paragraph);
            filter = HttpContext.Current.Server.UrlDecode(filter);

            List<JSONMessage> msglist = new List<JSONMessage>();

            if ((filter == "") || (filter == "undefined"))
            {
                filter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            }

            Dictionary<string, int> dict = new Dictionary<string, int>();

            //THE FILTER IS UPPERCASE
            filter = filter.ToUpper();
            //THE FILTER HAS NO SPACES
            filter = filter.Replace(" ", "");

            //BUILD A ZERO INDEXED FILTER LIST                                                                                                                                                                                                                                                                                                                                                                                                                                                  
            for (int i = 0; i < filter.Length; i++)
            {
                //ONLY ADD KEYS IF THEY ARE ALPHA AND DONT ALREADY EXIST                                                                                                                                                                                                                                                                                                                                                                                                                        
                string key = filter.Substring(i, 1).ToUpper();
                if ((!dict.ContainsKey(key)) && ("ABCDEFGHIJKLMNOPQRSTUVWXYZ".IndexOf(key) > -1))
                {
                    dict.Add(key, 0);
                }
            }



            string data = paragraph;
            //DEFENSIVE CODING INCASE THERE WAS MULTIPLE SPACES
            while (data.IndexOf("  ") > -1)
            {
                data = data.Replace("  ", " ");
            }
            data = data.Trim();
            string[] dataArray = data.Split(' ');

            foreach (string d in dataArray)
            {
                //SKIP EMPTY STRING
                if (d == string.Empty)
                {
                    continue;
                }

                string mykey = d.Substring(0, 1).ToUpper();

                if (dict.ContainsKey(mykey) == true)
                {
                    dict[mykey]++;
                }
                else
                {
                    dict.Add(mykey, 1);
                }
            }

            foreach (KeyValuePair<string, int> pair in dict)
            {
                if (filter.ToString().Contains(pair.Key.ToString()))
                {
                    JSONMessage msg = new JSONMessage();
                    msg.key = pair.Key.ToString();
                    msg.payload = pair.Value.ToString();
                    msglist.Add(msg);
                }
            }
            return msglist;
        }
    }
}
