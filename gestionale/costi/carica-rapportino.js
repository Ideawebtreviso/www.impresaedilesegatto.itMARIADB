function caricaRapportino_inserisci() {
    var el = event.srcElement;
    var eseguiQuery = true;

    var stringaidcantiere = iwebAUTOCOMPLETAMENTO_GetChiaveSelezionato("iwebAUTOCOMPLETAMENTOCantiere");
    eseguiQuery = eseguiQuery && stringaidcantiere != "";
    eseguiQuery = eseguiQuery && stringaidcantiere != "-1";
    eseguiQuery = eseguiQuery && document.getElementById("TextBoxData").value != "";
    eseguiQuery = eseguiQuery && document.getElementById("ore").value != "" && parseInt(document.getElementById("ore").value) > 0;
    if (eseguiQuery) {
        elQuery = el.parentElement.getElementsByClassName("iwebSQLSELECT")[0];
        if (elQuery != null) {
            //var querySelect = generaQueryDaSpanSql(elQuery);
            var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuery);
            var parametri = iwebGeneraParametriQueryDaSpanSql(elQuery);
            // console.log([querySelect, parametri]);

            var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari */ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    // elaborazione terminata
                    var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                    jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                    // inserimento completato, azzera i campi
                    //iwebAUTOCOMPLETAMENTO_AzzeraSelezionato("iwebAUTOCOMPLETAMENTOCantiere");
                    document.getElementById("TextBoxData").value = "";
                    document.getElementById("ore").value = "";
                    document.getElementById("descrizione").value = "";
                    document.getElementById("stringaValutazioneInserimento").innerHTML = "inserimento completato";

                    iwebCaricaElemento("tabellaCosti");

                    if (jsonRisultatoQuery[0].errore != null)
                        console.log("errore json " + jsonRisultatoQuery[0].errore);

                }
            }

            // versione WebService.asmx/sparaQueryReader
            xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryInsert", true);
            var jsonAsObject = {
                query: querySelect, // string
                parametri: parametri // String
            }

            xmlhttp.setRequestHeader("Content-type", "application/json");
            var jsonAsString = JSON.stringify(jsonAsObject);
            xmlhttp.send(jsonAsString);
        }
    } else {
        var stringa = "Errore inserimento";

        if (document.getElementById("ore").value == "")
            stringa = "Inserire una quantita' di ore";
        else if (parseInt(document.getElementById("ore").value) <= 0)
            stringa = "Inserire una quantita' di ore maggiore di zero";

        if (document.getElementById("TextBoxData").value == "")
            stringa = "Data non valida";

        if (stringaidcantiere == "" || stringaidcantiere == "-1")
            stringa = "Cantiere non selezionato";

        // aggiorno la stringa
        document.getElementById("stringaValutazioneInserimento").innerHTML = stringa;
    }

}
