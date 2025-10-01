function stampaComputo() {
    // devono essere fatte queste 3 cose, all'interno della prima funzione viene lanciata la seconda l'interno della seconda vien lanciata la terza
    salvaDatiComputo();
    //salvaDatiSuddivisioni();
    //lanciaStampa();
}

function salvaDatiComputo() {
    //var idComputo = document.getElementById("IDCOMPUTO").innerHTML;
    //var stampaPrezzi = document.getElementById("stampaPrezzi").checked;
    //var stampaCopertina = document.getElementById("stampaCopertina").checked;
    //var stampaSuddivisioni = document.getElementById("stampaSuddivisioni").checked;
    //var stampaMisure = document.getElementById("stampaMisure").checked;
    var titoloComputo = document.getElementById("titoloComputo").value;
    var dataDiStampa = document.getElementById("dataDiStampa").value;
    var stampaIva = document.getElementById("stampaIva").value;

    var stampaValida = true;

    if (titoloComputo.length > 100) {
        stampaValida = false;
        document.getElementById("titoloComputo").style.border = "solid 1px red";
    }
    if (dataDiStampa == ""){
        stampaValida = false;
        document.getElementById("dataDiStampa").style.border = "solid 1px red";
    }
    if (stampaIva != "" && regexNumeroFloat(stampaIva) == false) {
        stampaValida = false;
        document.getElementById("stampaIva").style.border = "solid 1px red";
    }
    // stampa
    if (stampaValida) {
        // cancello gli eventuali bordi rossi che segnalavano l'errore del campo
        document.getElementById("titoloComputo").style.border = "";
        document.getElementById("dataDiStampa").style.border = "";

        var elQueryInsert = document.getElementsByClassName("iwebSQLINSERT")[0];
        if (elQueryInsert != null) {
            var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryInsert);
            var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryInsert) + "&&&";
            parametriQuery = parametriQuery.substr(0, parametriQuery.length - 3); // tolgo gli ultimi 3 caratteri ("&&&")

            var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                    var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                    if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                    if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                        // codice qui

                        // ottengo l'ID dell'ultimo elemento inserito
                        var idStampa = jsonRisultatoQuery[0].risultato;
                        salvaDatiSuddivisioni(idStampa);

                        // ricarico la tabella stampe
                        iwebCaricaElemento("tabellaStampe");

                    } else {
                        if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                        else console.log("errore json " + jsonRisultatoQuery[0].errore);
                    }
                }
            }

            xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryInsertIdentity", true);
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


function salvaDatiSuddivisioni(idStampa) {
    var listaSuddivisioniDaStampare = document.getElementById("tabellaSuddivisioni").getElementsByTagName("tbody")[1].getElementsByTagName("tr");
    var suddivisioni = [];

    // if per verificare se sto visualizzando almeno una riga valida e non "Nessun elemento trovato"
    if (listaSuddivisioniDaStampare[0].getElementsByClassName("iwebCAMPO_id")[0] != null) {
        for (var i = 0; i < listaSuddivisioniDaStampare.length; i++) {
            var idSuddivisione = listaSuddivisioniDaStampare[i].getElementsByClassName("iwebCAMPO_id")[0].innerHTML;
            var dastampare = listaSuddivisioniDaStampare[i].getElementsByClassName("iwebCAMPO_truefalse")[0].checked;
            if (dastampare)
                suddivisioni.push(idSuddivisione);
        }
    }

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                // codice qui

                // ottengo l'ID dell'ultimo elemento inserito
                //var idSudd = jsonRisultatoQuery[0].risultato;
                lanciaStampa(idStampa);


            } else {
                if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                else console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/salvaPDFSuddivisioni", true);
    var jsonAsObject = {
        idStampa: idStampa,
        suddivisioni: suddivisioni
    }
    console.log(jsonAsObject);
    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}



function lanciaStampa(idStampa) {
    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
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
                var percorsoFile = document.getElementById("percorsoUploadPDFGestionale").innerHTML; // lo trovo nella master
                var miaWindow = window.open(percorsoFile + nomeFile, '_blank');

                // entra in modalità stampa
                //miaWindow.print();

            } else {
                if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                else console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/stampaPDF", true);
    var jsonAsObject = {
        idStampa: parseInt(idStampa)
    };

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}
