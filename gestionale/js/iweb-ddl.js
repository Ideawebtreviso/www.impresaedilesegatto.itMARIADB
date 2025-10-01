// <select id="ddlEsempioHeaderTabella"
// class="ddlajaxDB_STATO ddlajaxValore_ID ddlajaxNome_TIPO ddlajaxSelezionato_1">
function iwebDDL_Carica(idDDL, attesaRispostaServer) {
    // cerco il/i valore/i di preselezione
    var valoriPreselezionati = [];
    var elPreselezionato = prossimoElemento(document.getElementById(idDDL));
    var stringaClassi = elPreselezionato.className;
    while ( elPreselezionato != null && elPreselezionato.nodeName.toLowerCase() == "span" &&
            stringaClassi.indexOf("iwebSELECTSELECTED") == -1) {
        elPreselezionato = prossimoElemento(elPreselezionato);
        if (elPreselezionato == null)
            stringaClassi = "";
        else
            stringaClassi = elPreselezionato.className;
    }
    if (elPreselezionato != null && elPreselezionato.nodeName.toLowerCase() == "span") {
        // trovato!
        elSpanPreselezionati = elPreselezionato.getElementsByTagName("span");
        for (var i = 0; i < elSpanPreselezionati.length; i++) {
            valoriPreselezionati.push(elSpanPreselezionati[i].innerHTML);
        }
    }

    // console.log(valoriPreselezionati);

    // prendi il prossimo elemento cerca ricorsivamente gli span finchè non trovi quello con l'sql giusto -> TODO
    var elQuerySelect = iwebOttieniSqlRicors(prossimoElemento(document.getElementById(idDDL)), "select");
    if (elQuerySelect != null) {
        //var querySelect = generaQueryDaSpanSql(elQuerySelect);
        var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
        var parametriChiocciola = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);
        //console.log(querySelect);

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
                    //console.log("json3: " + jsonRisultatoQuery);
                    var nRigheContate = jsonRisultatoQuery[0].elementiContati;
                    //console.log(jsonRisultatoQuery);
                    iwebDDL_GeneraRighe(jsonRisultatoQuery, idDDL, valoriPreselezionati);
                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }

        // versione WebService.asmx/sparaQueryReader
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReader", true);
        //xmlhttp.open("POST", location.protocol+"//"+location.host+"/App_code/WebService.asmx/sparaQueryReader", true);
        var jsonAsObject = {
            nomeTabella: "", // string
            query: querySelect, // string
            pageSize: 10000, // int
            pageNumber: 0, // int
            datiFiltri: [], // object
            ordinamento: [], // array[2] -> NOMECAMPO, ASC||DESC
            parametriChiocciola: parametriChiocciola
        }

        // in entrambi casi
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        //console.log(jsonAsObject);
        if (querySelect != "")
            xmlhttp.send(jsonAsString);
    }
}

function iwebDDL_GeneraRighe(jsonRisultatoQuery, idDDL, valoriPreselezionati) {
    // il campione di base di riga
    var codeCampione = "<option value='@valore' @selected>@nome</option>";

    // il resto del jsonRisultatoQuery contiene i dati delle righe risultato
    var codeTemp = "";
    var risultatoInnerHTML = "";
    var elementiOggetto = [];
    for (var i = 1; i < jsonRisultatoQuery.length; ++i) {
        codeTemp = codeCampione;
        // esempio di risultato: elementiOggetto = ["ID","TIPO"]
        elementiOggetto = Object.getOwnPropertyNames(jsonRisultatoQuery[i]);
        for (var j = 0; j < elementiOggetto.length; ++j) {
            if (elementiOggetto.length == 1) {
                // in caso di distinct ho un solo campo in ritorno dalla query i-0 / i-0 (uguale)
                codeTemp = codeTemp.replace("@valore", jsonRisultatoQuery[i][elementiOggetto[0]]);
                codeTemp = codeTemp.replace("@nome", jsonRisultatoQuery[i][elementiOggetto[0]]);
            }
            else {
                // in caso di nome e valore ho due campi in ritorno dalla query i-0 / i-1 (diverso)
                //codeTemp = codeTemp.replace("@valore", jsonRisultatoQuery[i][elementiOggetto[0]]);
                //codeTemp = codeTemp.replace("@nome", jsonRisultatoQuery[i][elementiOggetto[1]]);
                codeTemp = codeTemp.replace("@valore", jsonRisultatoQuery[i].VALORE);
                codeTemp = codeTemp.replace("@nome", jsonRisultatoQuery[i].NOME);
            }
            // in entrambi i casi
            var valorePreselezionato = null;
            if (jsonRisultatoQuery[i][elementiOggetto[j]] == valorePreselezionato && valorePreselezionato != null)
                codeTemp = codeTemp.replace("@selected", "selected")
            else
                codeTemp = codeTemp.replace("@selected", "");
            var valorePreselezionato = null;
            /*for (var k = 0; k < valoriPreselezionati.length; k++) {
                valorePreselezionato = valoriPreselezionati[k];
                if (jsonRisultatoQuery[i][elementiOggetto[j]] == valorePreselezionato && valorePreselezionato != null)
                    codeTemp = codeTemp.replace("@selected", "selected")
                else
                    codeTemp = codeTemp.replace("@selected", "");
            }*/
        }
        // ho la stringa codeTemp con il codice da aggiungere alla stringa finale
        risultatoInnerHTML = risultatoInnerHTML + codeTemp;
    }

    // il contenuto del DDL deve essere riinizializzato, viene tenuta memoria degli elementi con class="iwebAGGIUNTO"
    var elDLL = document.getElementById(idDDL);
    var optionsDLL = elDLL.getElementsByTagName("option");
    var code = "";
    for (var i = 0; i < optionsDLL.length; i++) {
        if (optionsDLL[i].className.indexOf("iwebAGGIUNTO") >= 0)
            code += "<option class='iwebAGGIUNTO' value='" + optionsDLL[i].value + "'>" + optionsDLL[i].innerHTML + "</option>";
    }
    elDLL.innerHTML = code + risultatoInnerHTML;

    // valoriPreselezionati
    for (var i = 0; i < optionsDLL.length; i++) {
        for (var j = 0; j < valoriPreselezionati.length; j++) {
            if (optionsDLL[i].value == valoriPreselezionati[j]) {
                optionsDLL[i].selected = true;
                //elDLL.selectedIndex = i;
            }
        }
    }
}

// es1: iwebDDL_aggiornaSelezionati("popupTabellaVociModificaDDLSuddivisioni", [-1]); -> seleziona l'elemento che ha valore -1
// es2: iwebDDL_aggiornaSelezionati(elDDL, [-1]); -> seleziona l'elemento che ha valore -1
// es3: iwebDDL_aggiornaSelezionati(elDDL, -1); -> seleziona l'elemento che ha valore -1
// iwebDDL_aggiornaSelezionati(el || id, selezionato || arraySelezionati)
function iwebDDL_aggiornaSelezionati(idDDL_oppure_elDDL, selezionato_oppure_arraySelezionati) {
    // console.log([idDDL_oppure_elDDL, selezionato_oppure_arraySelezionati]);
    // valuto se il parametro passato è un id o un elemento
    var elPreselezionato = ""; var elPreselezionatoTemp = "";
    if (typeof (idDDL_oppure_elDDL) === "object" && idDDL_oppure_elDDL.innerHTML != null) { // questo è un elemento HTML

        if (idDDL_oppure_elDDL.className.indexOf("iwebDDL") >= 0)
            elPreselezionato = prossimoElemento(idDDL_oppure_elDDL);
        else
            elPreselezionato = idDDL_oppure_elDDL;
        elPreselezionatoTemp = elPreselezionato;

    } else { // questo è l'id dell'elemento (cioè una stringa)... altrimenti è un errore

        var elTemp = document.getElementById(idDDL_oppure_elDDL);
        if (elTemp.className.indexOf("iwebDDL") >= 0)
            elPreselezionato = prossimoElemento(elTemp);
        else
            elPreselezionato = elTemp;
        elPreselezionatoTemp = elPreselezionato;

    }
    if (elPreselezionato == null || elPreselezionato == "") console.log("%cErrore in iwebDDL_aggiornaSelezionati. elemento vuoto o null", "color:darkred");

    // valuto se il parametro passato è un valore o una lista di valori
    var arrayListaSelezionati = [];
    if (typeof (selezionato_oppure_arraySelezionati) === "object") { // questo è un array
        arrayListaSelezionati = selezionato_oppure_arraySelezionati;
    } else { // questo è un elemento da inserire in un nuovo array
        arrayListaSelezionati = [selezionato_oppure_arraySelezionati];
    }
    if (arrayListaSelezionati == null || arrayListaSelezionati == "") console.log("%cErrore in iwebDDL_aggiornaSelezionati. elementi selezionati vuoto o null", "color:darkred");

    // inizio la ricerca dell'elemento iwebSELECTSELECTED
    var stringaClassi = elPreselezionatoTemp.className;
    while (elPreselezionatoTemp != null && elPreselezionatoTemp.nodeName.toLowerCase() == "span" &&
            stringaClassi.indexOf("iwebSELECTSELECTED") == -1) {
        elPreselezionatoTemp = prossimoElemento(elPreselezionatoTemp);
        if (elPreselezionatoTemp == null)
            stringaClassi = "";
        else
            stringaClassi = elPreselezionatoTemp.className;
    }
    if (elPreselezionatoTemp != null && elPreselezionatoTemp.nodeName.toLowerCase() == "span") {
        // trovato! lo rigenero
        var code = "";

        for (var i = 0; i < arrayListaSelezionati.length; i++)
            code += "<span>" + arrayListaSelezionati[i] + "</span>";

        elPreselezionatoTemp.innerHTML = code;
    } else {
        // non trovato! lo devo creare e poi aggiungere gli elementi
        // cerco iwebSQL+[eventualestringa]. appena non ne trovo più aggiungo uno span 
        //var elContenitoreSelezionati = document.getElementById(idDDL);
        var elContenitoreSelezionati = elPreselezionato;
        var oldElContenitoreSelezionati = elContenitoreSelezionati;
        var esciDaWhile = false;
        while (!esciDaWhile) {
            // ottengo il prossimo elemento
            oldElContenitoreSelezionati = elContenitoreSelezionati;
            elContenitoreSelezionati = prossimoElemento(elContenitoreSelezionati);

            if ((elContenitoreSelezionati != null && elContenitoreSelezionati.nodeName.toLowerCase() == "span")) { // se trovo ad esempio uno span con una classeiwebSQL vado avanti
                // ignoro gli elementi iwebSQL
                if (elContenitoreSelezionati.className.indexOf("iwebSQL") < 0) {
                    var spn = document.createElement("SPAN");
                    spn.className = "iwebSELECTSELECTED";
                    var code = "";
                    for (var i = 0; i < arrayListaSelezionati.length; i++)
                        code += "<span>" + arrayListaSelezionati[i] + "</span>";
                    spn.innerHTML = code;
                    insertAfter(spn, oldElContenitoreSelezionati)
                    esciDaWhile = true;
                }
            }
            if ((elContenitoreSelezionati != null && elContenitoreSelezionati.nodeName.toLowerCase() != "span")) { // se trovo ad esempio un div mi fermo
                var spn = document.createElement("SPAN");
                spn.className = "iwebSELECTSELECTED";
                var code = "";
                for (var i = 0; i < arrayListaSelezionati.length; i++)
                    code += "<span>" + arrayListaSelezionati[i] + "</span>";
                spn.innerHTML = code;
                insertAfter(spn, oldElContenitoreSelezionati)
                esciDaWhile = true;
            }
            if (elContenitoreSelezionati == null) { // se non trovo più elementi mi fermo
                var spn = document.createElement("SPAN");
                spn.className = "iwebSELECTSELECTED";
                var code = "";
                for (var i = 0; i < arrayListaSelezionati.length; i++)
                    code += "<span>" + arrayListaSelezionati[i] + "</span>";
                spn.innerHTML = code;
                oldElContenitoreSelezionati.parentElement.appendChild(spn);
                esciDaWhile = true;
            }

        }

    }
}