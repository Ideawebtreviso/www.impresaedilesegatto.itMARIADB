function stampaPDF(idComputo) {
    location.replace("../stampa-computo/stampa-computo.aspx?IDCOMPUTO=" + idComputo);
    /*var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                // codice qui
                // console.log(jsonRisultatoQuery);
                var nomeFile = jsonRisultatoQuery[0].nomeFile;

                // apri in una nuova finestra il pdf da stampare
                //var miaWindow = window.open('/public/generazione-pdf/' + nomeFile, '_blank');
                var percorsoFile = document.getElementById("percorsoUploadPDFGestionale").innerHTML;
                var miaWindow = window.open(percorsoFile + nomeFile, '_blank');

                // entra in modalità stampa
                //miaWindow.print();

            } else {
                if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                else console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    var conPrezziTrueFalse = false;
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/stampaPDF", true);
    var jsonAsObject = {
        idComputo: parseInt(idComputo),
        opzioni: {
            conPrezzo: conPrezziTrueFalse,
            el1: "val1",
            el2: "val2",
            el3: "val3"
        }
    };

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
    */
}

function elencoComputi_duplicaComputo() {
    var idcomputo = document.getElementById("tabellaComputi").getElementsByTagName("tbody")[1].getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_computo.id")[0].innerHTML;

    iwebMostraCaricamentoAjax();

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                // codice qui
                iwebCaricaElemento("tabellaComputi");

                iwebNascondiCaricamentoAjax();
            } else {
                if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                else console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/duplicaComputo", true);
    var jsonAsObject = {
        idcomputo: parseInt(idcomputo) // int
    };
    //console.log(jsonAsObject);

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}

function elencoComputi_eliminaComputo() {
    var idcomputo = document.getElementById("tabellaComputi").getElementsByTagName("tbody")[1].getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_computo.id")[0].innerHTML;

    iwebMostraCaricamentoAjax();

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                // codice qui
                iwebCaricaElemento("tabellaComputi");

                // nascondi il caricamento
                iwebNascondiCaricamentoAjax();

                // chiudi e nascondi il popup
                var elPopupElimina = document.getElementById("popupTabellaComputiElimina");
                chiudiPopupType2B(elPopupElimina);

            } else {
                if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                else console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/eliminaComputo", true);
    var jsonAsObject = {
        idcomputo: parseInt(idcomputo) // int
    };
    //console.log(jsonAsObject);

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}
