function elencoCantieri_Report(IDCANTIERE) {
    location.replace("../report-cantiere/report-cantiere.aspx?IDCANTIERE=" + IDCANTIERE);
}

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

function elencoCantieri_eliminaCantiereTabellaCantieri() {
    var idcantiere = document.getElementById("tabellaCantieri").getElementsByTagName("tbody")[1].getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_cantiere.id")[0].innerHTML;
    elencoCantieri_eliminaCantiere(idcantiere);
}

function elencoCantieri_eliminaCantiere(idcantiere) {
    iwebMostraCaricamentoAjax();

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                // codice qui
                iwebCaricaElemento("tabellaCantieri");

                // nascondi il caricamento
                iwebNascondiCaricamentoAjax();

                // chiudi e nascondi il popup
                var elPopupElimina = document.getElementById("popupTabellaCantieriElimina");
                chiudiPopupType2B(elPopupElimina);

            } else {
                if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                else console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/eliminaCantiere", true);
    var jsonAsObject = {
        idcantiere: parseInt(idcantiere) // int
    };
    // console.log(jsonAsObject);

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}

function elencoCantieri_iwebTABELLA_ConfermaAzionePerSelezionati() {
    var el = event.srcElement;
    // ottengo il tipo di azione
    var select_ = precedenteElemento(el);
    var idAzioneSelezionata = select_.selectedIndex;
    var azioneSelezionata = select_.getElementsByTagName("option")[idAzioneSelezionata].value;

    if (azioneSelezionata != "") {
        var x = confirm("Confermi l'azione: '" + azioneSelezionata + "' ?");
        if (x) {
            // ottengo le righe selezionate
            var elTabella = prossimoElemento(el.parentElement);
            var idTabella = elTabella.id; // serve per poi ricaricare la tabella
            var listaElementiCheckBoxSelezionati = elTabella.getElementsByClassName("iwebCBSELEZIONABILE");
            var listaCheckBoxSelezionati = [];
            for (var i = 0; i < listaElementiCheckBoxSelezionati.length; i++) {
                if (listaElementiCheckBoxSelezionati[i].checked)
                    listaCheckBoxSelezionati.push(listaElementiCheckBoxSelezionati[i].title)
            }

            //console.log(azioneSelezionata + " per: " + listaCheckBoxSelezionati.join(","));
            // per ogni riga selezionata cerco la chiave della tabella e elimino la riga (es: iwebCHIAVE__id)
            var tbodyVisibile = elTabella.getElementsByTagName("tbody")[1];
            var campiChiaveTabella = elTabella.className.split("iwebCHIAVE__")[1].split(" ")[0].split("__");

            var ARRAYCONIDCANTIERE = [];

            for (var i = 0; i < listaCheckBoxSelezionati.length; i++) {
                var rigaSelezionata = listaCheckBoxSelezionati[i] - 1;
                for (var j = 0; j < campiChiaveTabella.length; j++) {
                    var campoChiave = campiChiaveTabella[j];
                    ARRAYCONIDCANTIERE.push(tbodyVisibile.getElementsByTagName("tr")[rigaSelezionata].getElementsByClassName("iwebCAMPO_" + campoChiave)[0].innerHTML);
                }
            }
            console.log(ARRAYCONIDCANTIERE);
            if (azioneSelezionata == "Elimina") {
                for (var i = 0; i < ARRAYCONIDCANTIERE.length; i++)
                    elencoCantieri_eliminaCantiere(ARRAYCONIDCANTIERE[i]);
            } // fine elimina
        } // fine azioneSelezionata != ""
    }
}
