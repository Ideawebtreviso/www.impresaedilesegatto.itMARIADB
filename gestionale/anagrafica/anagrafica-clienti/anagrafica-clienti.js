
function anagraficaClienti_iwebTABELLA_ConfermaAggiungiRecordInPopup(idPopupAssociato, idTabella, parametri, attesaRispostaServer) {
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

function anagraficaClienti_iwebTABELLA_ConfermaModificaRigaInPopup(IdPopupAssociato, idTabella, parametriSet, parametriWhere, attesaRispostaServer, iwebEseguiSincrono_oggetto) {
    // esempio --> popupAssociato = "popupModificaRiga"
    var popupAssociato = document.getElementById(IdPopupAssociato);

    // cerco nel popup la query di update
    var elQueryUpdate = popupAssociato.getElementsByClassName("iwebSQLUPDATE")[0];

    if (elQueryUpdate != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryUpdate);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryUpdate);
        //console.log(sqlQuery + "  /  " + parametriQuery)

        // esempio --> temp = "GridView1_3=ID,Nome,Cognome"
        var temp = popupAssociato.getElementsByClassName("iwebTABELLA_ContenitoreParametri")[0].innerHTML;

        // esempio --> idRigaDaModificare = "GridView1_3"
        var idRigaDaModificare = temp.split("-&gt;")[0]; // -> è diventato -&gt;
        var trPadre = document.getElementById(idRigaDaModificare);

        // esempio --> elencoParametriDaModificare = "ID,Nome,Cognome"
        var elencoParametriDaModificare = temp.split("-&gt;")[1]; // -> è diventato -&gt;
        //console.log(idRigaDaModificare + " " + elencoParametriDaModificare);
        // -elencoParametriDaModificare- contiene la stringa: "ID, Nome, Cognome" -> ciò significa che nella riga dove mi trovo devo andare a prendere l'id, il nome e il cognome
        var colonneDaModificare = elencoParametriDaModificare.split(" ").join("").split(",");
        var valoreRiga = "";

        // prepara la stringa di parametri da inviare al jsonEseguiQuery.
        if (parametriSet == "*")
            parametriSet = elencoParametriDaModificare;

        var campiObbligatoriVerificati = iwebTABELLA_VerificaCampiObbligatori(popupAssociato);
        //console.log(campiObbligatoriVerificati);
        if (campiObbligatoriVerificati.length == 0) {
            // cerco nel popup i dati modificati e li aggiorno in pagina
            for (var i = 0; i < colonneDaModificare.length; ++i) {
                var elTemp = popupAssociato.getElementsByClassName("iwebCAMPO_" + colonneDaModificare[i])[0];
                var elTemp2 = trPadre.getElementsByClassName("iwebCAMPO_" + colonneDaModificare[i])[0];
                var nomeNodo = elTemp.nodeName.toLowerCase();
                var nomeNodo2 = elTemp2.nodeName.toLowerCase()
                var classiNodo2 = elTemp2.className;

                // aggiorno la stringa di parametri da inviare al jsonEseguiQuery.
                //parametriSet = parametriSet.replace(colonneDaModificare[i], colonneDaModificare[i] + "=" + valoreRiga);
                var listaparametriSet = parametriSet.split(",");
                for (var j = 0; j < listaparametriSet.length; ++j)
                    if (listaparametriSet[j] == colonneDaModificare[i])
                        listaparametriSet[j] = colonneDaModificare[i] + "=" + valoreRiga;
                parametriSet = listaparametriSet.join(",");
                //parametriWhere = parametriWhere.replace(colonneDaModificare[i], colonneDaModificare[i] + "=" + valoreRiga);
                var listaparametriWhere = parametriWhere.split(",");
                for (var j = 0; j < listaparametriWhere.length; ++j)
                    if (listaparametriWhere[j] == colonneDaModificare[i])
                        listaparametriWhere[j] = colonneDaModificare[i] + "=" + valoreRiga;
                parametriWhere = listaparametriWhere.join(",");
                //console.log(colonneDaModificare[i] + " / " + valoreRiga);
            }

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
                            //iwebBind(idTabella);
                            iwebCaricaElemento(idTabella);
                            chiudiPopupType2B(popupAssociato);
                            document.getElementById("popupTabellaCantieriModificaSpanCodiceErrato").style.display = "none";
                        } else {
                            document.getElementById("popupTabellaCantieriModificaSpanCodiceErrato").style.display = "";
                        }
                    } else {
                        console.log("errore json " + jsonRisultatoQuery[0].errore);
                    }

                    if (iwebEseguiSincrono_oggetto != null)
                        iwebEseguiSincrono_oggetto.finito = true;
                }
            }

            xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/modificaCantiere", true);
            //var codice = popupAssociato.getElementsByClassName("iwebCAMPO_cantiere.codice")[0].value;
            var jsonAsObject = {
                query: sqlQuery, // string
                parametri: parametriQuery // string
            }
            // in entrambi i casi
            xmlhttp.setRequestHeader("Content-type", "application/json");
            var jsonAsString = JSON.stringify(jsonAsObject);
            xmlhttp.send(jsonAsString);
        }
    }
}
