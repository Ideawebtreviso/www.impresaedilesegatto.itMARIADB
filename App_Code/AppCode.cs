using System.Web;


namespace AppCode {



    public class GetDB {

        //public static string conn1 = "server=localhost; port=7306; user id=root; password=rootroot; database=segattoufficiale; pooling=false;Convert Zero Datetime=True;";
        //public static string conn2 = "server=localhost; port=7306; user id=root; password=rootroot; database=segattodurigon; pooling=false;Convert Zero Datetime=True;";

        //public static string conn1locale = "server=localhost; port=7306; user id=root; password=rootroot; database=segattoufficiale; pooling=false;Convert Zero Datetime=True;";
        //public static string conn2locale = "server=localhost; port=7306; user id=root; password=rootroot; database=segattodurigon; pooling=false;Convert Zero Datetime=True;";

        public static string conn1 = "server=localhost;  user id=root; password=rootroot; database=segattoufficiale; pooling=false;SSL Mode=None;";
        public static string conn2 = "server=localhost; user id=root; password=rootroot; database=segattodurigon; pooling=false;SSL Mode=None;";

        public static string conn1locale = "server=localhost; user id=root; password=rootroot; database=segattoufficiale; pooling=false;SSL Mode=None;";
        public static string conn2locale = "server=localhost; user id=root; password=rootroot; database=segattodurigon; pooling=false;SSL Mode=None;";

        public GetDB() {

        }

        public static string getDDBB(string pwd){

            string fullpathname = HttpContext.Current.Request.Url.Authority.ToLower();
            bool sonoinlocale = fullpathname.Contains("localhost");
            if (sonoinlocale) {
                 if (pwd == "24680ABC") return conn2locale;
                 else return conn1locale;
   
            }
            else { 
                 if (pwd == "24680ABC") return conn2;
                 else return conn1;
   
            }
            
        }

        public static string getDDBBasincrono(string pwd){
            string fullpathname = HttpContext.Current.Request.Url.Authority.ToLower();
            bool sonoinlocale = fullpathname.Contains("localhost");
            
            if (sonoinlocale)  return pwd == "24680ABC" ? conn1locale : conn2locale;
            else return pwd == "24680ABC" ? conn2 : conn1;

        }

    }
}
