function scaricoBolla_scarica() {
    var datiIncompleti = false;
    var tipoErrore = "";

    // idbolla della querystring deve essere valorizzata
    var idbollafattura = document.getElementById("IDBOLLA").innerHTML;
    if (idbollafattura == "0") {
        tipoErrore = "ID bolla non definito, torna alla pagina <a href='../gestione-bolle/gestione-bolle.aspx'>Gestione bolle</a>";
        datiIncompleti = true;
    }

    // campi obbligatori
    if (document.getElementById("nuovoQuantita").value == "") {
        tipoErrore = "Quantità non valida";
        datiIncompleti = true;
    }

    if (document.getElementById("nuovoProdotto").getElementsByTagName("input")[0].value == "") {// valore
        tipoErrore = "Prodotto non valido";
        datiIncompleti = true;
    }
    if (document.getElementById("nuovoProdotto").getElementsByTagName("span")[1].innerHTML == "") {// chiave
        tipoErrore = "Prodotto non valido";
        datiIncompleti = true;
    }
    if (document.getElementById("nuovoProdotto").getElementsByTagName("span")[1].innerHTML == "-1") {// chiave
        tipoErrore = "Prodotto non valido";
        datiIncompleti = true;
    }

    if (document.getElementById("nuovoCantiere").getElementsByTagName("input")[0].value == "") {// valore
        tipoErrore = "Cantiere non valido";
        datiIncompleti = true;
    }
    if (document.getElementById("nuovoCantiere").getElementsByTagName("span")[1].innerHTML == "") {// chiave
        tipoErrore = "Cantiere non valido";
        datiIncompleti = true;
    }
    if (document.getElementById("nuovoCantiere").getElementsByTagName("span")[1].innerHTML == "-1") {// chiave
        tipoErrore = "Cantiere non valido";
        datiIncompleti = true;
    }

    document.getElementById("labelErroreScaricoBolla").innerHTML = tipoErrore;

    // ho verificato di avere i dati necessari
    if (datiIncompleti == false) {
        if (document.getElementById("nuovoCantiere").getElementsByTagName("input")[0].value == "COSTI GENERALI SEGATTO - CS - COSTI GENERALI") {
            console.log("TROVATO CS");

            // ripartisco l'importo sui cantieri aperti
            var prezzo = document.getElementById("nuovoPrezzo").value;
            var idprodotto = document.getElementById("nuovoProdotto").getElementsByTagName("span")[1].innerHTML;
            var idbollafattura = document.getElementById("tabellaBolle").getElementsByTagName("tbody")[1].getElementsByClassName("iwebCAMPO_bollafattura.id")[0].innerHTML;
            var descrizione = document.getElementById("nuovoDescrizione").value;
            ripartisciImportoSuCantieriAperti(prezzo, idprodotto, idbollafattura, descrizione);

        } else {

            var elQueryInsert = document.getElementsByClassName("iwebSQLQUERY1")[0];
            if (elQueryInsert != null) {
                var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryInsert);
                var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryInsert);

                // attendi che finisca l'elaborazione
                iwebMostraCaricamentoAjax();

                var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                        var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                        if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                        //console.log(jsonRisultatoQuery);
                        if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                            // codice qui
                            // elaborazione terminata, termina l'attesa
                            iwebNascondiCaricamentoAjax();

                            // aggiorna prezzi e sconti anagrafica se prezzo > 0
                            if (document.getElementById("nuovoPrezzo").value != "" && document.getElementById("nuovoPrezzo").value != "0") {
                                scaricoBolla_scarica_parte2(); //  qui dentro alla fine c'è iwebCaricaElemento("tabellaRigheScaricate");
                                scaricoBolla_scarica_parte2b();
                            } else {
                                iwebCaricaElemento("tabellaRigheScaricate");
                            }

                            scaricoBolla_azzeraCampi();
                            document.getElementById('nuovoProdotto').getElementsByTagName('input')[0].focus();
                        } else {
                            if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                            else console.log("errore json " + jsonRisultatoQuery[0].errore);
                        }
                    }
                }

                xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryInsert", true);
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
}

function ripartisciImportoSuCantieriAperti(importo, idprodotto, idbollafattura, descrizione) {
    iwebMostraCaricamentoAjax();

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            //console.log(jsonRisultatoQuery);
            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                // codice qui
                // elaborazione terminata, termina l'attesa
                iwebNascondiCaricamentoAjax();

                scaricoBolla_azzeraCampi();
            } else {
                if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                else console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/ripartisciImportoSuCantieriAperti", true);
    var jsonAsObject = {
        importo: parseFloat(importo),
        idprodotto: parseInt(idprodotto),
        idbollafattura: parseInt(idbollafattura),
        descrizione: descrizione
    };
    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}

// ho dovuto dividere la funzione in due parti perchè per qualche motivo (probabilmente variabili in conflitto) non venivano conclusi correttamente entrambi gli xmlhttp.
function scaricoBolla_scarica_parte2() {
    // aggiorna il prezzolistino-sconto1-sconto2
    if (document.getElementById("aggiornaPrezzoAnagrafica").checked == true) {
        var elQueryUpdate = document.getElementsByClassName("iwebSQLQUERY2")[0];
        if (elQueryUpdate != null) {
            var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryUpdate);
            var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryUpdate);

            // attendi che finisca l'elaborazione
            iwebMostraCaricamentoAjax();

            var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                    var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                    if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                    // elaborazione terminata, termina l'attesa
                    iwebNascondiCaricamentoAjax();

                    if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                        // codice qui
                        iwebCaricaElemento("tabellaRigheScaricate");

                    } else {
                        if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                        else console.log("errore json " + jsonRisultatoQuery[0].errore);
                    }
                }
            }
            xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryUpdate", true);
            var jsonAsObject = {
                query: sqlQuery,
                parametri: parametriQuery
            }
            xmlhttp.setRequestHeader("Content-type", "application/json");
            var jsonAsString = JSON.stringify(jsonAsObject);
            xmlhttp.send(jsonAsString);
        }
    } else {
        // codice qui
        iwebCaricaElemento("tabellaRigheScaricate");
    }

}

function scaricoBolla_scarica_parte2b() {
    var elQueryUpdate = document.getElementsByClassName("iwebSQLQUERY3")[0];
    if (elQueryUpdate != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryUpdate);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryUpdate);

        // attendi che finisca l'elaborazione
        iwebMostraCaricamentoAjax();

        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                // elaborazione terminata, termina l'attesa
                iwebNascondiCaricamentoAjax();

                if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                    // codice qui
                    // iwebCaricaElemento("tabellaRigheScaricate");

                } else {
                    if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                    else console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryUpdate", true);
        var jsonAsObject = {
            query: sqlQuery,
            parametri: parametriQuery
        }
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}

function scaricoBolla_azzeraCampi() {
    // document.getElementById("nuovoCantiere").getElementsByTagName("input")[0].value = ""; il nuovoCantiere non si azzera
    document.getElementById("nuovoProdotto").getElementsByTagName("input")[0].value = "";
    document.getElementById("nuovoQuantita").value = "";
    document.getElementById("nuovoDescrizione").value = "";
    document.getElementById("nuovoPrezzo").value = "";
    document.getElementById("nuovoSconto1").value = "";
    document.getElementById("nuovoSconto2").value = "";
    document.getElementById("aggiornaPrezzoAnagrafica").checked = true;
}

function scaricobolla_leggiPrezzoEScontiDaDB(IDBOLLA) {
    if (IDBOLLA == null) {
        IDBOLLA = parseInt(document.getElementById("IDBOLLA").innerHTML);
        console.log(IDBOLLA);
        setTimeout(function () { scaricobolla_leggiPrezzoEScontiDaDB(IDBOLLA) }, 100);
    } else {
        if (IDBOLLA > 0) {
            var elQuerySelect = document.getElementsByClassName("iwebSQLQUERYPRODOTTOSELEZIONATO")[0];
            if (elQuerySelect != null) {
                var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
                var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);

                var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                        var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                        if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                        if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                            // codice qui
                            // iwebCaricaElemento("tabellaRigheScaricate");
                            if (jsonRisultatoQuery[1] == null) {
                                document.getElementById("aggiornaPrezzoAnagrafica").checked = false;
                                document.getElementById("nuovoPrezzo").value = 0;
                                document.getElementById("nuovoSconto1").value = 0;
                                document.getElementById("nuovoSconto2").value = 0;
                            } else {
                                var listino = jsonRisultatoQuery[1].listino;
                                var sconto1 = jsonRisultatoQuery[1].sconto1;
                                var sconto2 = jsonRisultatoQuery[1].sconto2;
                                document.getElementById("aggiornaPrezzoAnagrafica").checked = true;
                                document.getElementById("nuovoPrezzo").value = listino;
                                document.getElementById("nuovoSconto1").value = sconto1;
                                document.getElementById("nuovoSconto2").value = sconto2;
                            }
                        } else {
                            if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                            else console.log("errore json " + jsonRisultatoQuery[0].errore);
                        }
                    }
                }
                xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReaderSemplice", true);
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

}


function scaricobollaModifica_leggiPrezzoEScontiDaDB(idProdotto) {
    if (idProdotto == null) {
        idProdotto = parseInt(document.getElementById("IDBOLLA").innerHTML);
        setTimeout(function () { scaricobollaModifica_leggiPrezzoEScontiDaDB(idProdotto) }, 100);
    } else {
        if (idProdotto > 0) {
            var elQuerySelect = document.getElementsByClassName("iwebSQLQUERYPRODOTTOSELEZIONATOModifica")[0];
            if (elQuerySelect != null) {
                var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
                var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);

                var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                        var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                        console.log(jsonRisultatoQuery)
                        if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                        if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                            // codice qui
                            // iwebCaricaElemento("tabellaRigheScaricate");
                            var elPopup = document.getElementById("popupTabellaRigheScaricateModifica");
                            if (jsonRisultatoQuery[1] == null) {
                                elPopup.getElementsByClassName("aggiornaPrezzoEScontiInAnagrafica")[0].checked = false;
                                elPopup.getElementsByClassName("iwebCAMPO_costo.prezzo")[0].value = 0;
                                elPopup.getElementsByClassName("iwebCAMPO_costo.sconto1")[0].value = 0;
                                elPopup.getElementsByClassName("iwebCAMPO_costo.sconto2")[0].value = 0;
                            } else {
                                var listino = jsonRisultatoQuery[1].listino;
                                var sconto1 = jsonRisultatoQuery[1].sconto1;
                                var sconto2 = jsonRisultatoQuery[1].sconto2;
                                elPopup.getElementsByClassName("aggiornaPrezzoEScontiInAnagrafica")[0].checked = true;
                                elPopup.getElementsByClassName("iwebCAMPO_costo.prezzo")[0].value = listino;
                                elPopup.getElementsByClassName("iwebCAMPO_costo.sconto1")[0].value = sconto1;
                                elPopup.getElementsByClassName("iwebCAMPO_costo.sconto2")[0].value = sconto2;
                            }
                        } else {
                            if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                            else console.log("errore json " + jsonRisultatoQuery[0].errore);
                        }
                    }
                }
                xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReaderSemplice", true);
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

}





function scaricoBolla_iwebTABELLA_ConfermaModificaRigaInPopup(IdPopupAssociato, idTabella, parametriSet, parametriWhere, attesaRispostaServer, funzioneAFineEsecuzione) {
    // esempio --> popupAssociato = "popupModificaRiga"
    var popupAssociato = document.getElementById(IdPopupAssociato);

    // cerco nel popup la query di update
    // SPECIFICO PER SCARICO BOLLA
    if (popupAssociato.getElementsByClassName("iwebSQLQUERY1Modifica").length == 0)
        console.log("%ciwebSQLUPDATE non trovato nell'elemento " + IdPopupAssociato, "color:darkred");

    // SPECIFICO PER SCARICO BOLLA
    var elQueryUpdate = popupAssociato.getElementsByClassName("iwebSQLQUERY1Modifica")[0];

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

                if (nomeNodo == "input") {
                    if (elTemp.type == "text")
                        valoreRiga = elTemp.value;
                    else if (elTemp.type == "checkbox")
                        valoreRiga = elTemp.checked == true ? "1" : "0";
                } else if (nomeNodo == "span") {
                    valoreRiga = elTemp.innerHTML;
                } else if (nomeNodo == "textarea") {
                    valoreRiga = elTemp.value;
                } else if (nomeNodo == "div") {
                    if (elTemp.getElementsByTagName("select").length > 0) {
                        var elTempSelect = elTemp.getElementsByTagName("select")[0];
                        var elTempOption = elTempSelect.getElementsByTagName("option")[elTempSelect.selectedIndex];
                        // ottieni il valore del value (più tardi lo aggiornerò)
                        if (elTempOption.value >= 0)
                            valoreRiga = elTempOption.innerHTML;
                            //valoreRiga = elTempOption.value;
                        else
                            valoreRiga = "0";
                    }
                } else if (nomeNodo == "select") {
                    // ottieni il valore del text (più tardi lo aggiornerò)
                    var elTempOption = elTemp.getElementsByTagName("option")[elTemp.selectedIndex];
                    valoreRiga = elTempOption.value;
                }

                // classi particolari come tronca at
                if (classiNodo2.indexOf("iwebCodice") >= 0 || classiNodo2.indexOf("iwebTitolo") >= 0 || classiNodo2.indexOf("iwebDescrizione") >= 0) {
                    var nomeTagPadre = elTemp.parentElement.nodeName.toLowerCase();
                    var caratteriDaMostrare = 0;
                    if (classiNodo2.indexOf("iwebCodice") >= 0) {
                        caratteriDaMostrare = 11; if (nomeTagPadre == "td") aggiungiClasseAElemento(elTemp.parentElement, "iwebCodice_tdPadre");
                    }
                    if (classiNodo2.indexOf("iwebTitolo") >= 0) {
                        caratteriDaMostrare = 20; if (nomeTagPadre == "td") aggiungiClasseAElemento(elTemp.parentElement, "iwebTitolo_tdPadre");
                    }
                    if (classiNodo2.indexOf("iwebDescrizione") >= 0) {
                        caratteriDaMostrare = 100; if (nomeTagPadre == "td") aggiungiClasseAElemento(elTemp.parentElement, "iwebDescrizione_tdPadre");
                    }

                    // sovrascrivo la lunghezza di default
                    if (classiNodo2.indexOf("iwebTroncaCrtsAt_") >= 0) caratteriDaMostrare = classiNodo2.split("iwebTroncaCrtsAt_")[1].split(" ")[0];

                    // in caso di 0 caratteri da mostrare non mostro nulla.
                    if (caratteriDaMostrare == 0) valoreRiga = "";

                    if (valoreRiga != null && valoreRiga != "" && valoreRiga.length > caratteriDaMostrare) {
                        elTemp.title = valoreRiga; // valore completo su title
                        valoreRiga = valoreRiga.substr(0, caratteriDaMostrare) + "..."; // valore parziale in visualizzazione
                    }
                }

                // aggiorno la riga modificata
                if (nomeNodo2 == "span" || nomeNodo2 == "td")
                    elTemp2.innerHTML = valoreRiga;
                if (nomeNodo2 == "textarea")
                    elTemp2.value = valoreRiga;
                if (nomeNodo2 == "input") {
                    if (elTemp2.type == "text")
                        elTemp2.innerHTML = valoreRiga;
                    else if (elTemp2.type == "checkbox") {
                        if (valoreRiga == "0")
                            elTemp2.parentElement.innerHTML = elTemp2.parentElement.innerHTML.replace("checked", "");
                        else
                            elTemp2.parentElement.innerHTML = elTemp2.parentElement.innerHTML.replace(">", " checked>");
                    }
                }

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

                        // aggiorna le eventuali tabelle associate a questa modifica
                        /*var trovato = false;
                        for (var i = 0; i < document.getElementsByTagName("tr").length; ++i)
                            if (document.getElementsByTagName("tr")[i].className.indexOf("tabellaajaxRigaSelezionata") != -1)
                                trovato = true;
                        if (trovato == true)*/
                        //if (trPadre.className.indexOf("tabellaajaxRigaSelezionata") != -1)
                        iwebBind(idTabella);
                        chiudiPopupType2B(popupAssociato);

                        // SPECIFICI PER SCARICO BOLLA
                        scaricoBollaModifica_scarica_parte2();
                        scaricoBollaModifica_scarica_parte2b();
                        scaricoBollaModifica_scarica_parte2c();

                        if (funzioneAFineEsecuzione && typeof funzioneAFineEsecuzione === "function")
                            funzioneAFineEsecuzione();
                    } else {
                        console.log("errore json " + jsonRisultatoQuery[0].errore);
                    }

                }
            }

            xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryUpdate", true);
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



// ho dovuto dividere la funzione in due parti perchè per qualche motivo (probabilmente variabili in conflitto) non venivano conclusi correttamente entrambi gli xmlhttp.
function scaricoBollaModifica_scarica_parte2() {
    // aggiorna il prezzolistino-sconto1-sconto2
    if (document.getElementsByClassName("aggiornaPrezzoEScontiInAnagrafica")[0].checked == true) {
        var elQueryUpdate = document.getElementsByClassName("iwebSQLQUERY2Modifica")[0];
        if (elQueryUpdate != null) {
            var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryUpdate);
            var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryUpdate);

            // attendi che finisca l'elaborazione
            iwebMostraCaricamentoAjax();

            var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                    var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                    if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                    // elaborazione terminata, termina l'attesa
                    iwebNascondiCaricamentoAjax();

                    if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                        // codice qui
                        iwebCaricaElemento("tabellaRigheScaricate");

                    } else {
                        if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                        else console.log("errore json " + jsonRisultatoQuery[0].errore);
                    }
                }
            }
            xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryUpdate", true);
            var jsonAsObject = {
                query: sqlQuery,
                parametri: parametriQuery
            }
            xmlhttp.setRequestHeader("Content-type", "application/json");
            var jsonAsString = JSON.stringify(jsonAsObject);
            xmlhttp.send(jsonAsString);
        }
    } else {
        // codice qui
        iwebCaricaElemento("tabellaRigheScaricate");
    }

}

function scaricoBollaModifica_scarica_parte2b() {
    var elQueryUpdate = document.getElementsByClassName("iwebSQLQUERY3Modifica")[0];
    if (elQueryUpdate != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryUpdate);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryUpdate);

        // attendi che finisca l'elaborazione
        iwebMostraCaricamentoAjax();

        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                // elaborazione terminata, termina l'attesa
                iwebNascondiCaricamentoAjax();

                if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                    // codice qui
                    // iwebCaricaElemento("tabellaRigheScaricate");

                } else {
                    if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                    else console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryUpdate", true);
        var jsonAsObject = {
            query: sqlQuery,
            parametri: parametriQuery
        }
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}


function scaricoBollaModifica_scarica_parte2c() {
    var elQueryUpdate = document.getElementsByClassName("iwebSQLQUERY4Modifica")[0];
    if (elQueryUpdate != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryUpdate);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryUpdate);

        // attendi che finisca l'elaborazione
        iwebMostraCaricamentoAjax();

        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                // elaborazione terminata, termina l'attesa
                iwebNascondiCaricamentoAjax();

                if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                    // codice qui
                    // iwebCaricaElemento("tabellaRigheScaricate");

                } else {
                    if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                    else console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryUpdate", true);
        var jsonAsObject = {
            query: sqlQuery,
            parametri: parametriQuery
        }
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}

