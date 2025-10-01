<%@ Application Language="C#" %>

<script runat="server">
    
    void Application_Start(object sender, EventArgs e) 
    {
        string pathdirectoryassoluto = Server.MapPath("public");
        if (!System.IO.Directory.Exists(pathdirectoryassoluto)) System.IO.Directory.CreateDirectory(pathdirectoryassoluto);

        pathdirectoryassoluto = Server.MapPath("public/upload-immagini-gestionale");
        if (!System.IO.Directory.Exists(pathdirectoryassoluto)) System.IO.Directory.CreateDirectory(pathdirectoryassoluto);

        pathdirectoryassoluto = Server.MapPath("public/generazione-pdf-gestionale");
        if (!System.IO.Directory.Exists(pathdirectoryassoluto)) System.IO.Directory.CreateDirectory(pathdirectoryassoluto);

        pathdirectoryassoluto = Server.MapPath("public/gestionale-scansioni");
        if (!System.IO.Directory.Exists(pathdirectoryassoluto)) System.IO.Directory.CreateDirectory(pathdirectoryassoluto);
    }

    void Application_End(object sender, EventArgs e) 
    {
        //  Codice eseguito all\'arresto dell'applicazione
    }

    private bool SonoInLocale()
    {
        String fullpathname = HttpContext.Current.Request.Url.Authority.ToLower();
        return fullpathname.Contains("localhost");
    }
    void Application_BeginRequest(object sender, EventArgs e)
    {
        if (SonoInLocale() == false) {
        
            string url = Request.Url.AbsoluteUri;

            switch (Request.Url.Scheme) {
                case "https":
                    Response.AddHeader("Strict-Transport-Security", "max-age=300");
                    break;
                case "http":
                    var path = "https://" + Request.Url.Host + Request.Url.PathAndQuery;
                    Response.Status = "301 Moved Permanently";
                    Response.AddHeader("Location", path);
                    break;

            }
        }
    }

    void Application_Error(object sender, EventArgs e) 
    {
        if (!SonoInLocale()) {
            //// Codice eseguito in caso di errore non gestito
            //Exception ex = Server.GetLastError();
            //String msg;
            ////INVIO EMAIL IN CASO DI ERRORE 
            //msg = ((HttpException)(ex)).StackTrace;
            //msg += "\r\n";
            //msg += ((HttpException)(ex)).Message;
            //msg += "\r\n";
            //msg += ((HttpException)(ex)).GetHtmlErrorMessage();
            //msg += "\r\n";
            //msg += "PAGINA CHIAMANTE [" + Request.Url.AbsoluteUri + "]";
            //if (ex is HttpException) {
            //    if (((HttpException)(ex)).GetHttpCode() == 404) {
            //        String url = Request.Url.AbsoluteUri.ToLower();
            //        //INVIO MAIL
            //        InviaMail.inviaMail(System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), "WWW.IMPRESAEDILEDEMO.IT SISTEMA", System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), "Errore Pagina non Trovata", msg);
            //        Response.Redirect("~/");
            //    } else if (ex is HttpRequestValidationException) {
            //        Response.Redirect("~/");
            //        return;
            //    } else {
            //        //INVIO MAIL
            //        InviaMail.inviaMail(System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), "WWW.IMPRESAEDILEDEMO.IT SISTEMA", System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), "Errore Http Generico", msg);
            //        Response.Redirect("~/");
            //    }
            //} else {
            //    //INVIO MAIL
            //    InviaMail.inviaMail(System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), " WWW.IMPRESAEDILEDEMO.IT SISTEMA", System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), "Errore Generico", msg);
            //    Response.Redirect("~/");
            //}

            //TUTTI GLI ERRORI POSSIBILI: SOLO 1 DI QUESTI VERRA' INIZIALIZZATO A TRUE.
            Boolean IsHttpRequestValidationExceptionError = false;
            //Boolean Is404Exception = false;
            Boolean IsGenricError = false;

            //TROVO L'ERRORE ATTUALE
            Exception ex = Server.GetLastError();
            String msg;

            if (ex is HttpException) {
                //HTTP REQUEST VALIDATION
                if (ex is HttpRequestValidationException) {
                    IsHttpRequestValidationExceptionError = true;
                }
                    //404
                /*else if (((HttpException)(ex)).GetHttpCode() == 404) {
                    Is404Exception = true;
                }*/
                    //ERRORE GENERICO
                else {
                    IsGenricError = true;
                }
            } else {
                IsGenricError = true;
            }

            //ERRORE HTTP REQUEST VALIDATION
            if (IsHttpRequestValidationExceptionError) {
                msg = ((HttpException)(ex)).StackTrace;
                msg += "\r\n";
                msg += ((HttpException)(ex)).Message;
                msg += "\r\n";
                msg += ((HttpException)(ex)).GetHtmlErrorMessage();
                msg += "\r\n";
                msg += "PAGINA CHIAMANTE [" + Request.Url.AbsoluteUri + "]";

                String oggetto = "Errore 500 da [" + Request.Url.AbsoluteUri + "]";
                InviaMail.inviaMail(System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), "SIRIO ECCEZIONI", System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), oggetto, msg);

                Server.ClearError();
                Response.Clear();
                Response.StatusCode = 500;
                Response.Redirect("~/");
                //Server.Transfer("~/error-500.aspx");
            }
            //ERRORE 404
            //else if (Is404Exception) {
            //    msg = ((HttpException)(ex)).StackTrace;
            //    msg += "\r\n";
            //    msg += ((HttpException)(ex)).Message;
            //    msg += "\r\n";
            //    msg += ((HttpException)(ex)).GetHtmlErrorMessage();
            //    msg += "\r\n";
            //    msg += "PAGINA CHIAMANTE [" + Request.Url.AbsoluteUri + "]";

            //    String oggetto = "Errore 404 da [" + Request.Url.AbsoluteUri + "]";
            //    InviaMail.inviaMail(System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), "SIRIO ECCEZIONI", System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), oggetto, msg);

            //    Server.ClearError();
            //    Response.Clear();
            //    Response.StatusCode = 404;
            //    Response.StatusDescription = "Page not found";
            //    Server.Transfer("~/error-404.aspx");
            //}
            //ERRORE GENERICO
            else if (IsGenricError) {

                if (ex.Message.Contains("Validation of viewstate MAC failed")) {
                    FormsAuthentication.SignOut();
                    Response.Redirect("~/Login.aspx", true);
                }

                //INVIO EMAIL IN CASO DI ERRORE 
                msg = ((HttpException)(ex)).StackTrace;
                msg += "\r\n";
                msg += ((HttpException)(ex)).Message;
                msg += "\r\n";
                msg += ((HttpException)(ex)).GetHtmlErrorMessage();
                msg += "\r\n";
                msg += "PAGINA CHIAMANTE [" + Request.Url.AbsoluteUri + "]";

                String oggetto = "Errore da [" + Request.Url.AbsoluteUri + "]";
                InviaMail.inviaMail(System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), "SIRIO ECCEZIONI", System.Configuration.ConfigurationManager.AppSettings["Eccezioni"].ToString(), oggetto, msg);

                Server.ClearError();
                Response.Clear();
                Response.StatusCode = 500;
                Response.Redirect("~/");
                //Server.Transfer("~/error-500.aspx");
            }

        }
    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Codice eseguito all\'avvio di una nuova sessione
    }

    void Session_End(object sender, EventArgs e) 
    {
        // Codice eseguito al termine di una sessione. 
        // Nota: l'evento Session_End viene generato solo quando la modalità sessionstate
        // è impostata su InProc nel file Web.config. Se la modalità è impostata su StateServer 
        // o SQLServer, l'evento non viene generato.

    }
       
</script>