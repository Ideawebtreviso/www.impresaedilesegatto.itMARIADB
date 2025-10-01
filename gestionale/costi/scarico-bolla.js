function scaricoBolla_scarica() {
    var datiIncompleti = false;

    // idbolla della querystring deve essere valorizzata
    var idbollafattura = document.getElementById("IDBOLLA").innerHTML;
    if (idbollafattura == "0")
        datiIncompleti = true;

    // campi obbligatori
    if (document.getElementById("nuovoCantiere").getElementsByTagName("input")[0].value == "") // valore
        datiIncompleti = true;
    if (document.getElementById("nuovoCantiere").getElementsByTagName("span")[1].innerHTML == "") // chiave
        datiIncompleti = true;
    if (document.getElementById("nuovoProdotto").getElementsByTagName("input")[0].value == "") // valore
        datiIncompleti = true;
    if (document.getElementById("nuovoProdotto").getElementsByTagName("span")[1].innerHTML == "") // chiave
        datiIncompleti = true;
    if (document.getElementById("nuovoQuantita").value == "")
        datiIncompleti = true;

    // ho verificato di avere i dati necessari
    if (datiIncompleti == false) {

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

                        scaricoBolla_scarica_parte2();

                        scaricoBolla_azzeraCampi();
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

// ho dovuto dividere la funzione in due parti perchè per qualche motivo (probabilmente variabili in conflitto) non venivano conclusi correttamente entrambi gli xmlhttp.
function scaricoBolla_scarica_parte2() {
    // aggiorna il prezzolistino-sconto1-sconto2
    if (document.getElementById("aggiornaPrezzoAnagrafica").checked) {
        var elQueryInsert = document.getElementsByClassName("iwebSQLQUERY2")[0];
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

function scaricoBolla_azzeraCampi() {
    // document.getElementById("nuovoCantiere").getElementsByTagName("input")[0].value = ""; il nuovoCantiere non si azzera
    document.getElementById("nuovoProdotto").getElementsByTagName("input")[0].value = "";
    document.getElementById("nuovoQuantita").value = "";
    document.getElementById("nuovoPrezzo").value = "";
    document.getElementById("nuovoSconto1").value = "";
    document.getElementById("nuovoSconto2").value = "";
    document.getElementById("aggiornaPrezzoAnagrafica").checked = true;
}

