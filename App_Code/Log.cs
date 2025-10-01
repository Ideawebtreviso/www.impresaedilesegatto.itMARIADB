using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;

/// <summary>
/// Summary description for log
/// </summary>
public class log
{
    private static FileStream fs1 = null;
    private static StreamWriter sw1 = null;
    private static Boolean enabled = Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["LogFileEnabled"]);

    private log() {}

    public static void lg(string log)
    {
        return;
        if (enabled == true) {
            // if solo per l'apertura del log la prima volta
            if (fs1 == null) {
                String logFileName = HttpContext.Current.Server.MapPath(System.Configuration.ConfigurationManager.AppSettings["LogFile"].ToString());

                fs1 = new FileStream(logFileName, FileMode.Append);
                sw1 = new StreamWriter(fs1);
                Console.SetOut(sw1);
                Console.WriteLine("Apertura Log");
            }
            // log ogni volta che viene chiamato
            Console.WriteLine(DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss.fff: ") + log);
            sw1.Flush();
            //sw1.Close();
            //fs1.Close();
        }
    }

    public static void log2(string log) {
        if (enabled == true) {
            String logFileName = HttpContext.Current.Server.MapPath(System.Configuration.ConfigurationManager.AppSettings["LogFile"].ToString());

            using (System.IO.StreamWriter fs = new System.IO.StreamWriter(logFileName, true)) {
                if (log == "") fs.WriteLine("");
                else if (log == "\n") fs.WriteLine("\n");
                else fs.WriteLine(DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss.fff: ") + log);

                fs.Flush();
                fs.Close();
            }
        }
    }
    public static void clear() {
        if (enabled == true) {
            String logFileName = HttpContext.Current.Server.MapPath(System.Configuration.ConfigurationManager.AppSettings["LogFile"].ToString());

            FileInfo fi = new FileInfo(logFileName);
            using (TextWriter txtWriter = new StreamWriter(fi.Open(FileMode.Truncate))) {
                txtWriter.Write("Azzerato il log in data " + DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss.fff") + "\n");
            }
        }
    }

}
