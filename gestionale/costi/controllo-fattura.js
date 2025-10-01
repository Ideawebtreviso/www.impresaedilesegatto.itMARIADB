// creo questa funzione per caricare la tabella bolle aperte solo dopo che questa funzione termina
function controlloFattura_iwebTABELLA_Carica(idTabella, nPagina, attesaRispostaServer) {
    //document.getElementById(idTabella).getElementsByClassName("iwebPAGENUMBER")[0].getElementsByTagName("input")[0].value = "1";

    var elTabella = document.getElementById(idTabella);
    var tBodySorg = elTabella.getElementsByTagName("tbody")[0];
    var tBodyDest = elTabella.getElementsByTagName("tbody")[1];

    // prendi il prossimo elemento cerca ricorsivamente gli span finchè non trovi quello con l'sql giusto -> TODO
    var elQuerySelect = iwebOttieniSqlRicors(prossimoElemento(document.getElementById(idTabella)), "select");
    // cerco nel popup la query di select
    if (elQuerySelect != null) {
        //var querySelect = generaQueryDaSpanSql(elQuerySelect);
        var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
        var parametriChiocciola = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);
        //console.log(querySelect);
        //console.log([querySelect, parametriChiocciola]);
        // page size e page number
        //var pageNumber = document.getElementById(idTabella).getElementsByClassName("iwebPAGENUMBER")[0].getElementsByTagName("input")[0].value;
        //pageNumber = pageNumber - 1; // in visualizzazione considero le pagine da 1 a n, ma nel calcolo devo considerare le pagine da 0 a n-1
        var pageNumber = nPagina <= 1 ? 0 : nPagina - 1;
        var tempSelect = document.getElementById(idTabella).getElementsByClassName("iwebPAGESIZE")[0].getElementsByTagName("select")[0];
        var pageSize = tempSelect.getElementsByTagName("option")[tempSelect.selectedIndex].value;

        var datiFiltri = iwebTABELLA_OttieniDatiFiltri(idTabella);

        // ottieni i dati sull'ordinamento
        var datiOrdinamento = iwebTABELLA_OttieniDatiOrdinamento(idTabella);

        if (attesaRispostaServer)
            iwebMostraCaricamentoAjax();

        var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari */ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (attesaRispostaServer)
                    iwebNascondiCaricamentoAjax();

                if (jsonRisultatoQuery[0].errore == null) {
                    var nRigheContate = jsonRisultatoQuery[0].elementiContati;
                    var nColonne = tBodySorg.getElementsByTagName("td").length;

                    if (nRigheContate == 0) {
                        // genero il corpo
                        tBodyDest.innerHTML = "<tr><td colspan='" + nColonne + "'>Nessun elemento trovato</td></tr>";
                        // genero il footer (paging)
                        var tFoot = document.getElementById(idTabella).getElementsByTagName("tfoot");
                        var tHead = document.getElementById(idTabella).getElementsByTagName("thead");
                        tFoot[0].getElementsByTagName("tr")[1].getElementsByTagName("td")[0].colSpan = tHead[0].getElementsByTagName("th").length; // imposta il td dell'unica colonna larga come tutte le colonne
                        // calcolo i totali
                        iwebTABELLA_CalcoloTotaleColonne(idTabella);
                    } else {
                        // ottengo il codice originale da modificare e ripetere N volte.
                        iwebTABELLA_GeneraRigheTabella(jsonRisultatoQuery, tBodySorg, tBodyDest);
                        // genero il footer (paging)
                        iwebTABELLA_GeneraFooterTabella(idTabella, nRigheContate, pageSize, pageNumber, nColonne);
                        // calcolo i totali
                        iwebTABELLA_CalcoloTotaleColonne(idTabella);
                        // aggiorno i selezionati per le azioni su più righe
                        iwebTABELLA_AggiornaConteggioSelezionati(elTabella);
                        //if (pageNumber > 0)
                        //    document.getElementById(idTabella).getElementsByClassName("iwebPAGENUMBER")[0].getElementsByTagName("input")[0].value = pageNumber;
                    }

                    iwebCaricaElemento("tabellaBolleAperte");
                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }
        // versione WebService.asmx/sparaQueryReader
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReader", true);
        var jsonAsObject = {
            query: querySelect, // string
            pageSize: pageSize, // int
            pageNumber: pageNumber, // int
            datiFiltri: datiFiltri, // object
            ordinamento: datiOrdinamento, // array[2] -> NOMECAMPO, ASC||DESC
            parametriChiocciola: parametriChiocciola
        }

        //console.log(jsonAsObject)
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}


// inserisci su righe aperte un costo
function controlloFattura_inserisciCosto() {
    var elTabella = document.getElementById("tabellaRigheAperte");
    var listaElRigheModificabili = elTabella.getElementsByTagName("tbody")[1].getElementsByTagName("tr");
    var elementiDaAggiornare = [];
    var prodottiDaAggiornare = [];
    var query1 = document.getElementById("iwebSQLINSERISCICOSTO").innerHTML;
    var query2 = document.getElementById("iwebSQLAGGIORNADATOPRODOTTO").innerHTML;

    for (var i = 0; i < listaElRigheModificabili.length; i++) {
        // iwebCAMPO_costo.idbollafattura
        var elTemp = listaElRigheModificabili[i];
        var idbollafattura = document.getElementById("IDFATTURA").innerHTML;
        var idprodotto = elTemp.getElementsByClassName("iwebCAMPO_costo.idprodotto")[0].innerHTML;
        var idcantiere = elTemp.getElementsByClassName("iwebCAMPO_costo.idcantiere")[0].innerHTML;
        var idcostobollariferita = elTemp.getElementsByClassName("iwebCAMPO_costo.id")[0].innerHTML;
        var quantita = elTemp.getElementsByClassName("iwebCAMPO_costoinfattura.quantita")[0].value;
        var prezzo = elTemp.getElementsByClassName("iwebCAMPO_costoinfattura.prezzo")[0].value;
        var sconto1 = elTemp.getElementsByClassName("iwebCAMPO_costoinfattura.sconto1")[0].value;
        var sconto2 = elTemp.getElementsByClassName("iwebCAMPO_costoinfattura.sconto2")[0].value;
        var cbAggiornaDatoProdotto = elTemp.getElementsByClassName("cbAggiornaDatoProdotto")[0].checked; // checkbox

        var confermaInserimento = true;
        if (idbollafattura == "") confermaInserimento = false;
        if (idprodotto == "") confermaInserimento = false;
        if (idcantiere == "") confermaInserimento = false;
        if (idcostobollariferita == "") confermaInserimento = false;
        if (quantita == "") confermaInserimento = false;
        if (prezzo == "") confermaInserimento = false;
        if (sconto1 == "") sconto1 = "0";
        if (sconto2 == "") sconto2 = "0";

        if (confermaInserimento) {
            // ok procedo con l'inserimento
            var parametriQuery = "idbollafattura=" + idbollafattura + "&&&";
            parametriQuery += "idprodotto=" + idprodotto + "&&&";
            parametriQuery += "idcantiere=" + idcantiere + "&&&";
            parametriQuery += "idcostobollariferita=" + idcostobollariferita + "&&&";
            parametriQuery += "quantita=" + quantita + "&&&";
            parametriQuery += "prezzo=" + prezzo + "&&&";
            parametriQuery += "sconto1=" + sconto1 + "&&&";
            parametriQuery += "sconto2=" + sconto2 + "&&&";
            parametriQuery += "cbAggiornaDatoProdotto=" + cbAggiornaDatoProdotto;
            elementiDaAggiornare.push(parametriQuery);
        }
    }

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
                iwebCaricaElemento("tabellaBolleAperte");
                iwebCaricaElemento("elementoConITab");

            } else {
                if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                else console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/aggiornaRigheBolleAperte");
    var jsonAsObject = {
        listaparametri: elementiDaAggiornare,
        query1: query1,
        query2: query2
    }
    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}
