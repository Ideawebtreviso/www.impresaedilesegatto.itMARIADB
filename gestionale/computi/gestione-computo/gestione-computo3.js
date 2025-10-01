function gestioneComputo_iwebAUTOCOMPLETAMENTO_Ricerca(event, el) {
    var elRicerca = el.parentElement;
    var elSearchResults = elRicerca.getElementsByTagName("div")[0];
    var elQuerySelect = elRicerca.getElementsByClassName("iwebSQLSELECT")[0];

    if (elQuerySelect != null) {
        var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
        var parametriChiocciola = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);


        // se il campo è vuoto non fare alcuna ricerca e nascondi il riquadro della ricerca
        if (el.value == "") {
            elSearchResults.style.display = "none";
            return;
        }

        // alla pressione di su e giù non deve essere fatta la ricerca
        if (event.which == 38 || event.keyCode == 38 ||
            event.which == 40 || event.keyCode == 40)
            return;

        // alla pressione di invio il selezionato è confermato quindi chiudo senza fare la ricerca
        if (event.which == 13 || event.keyCode == 13) {
            // el(è input) -> div -> td -> tr -> tbody
            el.parentElement.parentElement.parentElement.parentElement.getElementsByClassName("iwebCAMPO_voce.descrizione")[0].value = iwebAUTOCOMPLETAMENTO_GetChiaveSelezionato(el.parentElement.id);

            elSearchResults.style.display = "none";
            return;
        } else {
            // non ho premuto su/giù e non ho premuto invio (cioè i tasti chiave) quindi azzero chiave e valore
            //var elInputRicerca = el.parentElement.parentElement.getElementsByTagName("input")[0];
            //elInputRicerca.value = "-1";
            // salvo nello span nascosto la chiave
            //var elChiave = el.parentElement.parentElement.getElementsByTagName("span")[1];
            //elChiave.innerHTML = "-1";
            var tastoPremuto = event.which;
            // pressione di tasto indietro, canc oppure un tasto alfanumerico
            if (tastoPremuto < 37 || tastoPremuto > 40) {
                var elChiave = el.parentElement.parentElement.getElementsByTagName("span")[1];
                elChiave.innerHTML = "-1";
            }
        }

        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                // elaborazione terminata, valuta il risultato nella variabile jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery[0].errore == null) {
                    // conto gli elementi risultati dalla ricerca
                    var elementiContati = jsonRisultatoQuery[0].elementiContati;

                    // per ogni elemento creo un div
                    var risultatoRicerca = "";
                    for (var i = 1; i < jsonRisultatoQuery.length; i++) {
                        var chiave = jsonRisultatoQuery[i].chiave;
                        var valore = jsonRisultatoQuery[i].valore;
                        risultatoRicerca += "<div class='iwebAUTOCOMPLETAMENTO_risultato' onclick='gestioneComputo_iwebAUTOCOMPLETAMENTO_SelezionaEChiudi(this)'>";
                        risultatoRicerca += "<span class='iwebNascosto'>" + chiave + "</span>";
                        risultatoRicerca += "<span>" + valore + "</span>";
                        risultatoRicerca += "</div>";
                    }

                    // aggiorno i div creati in cascata alla ricerca
                    elSearchResults.innerHTML = risultatoRicerca;
                    elSearchResults.style.border = "solid 1px gray";
                    elSearchResults.style.display = "inline-block";
                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }

            }
        }

        // versione WebService.asmx/sparaQueryReader
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReaderAUTOCOMPLETAMENTO", true);
        var jsonAsObject = {
            query: querySelect, // string
            parametriChiocciola: parametriChiocciola
        };
        //console.log([querySelect, parametriChiocciola]);
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}


function gestioneComputo_iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, el) {
    var elSearchResults = el.parentElement.getElementsByTagName("div")[0];
    var nRighe = elSearchResults.getElementsByTagName("div").length;
    var elRigaSelezionata = el.parentElement.getElementsByTagName("span")[0];
    var rigaSelezionata = parseInt(elRigaSelezionata.innerHTML);

    // nascondo i risultati della ricerca in caso di tab
    if (event.which == 9 || event.keyCode == 9) {
        var elSearchResults = el.parentElement.getElementsByClassName("iwebAUTOCOMPLETAMENTO_risultatiRicerca")[0];
        elSearchResults.style.display = "none";
    }

    // devono esserci elementi su cui scorrere con la freccia su/giù
    if (nRighe > 0) {

        // su o giù?
        var direzione = 0;
        if (event.which == 38 || event.keyCode == 38) //EVENTO UP
            direzione = -1;
        else if (event.which == 40 || event.keyCode == 40) //EVENTO DOWN
            direzione = 1;

        // se ho premuto su o giù
        if (direzione != 0 ) {
            var tutti_div = elSearchResults.getElementsByTagName("div");

            for (var i = 0; i < tutti_div.length; i++)
                tutti_div[i].className = "iwebAUTOCOMPLETAMENTO_risultato"; // classe per css

            // freccia su o giù spostano il selezionato
            rigaSelezionata += direzione;
            if (rigaSelezionata >= nRighe) rigaSelezionata = 0;
            if (rigaSelezionata < 0) rigaSelezionata = nRighe - 1;
            //console.log(rigaSelezionata);
            tutti_div[rigaSelezionata].className = "iwebAUTOCOMPLETAMENTO_risultatoSelezionato"; // classe per css

            // aggiorno il selezionato (ci sono due span, il primo è la chiave, il secondo il valore)
            var chiave = tutti_div[rigaSelezionata].getElementsByTagName("span")[0].innerHTML; // chiave
            var valore = tutti_div[rigaSelezionata].getElementsByTagName("span")[1].innerHTML; // valore

            // assegno chiave e valore
            el.parentElement.getElementsByTagName("span")[1].innerHTML = chiave;
            el.value = valore;

            elRigaSelezionata.innerHTML = rigaSelezionata;

            // el(è input) -> div -> td -> tr -> tbody
            el.parentElement.parentElement.parentElement.parentElement.getElementsByClassName("iwebCAMPO_voce.descrizione")[0].value = iwebAUTOCOMPLETAMENTO_GetChiaveSelezionato(el.parentElement.id);
        }
    }
}

// el è l'elemento cliccato fra quelli in cascata
function gestioneComputo_iwebAUTOCOMPLETAMENTO_SelezionaEChiudi(el) {
    // ottengo il contenuto dell'elemento cliccato
    // (ci sono due span, il primo è la chiave, il secondo il valore)
    var chiave = el.getElementsByTagName("span")[0].innerHTML; // chiave
    var valore = el.getElementsByTagName("span")[1].innerHTML; // valore

    // salvo nell'input di ricerca il valore appena ottenuto
    var elInputRicerca = el.parentElement.parentElement.getElementsByTagName("input")[0];
    elInputRicerca.value = valore;
    // salvo nello span nascosto la chiave
    var elChiave = el.parentElement.parentElement.getElementsByTagName("span")[1];
    elChiave.innerHTML = chiave;

    // el(è input) -> div -> div -> td -> tr -> tbody
    el.parentElement.parentElement.parentElement.parentElement.parentElement.getElementsByClassName("iwebCAMPO_voce.descrizione")[0].value = iwebAUTOCOMPLETAMENTO_GetChiaveSelezionato(el.parentElement.parentElement.id);

    // nascondo i risultati della ricerca
    var elSearchResults = el.parentElement;
    elSearchResults.style.display = "none";
}


function gestioneComputo_popupTabellaVociInserimento_confermaInserimento(idPopupAssociato, idTabella, vaiANuovaMisura) {
    var elPopup = document.getElementById(idPopupAssociato);

    var campiObbligatoriVerificati = iwebTABELLA_VerificaCampiObbligatori(elPopup);
    //console.log(campiObbligatoriVerificati);
    if (campiObbligatoriVerificati.length == 0) {
        //var idsuddivisione = document.getElementById("popupTabellaVociModificaDDLSuddivisioni").selectedIndex;
        var elDLL = document.getElementById("popupTabellaVociInserimentoDDLSuddivisioni");
        var optionsDLL = elDLL.getElementsByTagName("option");
        var idsuddivisione = optionsDLL[elDLL.selectedIndex].value;

        // parametriQuery
        var idcomputo = document.getElementById("IDCOMPUTO").innerHTML;
        var nomeNuovaSuddivisione = elPopup.getElementsByClassName("iwebCAMPO_suddivisione.descrizione")[0].value;
        var parametriQuery = {
            idcomputo: idcomputo,
            descrizione: nomeNuovaSuddivisione
        };

        // parametriQuery2
        var codice = elPopup.getElementsByClassName("iwebCAMPO_voce.codice")[0].value;
        var titolo = iwebAUTOCOMPLETAMENTO_GetValoreSelezionato("iwebAUTOCOMPLETAMENTOTitoloInserimento");
        var descrizionevoce = elPopup.getElementsByClassName("iwebCAMPO_voce.descrizione")[0].value;
        var posizionevoce = elPopup.getElementsByClassName("iwebCAMPO_voce.posizione")[0].innerHTML;
        var parametriQuery2 = {
            idcomputo: idcomputo,
            codice: codice,
            titolo: titolo,
            descrizionevoce: descrizionevoce,
            posizionevoce: posizionevoce,
            idsuddivisione: idsuddivisione
        };
        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (typeof(jsonRisultatoQuery) == "number") {
                    // codice qui

                    // chiudi e nascondi il popup
                    elPopup.className = "popup popupType2 chiudiPopup";
                    setTimeout(function () { elPopup.style.display = "none" }, 480);

                    if (vaiANuovaMisura == true) {
                        // metto il filtro id, tolgo gli altri filtri presenti e ricarico la tabella
                        document.getElementById(idTabella).getElementsByTagName("thead")[0].getElementsByTagName("tr")[1].getElementsByClassName("iwebCAMPO_voce.id")[0].getElementsByTagName("input")[0].value = jsonRisultatoQuery;
                        document.getElementById(idTabella).getElementsByTagName("thead")[0].getElementsByTagName("tr")[1].getElementsByClassName("iwebCAMPO_voce.codice")[0].getElementsByTagName("input")[0].value = "";
                        document.getElementById(idTabella).getElementsByTagName("thead")[0].getElementsByTagName("tr")[1].getElementsByClassName("iwebCAMPO_voce.titolo")[0].getElementsByTagName("input")[0].value = "";
                        document.getElementById(idTabella).getElementsByTagName("thead")[0].getElementsByTagName("tr")[1].getElementsByClassName("iwebCAMPO_voce.descrizione")[0].getElementsByTagName("input")[0].value = "";
                        document.getElementById(idTabella).getElementsByTagName("thead")[0].getElementsByTagName("tr")[1].getElementsByClassName("iwebCAMPO_voce.idsuddivisione")[0].getElementsByTagName("select")[0].selectedIndex = 0;

                        iwebCaricaElemento(idTabella, false, function () {
                            /* ho finito di caricare la tabella, seleziono il primo e unico elemento */
                            document.getElementById(idTabella).getElementsByTagName("tbody")[1].getElementsByTagName("tr")[0].className = "iwebRigaSelezionata";
                            var elementiTab = document.getElementById("elementoConITab").getElementsByClassName("headerTab")[0].getElementsByClassName("iwebTABFIGLIO");
                            // seleziono il tab "Misure" (indice = 1)
                            iwebTABFIGLIO_Aggiorna(elementiTab[1]);

                            // mentre si aggiorna la tabella misure premo il pulsante inserisci (non viene toccato dalla generazione della tabella)
                            apriPopupType2_bind('popupTabellaMisureInserimento', true);
                            azzeraCampiInserimentoTabellaMisure();
                            preCaricaCodiceMisura();
                            document.getElementById('popupTabellaMisureInserimento').getElementsByClassName('iwebCAMPO_sottocodice')[0].focus();
                        });
                    } else {
                        iwebCaricaElemento(idTabella);
                    }

                    if (nomeNuovaSuddivisione != "") { // se è stata inserita una nuova divisione aggiorna i dll di tabella, modifica e inserimento
                        iwebCaricaElemento("tabellaVociDDLSuddivisioni");
                        iwebCaricaElemento("popupTabellaVociInserimentoDDLSuddivisioni");
                        iwebCaricaElemento("popupTabellaVociModificaDDLSuddivisioni");
                        iwebCaricaElemento("ddlFiltroGenericoSuddivisioni");

                        // azzero il campo Nuova suddivisione dopo l'inserimento
                        elPopup.getElementsByClassName("iwebCAMPO_suddivisione.descrizione")[0].value = "";
                    }

                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }

        xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/nuovaVoce", true);
        var jsonAsObject = {
            parametriQuery: parametriQuery,
            parametriQuery2: parametriQuery2
        }

        //console.log(jsonAsObject);
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}

function gestioneComputo_popupTabellaVociModifica_confermaModifica(idPopupAssociato, idTabella) {
    var elPopup = document.getElementById(idPopupAssociato);

    var campiObbligatoriVerificati = iwebTABELLA_VerificaCampiObbligatori(elPopup);
    //console.log(campiObbligatoriVerificati);
    if (campiObbligatoriVerificati.length == 0) {

        //var idsuddivisione = document.getElementById("popupTabellaVociModificaDDLSuddivisioni").selectedIndex;
        var elDLL = document.getElementById("popupTabellaVociModificaDDLSuddivisioni");
        var optionsDLL = elDLL.getElementsByTagName("option");
        var idsuddivisione = optionsDLL[elDLL.selectedIndex].value;


        // parametriQuery
        var idcomputo = document.getElementById("IDCOMPUTO").innerHTML;
        var nomeNuovaSuddivisione = elPopup.getElementsByClassName("iwebCAMPO_suddivisione.descrizione")[0].value;
        var parametriQuery = {
            idcomputo: idcomputo,
            descrizione: nomeNuovaSuddivisione
        };

        // parametriQuery2
        var idvoce = elPopup.getElementsByClassName("iwebCAMPO_voce.id")[0].innerHTML;
        var codice = elPopup.getElementsByClassName("iwebCAMPO_codice")[0].value;
        var titolo = elPopup.getElementsByClassName("iwebCAMPO_titolo")[0].value;
        var idvoceorigine = elPopup.getElementsByClassName("iwebCAMPO_voce.idvoceorigine")[0].innerHTML;
        var descrizionevoce = elPopup.getElementsByClassName("iwebCAMPO_voce.descrizione")[0].value;
        var posizionevoce = elPopup.getElementsByClassName("iwebCAMPO_voce.posizione")[0].innerHTML;
        var parametriQuery2 = {
            idvoce: idvoce,
            idcomputo: idcomputo,
            idsuddivisione: idsuddivisione,
            idvoceorigine: idvoceorigine,
            codice: codice,
            titolo: titolo,
            descrizionevoce: descrizionevoce,
            posizionevoce: posizionevoce
        };
        console.log("idvoceorigine: " + idvoceorigine)
        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery[0].errore == null) {
                    // codice qui

                    // chiudi e nascondi il popup
                    //elPopup.className = "popup popupType2 chiudiPopup";  nooooooooooooooooooooooo!
                    if (elPopup.className.indexOf("chiudiPopup") == -1)
                        elPopup.className += " chiudiPopup";
                    elPopup.className = elPopup.className.replace("apriPopup", "");

                    setTimeout(function () { elPopup.style.display = "none" }, 480);

                    // ricarico l'elemento tabellaVoci e dettaglioAnagrafica
                    iwebCaricaElemento(idTabella);
                    iwebBind("popupModificaAnagraficaVoce");
                    //iwebCaricaElemento("tabellaVoci");
                    //iwebCaricaElemento("tabellaVoci", false, false, function () { iwebTABELLA_SelezionaRigaComeUnica() });

                    if (nomeNuovaSuddivisione != "") { // se è stata inserita una nuova divisione aggiorna i dll di tabella, modifica e inserimento
                        iwebCaricaElemento("tabellaVociDDLSuddivisioni");
                        iwebCaricaElemento("popupTabellaVociInserimentoDDLSuddivisioni");
                        iwebCaricaElemento("popupTabellaVociModificaDDLSuddivisioni");
                        iwebCaricaElemento("ddlFiltroGenericoSuddivisioni");
                    }

                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }

        xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/modificaVoce", true);
        var jsonAsObject = {
            parametriQuery: parametriQuery,
            parametriQuery2: parametriQuery2
        }

        //console.log(jsonAsObject);
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}

// precarico nel popup idPopup='popupTabellaVociInserimento' all'input codice il valore
function preCaricaCodiceVoce() {
    var idPopup = "popupTabellaVociInserimento";
    var elSelezionato = document.getElementById("IDCOMPUTO");
    var idComputo = 0;
    if (elSelezionato != null)
        idComputo = parseInt(document.getElementById("IDCOMPUTO").innerHTML);

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery[0].errore == null) {
                // codice qui

                document.getElementById(idPopup).getElementsByClassName("iwebCAMPO_voce.codice")[0].value = jsonRisultatoQuery;

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/trovaVoceSuccessiva", true);
    var jsonAsObject = { idComputo: idComputo };

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}
function preCaricaPosizioneVoce(el) {
    var posizione = 99999;
    if (el == null) {
        // nuova suddivisione (sto cliccando sul più nell'header della tabella): mostro "Nuova suddivisione" e permetto scelta nella DDL suddivisione
        posizione = 99999;
        document.getElementById("popupTabellaVociInserimentoDDLSuddivisioni").disabled = false;
        iwebDDL_aggiornaSelezionati("popupTabellaVociInserimentoDDLSuddivisioni", []);
        document.getElementById("popupTabellaVociInserimento_trNuovaSuddivisione").className = "";
    } else {
        // nuova suddivisione (sto cliccando sul più in una riga): nascondo "Nuova suddivisione" e disabilito la DDL suddivisione
        var temp = el.parentElement.parentElement.getElementsByClassName("iwebCAMPO_voce.posizione")[0].innerHTML;
        posizione = temp == "" ? 99999 : parseInt(temp) + 1;
        temp = el.parentElement.parentElement.getElementsByClassName("iwebCAMPO_suddivisione.id")[0].innerHTML;
        console.log(temp);
        iwebDDL_aggiornaSelezionati("popupTabellaVociInserimentoDDLSuddivisioni", temp);
        //iwebCaricaElemento("popupTabellaVociInserimentoDDLSuddivisioni");
        document.getElementById("popupTabellaVociInserimentoDDLSuddivisioni").disabled = true;
        document.getElementById("popupTabellaVociInserimento_trNuovaSuddivisione").className = "iwebNascosto";
    }

    var idPopup = "popupTabellaVociInserimento";
    var popupAssociato = document.getElementById(idPopup);
    popupAssociato.getElementsByClassName("iwebCAMPO_voce.posizione")[0].innerHTML = posizione;
}

// precarico nel popup idPopup='popupTabellaMisureInserimento' all'input codice il valore
function preCaricaCodiceMisura() {
    var idPopup = "popupTabellaMisureInserimento";

    // ottengo il primo elemento selezionato (se ce ne sono di più, gli altri vengono ignorati)
    var elSelezionato = document.getElementById("tabellaVoci").getElementsByClassName("iwebRigaSelezionata")[0];
    var idVoce = 0;
    if (elSelezionato != null)
        idVoce = parseInt(elSelezionato.getElementsByClassName("iwebCAMPO_voce.id")[0].innerHTML);

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (typeof(jsonRisultatoQuery) == "number")
                document.getElementById(idPopup).getElementsByClassName("iwebCAMPO_sottocodice")[0].value = jsonRisultatoQuery;
            else
                document.getElementById(idPopup).getElementsByClassName("iwebCAMPO_sottocodice")[0].value = "";
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/trovaMisuraSuccessiva", true);
    var jsonAsObject = { idVoce: idVoce };

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}

function calcolaTextareaComputo(el, idTextAreaDaAggiornare, idPopup) {
    //var el = event.srcElement;
    // preparo testo iniziale e finale
    var testoIniziale = el.value;
    var testoFinale = "";

    // divido il testo iniziale in righe per ottenere il: testoFinale
    var righe = testoIniziale.split("\n");
    var nRighe = righe.length;
    for (var i = 0; i < nRighe; i++) {
        // percorro le righe, ogni volta che trovo il simbolo di uguale a inizio riga valuto la riga
        var rigaValutata = "";
        if (righe[i][0] == "=") {
            var stringaDaValutare = righe[i].substr(1, righe[i].length - 1);
            stringaDaValutare = valutaElevamentiPotenza(stringaDaValutare);
            rigaValutata = stringaDaValutare + " = " + parseFloat(eval(stringaDaValutare)).toFixed(2);
        }
        testoFinale += rigaValutata + "\r\n";
    }

    // divido il testo finale in righe per calcolare: totaleMisura
    righe = testoFinale.split("\n");
    nRighe = righe.length;
    var totaleMisura = 0;
    for (var i = 0; i < nRighe; i++) {
        // percorro le righe, ogni volta che trovo il simbolo di uguale a inizio riga valuto la riga
        if (righe[i].indexOf("=") >= 0)
            totaleMisura += parseFloat(trim(righe[i].split("=")[1]));
    }

    document.getElementById(idTextAreaDaAggiornare).value = testoFinale;
    document.getElementById(idPopup).getElementsByClassName("iwebCAMPO_totalemisura")[0].innerHTML = parseFloat(totaleMisura).toFixed(2);

    var prezzoUnitario = document.getElementById(idPopup).getElementsByClassName("iwebCAMPO_prezzounitario")[0].value;
    document.getElementById(idPopup).getElementsByClassName("iwebCAMPO_totaleimporto")[0].innerHTML = (parseFloat(totaleMisura) * parseFloat(prezzoUnitario)).toFixed(2);

} 

function ricalcolaAltezzaTextareaComputo(idTextAreaDaAggiornare) {
    var el = event.srcElement;
    document.getElementById(idTextAreaDaAggiornare).style.height = el.style.height;
}

function aggiornaImmagine(idPopup, idFileUpload, nomeSQL) {
    var elPopup = document.getElementById(idPopup);
    var el = event.srcElement; // this
    var elFileUpload = document.getElementById(idFileUpload);
    var datiImmagine = elFileUpload.getElementsByTagName("span")[0].innerHTML;
    var nomeImmagine = elFileUpload.getElementsByTagName("span")[1].innerHTML;

    // cerco nel popup la query di update
    var elQueryUpdate = el.parentElement.getElementsByClassName(nomeSQL)[0];

    if (elQueryUpdate != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryUpdate);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryUpdate);
        //console.log(sqlQuery + "  /  " + parametriQuery)

        var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari*/ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery[0].errore == null) {
                    // codice qui

                    // chiudi e nascondi il popup
                    elPopup.className = "popup popupType2 chiudiPopup";
                    setTimeout(function () { elPopup.style.display = "none" }, 480);
                    //console.log(jsonRisultatoQuery);
                    nomeImmagine = jsonRisultatoQuery
                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }

                // aggiorno il dato in pagina nomeImmagine
                var id = elPopup.getElementsByClassName("iwebCAMPO_misura.id")[0].innerHTML;
                var listaTrTabellaMisure = document.getElementById("tabellaMisure").getElementsByTagName("tbody")[1].getElementsByTagName("tr");
                for (var i = 0; i < listaTrTabellaMisure.length; i++) {
                    console.log(listaTrTabellaMisure[i].getElementsByClassName("iwebCAMPO_misura.id")[0].innerHTML)
                    if (listaTrTabellaMisure[i].getElementsByClassName("iwebCAMPO_misura.id")[0].innerHTML == id) {
                        console.log("modifica qui");
                        listaTrTabellaMisure[i].getElementsByClassName("iwebCAMPO_pathimmagine")[0].innerHTML = nomeImmagine;
                    }
                }

            }
        }

        /*xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/prova2", true);
        //xmlhttp.open("POST", getRootPath() + "/Service.svc/servizioprova", true);
        datiImmagine = "";
        for (var i = 0; i < 30000000; i++) {
            datiImmagine += "aaa";
        }
        var jsonAsObject = {
            pippo: datiImmagine,
            tredici: 13
        }
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);*/

        //xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        //xmlhttp.send("pippo=" + datiImmagine + "&tredici=13");

        xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/aggiornaImmagine", true);
        var jsonAsObject = {
            query: sqlQuery, // string
            parametri: parametriQuery, // string
            datiImmagine: datiImmagine,
            nomeImmagine: nomeImmagine
        }

        console.log(sqlQuery + " / " + parametriQuery + " / " + nomeImmagine);
        //console.log(datiImmagine);
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }

}


// sleep(new Date().getTime(), timeout, stringaFunzioneDaValutare);
/*function sleep(datetime, timeout, stringafunzione) {
    var tempoTrascorso = new Date().getTime() - datetime;

    //console.log(tempoTrascorso)
    if (tempoTrascorso < timeout)
        setTimeout(function () { sleep(datetime, timeout, stringafunzione) }, 100);
    else
        eval(stringafunzione);
}*/


// chiamata: iwebEseguiSincrono(["miafun1()", "miafun2()"], 0)
/*function iwebEseguiSincrono(listaFunzioni, indice) {
    var iwebEseguiSincrono_oggetto = { finito: false };
    iwebEseguiSincrono_oggetto = eval(listaFunzioni[indice]);
    sleep2( function () { iwebEseguiSincrono(listaFunzioni, indice + 1) }, // funzione
            iwebEseguiSincrono_oggetto, // oggetto che contiene la variabile boolean finito
            new Date().getTime(), 2000); // parametri per il timeout
}*/

function iwebEseguiSincrono(listaFunzioni) {
    for (var i = 0; i < listaFunzioni.length; i++) {
        var iwebEseguiSincrono_oggetto = { finito: false };
        console.log(listaFunzioni[i]);
        eval(listaFunzioni[i]);
        while (iwebEseguiSincrono_oggetto.finito == false)
            alert(iwebEseguiSincrono_oggetto.finito);
        console.log("sono passato di qui3");
    }
}


function gestioneComputo_aggiornaMisuraEAggiornaElementiAssociati() {
    iwebTABELLA_ConfermaModificaRigaInPopup(
        'popupTabellaMisureModifica',
        'tabellaMisure',
        'sottocodice, unitadimisura.id, prezzounitario, descrizione, totalemisura, totaleimporto',
        'misura.id',
        true,
        gestioneComputo_aggiornaMisuraEAggiornaElementiAssociati_aggiorna);
}
function gestioneComputo_aggiornaMisuraEAggiornaElementiAssociati_aggiorna() {
    iwebAggiornaRigaSelezionataIwebTABELLA('tabellaVoci');
    iwebTABELLA_CalcoloTotaleColonne('tabellaVoci');
    iwebTABELLA_CalcoloTotaleColonne('tabellaMisure'); // non viene modificato il resto della tabella. solo la riga aggiornata e il totale.
}

function gestioneComputo_inserisciMisuraEAggiorna() {
    var idvoce = document.getElementById("tabellaVoci").getElementsByTagName("tbody")[1].getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_voce.id")[0].innerHTML;
    iwebTABELLA_ConfermaAggiungiRecordInPopup(
        'popupTabellaMisureInserimento',
        'tabellaMisure',
        '',
        true,
        function () { gestioneComputo_rinormalizzaPosizioneMisure(idvoce); gestioneComputo_inserisciMisuraEAggiorna_aggiorna(); });
}

function gestioneComputo_inserisciMisuraEAggiorna_poiRiproponiNuovaMisura() {
    var idvoce = document.getElementById("tabellaVoci").getElementsByTagName("tbody")[1].getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_voce.id")[0].innerHTML;
    iwebTABELLA_ConfermaAggiungiRecordInPopup(
        'popupTabellaMisureInserimento',
        'tabellaMisure',
        '',
        true,
        function () {
            gestioneComputo_rinormalizzaPosizioneMisure(idvoce);
            gestioneComputo_inserisciMisuraEAggiorna_aggiorna();

            /* riproponi l'inserimento di una nuova misura*/
            setTimeout(function () {
                apriPopupType2_bind('popupTabellaMisureInserimento', true);
                azzeraCampiInserimentoTabellaMisure();
                preCaricaCodiceMisura();
                document.getElementById('popupTabellaMisureInserimento').getElementsByClassName('iwebCAMPO_sottocodice')[0].focus();
            }, 500);
        });
}
function gestioneComputo_rinormalizzaPosizioneMisure(idvoce) {
    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                // codice qui

                //iwebCaricaElemento('tabellaMisure');

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/rinormalizzaPosizioneMisure", true);
    var jsonAsObject = { idvoce: parseInt(idvoce) };

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}
function gestioneComputo_inserisciMisuraEAggiorna_aggiorna() {
    // iwebTABELLA_Carica(idTabella, 0, true) -> contenuto nell'inserimento
    iwebAggiornaRigaSelezionataIwebTABELLA('tabellaVoci');
    iwebTABELLA_CalcoloTotaleColonne('tabellaVoci');
}
function gestioneComputo_eliminaMisuraEAggiorna() {
    // specifica per questa pagina
    gestioneComputo_iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaMisureElimina', 'tabellaMisure', true, gestioneComputo_eliminaMisuraEAggiorna_aggiorna)
}
function gestioneComputo_eliminaMisuraEAggiorna_aggiorna() {
    // iwebTABELLA_Carica(idTabella, 0, true) -> contenuto nell'eliminazione
    iwebAggiornaRigaSelezionataIwebTABELLA('tabellaVoci');
    iwebTABELLA_CalcoloTotaleColonne('tabellaVoci');

}

//spostaMisuraSopra()
function onclick_spostaMisuraSopra(nomeCampo) {
    var el = event.srcElement;
    var idMisura = el.parentElement.parentElement.parentElement.getElementsByClassName("iwebCAMPO_" + nomeCampo)[0].innerHTML;

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                // codice qui

                iwebCaricaElemento('tabellaMisure');

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/spostaMisuraSopra", true);
    var jsonAsObject = { IDMisuraDaSpostare: idMisura };

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}
function onclick_spostaMisuraSotto(nomeCampo) {
    var el = event.srcElement;
    var idMisura = el.parentElement.parentElement.parentElement.getElementsByClassName("iwebCAMPO_" + nomeCampo)[0].innerHTML;

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                // codice qui

                iwebCaricaElemento('tabellaMisure');

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/spostaMisuraSotto", true);
    var jsonAsObject = { IDMisuraDaSpostare: idMisura };

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}



function gestioneComputo_iwebTABELLA_ConfermaAzionePerSelezionati() {
    var el = event.srcElement;
    // ottengo il tipo di azione
    var select_ = precedenteElemento(precedenteElemento(el));
    var idAzioneSelezionata = select_.selectedIndex;
    var azioneSelezionata = select_.getElementsByTagName("option")[idAzioneSelezionata].innerHTML;
    var valoreAzioneSelezionata = select_.getElementsByTagName("option")[idAzioneSelezionata].value;

    // console.log(valoreAzioneSelezionata);
    // console.log(azioneSelezionata);

    // devo rimappare la suddivisione di tutti gli elementi selezionati
    // 1. ottengo la lista di id di elementi da modificare
    // 2. passo li risultato alla query

    if (azioneSelezionata != "") {
        var x = confirm("Confermi la rimappatura della suddivisione degli elementi selezionati a '" + azioneSelezionata + "' ?");

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
            var parametriQuery = [];
            for (var i = 0; i < listaCheckBoxSelezionati.length; i++) {
                var rigaSelezionata = listaCheckBoxSelezionati[i] - 1;
                for (var j = 0; j < campiChiaveTabella.length; j++) {
                    var campoChiave = campiChiaveTabella[j];
                    var valoreCampo = tbodyVisibile.getElementsByTagName("tr")[rigaSelezionata].getElementsByClassName("iwebCAMPO_" + campoChiave)[0].innerHTML;
                    parametriQuery.push(valoreCampo);
                }
            }

            var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    console.log("eseguito");
                    // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                    var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                    jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                    if (jsonRisultatoQuery[0].errore == null) {
                        // ricarica la tabella
                        iwebCaricaElemento(idTabella, true);
                        // iwebTABELLA_Carica(idTabella, 0, true)
                    } else {
                        console.log("errore json " + jsonRisultatoQuery[0].errore);
                    }
                }
            }

            // versione WebService.asmx/sparaQueryDelete
            xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/rimappaSuddivisioneVoci", true);
            var jsonAsObject = {
                idSuddivisione: parseInt(valoreAzioneSelezionata), // int
                listaParametri: parametriQuery // string[]
            }

            console.log(jsonAsObject)
            xmlhttp.setRequestHeader("Content-type", "application/json");
            var jsonAsString = JSON.stringify(jsonAsObject);
            xmlhttp.send(jsonAsString);


        } // fine azioneSelezionata != ""
    }
}

// specifica per questa pagina
function gestioneComputo_iwebTABELLA_ConfermaEliminaRigaInPopup(IdPopupAssociato, idTabella, attesaRispostaServer, funzioneAFineEsecuzione) {
    // esempio --> popupAssociato = "popupEliminaRiga"
    var popupAssociato = document.getElementById(IdPopupAssociato);
    var idvoce = parseInt(popupAssociato.getElementsByClassName("iwebCAMPO_misura.idvoce")[0].innerHTML);
    var idmisura = parseInt(popupAssociato.getElementsByClassName("iwebCAMPO_misura.id")[0].innerHTML);

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
                // ricarica la tabella
                iwebTABELLA_Carica(idTabella, 0, true)
            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }

            if (funzioneAFineEsecuzione && typeof funzioneAFineEsecuzione === "function")
                funzioneAFineEsecuzione();
        }
        if (xmlhttp.status == 500) {
            console.log("%cErrore json: possibile tipo di parametri sbagliato?", "color:darkred"); for (var t = 0; t < Object.getOwnPropertyNames(jsonAsObject).length; t++) {
                var xmlhttp_parametro = Object.getOwnPropertyNames(jsonAsObject)[t];
                console.log("%c    " + typeof (xmlhttp_parametro) + " " + xmlhttp_parametro + " = " + '"' + jsonAsObject[xmlhttp_parametro] + '"', "color:darkred");
            }
        }
    }
    xmlhttp.onerror = function () {
        console.log("errore qui");
    }
    // versione WebService.asmx/sparaQueryDelete
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/eliminaENormalizzaMisura", true);
    var jsonAsObject = {
        idmisura: idmisura,
        idvoce: idvoce
    }
    //console.log(jsonAsObject)
    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);

    // chiudi e nascondi il popup
    popupAssociato.className = "popup popupType2 chiudiPopup";
    setTimeout(function () { popupAssociato.style.display = "none" }, 480);

}

// entro in questa funzione subito dopo aver eliminato con successo una riga nella tabella voci
function gestioneComputo_iwebTABELLA_ConfermaEliminaRigaInPopup_tabellaVoci(IdPopupAssociato, idTabella, attesaRispostaServer, funzioneAFineEsecuzione) {
    // esempio --> popupAssociato = "popupEliminaRiga"
    var popupAssociato = document.getElementById(IdPopupAssociato);
    if (popupAssociato == null)
        console.log("%cErrore nella conferma dell'eliminazione. Non trovo il popup " + IdPopupAssociato, "color:darkred");
    if (document.getElementById(idTabella) == null)
        console.log("%cErrore nella conferma dell'eliminazione. Non trovo la tabella associata " + idTabella, "color:darkred");

    // OTTENGO L'IDSUDDIVISIONE. La userò in seguito per rimappare le voci associate
    var idSuddivisione = popupAssociato.getElementsByClassName("iwebCAMPO_suddivisione.id")[0].innerHTML;
    var idvoce = parseInt(popupAssociato.getElementsByClassName("iwebCAMPO_voce.id")[0].innerHTML);

    if (attesaRispostaServer)
        iwebMostraCaricamentoAjax();

    var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari*/ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function (e) {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 500) { var errore = e.target.response; if (errore.substr(0, 5) == "<!DOC") { console.log(errore.split("</html>")[1]); } else { errore = JSON.parse(errore); console.log(errore.ExceptionType + "\n" + errore.Message + "\n" + errore.StackTrace); } }
        else if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // HO ELIMINATO VOCE E MISURE ASSOCIATE (+immagini delle misure associate)
            if (attesaRispostaServer)
                iwebNascondiCaricamentoAjax();

            // chiudi e nascondi il popup
            chiudiPopupType2B(popupAssociato);

            // ricarica la tabella
            iwebTABELLA_Carica(idTabella, 0, true);

            // rimappa le voci
            rimappaVociDellaSuddivisione(idSuddivisione);

            if (funzioneAFineEsecuzione && typeof funzioneAFineEsecuzione === "function")
                funzioneAFineEsecuzione();

        }
    }

    // versione WebService.asmx/sparaQueryDelete
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/eliminaVoce", true);
    var jsonAsObject = {
        idvoce: idvoce
    }
    //console.log(jsonAsObject)
    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}

// esempio: rimappaVociDellaSuddivisione(140)
function rimappaVociDellaSuddivisione(idsuddivisione) {
    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery[0].errore == null) {
                // ricarica la tabella
                // iwebCaricaElemento(idTabella, true);
                // iwebTABELLA_Carica(idTabella, 0, true)
            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    // versione WebService.asmx/sparaQueryDelete
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/rinormalizzaPosizioneVoci", true);
    var jsonAsObject = {
        idsuddivisione: parseInt(idsuddivisione) // int
    }
    //console.log(jsonAsObject)
    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}

function azzeraCampiInserimentoTabellaVoci() {
    var elPopup = document.getElementById("popupTabellaVociInserimento");

    // azzero gli input
    var listaElInput = elPopup.getElementsByTagName("input");
    for (var i = 0; i < listaElInput.length; i++) {
        listaElInput[i].value = "";
    }

    // azzero il textarea
    var listaElTextArea = elPopup.getElementsByTagName("textarea");
    for (var i = 0; i < listaElTextArea.length; i++) {
        listaElTextArea[i].value = "";
    }
}

function azzeraCampiInserimentoTabellaMisure() {
    var elPopup = document.getElementById("popupTabellaMisureInserimento");

    // azzero gli input
    var listaElInput = elPopup.getElementsByTagName("input");
    for (var i = 0; i < listaElInput.length; i++) {
        listaElInput[i].value = "";
    }

    // azzero il textarea
    var listaElTextArea = elPopup.getElementsByTagName("textarea");
    for (var i = 0; i < listaElTextArea.length; i++) {
        listaElTextArea[i].value = "";
    }

    // aggiorno gli span
    var elSuddivisione = document.getElementById("tabellaVoci").getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_suddivisione.descrizione")[0];
    var elVoce = document.getElementById("tabellaVoci").getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_voce.titolo")[0];

    var suddivisione = "";
    if (elSuddivisione.title != "") suddivisione = elSuddivisione.title; else suddivisione = elSuddivisione.innerHTML;

    var voce = "";
    if (elVoce.title != "") voce = elVoce.title; else voce = elVoce.innerHTML;

    elPopup.getElementsByClassName("popupTabellaMisureInserimento_suddivisionedescrizione")[0].innerHTML = suddivisione;
    elPopup.getElementsByClassName("popupTabellaMisureInserimento_vocetitolo")[0].innerHTML = voce;
}

function modificaMisura_aggiornaSpan() {
    var elPopup = document.getElementById("popupTabellaMisureModifica");

    // aggiorno gli span
    var elSuddivisione = document.getElementById("tabellaVoci").getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_suddivisione.descrizione")[0];
    var elVoce = document.getElementById("tabellaVoci").getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_voce.titolo")[0];

    var suddivisione = "";
    if (elSuddivisione.title != "") suddivisione = elSuddivisione.title; else suddivisione = elSuddivisione.innerHTML;

    var voce = "";
    if (elVoce.title != "") voce = elVoce.title; else voce = elVoce.innerHTML;

    elPopup.getElementsByClassName("popupTabellaMisureModifica_suddivisionedescrizione")[0].innerHTML = suddivisione;
    elPopup.getElementsByClassName("popupTabellaMisureModifica_vocetitolo")[0].innerHTML = voce;
}

function modificaImmagine_mostraDatiVoce() {
    var elPopup = document.getElementById("popupTabellaMisureModificaSoloImmagine");

    // aggiorno gli span
    var elSuddivisione = document.getElementById("tabellaVoci").getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_suddivisione.descrizione")[0];
    var elVoce = document.getElementById("tabellaVoci").getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_voce.titolo")[0];

    var suddivisione = "";
    if (elSuddivisione.title != "") suddivisione = elSuddivisione.title; else suddivisione = elSuddivisione.innerHTML;

    var voce = "";
    if (elVoce.title != "") voce = elVoce.title; else voce = elVoce.innerHTML;

    elPopup.getElementsByClassName("popupTabellaMisureModificaSoloImmagine_suddivisionedescrizione")[0].innerHTML = suddivisione;
    elPopup.getElementsByClassName("popupTabellaMisureModificaSoloImmagine_vocetitolo")[0].innerHTML = voce;
}


function gestioneComputo_duplicaRigaTabellaVoci(el) {
    var attesaRispostaServer = true

    var elTr = el.parentElement.parentElement;
    var idVoce = elTr.getElementsByClassName("iwebCAMPO_voce.id")[0].innerHTML;

    var popupInserimento = document.getElementById("popupTabellaVociInserimento");
    var elQuerySelectDuplica = document.getElementById("iwebSQLSELECTduplica");
    if (elQuerySelectDuplica != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQuerySelectDuplica);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQuerySelectDuplica) + "&&&";
        parametriQuery = parametriQuery.substr(0, parametriQuery.length - 3); // tolgo gli ultimi 3 caratteri ("&&&")
        // cerco gli elementi che sono presenti sia nella riga che nel popup associato "iwebCAMPO_"
        var allElements_popupAssociato = popupInserimento.getElementsByTagName("*");

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
                    var recordRisultato = jsonRisultatoQuery[1];
                    console.log(recordRisultato);

                    // apro il popup per l'inserimento
                    azzeraCampiInserimentoTabellaVoci();
                    preCaricaCodiceVoce();
                    preCaricaPosizioneVoce(null);
                    apriPopupType2('popupTabellaVociInserimento', true);
                    iwebCaricaElemento("popupTabellaVociInserimentoDDLSuddivisioni", true, function () {
                        popupInserimento.getElementsByClassName('iwebCAMPO_voce.codice')[0].focus();
                        popupInserimento.getElementsByClassName('iwebCAMPO_voce.posizione')[0].innerHTML = recordRisultato.posizione;
                        popupInserimento.getElementsByClassName('iwebCAMPO_voce.titolo')[0].getElementsByTagName("input")[0].value = recordRisultato.titolo;
                        popupInserimento.getElementsByClassName('iwebCAMPO_voce.descrizione')[0].value = recordRisultato.descrizione;
                        // recordRisultato.idsuddivisione
                        /*if (recordRisultato.idsuddivisione != null && parseInt(recordRisultato.idsuddivisione) > 0) {
                            var elSelectSuddivisione = document.getElementById('popupTabellaVociInserimentoDDLSuddivisioni');
                            var elOptionSelectSuddivisione = elSelectSuddivisione.getElementsByTagName("option");
                            for (var i = 0; i < elOptionSelectSuddivisione.length; i++) {
                                console.log(elOptionSelectSuddivisione.length)

                                if (elOptionSelectSuddivisione[i].value == recordRisultato.idsuddivisione)
                                    elSelectSuddivisione.selectedIndex = i;
                            }
                        }*/
                    });


                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }

            }
        }


        // versione WebService.asmx/sparaQueryReader
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReader", true);
        var jsonAsObject = {
            query: sqlQuery, // string
            pageSize: 1, // int
            pageNumber: 0, // int
            datiFiltri: [], // object[] datiFiltri
            ordinamento: [], // String[] ordinamento
            parametriChiocciola: parametriQuery
        };

        //console.log(jsonAsObject);
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }

}