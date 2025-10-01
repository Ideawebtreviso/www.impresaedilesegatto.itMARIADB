/*
    <div class="iwebAUTOCOMPLETAMENTO" id="nuovoProdotto">
        <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

        <%-- Chiave dell'el selezionato --%>
        <span class="iwebNascosto"></span>

        <%-- Valore dell'el selezionato --%>
        <input type="text" autocomplete="off" class="iwebTIPOCAMPO_varchar iwebCAMPO_PRODOTTO.NOME"
            onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
            onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)" 
            onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)"/>

        <span class="iwebSQLSELECT">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT TOP 5 id as chiave, descrizione as valore FROM prodotto WHERE descrizione like @descrizione AND idfornitore = @idfornitore") %></span>
            <span class="iwebPARAMETRO">@descrizione = like_nuovoProdotto_getValore</span>
            <span class="iwebPARAMETRO">@idfornitore = tabellaBolle_findFirstValue_fornitore.id</span>
        </span>
        <div><%--RISULTATI RICERCA--%></div>
    </div>
*/

function isEmpty(str) {
    return (str == "" || 0 == str.length);
}
function iwebAUTOCOMPLETAMENTO_Ricerca(event, el, funzioneAConfermaSelezionato) {
    var elRicerca = el.parentElement;
    var elSearchResults = elRicerca.getElementsByTagName("div")[0];
    var elQuerySelect = elRicerca.getElementsByClassName("iwebSQLSELECT")[0];

    //var isFiltroIWEBTABELLA = el.parentElement.className("iwebFILTRO")

    if (elQuerySelect != null) {
        var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
        var parametriChiocciola = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);


        // se il premi tab non fare alcuna ricerca e nascondi il riquadro della ricerca
        if (event.which == 9 || event.keyCode == 9) {
            elSearchResults.style.display = "none";
            return;
        }

        // se il campo è vuoto non fare alcuna ricerca e nascondi il riquadro della ricerca
        // se premo backspace o canc per cancellare tutto il contenuto non vale più regola della riga precedente
        if (el.value == ""
            &&
            !(event.which == 8 || event.keyCode == 8 ||
            event.which == 46 || event.keyCode == 46)
            ) {
            elSearchResults.style.display = "none";
            return;
        }

        // alla pressione di su e giù non deve essere fatta la ricerca
        if (event.which == 38 || event.keyCode == 38 ||
            event.which == 40 || event.keyCode == 40)
            return;

        // alla pressione di invio il selezionato è confermato quindi chiudo senza fare la ricerca
        if (event.which == 13 || event.keyCode == 13) {
            elSearchResults.style.display = "none";
            if (funzioneAConfermaSelezionato != null)
                eval(funzioneAConfermaSelezionato + "(this)");
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

                        if (funzioneAConfermaSelezionato != null){
                            risultatoRicerca += "<div class='iwebAUTOCOMPLETAMENTO_risultato' onclick='iwebAUTOCOMPLETAMENTO_SelezionaEChiudi(this); " + funzioneAConfermaSelezionato + "(this);'>";
                        } else {
                            risultatoRicerca += "<div class='iwebAUTOCOMPLETAMENTO_risultato' onclick='iwebAUTOCOMPLETAMENTO_SelezionaEChiudi(this);'>";
                        }
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

function iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, el, funzioneAConfermaSelezionato) {
    var elSearchResults = el.parentElement.getElementsByTagName("div")[0];
    var nRighe = elSearchResults.getElementsByTagName("div").length;
    var elRigaSelezionata = el.parentElement.getElementsByTagName("span")[0];
    var rigaSelezionata = parseInt(elRigaSelezionata.innerHTML);
    var elRicerca = el.parentElement;

    // nascondo i risultati della ricerca in caso di tab
    if (event.which == 9 || event.keyCode == 9) {
        if (elRicerca.getElementsByTagName("input")[0].value != "") {
            var elSearchResults = el.parentElement.getElementsByClassName("iwebAUTOCOMPLETAMENTO_risultatiRicerca")[0];
            //if (elSearchResults.style.display != "none")

            var chiaveSelezionata = elRicerca.getElementsByTagName("span")[1].innerHTML;
            // se quando premo tab trovo almeno un elemento selezionabile, lo considero selezionato
            if (elRicerca.getElementsByClassName("iwebAUTOCOMPLETAMENTO_risultatiRicerca")[0].getElementsByClassName("iwebAUTOCOMPLETAMENTO_risultato").length > 0
                && (chiaveSelezionata == "-1" || chiaveSelezionata == "")) {
                // CASO: non ho selezionato nulla con freccia su / freccia giù e premo tab

                // assegno chiave e valore
                var chiave = elRicerca.getElementsByClassName("iwebAUTOCOMPLETAMENTO_risultatiRicerca")[0].getElementsByTagName("span")[0].innerHTML;
                var valore = elRicerca.getElementsByClassName("iwebAUTOCOMPLETAMENTO_risultatiRicerca")[0].getElementsByTagName("span")[1].innerHTML;
                elRicerca.parentElement.getElementsByTagName("span")[1].innerHTML = chiave;
                elRicerca.parentElement.getElementsByTagName("input")[0].value = valore;

            } else {
                // CASO: ho selezionato qualcosa con freccia su / freccia giù e premo tab (non ho premuto invio per selezionare questo elemento)
            }

            // alla pressione di tab eseguo questa funzione
            if (funzioneAConfermaSelezionato != null)
                eval(funzioneAConfermaSelezionato + "(this)");
        }

        elSearchResults.style.display = "none";
        //else
        //    el.focus();
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
        if (direzione != 0) {
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
        }
    }
}

function iwebAUTOCOMPLETAMENTO_ScorriRisultati_SENZATAB(event, el) {
    var elSearchResults = el.parentElement.getElementsByTagName("div")[0];
    var nRighe = elSearchResults.getElementsByTagName("div").length;
    var elRigaSelezionata = el.parentElement.getElementsByTagName("span")[0];
    var rigaSelezionata = parseInt(elRigaSelezionata.innerHTML);

    // nascondo i risultati della ricerca in caso di tab
    if (event.which == 9 || event.keyCode == 9) {
        //var elSearchResults = el.parentElement.getElementsByClassName("iwebAUTOCOMPLETAMENTO_risultatiRicerca")[0];
        //if (elSearchResults.style.display != "none")
            elSearchResults.style.display = "none";
        //else
        //    el.focus();
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
        if (direzione != 0) {
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
        }
    }
}

// iwebAUTOCOMPLETAMENTO_onblur è un controllo aggiuntivo.
// Ad esempio in caso di taglia o cancella dal menu a tendina del tasto destro del mouse
// Altro esempio: ho appena cancellato completamente il campo e non voglio selezionare nulla
function iwebAUTOCOMPLETAMENTO_onblur(event, el) {
    var elRicerca = el.parentElement;
    var elSearchResults = elRicerca.getElementsByTagName("div")[0];

    console.log("blur dall'elemento: " + elRicerca.id);
    var valoreSelezionato = elRicerca.getElementsByTagName("input")[0].value; // valore
    var chiaveSelezionata = elRicerca.getElementsByTagName("span")[1].innerHTML; // chiave

    if (valoreSelezionato == "") {
        if (chiaveSelezionata != "-1") {
            elRicerca.getElementsByTagName("span")[1].innerHTML = "-1";
        }
        elSearchResults.style.display = "none";
    } else {
        var elementiNellaListaDiRicerca = elSearchResults.getElementsByClassName("iwebAUTOCOMPLETAMENTO_risultato").length;
        // caso in cui sto ricercando ad esempio: "aisdnoas". La stringa non esiste e non trova neanche un risultato quindi deve essere azzerato il campo di ricerca
        if (chiaveSelezionata == "-1" && elementiNellaListaDiRicerca == 0) {
            elRicerca.getElementsByTagName("input")[0].value = "";
            elSearchResults.style.display = "none";
        }
    }
}

// el è l'elemento cliccato fra quelli in cascata
function iwebAUTOCOMPLETAMENTO_SelezionaEChiudi(el) {
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

    // nascondo i risultati della ricerca
    var elSearchResults = el.parentElement;
    elSearchResults.style.display = "none";
}

// GET e SET CHIAVE
// console.log("chiave: " + iwebAUTOCOMPLETAMENTO_GetChiaveSelezionato("nuovoProdotto"));
function iwebAUTOCOMPLETAMENTO_GetChiaveSelezionato(id_iwebAUTOCOMPLETAMENTO) {
    var elRicerca = document.getElementById(id_iwebAUTOCOMPLETAMENTO);
    return elRicerca.getElementsByTagName("span")[1].innerHTML; // chiave
}
function iwebAUTOCOMPLETAMENTO_SetChiaveSelezionato(id_iwebAUTOCOMPLETAMENTO, chiave) {
    var elRicerca = document.getElementById(id_iwebAUTOCOMPLETAMENTO);
    elRicerca.getElementsByTagName("span")[1].innerHTML = chiave; // chiave
}

// GET e SET VALORE
// console.log("valore: " + iwebAUTOCOMPLETAMENTO_GetValoreSelezionato("nuovoProdotto"));
function iwebAUTOCOMPLETAMENTO_GetValoreSelezionato(id_iwebAUTOCOMPLETAMENTO) {
    var elRicerca = document.getElementById(id_iwebAUTOCOMPLETAMENTO);
    return elRicerca.getElementsByTagName("input")[0].value; // valore
}
function iwebAUTOCOMPLETAMENTO_SetValoreSelezionato(id_iwebAUTOCOMPLETAMENTO, valore) { /* non ancora usato */
    var elRicerca = document.getElementById(id_iwebAUTOCOMPLETAMENTO);
    elRicerca.getElementsByTagName("input")[0].value = valore; // valore
}

// azzera la ricerca
function iwebAUTOCOMPLETAMENTO_AzzeraSelezionato(id_iwebAUTOCOMPLETAMENTO) {
    var elRicerca = document.getElementById(id_iwebAUTOCOMPLETAMENTO);
    elRicerca.getElementsByTagName("span")[1].innerHTML = ""; // chiave
    elRicerca.getElementsByTagName("input")[0].value = ""; // valore
}
