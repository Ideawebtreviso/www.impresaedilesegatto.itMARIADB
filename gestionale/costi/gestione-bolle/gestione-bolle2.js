function gestioneBolle_scaricaBolla(idBolla) {
    location.replace("../scarico-bolla/scarico-bolla.aspx?IDBOLLA=" + idBolla);
}
/*
function gestioneBolle_eliminaBolla() {
    // eliminare una bolla: eliminare la scansione (?)
    // eliminare le righebolla associate: in più se sono righe chiuse eliminare anche le righe aperte (le righe chiuse sono create da una base di un record di riga aperta)

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

                // elimina la bolla
                eliminaBolla();

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
*/
function eliminaBolla() {
    var idBolla = document.getElementById("tabellaBolle").getElementsByTagName("tbody")[1].getElementsByClassName("iwebRigaSelezionata")[0].getElementsByClassName("iwebCAMPO_bollafattura.id")[0].innerHTML;

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

                // chiudi e nascondi il popup
                elPopup = document.getElementById("popupTabellaBolleElimina");
                chiudiPopupType2B(elPopup);

                // ricarica la tabella
                iwebTABELLA_Carica("tabellaBolle", 0, true)

                /*if (funzioneAFineEsecuzione && typeof funzioneAFineEsecuzione === "function")
                    funzioneAFineEsecuzione();*/
            } else {
                if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                else console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/eliminaBolla", true);
    var jsonAsObject = {
        idBolla: parseInt(idBolla)
    }
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.setRequestHeader("Content-type", "application/json");
    xmlhttp.send(jsonAsString);
}

function popupTabellaBolleInserimentoVerificaInserimentiDoppi(funzioneAFineEsecuzione) {
    var numero = document.getElementById("popupTabellaBolleInserimento").getElementsByClassName("iwebCAMPO_bollafattura.numero")[0].value;
    var giornomeseanno = document.getElementById("popupTabellaBolleInserimento").getElementsByClassName("iwebCAMPO_bollafattura.databollafattura")[0].value;
    var idfornitore = document.getElementById("popupTabellaBolleInserimento").getElementsByClassName("iwebCAMPO_fornitore.id")[0].value;

    // precontrollo che le stringhe non siano vuote:
    if (numero == "" || giornomeseanno == "" || idfornitore == "-1") {
        alert("Numero, data e fornitore sono campi obbligatori");
        return;
    }

    // anno è ancora una data in formato stringa da cui devo estrarre giorno e mese
    giornomeseanno = giornomeseanno.split("/").join("-").split(".").join("-").split(" ").join("-");
    if (giornomeseanno.split("-").length == 3) {
        var giorno = giornomeseanno.split("-")[0];
        var mese = giornomeseanno.split("-")[1];
        var anno = giornomeseanno.split("-")[2];

        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                    // codice qui
                    var esisteGia = jsonRisultatoQuery[0].risultato == "1";
                    if (esisteGia) {
                        alert('Esiste già una bolla o una fattura con questa combinazione di numero-giorno-mese-anno-fornitore.')
                    } else {
                        if (funzioneAFineEsecuzione && typeof funzioneAFineEsecuzione === "function")
                            funzioneAFineEsecuzione();
                    }
                } else {
                    if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                    else console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }
        xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/verificaInserimentiDoppi", true);
        var jsonAsObject = {
            numero: numero,
            giorno: giorno,
            mese: mese,
            anno: anno,
            idfornitore: idfornitore
        }
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.setRequestHeader("Content-type", "application/json");
        xmlhttp.send(jsonAsString);
    } else {
        alert("giorno-mese-anno non hanno un valore valido");
    }

}
