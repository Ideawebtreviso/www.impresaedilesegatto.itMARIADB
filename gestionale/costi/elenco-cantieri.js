
function elencoCantieri_iwebTABELLA_ConfermaAggiungiRecordInPopup(idPopupAssociato, idTabella, parametri, attesaRispostaServer) {
    // esempio --> popupAssociato = "popupInserisciRiga"
    var popupAssociato = document.getElementById(idPopupAssociato);
    var tabellaAssociata = document.getElementById(idTabella);

    // cerco nel popup delete la query delete
    if (popupAssociato == null)
        console.log("%cErrore su iwebTABELLA_ConfermaAggiungiRecordInPopup: ricontrolla i parametri: " + idPopupAssociato + ", " + idTabella, "color:darkred");


    var campiObbligatoriVerificati = iwebTABELLA_VerificaCampiObbligatori(popupAssociato);
    //console.log(campiObbligatoriVerificati);
    if (campiObbligatoriVerificati.length == 0) {
        var elQueryInsert = popupAssociato.getElementsByClassName("iwebSQLINSERT")[0];
        if (elQueryInsert != null) {
            var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryInsert);
            var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryInsert) + "&&&";
            // cerco gli elementi che sono presenti sia nella riga che nel popup associato "iwebCAMPO_"
            var allElements_popupAssociato = popupAssociato.getElementsByTagName("*");

            // tolgo gli ultimi 3 caratteri ("&&&")
            parametriQuery = parametriQuery.substr(0, parametriQuery.length - 3);
            //console.log(parametriQuery)

            if (attesaRispostaServer)
                iwebMostraCaricamentoAjax();

            var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari*/ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                    var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                    jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                    if (attesaRispostaServer)
                        iwebNascondiCaricamentoAjax();

                    if (jsonRisultatoQuery[0].errore == null) {
                        // codice qui
                        // console.log(jsonRisultatoQuery[0].risultato);

                        if (jsonRisultatoQuery[0].risultato == "Inserimento effettuato") {
                            // ricarica la tabella
                            iwebCaricaElemento(idTabella);
                            chiudiPopupType2B(popupAssociato);
                            document.getElementById("popupTabellaCantieriInserimentoSpanCodiceErrato").style.display = "none";
                        } else {
                            document.getElementById("popupTabellaCantieriInserimentoSpanCodiceErrato").style.display = "";
                        }

                    } else {
                        console.log("errore json " + jsonRisultatoQuery[0].errore);
                    }
                }
            }

            xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/inserisciCantiere", true);
            var jsonAsObject = {
                query: sqlQuery,
                parametri: parametriQuery
            }
            xmlhttp.setRequestHeader("Content-type", "application/json");
            var jsonAsString = JSON.stringify(jsonAsObject);
            xmlhttp.send(jsonAsString);
        }
    }
}

//function elencoCantieri_iwebTABELLA_ConfermaModificaRigaInPopup(idPopupAssociato, idTabella, parametriSet, parametriWhere, attesaRispostaServer, iwebEseguiSincrono_oggetto) {
function elencoCantieri_iwebBindPopupModificaiwebDETTAGLIO(idPopupAssociato, attesaRispostaServer) {
    // esempio --> popupAssociato = "popupModificaRiga"
    var popupAssociato = document.getElementById(idPopupAssociato);

    // cerco nel popup la query di update
    var elQueryUpdate = popupAssociato.getElementsByClassName("iwebSQLUPDATE")[0];

    if (elQueryUpdate != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryUpdate);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryUpdate);
        // console.log(sqlQuery + "  /  " + parametriQuery)

        var campiObbligatoriVerificati = iwebTABELLA_VerificaCampiObbligatori(popupAssociato);
        //console.log(campiObbligatoriVerificati);
        if (campiObbligatoriVerificati.length == 0) {

            if (attesaRispostaServer)
                iwebMostraCaricamentoAjax();

            var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari*/ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                    var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                    jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                    if (attesaRispostaServer)
                        iwebNascondiCaricamentoAjax();

                    if (jsonRisultatoQuery[0].errore == null) {
                        // codice qui
                        // console.log(jsonRisultatoQuery[0].risultato);
                        if (jsonRisultatoQuery[0].risultato == "Modifica effettuata") {
                            iwebBind(idPopupAssociato);
                            chiudiPopupType2B(popupAssociato);
                            document.getElementById("popupTabellaCantieriModificaSpanCodiceErrato").style.display = "none";
                        } else {
                            document.getElementById("popupTabellaCantieriModificaSpanCodiceErrato").style.display = "";
                        }
                    } else {
                        console.log("errore json " + jsonRisultatoQuery[0].errore);
                    }
                }
            }

            //var jsonAsObject = { query: queryUpdate };
            var jsonAsObject = {
                query: sqlQuery, // string
                parametri: parametriQuery // string
            }
            var jsonAsString = JSON.stringify(jsonAsObject);
            xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/modificaCantiere");
            xmlhttp.setRequestHeader("Content-type", "application/json");
            xmlhttp.send(jsonAsString);

        }
    }
}
