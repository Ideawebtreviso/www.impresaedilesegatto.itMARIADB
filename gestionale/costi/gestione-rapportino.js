function iwebQuadro_Carica(idQuadro) {
    var el = document.getElementById(idQuadro);

    /*
    1) ottengo i dati della prima riga
    2) ottengo i dati della prima colonna
    3) genero la tabella inserendo i dati ottenuti
    */
    if (el == null)
        console.log("%cErrore in iwebQuadro_Carica: " + idQuadro + " non esiste.", "color:darkred");
    else {
        // conto le righe (qua dentro, alla fine, conterò le colonne)
        eval("iwebQuadroCaricaRiga_" + idQuadro + "()");
    }
}

// ottengo i dati della riga (alla fine chiamerò la funzione per ottenere i dati delle colonne)
function iwebQuadroCaricaRiga_quadroRapportini() {
    var elQuadro = document.getElementById("quadroRapportini");
    var idQuadro = elQuadro.id;

    var datetime1 = document.getElementById("TextBoxDataDa").value.split("/").join("-");
    var datetime1_giorno = datetime1.split("-")[0];
    var datetime1_mese = datetime1.split("-")[1];
    var datetime1_anno = datetime1.split("-")[2];
    datetime1 = new Date(datetime1_anno, datetime1_mese, datetime1_giorno);

    var datetime2 = document.getElementById("TextBoxDataA").value.split("/").join("-");
    var datetime2_giorno = datetime2.split("-")[0];
    var datetime2_mese = datetime2.split("-")[1];
    var datetime2_anno = datetime2.split("-")[2];
    datetime2 = new Date(datetime2_anno, datetime2_mese, datetime2_giorno);

    var giorniRange = (datetime2 - datetime1) / (24 * 60 * 60 * 1000);
    giorniRange += 1; // primo e ultimo giorno compresi quindi serve il +1

    // devo disegnare giorniRange+1 colonne
    var arrayGiorni = [];
    var datetimeTemp = new Date(datetime1_anno, datetime1_mese, parseInt(datetime1_giorno) + 1);
    for (var i = 0; i < giorniRange; i++) {
        datetimeTemp = new Date(datetime1_anno, datetime1_mese, parseInt(datetime1_giorno) + i);
        arrayGiorni.push(datetimeTemp.getDate() + "-" + datetimeTemp.getMonth() + "-" + datetimeTemp.getFullYear());
    }
    // console.log(arrayGiorni);

    var thead4 = elQuadro.getElementsByTagName("thead")[0].getElementsByTagName("tr")[3];
    thead4.getElementsByTagName("span")[0].innerHTML = arrayGiorni.join(",");

    // ora conto le colonne
    eval("iwebQuadroCaricaColonna_" + idQuadro + "()");
}

// ottengo i dati della colonna (alla fine dovrò chiamare la funzione: iwebQuadroGeneraTabella(idQuadro);)
function iwebQuadroCaricaColonna_quadroRapportini() {
    var elQuadro = document.getElementById("quadroRapportini");
    var idQuadro = elQuadro.id;

    var elQuery = elQuadro.parentElement.getElementsByClassName("iwebSQLQuadroColonna")[0];
    if (elQuery != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQuery);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQuery);

        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {

                    // codice qui
                    //console.log(jsonRisultatoQuery);
                    var arrayRisultati = [];
                    for (var i = 1; i < jsonRisultatoQuery.length; i++) {
                        arrayRisultati.push(jsonRisultatoQuery[i].codice);
                    }

                    var thead4 = elQuadro.getElementsByTagName("thead")[0].getElementsByTagName("tr")[3];
                    thead4.getElementsByTagName("span")[1].innerHTML = arrayRisultati.join(",");

                    iwebQuadroGeneraTabella(idQuadro);
                } else {
                    if (jsonRisultatoQuery[0] == null || jsonRisultatoQuery[0].errore == null) console.log("errore json" + jsonRisultatoQuery[0]);
                    else console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReader");
        var jsonAsObject = {
            query: sqlQuery, // string
            pageSize: 100, // int
            pageNumber: 0, // int
            datiFiltri: [], // object
            ordinamento: null, // array[2] -> NOMECAMPO, ASC||DESC
            parametriChiocciola: parametriQuery
        }
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}

function iwebQuadroGeneraTabella(idQuadro) {
    elQuadro = document.getElementById(idQuadro);

    // ottengo i dati da stampare nella prima riga/prima colonna
    var thead4 = elQuadro.getElementsByTagName("thead")[0].getElementsByTagName("tr")[3];
    var array1 = thead4.getElementsByTagName("span")[0].innerHTML.split(",");
    var array2 = thead4.getElementsByTagName("span")[1].innerHTML.split(",");
     console.log(array1); console.log(array2);

    // ottengo 2 campioni di td
    var campione1 = elQuadro.getElementsByTagName("thead")[0].getElementsByTagName("tr")[0];
    var campione2 = elQuadro.getElementsByTagName("thead")[0].getElementsByTagName("tr")[1];
    var campione3 = elQuadro.getElementsByTagName("thead")[0].getElementsByTagName("tr")[2];

    var code = "";
    for (var i = 0; i < array2.length+1; i++) { // colonna
        var codeTrTemp = "<tr>"
        for (var j = 0; j < array1.length+1; j++) { // riga
            var codeTdTemp = campione3.innerHTML;

            // prima cella
            if (i == 0 && j == 0)
                codeTdTemp = "<td></td>";
            else if (i == 0 && j > 0) // prima riga
                codeTdTemp = campione1.innerHTML.replace("@valore", array1[j - 1]);
            else if (j == 0 && i > 0) // prima colonna
                codeTdTemp = campione2.innerHTML.replace("@valore", array2[i - 1]);
            else {
                // cella normale
                codeTdTemp = codeTdTemp.replace("@valore", "todo [" + i + "," + j + "]");
            }
            codeTrTemp += codeTdTemp;
        }
        codeTrTemp += "</tr>";
        code += codeTrTemp;
    }
    elQuadro.getElementsByTagName("tbody")[0].innerHTML = code;

}
