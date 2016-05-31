using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace WebApplication13
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://JENNIFERNINE.COM/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetTextStatistics( string paragraph , 
                                         string filter)
        {

            if ((filter == "")||(filter=="undefined"))
            {
                filter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            }

            Dictionary<string, int> dict = new Dictionary<string, int>();

            filter = filter.ToUpper();
            filter = filter.Replace(" ", "");

            //BUILD A ZERO INDEXED FILTER LIST
            for (int i=0 ; i < filter.Length ; i++ )
            {
                //ONLY ADD KEYS IF THEY ARE ALPHA AND DONT ALREADY EXIST
                string key = filter.Substring(i,1).ToUpper();
                if ((!dict.ContainsKey(key))&&( "ABCDEFGHIJKLMNOPQRSTUVWXYZ".IndexOf(key) > -1 )) {
                dict.Add(key , 0);
                }
            }



            string data = paragraph ;
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
                if (d == "")
                {
                    continue;
                }

                string mykey = d.Substring(0, 1).ToUpper();

                if (dict.ContainsKey(mykey)==true)
                {
                    int i = dict[mykey];
                    i++;
                    dict[mykey] = i;
                }
                else
                {
                    dict.Add(mykey, 1);
                }
            }
            string result = "<table>";
            result = result + "<tr><td>[STARTING LETTER]</td><td>[WORD COUNT]</td></tr></tr>";

            foreach (KeyValuePair<string, int> pair in dict) {

                if (filter.ToString().Contains(pair.Key.ToString())  )
                {
                    result = result + "<tr>";
                    result = result + "<td>" + pair.Key.ToString() + "</td><td>" + pair.Value.ToString() + "</td>"; 
                    result = result + "</tr>";
                }

                }

            result = result + "</table>";

            return result;
        }
    }
}
