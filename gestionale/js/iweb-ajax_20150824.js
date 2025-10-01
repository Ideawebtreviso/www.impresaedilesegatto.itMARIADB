// variabile contatore che conta gli elementi in caricamento aperti e chiusi
var iwebVariabileGlobale_caricamentoAjax = 0;

function iwebMostraCaricamentoAjax() {
    iwebVariabileGlobale_caricamentoAjax += 1;
    //console.log("mostra"+iwebVariabileGlobale_caricamentoAjax);

    var el = document.getElementById("divLoadingAjax");
    if (iwebVariabileGlobale_caricamentoAjax > 0 && el.className.indexOf("apriPopup") < 0) {
        // apri e mostra gradualmente il popup appena viene aperto il primo caricamento
        el.className = "popup popupType2 apriPopup";
        el.style.display = "";
        setTimeout(function () { el.style.display = "" }, 480); // se crea problemi trasformare il tempo in una variabile
    }
}
function iwebNascondiCaricamentoAjax() {
    //console.log("nascondi" + iwebVariabileGlobale_caricamentoAjax);
    iwebVariabileGlobale_caricamentoAjax -= 1;

    var el = document.getElementById("divLoadingAjax");
    if (iwebVariabileGlobale_caricamentoAjax == 0) {
        el.className = "popup popupType2 chiudiPopup";
        setTimeout(function () { el.style.display = "none" }, 480);
    }
}


// ricarica azzera il paging a pagina uno
function iwebTABELLA_Carica(idTabella, nPagina, attesaRispostaServer, funzioneAFineEsecuzione) {
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

                    if (funzioneAFineEsecuzione && typeof funzioneAFineEsecuzione === "function")
                        funzioneAFineEsecuzione();
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


function iwebTABELLA_OttieniDatiFiltri(idTabella) {
    var datiFiltri = [];
    var tHead = document.getElementById(idTabella).getElementsByTagName("thead")[0];
    var elementiConFiltro = tHead.getElementsByClassName("iwebFILTRO");

    // percorro la lista di elementi con filtro
    for (var i = 0; i < elementiConFiltro.length; ++i) {
        iwebValutaFiltro(elementiConFiltro[i], datiFiltri);
    }
    //console.log(datiFiltri);
    return datiFiltri;
}
function iwebValutaFiltro(elConFiltro, datiFiltri) {
    var filtro = { nomeCampo: "", valoreCampo: "", tipoCampo: "", tipoFiltro: "" };
    var nomeclassi = elConFiltro.className.split(" ");

    // cerco il nome del campo, valore associato e tipo di filtro
    for (var j = 0; j < nomeclassi.length; ++j) {
        // cerco il nome del campo
        if (nomeclassi[j].indexOf("iwebCAMPO_") != -1)
            filtro.nomeCampo = nomeclassi[j].split("iwebCAMPO_")[1].split(" ")[0];

        // cerco il tipo del campo (per ora esiste solo il tipo data)
        if (nomeclassi[j].indexOf("iwebFILTROTIPOCAMPO_") != -1)
            filtro.tipoCampo = nomeclassi[j].split("iwebFILTROTIPOCAMPO_")[1].split(" ")[0];

        // cerco il tipo di filtro
        if (nomeclassi[j] == "iwebFILTROTestoSemplice") {
            filtro.tipoFiltro = "TestoSemplice"
            // in caso di testo libero
            if (elConFiltro.getElementsByTagName("input").length > 0)
                filtro.valoreCampo = elConFiltro.getElementsByTagName("input")[0].value;
        }
        if (nomeclassi[j] == "iwebFILTROUgualaA") {
            filtro.tipoFiltro = "UgualeA"; // fa un list in nella where
            // in caso di DDL
            if (elConFiltro.getElementsByTagName("select").length > 0) {
                var elSelect = elConFiltro.getElementsByTagName("select")[0];
                var idOption = elSelect.selectedIndex;
                if (idOption > 0) {
                    if (elSelect.multiple) {
                        filtro.tipoFiltro = "UgualeAMolti"; // fa un list in nella where
                        // utilizzato "|||" come separatore per i valori multipli di select (usato qui e in Webservice.cs)
                        for (var k = 0; k < elSelect.getElementsByTagName("option").length; ++k) {
                            if (elSelect.getElementsByTagName("option")[k].selected)
                                filtro.valoreCampo += elSelect.getElementsByTagName("option")[k].value + "|||";
                        }
                        filtro.valoreCampo = filtro.valoreCampo.substr(0, filtro.valoreCampo.length - 3);
                        //filtro.valoreCampo = "'" + filtro.valoreCampo.split(",").join("','") + "'";
                    } else {
                        //filtro.valoreCampo = "'" + elConFiltro.getElementsByTagName("option")[idOption].value + "'";
                        filtro.valoreCampo = elConFiltro.getElementsByTagName("option")[idOption].value;
                    }
                    // rimuovi gli apici (primo e ultimo carattere)
                    //filtro.valoreCampo = leftString(filtro.valoreCampo, filtro.valoreCampo.length - 1);
                    //filtro.valoreCampo = rightString(filtro.valoreCampo, filtro.valoreCampo.length - 1);
                    //console.log(filtro.valoreCampo);
                } else {
                    filtro.valoreCampo = "";
                }
            }
        }
        // iwebFILTROTestoLiberoMaggioreDi -> iwebFILTROTestoLibero + (MaggioreDi || MaggioreUgualeDi || MinoreDi || MinoreUgualeDi)
        if (nomeclassi[j] == "iwebFILTROMaggioreDi" ||
            nomeclassi[j] == "iwebFILTROMaggioreUgualeDi" ||
            nomeclassi[j] == "iwebFILTROMinoreDi" ||
            nomeclassi[j] == "iwebFILTROMinoreUgualeDi") {
            // in caso di testo libero
            if (elConFiltro.getElementsByTagName("input").length > 0)
                filtro.valoreCampo = elConFiltro.getElementsByTagName("input")[0].value;

            filtro.tipoFiltro = nomeclassi[j].split("iwebFILTRO")[1].split(" ")[0];
            var patternNumeroIntero = /[-][^0-9]/g;
            if (filtro.valoreCampo.match(patternNumeroIntero) != null) filtro.valoreCampo = "0"
        }
        if (nomeclassi[j] == "iwebFILTROTestoLiberoMinoreDi") {
            filtro.valoreCampo = elConFiltro.getElementsByTagName("input")[0].value;
            filtro.tipoFiltro = "MinoreDi"
            var patternNumeroIntero = /[-][^0-9]/g;
            if (filtro.valoreCampo.match(patternNumeroIntero) != null) filtro.valoreCampo = "0"
        }
    }
    // devo aver trovato un tipo filtro && non ha senso che il valore campo sia vuoto
    if (filtro.tipoFiltro != "" && filtro.valoreCampo != "")
        datiFiltri.push(filtro);
}


function iwebTABELLA_OttieniDatiOrdinamento(idTabella) {
    var datiOrdinamento = [];

    var tHead = document.getElementById(idTabella).getElementsByTagName("thead")[0];
    var elementoOrdinamento = tHead.getElementsByClassName("iwebFILTROOrdinamento")[0];
    if (elementoOrdinamento != null) {
        var nomeclassi = elementoOrdinamento.className.split(" ");
        // cerco il nome del campo, valore associato e tipo di filtro
        for (var i = 0; i < nomeclassi.length; ++i) {
            if (nomeclassi[i].indexOf("iwebSORT_") != -1) {
                // aggiungo il nomecampo es: ["NOME", "ASC"]
                var stringaDatiOrdinamento = nomeclassi[i].split("iwebSORT_")[1].split(" ")[0];
                if (rightString(stringaDatiOrdinamento, 4) == "_ASC")
                    datiOrdinamento = [leftString(stringaDatiOrdinamento, stringaDatiOrdinamento.length - 4), "ASC"];
                else
                    datiOrdinamento = [leftString(stringaDatiOrdinamento, stringaDatiOrdinamento.length - 5), "DESC"];
            }
        }
    }
    return datiOrdinamento;
}

function iwebTABELLA_CambiaOrdinamento() {
    var el = event.srcElement;
    var nomeClassi = el.className.split(" ");
    // scorro le classi dell'elemento
    for (var i = 0; i < nomeClassi.length; ++i) {
        if (nomeClassi[i].indexOf("iwebSORT_") >= 0) {
            // cambio asc in desc e viceversa
            var stringaDatiOrdinamento = nomeClassi[i].split("iwebSORT_")[1].split(" ")[0];
            if (rightString(stringaDatiOrdinamento, 4) == "_ASC")
                nomeClassi[i] = "iwebSORT_" + leftString(stringaDatiOrdinamento, stringaDatiOrdinamento.length - 4) + "_DESC";
            else
                nomeClassi[i] = "iwebSORT_" + leftString(stringaDatiOrdinamento, stringaDatiOrdinamento.length - 5) + "_ASC";
        }
        if (nomeClassi[i].indexOf("glyphicon-sort-by-alphabet") != -1) {
            nomeClassi[i] = nomeClassi[i] == "glyphicon-sort-by-alphabet" ? "glyphicon-sort-by-alphabet-alt" : "glyphicon-sort-by-alphabet";
        }
    }
    el.className = nomeClassi.join(" ");

    // ricarica la tabella: tabellaajaxCarica(idTabella, true)
    iwebTABELLA_Carica(cercaTablePadreRicors(el).id, 0, true);
}

function iwebTABELLA_GeneraRigheTabella(jsonRisultatoQuery, tBodySorg, tBodyDest) {
    tBodyDest.innerHTML = "";
    // il primo elemento è il numero di righe, il resto del jsonRisultatoQuery contiene i dati delle righe risultato
    var elementiOggetto = [];
    for (var i = 1; i < jsonRisultatoQuery.length; ++i) {
        // ottengo un clone della riga originale
        var cloneRiga = tBodySorg.cloneNode(true);

        // esempio di risultato: elementiOggetto = ["ID","NOME","COGNOME"]
        elementiOggetto = Object.getOwnPropertyNames(jsonRisultatoQuery[i]);

        // primo checkbox
        cloneRiga.getElementsByTagName("input")[0].title = i;

        // ciclo sulle colonne
        for (var j = 0; j < elementiOggetto.length; ++j) {
            var elTemp = cloneRiga.getElementsByClassName("iwebCAMPO_" + elementiOggetto[j])[0];
            if (elTemp != null) {

                // ottengo il valore e lo formatto correttamente (se è stato indicato un formato specifico)
                var valore = jsonRisultatoQuery[i][elementiOggetto[j]];

                // modifico stile e valore del dato ottenuto da db
                valore = iwebElaboraCampo(elTemp, valore);

                var nomeNodo = elTemp.nodeName.toLowerCase();
                if (elTemp.onclick != null) { // per ora usato solo su generazione pdf
                    var x = elTemp.onclick.toString().split("function onclick(event) {")[1];
                    x = leftString(x, x.length-1);
                    x = x.replace("iwebCAMPO_" + elementiOggetto[j], valore); // replace del iwebcampo... purtroppo senza chiocciola
                    elTemp.setAttribute("onClick", x);
                }
                if (nomeNodo == "a" && elTemp.href != "") {
                    elTemp.href = elTemp.href.replace("@iwebCAMPO_" + elementiOggetto[j], valore);
                }
                if (nomeNodo == "td") {
                    elTemp.innerHTML = valore
                }
                if (nomeNodo == "span") {
                    elTemp.innerHTML = valore
                }
                if (nomeNodo == "input") {
                    if (elTemp.type == "checkbox")
                        if (valore == true)
                            elTemp.parentElement.innerHTML = elTemp.parentElement.innerHTML.replace(">", " checked>");
                }
            } else {
                //console.log("%cNon sono riuscito a utilizzare la colonna " + "iwebCAMPO_" + elementiOggetto[j], "color:darkred");
            }
        }
        // ho la riga clonata pronta e valorizzata correttamente. vado ad aggiungerla alla tabella
        tBodyDest.innerHTML += cloneRiga.innerHTML;
    }
}

function iwebElaboraCampo(elTemp, valore) {
    var nomeClasse = elTemp.className;

    if (nomeClasse.indexOf("iwebFORMATO_") >= 0) { // es: iwebFORMATO_datetime_dd/MM/yyyy
        // esempio: valore = iwebFORMATTA(formato, valoreJson)
        var formato = nomeClasse.split("iwebFORMATO_")[1].split(" ")[0];
        valore = iwebFORMATTA(formato, valore);
    }

    if (nomeClasse.indexOf("iwebData") >= 0) {
        valore = iwebFORMATTA("datetime_dd/MM/yyyy", valore);

        // aggiungo all'elemento padre la classe che centra l'elemento attuale
        var nomeTagPadre = elTemp.parentElement.nodeName.toLowerCase();
        if (nomeTagPadre == "td") aggiungiClasseAElemento(elTemp.parentElement, "iwebData_tdPadre");
    }

    if (nomeClasse.indexOf("iwebCodice") >= 0 || nomeClasse.indexOf("iwebTitolo") >= 0 || nomeClasse.indexOf("iwebDescrizione") >= 0) {
        var nomeTagPadre = elTemp.parentElement.nodeName.toLowerCase();
        var caratteriDaMostrare = 0;
        if (nomeClasse.indexOf("iwebCodice") >= 0) {
            caratteriDaMostrare = 11; if (nomeTagPadre == "td") aggiungiClasseAElemento(elTemp.parentElement, "iwebCodice_tdPadre");
        }
        if (nomeClasse.indexOf("iwebTitolo") >= 0) {
            caratteriDaMostrare = 20; if (nomeTagPadre == "td") aggiungiClasseAElemento(elTemp.parentElement, "iwebTitolo_tdPadre");
        }
        if (nomeClasse.indexOf("iwebDescrizione") >= 0) {
            caratteriDaMostrare = 100; if (nomeTagPadre == "td") aggiungiClasseAElemento(elTemp.parentElement, "iwebDescrizione_tdPadre");
        }

        // sovrascrivo la lunghezza di default
        if (nomeClasse.indexOf("iwebTroncaCrtsAt_") >= 0) caratteriDaMostrare = nomeClasse.split("iwebTroncaCrtsAt_")[1].split(" ")[0];

        // in caso di 0 caratteri da mostrare non mostro nulla.
        if (caratteriDaMostrare == 0) valore = "";

        if (valore != null && valore != "" && valore.length > caratteriDaMostrare) {
            elTemp.title = valore; // valore completo su title
            valore = valore.substr(0, caratteriDaMostrare) + "..."; // valore parziale in visualizzazione
        }
    }

    if (nomeClasse.indexOf("iwebValuta") >= 0) {
        // formattazione valuta
        if (valore != null && valore != "")
            valore = parseFloat(valore).toFixed(2);
        //valore = toValuta(valore);

        // aggiungo all'elemento padre la classe che centra l'elemento attuale
        var nomeTagPadre = elTemp.parentElement.nodeName.toLowerCase();
        if (nomeTagPadre == "td") aggiungiClasseAElemento(elTemp.parentElement, "iwebValuta_tdPadre");
    }

    if (nomeClasse.indexOf("iwebQuantita") >= 0) {
        // formattazione valuta
        if (valore != null && valore != "")
            valore = parseFloat(valore).toFixed(3);
        //valore = toValuta(valore);

        // aggiungo all'elemento padre la classe che centra l'elemento attuale
        var nomeTagPadre = elTemp.parentElement.nodeName.toLowerCase();
        if (nomeTagPadre == "td") aggiungiClasseAElemento(elTemp.parentElement, "iwebQuantita_tdPadre");
    }

    return valore;
}

function iwebTABELLA_GeneraFooterTabella(idTabella, nRigheContate, pageSize, pageNumber, nColonne) {
    var totPagine = parseInt((nRigheContate / pageSize) + 0.9999);
    var tFoot = document.getElementById(idTabella).getElementsByTagName("tfoot")[0];
    tFoot.getElementsByTagName("tr")[1].getElementsByTagName("td")[0].colSpan = nColonne; // imposta il td dell'unica colonna larga come tutte le colonne

    //var tempSelect = tFoot.getElementsByClassName("iwebPAGESIZE")[0].getElementsByTagName("select")[0];
    //var pageSize = tempSelect.getElementsByTagName("option")[tempSelect.selectedIndex].value;

    pageNumber = pageNumber + 1; // nel calcolo devo considerare le pagine da 0 a n-1, ma in visualizzazione considero le pagine da 1 a n
    tFoot.getElementsByClassName("iwebPAGENUMBER")[0].getElementsByTagName("input")[0].value = pageNumber;
    tFoot.getElementsByClassName("iwebTOTPAGINE")[0].innerHTML = totPagine;
    tFoot.getElementsByClassName("iwebPAGESIZE")[0].getElementsByTagName("select")[0].value = pageSize;
    tFoot.getElementsByClassName("iwebTOTRECORD")[0].innerHTML = "Trovati " + nRigheContate + " record";
}

function iwebTABELLA_VerificaAutocompletamento() {
    var el = event.srcElement;
    var stringa = el.value;
    setTimeout(function () {
        var newStringa = el.value;
        if (newStringa.substr(0, newStringa.length - 1) == stringa) {
            iwebTABELLA_Carica(cercaTablePadreRicors(el).id, 0, true);
        }
    }, 400);
}

function iwebTABELLA_AssociaDatoInPopup(popupAssociato, nomeCampo, valoreRiga) {
    // ho trovato il valore della colonna che mi interessava, devo andare ad associarlo all'id giusto nel popup
    var elTemp = popupAssociato.getElementsByClassName("iwebCAMPO_" + nomeCampo)[0];
    var nomeNodo = elTemp.nodeName.toLowerCase();
    //console.log(nomeNodo);

    if (nomeNodo == "input") {
        if (elTemp.type == "text")
            elTemp.value = valoreRiga;
        else if (elTemp.type == "checkbox") {
            elTemp.checked = valoreRiga == true; // if (valoreRiga == true) elTemp.checked = "checked"; else elTemp.checked = "";
        }
    } else if (nomeNodo == "textarea") {
        elTemp.value = valoreRiga;
    } else if (nomeNodo == "span") {
        elTemp.innerHTML = valoreRiga;
    } else if (nomeNodo == "div") {
        // file upload
        if (elTemp.className.indexOf("iwebFileUpload") >= 0) {
            elTemp.getElementsByTagName("img")[0].src = "/public/" + valoreRiga;
            elTemp.title = "/public/" + valoreRiga;
        }
    } else if (nomeNodo == "select") {
        // iwebDDL_aggiornaSelezionati(ELEM_oppure_IDELEM_DDL, listaSelezionati)
        // iwebDDL_aggiornaSelezionati(elTemp, valoreRiga);
        // aggiorna i valori preselezionati
        var idTemp = elTemp.id;
        if (elTemp.id != "") {
            iwebDDL_aggiornaSelezionati(idTemp, valoreRiga);
            // bind sull'elemento DDL
            if (elTemp.className.indexOf("iwebDDL") >= 0) {
                // eventualmente va aggiunto un timeout o messo nel prerender di iwebDDL_aggiornaSelezionati qua sopra caricato
                iwebCaricaElemento(idTemp);
            }
        }
    }
}

// restituisce tutti i campi obbligatori non validi contenuti nell'elemento passato come parametro
function iwebTABELLA_VerificaCampiObbligatori(el) {
    var listaCampiErrati = [];
    var elDaControllare = el.getElementsByClassName("iwebCAMPOOBBLIGATORIO");
    for (var i = 0; i < elDaControllare.length; i++) {
        var campoErrato = false;
        var elTemp = elDaControllare[i];
        var nomeNodo = elTemp.nodeName.toLowerCase();
        if (nomeNodo == "span") {
            if (elTemp.innerHTML == "") {
                listaCampiErrati.push("iwebCAMPO_" + elTemp.className.split("iwebCAMPO_")[1].split(" ")[0]);
                campoErrato = true;
            }
        } else if (nomeNodo == "input") {
            // non ha senso il controllo per il checkbox
            if (elTemp.type == "text") {
                if (elTemp.value == "") {
                    listaCampiErrati.push("iwebCAMPO_" + elTemp.className.split("iwebCAMPO_")[1].split(" ")[0]);
                    campoErrato = true;
                }

                /*if (elTemp.parentElement.className.indexOf("iwebAUTOCOMPLETAMENTO") >= 0) {
                    if (precedenteElemento(elTemp).innerHTML == "" || precedenteElemento(elTemp).innerHTML == -1) {
                        listaCampiErrati.push("iwebCAMPO_" + elTemp.className.split("iwebCAMPO_")[1].split(" ")[0]);
                        campoErrato = true;
                    }
                }*/
            }
        } else if (nomeNodo == "div") {
            // elTemp.className.indexOf("iwebFileUpload") >= 0
            if (elTemp.className.indexOf("iwebAUTOCOMPLETAMENTO") >= 0) {
                var tempSpan = elTemp.getElementsByTagName("span")[1];
                if (tempSpan.innerHTML == "" || tempSpan.innerHTML == "-1") {
                    listaCampiErrati.push("iwebCAPO_" + tempSpan.className.split("iwebCAMPO_")[1].split(" ")[0]);
                    campoErrato = true;

                    // SOSTITUISCO ELTEMP CON L'INPUT SPECIFICO IN MODO CHE SIA QUELLO AD ASSUMERE IL BORDO ROSSO
                    var tempInput = elTemp.getElementsByTagName("input")[0];
                    elTemp = tempInput;
                }
            }
        } else if (nomeNodo == "select") {
            if (elTemp.value == "-1") {
                if (elTemp.className.indexOf("iwebCAMPO_") < 0) elTemp = elTemp.parentElement; // può essere che il campo select non abbia iwebCAMPO, ma ce l'abbia il padre
                listaCampiErrati.push("iwebCAMPO_" + elTemp.className.split("iwebCAMPO_")[1].split(" ")[0]);
                campoErrato = true;
            }
        }

        if (campoErrato) {
            elTemp.style.border = "solid 1px red";
        }
        else {
            elTemp.style.border = "";
        }
    }
    // listaCampiErrati per ora mi serve solo per calcolare il numero di elementi e verificare che non sia zero.
    return listaCampiErrati;
}

/* #ELIMINAZIONE */
function iwebTABELLA_EliminaRigaInPopup(IdPopupAssociato) {
    var el = event.srcElement;
    var trPadre = el.parentElement.parentElement;
    var popupAssociato = document.getElementById(IdPopupAssociato);

    // cerco gli elementi che sono presenti sia nella riga che nel popup associato "iwebCAMPO_"
    var allElements_popupAssociato = popupAssociato.getElementsByTagName("*");
    var elencoParametriDaModificare = "";
    for (var i = 0; i < allElements_popupAssociato.length; ++i) {
        if (allElements_popupAssociato[i].className.indexOf("iwebCAMPO_") >= 0) {
            // ## POSSIBILE MODIFICA ERRATA
            var parametroDaModificare = allElements_popupAssociato[i].className.split("iwebCAMPO_")[1].split(" ")[0];
            if (trPadre.getElementsByClassName("iwebCAMPO_" + parametroDaModificare)[0] != null)
                elencoParametriDaModificare += parametroDaModificare + ",";
        }
    }
    // tolgo l'ultima virgola
    if (elencoParametriDaModificare.length > 0)
        elencoParametriDaModificare = elencoParametriDaModificare.substr(0, elencoParametriDaModificare.length - 1);

    // genero un id univoco per questa riga e associo questo id al trPadre
    //var IdUnivocoDiQuestaRiga = iwebTABELLA_GeneraIdPerQuestaRiga(trPadre);

    // -elencoParametriDaModificare- contiene ad esempio la stringa: "ID, Nome, Cognome" -> ciò significa che nella riga dove mi trovo devo andare a modificare l'id, il nome e il cognome
    var colonneDaModificare = elencoParametriDaModificare.split(",");

    // OTTENGO i valori che mi servono dalla riga che sto per eliminare
    var valoreRiga = "";
    for (var i = 0; i < colonneDaModificare.length; ++i) {
        // esempio per ottenere il valore della colonna ID per la riga che voglio modificare: iwebTABELLA_GetRigaPuntuale(el, "ID")
        valoreRiga = iwebTABELLA_GetRigaPuntuale(trPadre, colonneDaModificare[i]);

        // ho trovato il valore della colonna che mi interessava, devo andare ad associarlo all'id giusto nel popup
        var nomeCampo = colonneDaModificare[i];
        iwebTABELLA_AssociaDatoInPopup(popupAssociato, nomeCampo, valoreRiga);
        /*var elTemp = popupAssociato.getElementsByClassName("iwebCAMPO_" + colonneDaModificare[i])[0];
        if (elTemp.nodeName.toLowerCase() == "input") {
            if (elTemp.type == "text")
                elTemp.value = valoreRiga;
            else if (elTemp.type == "checkbox") {
                if (valoreRiga == true)
                    elTemp.checked = "checked";
                else
                    elTemp.checked = "";
            }
        } else
            elTemp.innerHTML = valoreRiga;*/
    }
    apriPopupType2_bind(IdPopupAssociato, true)
}

function iwebTABELLA_ConfermaEliminaRigaInPopup(IdPopupAssociato, idTabella, attesaRispostaServer, funzioneAFineEsecuzione) {
    // esempio --> popupAssociato = "popupEliminaRiga"
    var popupAssociato = document.getElementById(IdPopupAssociato);
    if (popupAssociato == null)
        console.log("%cErrore nella conferma dell'eliminazione. Non trovo il popup " + IdPopupAssociato, "color:darkred");
    if (document.getElementById(idTabella) == null)
        console.log("%cErrore nella conferma dell'eliminazione. Non trovo la tabella associata " + idTabella, "color:darkred");
    // cerco nel popup delete la query delete
    var elQueryDelete = popupAssociato.getElementsByClassName("iwebSQLDELETE")[0];
    //var queryDelete = generaQueryDaSpanSql(elQueryDelete);
    if (elQueryDelete != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryDelete);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryDelete);

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

                // chiudi e nascondi il popup
                chiudiPopupType2B(popupAssociato);

                if (jsonRisultatoQuery[0].errore == null) {
                    // ricarica la tabella
                    iwebTABELLA_Carica(idTabella, 0, true)

                    if (funzioneAFineEsecuzione && typeof funzioneAFineEsecuzione === "function")
                        funzioneAFineEsecuzione();
                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }

        // versione WebService.asmx/sparaQueryDelete
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryDelete", true);
        var jsonAsObject = {
            query: sqlQuery, // string
            parametri: parametriQuery // string
        }
        //console.log(jsonAsObject)
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);

    } else {
        console.log("%ciwebSQLDELETE non trovato nell'elemento " + IdPopupAssociato, "color:darkred");
    }
}

/* #MODIFICA */
function iwebTABELLA_ModificaRigaInPopup(IdPopupAssociato) {
    var el = event.srcElement;
    var trPadre = el.parentElement.parentElement;
    var popupAssociato = document.getElementById(IdPopupAssociato);

    // controllo per i campi obbligatori devo ciclare sugli elementi con i web campo obbligatorio
    var elementiDaAggiornare = popupAssociato.getElementsByClassName("iwebCAMPOOBBLIGATORIO");
    for (var i = 0; i < elementiDaAggiornare.length; i++)
        if (elementiDaAggiornare[i].style.border == "1px solid red")
            elementiDaAggiornare[i].style.border = "";

    // cerco gli elementi che sono presenti sia nella riga che nel popup associato "iwebCAMPO_"
    var allElements_popupAssociato = popupAssociato.getElementsByTagName("*");
    var elencoParametriDaModificare = "";
    for (var i = 0; i < allElements_popupAssociato.length; ++i) {
        if (allElements_popupAssociato[i].className.indexOf("iwebCAMPO_") >= 0) {
            var parametroDaModificare = allElements_popupAssociato[i].className.split("iwebCAMPO_")[1].split(" ")[0];

            if (trPadre.getElementsByClassName("iwebCAMPO_" + parametroDaModificare)[0] != null)
                elencoParametriDaModificare += parametroDaModificare + ",";
        }
    }
    // tolgo l'ultima virgola
    if (elencoParametriDaModificare.length > 0)
        elencoParametriDaModificare = elencoParametriDaModificare.substr(0, elencoParametriDaModificare.length - 1);
    var IdUnivocoDiQuestaRiga = iwebTABELLA_GeneraIdPerQuestaRiga(trPadre);
    // console.log(IdUnivocoDiQuestaRiga + " -&gt; " + elencoParametriDaModificare);
    // genero un id univoco per questa riga e associo questo id al trPadre

    // memorizzo nel popup una copia delle variabili che voglio modificare. mi servirà per quando chiudo il popup e aggiorno il dato in tabella
    popupAssociato.getElementsByClassName("iwebTABELLA_ContenitoreParametri")[0].innerHTML = IdUnivocoDiQuestaRiga + "-&gt;" + elencoParametriDaModificare;
    popupAssociato.getElementsByClassName("iwebTABELLA_ContenitoreParametri")[0].style.display = "none";

    // -elencoParametriDaModificare- contiene ad esempio la stringa: "ID, Nome, Cognome" -> ciò significa che nella riga dove mi trovo devo andare a modificare l'id, il nome e il cognome
    var colonneDaModificare = elencoParametriDaModificare.split(",");

    // OTTENGO i valori che mi servono dalla riga che sto modificando
    var valoreRiga = "";
    for (var i = 0; i < colonneDaModificare.length; ++i) {
        // esempio per ottenere il valore della colonna ID per la riga che voglio modificare: iwebTABELLA_GetRigaPuntuale(el, "ID")
        valoreRiga = iwebTABELLA_GetRigaPuntuale(trPadre, colonneDaModificare[i]);

        // ho trovato il valore della colonna che mi interessava, devo andare ad associarlo all'id giusto nel popup
        var nomeCampo = colonneDaModificare[i];
        //console.log([popupAssociato, nomeCampo, valoreRiga, "se sembra mancare un parametro forse è perchè manca nel popup o nella tabella associata"]);
        iwebTABELLA_AssociaDatoInPopup(popupAssociato, nomeCampo, valoreRiga)

        // cancellare questo codice in giugno
        /*var elTemp = popupAssociato.getElementsByClassName("iwebCAMPO_" + colonneDaModificare[i])[0];
        var nomeNodo = elTemp.nodeName.toLowerCase();
        if (nomeNodo == "input") {
            if (elTemp.type == "text")
                elTemp.value = valoreRiga;
            else if (elTemp.type == "checkbox")
                elTemp.checked = valoreRiga == true;
        } else if (nomeNodo == "span") {
            elTemp.innerHTML = valoreRiga;
        } else if (nomeNodo == "textarea") {
            elTemp.value = valoreRiga;
        } else if (nomeNodo == "div") {
            // file upload
            if (elTemp.className.indexOf("iwebFileUpload") >= 0) {
                elTemp.getElementsByTagName("img")[0].src = "/public/" + valoreRiga;
                elTemp.title = "/public/" + valoreRiga;
                console.log("sono qui" + elTemp.className);
            }
        } else if (nomeNodo == "select") {
            // iwebDDL_aggiornaSelezionati(ELEM_oppure_IDELEM_DDL, listaSelezionati)
            //iwebDDL_aggiornaSelezionati(elTemp, valoreRiga);

            // aggiorna i valori preselezionati
            var idTemp = elTemp.id;

            if (elTemp.id != "") {
                iwebDDL_aggiornaSelezionati(idTemp, valoreRiga);
                // bind sull'elemento DDL
                if (elTemp.className.indexOf("iwebDDL") >= 0) {
                    // eventualmente va aggiunto un timeout o messo nel prerender di iwebDDL_aggiornaSelezionati qua sopra caricato
                    iwebCaricaElemento(idTemp);
                }
            }
        }*/

    }

    // ho ottenuto i dati che mi servono, ora apro il popup passandogli le informazioni raccolte
    apriPopupType2_bind(IdPopupAssociato, true)
}

// string, string, string, boolean -> TODO aggiornare il record online
function iwebTABELLA_ConfermaModificaRigaInPopup(IdPopupAssociato, idTabella, parametriSet, parametriWhere, attesaRispostaServer, funzioneAFineEsecuzione) {
    // esempio --> popupAssociato = "popupModificaRiga"
    var popupAssociato = document.getElementById(IdPopupAssociato);

    // cerco nel popup la query di update
    if (popupAssociato.getElementsByClassName("iwebSQLUPDATE").length == 0)
        console.log("%ciwebSQLUPDATE non trovato nell'elemento " + IdPopupAssociato, "color:darkred");

    var elQueryUpdate = popupAssociato.getElementsByClassName("iwebSQLUPDATE")[0];

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

/* #INSERISCI */
function iwebTABELLA_AggiungiRigaInPopup(idPopupAssociato) {
    var el = event.srcElement;
    var popupAssociato = document.getElementById(idPopupAssociato);

    // controllo per i campi obbligatori devo ciclare sugli elementi con i web campo obbligatorio
    var elementiDaAggiornare = popupAssociato.getElementsByClassName("iwebCAMPOOBBLIGATORIO");
    for (var i = 0; i < elementiDaAggiornare.length; i++)
        if (elementiDaAggiornare[i].style.border == "1px solid red")
            elementiDaAggiornare[i].style.border = "";

    // carico i DDL che trovo nel popup. Non mi preoccupo dei valori preselezionati
    var DDLDaCaricare = popupAssociato.getElementsByTagName("select");
    for (var i = 0; i < DDLDaCaricare.length; i++) {
        var elTemp = DDLDaCaricare[i];
        if (elTemp.className.indexOf("iwebDDL") >= 0) {
            var idElTemp = elTemp.id;
            iwebCaricaElemento(idElTemp);
        }
    }

    // apro il popup di inserimento
    apriPopupType2_bind(idPopupAssociato, true);
}

// i parametri sono superflui, posso in futuro rimpiazzare quel parametro con un altro, facendo però il controllo del typeof su parametri.. normalmente gli passo una stringa
function iwebTABELLA_ConfermaAggiungiRecordInPopup(idPopupAssociato, idTabella, parametri, attesaRispostaServer, funzioneAFineEsecuzione) {
    // esempio --> popupAssociato = "popupInserisciRiga"
    var popupAssociato = document.getElementById(idPopupAssociato);
    var tabellaAssociata = document.getElementById(idTabella);
    // cerco nel popup delete la query delete
    if (popupAssociato == null || tabellaAssociata == null)
        console.log("%cErrore su iwebTABELLA_ConfermaAggiungiRecordInPopup: ricontrolla i parametri: " + idPopupAssociato + ", " + idTabella, "color:darkred");
    // console.log("%cErrore su iwebTABELLA_ConfermaAggiungiRecordInPopup: ricontrolla i parametri passati alla funzione. oppure c'entra questo? -> (" + campiObbligatoriVerificati + ")", "color:darkred");

    var campiObbligatoriVerificati = iwebTABELLA_VerificaCampiObbligatori(popupAssociato);
    //console.log(campiObbligatoriVerificati);
    if (campiObbligatoriVerificati.length == 0) {
        var elQueryInsert = popupAssociato.getElementsByClassName("iwebSQLINSERT")[0];
        if (elQueryInsert != null) {
            var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryInsert);
            var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryInsert) + "&&&";
            parametriQuery = parametriQuery.substr(0, parametriQuery.length - 3); // tolgo gli ultimi 3 caratteri ("&&&")
            // cerco gli elementi che sono presenti sia nella riga che nel popup associato "iwebCAMPO_"
            var allElements_popupAssociato = popupAssociato.getElementsByTagName("*");
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

                    // chiudi e nascondi il popup
                    chiudiPopupType2B(popupAssociato);

                    if (jsonRisultatoQuery[0].errore == null) {
                        // codice qui

                        // ricarica la tabella
                        iwebTABELLA_Carica(idTabella, 0, true, funzioneAFineEsecuzione);

                        /*if (funzioneAFineEsecuzione && typeof funzioneAFineEsecuzione === "function")
                            funzioneAFineEsecuzione();*/
                    } else {
                        console.log("errore json " + jsonRisultatoQuery[0].errore);
                    }

                }
            }

            xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryInsert", true);
            var jsonAsObject = {
                query: sqlQuery,
                parametri: parametriQuery
            }
            //console.log(jsonAsObject);
            xmlhttp.setRequestHeader("Content-type", "application/json");
            var jsonAsString = JSON.stringify(jsonAsObject);
            xmlhttp.send(jsonAsString);
        }
    }
}


// esempio: gli passo l'id della tabella clienti e il campo cliente.id, la funzione restituisce l'id del cliente selezionato se ce n'è almeno uno selezionato
function iwebTABELLA_GetValoreFromRigaSelezionata(idTabella, nomeColonna) { // nomecolonna senza iwebCAMPO_
    var el = iwebTABELLA_GetRigaSelezionata(idTabella);
    if (el != null)
        return iwebTABELLA_GetRigaPuntuale(el, nomeColonna);
    return "";
}
function iwebTABELLA_GetRigaSelezionata(idTabella) {
    return document.getElementById(idTabella).getElementsByClassName("iwebRigaSelezionata")[0];
}

// ottengo il primo elemento che ha come classe iwebcampo. da quello ottengo il suo valore
function iwebTABELLA_GetRigaPuntuale(trPadre, nomeCampo) {
    // verifico che ci sia un solo elemento, altrimenti è un probabile errore
    if (trPadre.getElementsByClassName("iwebCAMPO_" + nomeCampo).length > 1)
        console.log("%cErrore nella funzione iwebTABELLA_GetRigaPuntuale. Più di un valore con classe: iwebCAMPO_" + nomeCampo, "color:darkred");

    var elemento = trPadre.getElementsByClassName("iwebCAMPO_" + nomeCampo)[0];
    var valoreTrovato = iwebTABELLA_GetValoreFromElement(elemento);
    return valoreTrovato;
}

// esempio: gli passo un elemento span con contenuto "abc", la funzione restituisce abc
function iwebTABELLA_GetValoreFromElement(el) {
    var valoreTrovato = "";

    if (el == null)
        console.log("%cErrore in iwebTABELLA_GetValoreFromElement. L'elemento non esiste nella tabella o nel popup", "color:darkred");
    else {
        if (el.className.indexOf("iwebCAMPO") < 0)
            console.log("%cErrore in iwebTABELLA_GetValoreFromElement. l'elemento non è un iwebCAMPO", "color:darkred");

        var nomeNodo = el.nodeName.toLowerCase();

        if (nomeNodo == "span" || nomeNodo == "td") {
            // se ci sono i 3 puntini alla fine ed è stato assegnato un title a questo elemento, è probabile (non certo) che i puntini siano stati messi da "iwebTroncaCrtsAt_" o simili
            if (rightString(el.innerHTML, 3) == "..." && el.title != "")
                valoreTrovato = el.title;
            else
                valoreTrovato = el.innerHTML;
        } else if (nomeNodo == "input" && el.type == "checkbox") {
            valoreTrovato = el.checked;
        } else if (nomeNodo == "input" || nomeNodo == "textarea") {
            valoreTrovato = el.value;
        }

    }

    return valoreTrovato;
}

function iwebTABELLA_GeneraIdPerQuestaRiga(trPadre) {
    var nomeTable = trPadre.parentElement.parentElement.id;
    var classiTabella = trPadre.parentElement.parentElement.className.split(" ");

    // ottengo la chiave della tabella
    var chiaveTabella = "";
    for (var i = 0; i < classiTabella.length; ++i)
        if (classiTabella[i].indexOf("iwebCHIAVE__") != -1)
            chiaveTabella = classiTabella[i].split("iwebCHIAVE__")[1].split(" ")[0];

    // una tabella può avere più campi per formare la chiave
    var campiChiaveTabella = chiaveTabella.split("__");

    // genero un id univoco per questa riga. esempio -> iwebCHIAVE__ID la chiave è ID (Attenzione!!! è case sensitive!!!)
    // esempio 2 -> iwebCHIAVE__ID__Nome -> la chiave è formata da ID e Nome
    var IDQuestaRiga = nomeTable;
    for (var i = 0; i < campiChiaveTabella.length ; ++i) {
        var elTemp = trPadre.getElementsByClassName("iwebCAMPO_" + campiChiaveTabella[i]);
        if (elTemp.length == 0)
            console.log("%cErrore: Non riesco a trovare la chiave nella tabella con id " + nomeTable + ". non esiste il campo iwebCAMPO_" + campiChiaveTabella[i], "color:darkred");
        IDQuestaRiga += "__" + elTemp[0].innerHTML;
    }
    trPadre.id = IDQuestaRiga;
    return IDQuestaRiga;
}

function iwebTABELLA_FooterVaiPaginaPrec() {
    var el = event.srcElement;
    if (el != null) {
        if (el.className.indexOf("iwebCliccabile") == -1) el = el.parentElement;
        if (el.className.indexOf("iwebCliccabile") == -1) el = el.parentElement;
    }
    var elPageNumber = el.nextElementSibling.getElementsByTagName('input')[0];

    var pageNumber = parseInt(elPageNumber.value);
    if (pageNumber > 1) {
        var idTabella = cercaTablePadreRicors(el).id;
        iwebTABELLA_Carica(idTabella, pageNumber - 1, true);
    }
}
function iwebTABELLA_FooterVaiPaginaSpec() {
    var el = event.srcElement;
    var el2 = el.parentElement.nextElementSibling.nextElementSibling.nextElementSibling;
    var patternNumeroIntero = /[^0-9]/g;
    var pageNumber = 0;

    //pageNumber = regexNumeroIntero(pageNumber);
    // se non contiene caratteri alfabetici o speciali || è un numero inferiore a 1 -> il pageNumber viene settato a 1
    if (el.value.match(patternNumeroIntero) != null || parseInt(el.value) < 1)
        pageNumber = 1;
    else
        pageNumber = parseInt(el.value);

    // se il numero pagina è oltre l'ultima pagina, viene selezionata l'ultima pagina
    if (pageNumber > parseInt(el2.innerHTML))
        pageNumber = parseInt(el2.innerHTML);
    iwebTABELLA_Carica(cercaTablePadreRicors(el).id, pageNumber, true);
}
function iwebTABELLA_FooterVaiPaginaSucc() {
    var el = event.srcElement;
    if (el != null) {
        if (el.className.indexOf("iwebCliccabile") == -1) el = el.parentElement;
        if (el.className.indexOf("iwebCliccabile") == -1) el = el.parentElement;
    }
    var elPageNumber = el.previousElementSibling.getElementsByTagName('input')[0];
    var el3 = el.nextElementSibling.nextElementSibling;

    var pageNumber = parseInt(elPageNumber.value);
    if (pageNumber < parseInt(el3.innerHTML)) {
        var idTabella = cercaTablePadreRicors(el).id;
        iwebTABELLA_Carica(idTabella, pageNumber + 1, true);
    }
}
function iwebTABELLA_FooterCambiaPageSize() {
    var el = event.srcElement;
    //el.parentElement.parentElement.getElementsByTagName("input")[0].value = "1";
    iwebTABELLA_Carica(cercaTablePadreRicors(el).id, 1, true)
}

function iwebTABELLA_CheckboxTuttiNessuno() {
    var el = event.srcElement;
    var questoCheckboxChecked = el.checked;
    var elTable = el.parentElement.parentElement.parentElement.parentElement;
    var corpoTabella = elTable.getElementsByTagName("tbody")[1].getElementsByTagName("tr");

    for (var i = 0; i < corpoTabella.length; i++)
        corpoTabella[i].getElementsByTagName("input")[0].checked = questoCheckboxChecked;
    /*if (questoCheckboxChecked == true) {
        if (corpoTabella[i].className.indexOf("tabellaajaxRigaSelezionata") == -1)
            corpoTabella[i].className += " tabellaajaxRigaSelezionata";
    } else {
        if (corpoTabella[i].className.indexOf("tabellaajaxRigaSelezionata") >= 0)
            corpoTabella[i].className = corpoTabella[i].className.replace("tabellaajaxRigaSelezionata", " ").replace("  ", " ");
    }*/
}
function iwebTABELLA_SelezionaRigaComeUnica() {
    var el = event.srcElement;

    // ottengo il tBody padre per poi ciclare sui tr e sui checkbox tabellaajaxRigaSelezionata
    var tbodyPadre = cercaTablePadreRicors(el).getElementsByTagName("tbody")[1];
    var listaTr = tbodyPadre.getElementsByTagName("tr");

    // controllo tutti i tr della tabella e tolgo tutte le classi iwebRigaSelezionata
    for (var i = 0; i < listaTr.length; ++i)
        listaTr[i].className = listaTr[i].className.replace(" iwebRigaSelezionata ", " ").replace("iwebRigaSelezionata ", "").replace(" iwebRigaSelezionata", "").replace("iwebRigaSelezionata", "");

    // assegno iwebRigaSelezionata al tr selezionato
    var trPadre = el.parentElement.parentElement;
    trPadre.className = "iwebRigaSelezionata " + trPadre.className;
}

// caricamento di un elemento
function iwebCaricaElemento(idElemento, attesaRispostaServer, funzioneAFineEsecuzione) {
    if (attesaRispostaServer != true) attesaRispostaServer = false;

    var elementoDaCaricare = document.getElementById(idElemento);
    if (elementoDaCaricare == null)
        console.log("'" + idElemento + "' non esiste, non posso caricarlo. (iwebCaricaElemento)");
    var nomeClasse = elementoDaCaricare.className;

    if (nomeClasse.indexOf("iwebTABELLA") >= 0) {
        iwebTABELLA_Carica(idElemento, 0, attesaRispostaServer, funzioneAFineEsecuzione);
        console.log("carico iwebTABELLA " + idElemento);
    } else if (nomeClasse.indexOf("iwebTABPADRE") >= 0) {
        iwebTABPADRE_Carica(idElemento, attesaRispostaServer);
        console.log("carico iwebTABPADRE " + idElemento);
    } else if (nomeClasse.indexOf("iwebDETTAGLIO") >= 0) {
        iwebDETTAGLIO_Carica(idElemento);
        console.log("carico iwebDETTAGLIO " + idElemento);
    } else if (nomeClasse.indexOf("iwebDDL") >= 0) {
        iwebDDL_Carica(idElemento, attesaRispostaServer);
        console.log("carico iwebDDL " + idElemento);
    } else if (nomeClasse.indexOf("iwebLABEL") >= 0) {
        iwebLABEL_Carica(idElemento);
        console.log("carico iwebLABEL " + idElemento);
    }
}

// bind a tabelle secondarie:
// L'elemento (principale) che ha possibilità di legarsi e manipolare tabelle/elementi (secondari) deve avere tra le classi: "iwebBind" + nVolte["_"+idElementoSecondario]
// L'elemento che ha possibilità di scatenare il bind deve chiamare la funzione iwebBind(idElementoPrincipale)
// NOTE: - tutti gli elementi id NON devono avere "_" nel nome id
//       - tutti gli elementi secondari devono contenere nel nome classe una delle seguenti sottostringhe di riconoscimento (in caso contrario verranno ignorati i bind):
//         "tabellaajax" (nel caso di tabelleajax), "ajaxDettaglio" (nel caso di lettura semplice della riga), todo
function iwebBind(idElemento) {
    var el = document.getElementById(idElemento);
    if (el == null)
        console.log("%cErrore nella funzione iwebBind(idElemento). Non trovo l'elemento con id " + idElemento, 'color:darkred');
    iwebBindThisEl(el);
}
function iwebBindThisEl(el) {
    var nomeClassi = el.className.split(" ");

    // genera la lista delle tabelle da aggiornare
    var listaElementiDaAggiornare = [];
    for (var i = 0; i < nomeClassi.length; ++i) {
        if (nomeClassi[i].indexOf("iwebBIND__") >= 0) {
            var tempStringaTabelle = [];
            tempStringaTabelle = nomeClassi[i].substr(nomeClassi[i].indexOf("iwebBIND__") + "iwebBIND__".length).split("__");
            // considera valide solo le tabelle veramente esistenti, mostra un log di errore se non esiste la tabella specifica
            for (var j = 0; j < tempStringaTabelle.length; ++j) {
                if (document.getElementById(tempStringaTabelle[j]) == null) {
                    console.log("%cErrore bind: non esiste l'id '" + tempStringaTabelle[j] + "'" + " (vedi el con classname: " + el.className + ")", 'color:darkred');
                    //alert("Errore bind: non esiste l'id '" + tempStringaTabelle[j] + "'")
                } else {
                    listaElementiDaAggiornare.push(tempStringaTabelle[j]);
                }
            }
        }
    }
    // ho la lista degli elementi da aggiornare -> console.log(listaElementiDaAggiornare);
    // aggiorno uno alla volta ogni elemento
    for (var i = 0; i < listaElementiDaAggiornare.length; ++i)
        iwebCaricaElemento(listaElementiDaAggiornare[i], true);


    // ricomincio la ricerca, questa volta cerco iwebBINDRIGASELEZIONATA__ per aggiornare la riga selezionata della tabella di riferimento
    var nomeClassi = el.className.split(" ");
    var listaElementiDaAggiornare = [];
    for (var i = 0; i < nomeClassi.length; ++i) {
        if (nomeClassi[i].indexOf("iwebBINDRIGASELEZIONATA__") >= 0) {
            var tempStringaTabelle = [];
            tempStringaTabelle = nomeClassi[i].substr(nomeClassi[i].indexOf("iwebBINDRIGASELEZIONATA__") + "iwebBINDRIGASELEZIONATA__".length).split("__");

            // considera valide solo le tabelle veramente esistenti, mostra un log di errore se non esiste la tabella specifica
            for (var j = 0; j < tempStringaTabelle.length; ++j) {
                if (document.getElementById(tempStringaTabelle[j]) == null) {
                    console.log("%cErrore bind riga selezionata: non esiste l'id '" + tempStringaTabelle[j] + "'" + " (vedi el con classname: " + el.className + ")", 'color:darkred');
                    //alert("Errore bind: non esiste l'id '" + tempStringaTabelle[j] + "'")
                } else {
                    listaElementiDaAggiornare.push(tempStringaTabelle[j]);
                }
            }
        }
    }
    for (var i = 0; i < listaElementiDaAggiornare.length; ++i)
        iwebAggiornaRigaSelezionataIwebTABELLA(listaElementiDaAggiornare[i]);
}

function iwebAggiornaRigaSelezionataIwebTABELLA(idTabella) {
    var elTabella = document.getElementById(idTabella);
    // ottengo la chiave (array contenente i campi che formano la chiave)
    var chiaveTabella = elTabella.className.split("iwebCHIAVE__")[1].split(" ")[0].split("__");

    // ottengo l'elemento selezionato
    var elTr = elTabella.getElementsByClassName("iwebRigaSelezionata");
    var elTrSelezionato = null;
    for (var i = 0; i < elTr.length; i++)
        elTrSelezionato = elTr[i];

    // ottengo i dati chiave dell'elemento selezionato
    var listaCampiTabella = [];
    for (var i = 0; i < chiaveTabella.length; i++) {
        var x = elTrSelezionato.getElementsByClassName("iwebCAMPO_" + chiaveTabella[i])[0];
        if (x != null) {
            var nomeNodo = x.nodeName.toLowerCase();
            var valorecampo = "";
            if (nomeNodo == "span")
                valorecampo = x.innerHTML;
            if (nomeNodo == "input")
                valorecampo = x.value;
            listaCampiTabella.push("@" + chiaveTabella[i] + "=" + valorecampo);
        }
    }

    //console.log("iwebAggiornaRigaSelezionataIwebTABELLA " + chiaveTabella.join(",") + "  /  " + elTrSelezionato.className + "  / " + listaCampiTabella.join(","));
    //console.log("iwebAggiornaRigaSelezionataIwebTABELLA " + listaCampiTabella.join(","));

    // prendi il prossimo elemento cerca ricorsivamente gli span finchè non trovi quello con l'sql giusto
    var elQuerySelect = iwebOttieniSqlRicors(prossimoElemento(document.getElementById(idTabella)), "select");
    // var querySelect = generaQueryDaSpanSql(elQuerySelect);
    if (elQuerySelect != null) {
        var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
        var parametriExtra = listaCampiTabella.join("&&&");
        //console.log("prima: " + parametriExtra);
        var parametriChiocciola = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);
        if (rightString(parametriChiocciola, 3) == "&&&")
            parametriChiocciola = parametriChiocciola.substr(0, parametriChiocciola.length - 3);
        //console.log("dopo: " + parametriExtra + parametriChiocciola);

        var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari */ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery[0].errore == null) {
                    var tBodySorg = elTabella.getElementsByTagName("tbody")[0];
                    var tBodyDest = elTabella.getElementsByTagName("tbody")[1];
                    var cloneRiga = tBodySorg.cloneNode(true);
                    elementiOggetto = Object.getOwnPropertyNames(jsonRisultatoQuery[1]);

                    // primo checkbox
                    cloneRiga.getElementsByTagName("input")[0].title = i;

                    // ciclo sulle colonne
                    for (var j = 0; j < elementiOggetto.length; ++j) {
                        var elTemp = cloneRiga.getElementsByClassName("iwebCAMPO_" + elementiOggetto[j])[0];
                        if (elTemp != null) {

                            // ottengo il valore e lo formatto correttamente (se è stato indicato un formato specifico)
                            var valore = jsonRisultatoQuery[i][elementiOggetto[j]];

                            // modifico stile e valore del dato ottenuto da db
                            valore = iwebElaboraCampo(elTemp, valore);

                            var nomeNodo = elTemp.nodeName.toLowerCase();
                            if (elTemp.onclick != null) { // per ora usato solo su generazione pdf
                                var x = elTemp.onclick.toString().split("function onclick(event) {")[1];
                                x = leftString(x, x.length - 1);
                                x = x.replace("iwebCAMPO_" + elementiOggetto[j], valore); // replace del iwebcampo... purtroppo senza chiocciola
                                elTemp.setAttribute("onClick", x);
                            }
                            if (nomeNodo == "a" && elTemp.href != "") {
                                elTemp.href = elTemp.href.replace("@iwebCAMPO_" + elementiOggetto[j], valore);
                            }
                            if (nomeNodo == "td") {
                                elTemp.innerHTML = valore
                            }
                            if (nomeNodo == "span") {
                                elTemp.innerHTML = valore
                            }
                            if (nomeNodo == "input") {
                                if (elTemp.type == "checkbox")
                                    if (valore == true)
                                        elTemp.parentElement.innerHTML = elTemp.parentElement.innerHTML.replace(">", " checked>");
                            }

                        } else {
                            //console.log("%cNon sono riuscito a utilizzare la colonna " + "iwebCAMPO_" + elementiOggetto[j], "color:darkred");
                        }
                    }

                    // primo checkbox (per la selezione di righe multipla)
                    var cbTemp = elTabella.getElementsByClassName("iwebRigaSelezionata")[0].getElementsByTagName("input")[0].title;
                    cloneRiga.getElementsByTagName("input")[0].title = cbTemp;
                    // sostituisci la riga
                    elTabella.getElementsByClassName("iwebRigaSelezionata")[0].innerHTML = cloneRiga.innerHTML;
                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }

        // versione WebService.asmx/sparaQueryReader
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReaderRigaSelezionata", true);
        var jsonAsObject = {
            query: querySelect, // string
            parametriChiocciola: parametriChiocciola,
            parametriExtra: parametriExtra
        };
        //console.log(jsonAsObject);
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.setRequestHeader("Content-type", "application/json");
        xmlhttp.send(jsonAsString);
    }

}

function iwebDETTAGLIO_Carica(idElemento) {
    var el = document.getElementById(idElemento);

    var tBodySorg = el.getElementsByTagName("tbody")[0];
    var primoTrSorg = tBodySorg.getElementsByTagName("tr")[0];
    var tBodyDest = el.getElementsByTagName("tbody")[1];

    // prendi il prossimo elemento cerca ricorsivamente gli span finchè non trovi quello con l'sql giusto
    var elQuerySelect = iwebOttieniSqlRicors(prossimoElemento(document.getElementById(idElemento)), "select");
    // var querySelect = generaQueryDaSpanSql(elQuerySelect);
    if (elQuerySelect != null) {
        var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
        var parametriChiocciola = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);

        var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari */ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);
                if (jsonRisultatoQuery[0].errore == null) {
                    var risultatoInnerHTML = "";
                    var nRigheContate = jsonRisultatoQuery[0].elementiContati;

                    // se non sono stati trovati elementi mostra Nessun elemento trovato
                    if (nRigheContate == 0) {
                        var nColonne = tBodySorg.getElementsByTagName("td").length;
                        tBodyDest.innerHTML = "<tr><td colspan='" + nColonne + "'>Nessun elemento trovato</td></tr>";
                    } else {
                        // distingui la generazione delle righe automatica da quella manuale
                        if (primoTrSorg.innerHTML.indexOf("iwebCAMPO_@NOMECAMPO") >= 0 && primoTrSorg.className.indexOf("iwebNascosto") < 0) {
                            // A. caricamento elementi automatico
                            var modelloTR = primoTrSorg.innerHTML;
                            for (var i = 1; i <= nRigheContate; ++i) {
                                // esempio di risultato: elementiOggetto = ["ID","NOME","COGNOME"]
                                var elementiOggetto = Object.getOwnPropertyNames(jsonRisultatoQuery[i]);
                                for (var j = 0; j < elementiOggetto.length; ++j) {
                                    var nomeCampo = elementiOggetto[j];
                                    var valoreCampo = jsonRisultatoQuery[i][elementiOggetto[j]];
                                    var tempCode = modelloTR;
                                    tempCode = tempCode.split("@NOMECAMPO").join(nomeCampo);
                                    tempCode = tempCode.split("@VALORECAMPO").join(valoreCampo);
                                    risultatoInnerHTML += "<tr>" + tempCode + "</tr>";
                                }
                            }
                            tBodyDest.innerHTML = risultatoInnerHTML;
                        } else {
                            // B. caricamento elementi manuale
                            tBodyDest.innerHTML = tBodySorg.innerHTML;

                            // sostituisco iwebCampo dove posso
                            // var nRigheContate = jsonRisultatoQuery[0].elementiContati;
                            for (var i = 1; i <= nRigheContate; ++i) {
                                // esempio di risultato: elementiOggetto = ["ID","NOME","COGNOME"]
                                var elementiOggetto = Object.getOwnPropertyNames(jsonRisultatoQuery[i]);
                                for (var j = 0; j < elementiOggetto.length; ++j) {
                                    var nomeCampo = elementiOggetto[j];
                                    var elTemp = tBodyDest.getElementsByClassName("iwebCAMPO_" + nomeCampo)[0];

                                    if (elTemp != null) {
                                        // ottengo il valore e lo formatto correttamente (se è stato indicato un formato specifico)
                                        var valore = jsonRisultatoQuery[i][elementiOggetto[j]];

                                        // modifico stile e valore del dato ottenuto da db
                                        valore = iwebElaboraCampo(elTemp, valore);

                                        var nomeNodo = elTemp.nodeName.toLowerCase();
                                        if (elTemp.onclick != null) { // per ora usato solo su generazione pdf
                                            var x = elTemp.onclick.toString().split("function onclick(event) {")[1];
                                            x = leftString(x, x.length - 1);
                                            x = x.replace("iwebCAMPO_" + elementiOggetto[j], valore); // replace del iwebcampo... purtroppo senza chiocciola
                                            elTemp.setAttribute("onClick", x);
                                        }
                                        if (nomeNodo == "a" && elTemp.href != "") {
                                            elTemp.href = elTemp.href.replace("@iwebCAMPO_" + elementiOggetto[j], valore);
                                        }
                                        if (nomeNodo == "td") {
                                            elTemp.innerHTML = valore
                                        }
                                        if (nomeNodo == "span") {
                                            elTemp.innerHTML = valore
                                        }
                                        if (nomeNodo == "input") {
                                            if (elTemp.type == "checkbox")
                                                if (valore == true)
                                                    elTemp.parentElement.innerHTML = elTemp.parentElement.innerHTML.replace(">", " checked>");
                                        }

                                    }
                                }
                            }
                        }

                        
                    }

                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }

        // versione WebService.asmx/sparaQueryReader
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReader", true);
        var jsonAsObject = {
            query: querySelect, // string
            pageSize: 100, // int
            pageNumber: 0, // int
            datiFiltri: [], // object[] datiFiltri
            ordinamento: [], // String[] ordinamento
            parametriChiocciola: parametriChiocciola
        };

        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}

function iwebApriPopupModificaiwebDETTAGLIO(idElTableAnagrafica, idPopupAssociato) {
    var elTableAnagrafica = document.getElementById(idElTableAnagrafica);
    // errore: il TableAnagrafica non esiste
    if (elTableAnagrafica == null) console.log("%cErrore in iwebDETTAGLIO: non esiste l'elemento '" + elTableAnagrafica + "'", "color:darkred");
    var popupAssociato = document.getElementById(idPopupAssociato);
    // errore: il divPopup non esiste
    if (popupAssociato == null) console.log("%cErrore in iwebDETTAGLIO: non esiste l'elemento '" + idPopupAssociato + "'", "color:darkred");

    // ciclo sugli elementi iwebcampo del iwebdettaglio e per ognuno importo nel popup quando trovo corrispondenza
    if (elTableAnagrafica.getElementsByTagName("tbody")[1].getElementsByTagName("tr").length > 1) {
        var tuttiElementiAnagrafica = elTableAnagrafica.getElementsByTagName("tbody")[1].getElementsByTagName("*");
        for (var i = 0; i < tuttiElementiAnagrafica.length; i++) {
            if (tuttiElementiAnagrafica[i].className.indexOf("iwebCAMPO_") >= 0) {
                // tuttiElementiAnagrafica[i].innerHTML -> valore campo
                var valorecampo = iwebTABELLA_GetValoreFromElement(tuttiElementiAnagrafica[i]);
                var nomecampo = tuttiElementiAnagrafica[i].className.split("iwebCAMPO_")[1].split(" ")[0];
                nomecampo = nomecampo.split(" ")[0];
                var elDaAggiornare = popupAssociato.getElementsByClassName("iwebCAMPO_" + nomecampo)[0];
                if (elDaAggiornare != null) {
                    // controllo per i campi obbligatori
                    if (elDaAggiornare.style.border == "1px solid red") elDaAggiornare.style.border = "";
                    var nomeNodo = elDaAggiornare.nodeName.toLowerCase();
                    iwebTABELLA_AssociaDatoInPopup(popupAssociato, nomecampo, valorecampo)
                }
            }
        }

        apriPopupType2_bind(idPopupAssociato, false);
    }
}

//iwebBindPopupModificaiwebDETTAGLIO
// idPopupPadre è opzionale. se è specificato usa quello
function iwebBindPopupModificaiwebDETTAGLIO(idPopupAssociato) {
    var popupAssociato = null;
    // se mi è stato passato come parametro idPopupAssociato
    if (idPopupAssociato != null)
        popupAssociato = document.getElementById(idPopupAssociato);
    else {
        // se NON mi è stato passato come parametro idPopupAssociato, lo cerco
        var el = event.srcElement;
        popupAssociato = cercaPopupPadreRicors(el);
        idPopupAssociato = popupAssociato.id;
    }
    var attesaRispostaServer = false;

    var campiObbligatoriVerificati = iwebTABELLA_VerificaCampiObbligatori(popupAssociato);
    //console.log(campiObbligatoriVerificati);
    if (campiObbligatoriVerificati.length == 0) {
        // cerco nel popup la query di update
        //var elQueryUpdate = popupAssociato.getElementsByClassName("iwebSQLUPDATE")[0];
        var elQueryUpdate = iwebOttieniSqlRicors(prossimoElemento(popupAssociato), "update");
        if (elQueryUpdate != null) {
            var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryUpdate);
            var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryUpdate);

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
                        iwebBind(idPopupAssociato);
                        chiudiPopupType2B(popupAssociato);
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
            xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryUpdate", true);
            xmlhttp.setRequestHeader("Content-type", "application/json");
            xmlhttp.send(jsonAsString);
        }
    }
}

// ciclo sui totali da calcolare e li calcolo uno a uno per la tabella selezionata
function iwebTABELLA_CalcoloTotaleColonne(idTabella) {
    var elTabella = document.getElementById(idTabella);
    var tfoot = elTabella.getElementsByTagName("tfoot");
    var spanDeiTotali = tfoot[0].getElementsByClassName("iwebTOTALE");
    for (var i = 0; i < spanDeiTotali.length; i++) {
        if (spanDeiTotali[i].parentElement.getElementsByClassName("iwebSQLSELECT").length > 0) {
            if (spanDeiTotali[i] != null && spanDeiTotali[i].className.indexOf("iwebUSAFILTRI") >= 0)
                iwebTABELLA_CalcoloTotaleColonna(spanDeiTotali[i], true); // iwebSQLSELECT
            else
                iwebTABELLA_CalcoloTotaleColonna(spanDeiTotali[i], false); // iwebSQLSELECT
        } else
            iwebTABELLA_CalcoloTotaleColonnaAutomatico(idTabella, spanDeiTotali[i]); // iwebSQLTOTAL
    }
}
function iwebTABELLA_CalcoloTotaleColonnaAutomatico(idTabella, elSpanTotale) {
    // dopo questo elemento c'è di sicuro l'elemento sql contenuto in uno span
    var campoQuery = prossimoElemento(elSpanTotale).innerHTML
    //var elQuerySelect = iwebOttieniSqlRicors(prossimoElemento(elSpanTotale), "select");

    //console.log(prossimoElemento(document.getElementById(idTabella)).innerHTML.trim().split("\n").join(""));
    var tBodySorg = document.getElementById(idTabella).getElementsByTagName("tbody")[0];
    var tBodyDest = document.getElementById(idTabella).getElementsByTagName("tbody")[1];

    // prendi il prossimo elemento cerca ricorsivamente gli span finchè non trovi quello con l'sql giusto -> TODO
    var elQuerySelect = iwebOttieniSqlRicors(prossimoElemento(document.getElementById(idTabella)), "select");
    if (elQuerySelect != null) {
        var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
        var parametriChiocciola = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);

        // page size e page number
        var pageNumber = document.getElementById(idTabella).getElementsByClassName("iwebPAGENUMBER")[0].getElementsByTagName("input")[0].value;
        pageNumber = pageNumber - 1; // in visualizzazione considero le pagine da 1 a n, ma nel calcolo devo considerare le pagine da 0 a n-1
        var tempSelect = document.getElementById(idTabella).getElementsByClassName("iwebPAGESIZE")[0].getElementsByTagName("select")[0];
        var pageSize = tempSelect.getElementsByTagName("option")[tempSelect.selectedIndex].value;

        var datiFiltri = iwebTABELLA_OttieniDatiFiltri(idTabella);
        // ottieni i dati sull'ordinamento
        var datiOrdinamento = iwebTABELLA_OttieniDatiOrdinamento(idTabella);


        var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari */ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery[0].errore == null) {
                    //var nRigheContate = jsonRisultatoQuery[0].elementiContati;
                    // devo leggere solo la prima cella della prima riga (jsonRisultatoQuery[1].TOTALE)
                    //  prendi il nomecampo del primo elemento
                    if (jsonRisultatoQuery.length == 2) {
                        var elementiOggetto = Object.getOwnPropertyNames(jsonRisultatoQuery[1]);
                        var totaleCalcolato = jsonRisultatoQuery[1][elementiOggetto[0]];

                        // modifico stile e valore del dato ottenuto da db
                        totaleCalcolato = iwebElaboraCampo(elSpanTotale, totaleCalcolato);

                        elSpanTotale.innerHTML = totaleCalcolato;
                    } else {
                        elSpanTotale.innerHTML = "";
                    }

                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }

        // versione WebService.asmx/sparaQueryReaderTotale
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReaderTotale", true);
        var jsonAsObject = {
            nomeCampoSum: campoQuery, // string
            query: querySelect, // string
            pageSize: pageSize, // int
            pageNumber: pageNumber, // int
            datiFiltri: datiFiltri, // object
            ordinamento: datiOrdinamento, // array[2] -> NOMECAMPO, ASC||DESC
            parametriExtra: parametriChiocciola // String
        }

        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}

// calcola il totale della colonna selezionata
function iwebTABELLA_CalcoloTotaleColonna(elSpanTotale, usaFiltriIwebTabella) {
    // se non è stato specificato il secondo parametro, diventa false di default
    if (usaFiltriIwebTabella != true)
        usaFiltriIwebTabella = false;

    // se uso i filtri della tabella, cerco ricorsivamente il primo table padre e da li ottengo i filtri
    var datiFiltri = [];
    if (usaFiltriIwebTabella == true) {
        var idTabella = cercaTablePadreRicors(elSpanTotale).id
        datiFiltri = iwebTABELLA_OttieniDatiFiltri(idTabella);
    }

    // cerco nel popup la query di select
    var elQuerySelect = elSpanTotale.parentElement.getElementsByClassName("iwebSQLSELECT")[0];
    if (elQuerySelect != null) {
        //var querySelect = generaQueryDaSpanSql(elQuerySelect);
        var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
        var parametriChiocciola = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);
        //console.log(querySelect);

        var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari */ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery[0].errore == null) {
                    // NO, perchè uso distinct o group by -> var nRigheContate = jsonRisultatoQuery[0].elementiContati;
                    var nRigheContate = jsonRisultatoQuery.length - 1;
                    // console.log("righe contate " + nRigheContate);
                    // (jsonRisultatoQuery[i].TOTALE)
                    var totaleCalcolato = 0;
                    for (var i = 0; i < nRigheContate; i++) {
                        var elementiOggetto = Object.getOwnPropertyNames(jsonRisultatoQuery[1]);
                        totaleCalcolato += jsonRisultatoQuery[i+1][elementiOggetto[0]];
                    }
                    //var totaleCalcolato = jsonRisultatoQuery[1][elementiOggetto[0]];

                    if (nRigheContate == 0) {
                        elSpanTotale.innerHTML = "";
                    } else {
                        // modifico stile e valore del dato ottenuto da db
                        totaleCalcolato = iwebElaboraCampo(elSpanTotale, totaleCalcolato);
                        elSpanTotale.innerHTML = totaleCalcolato;
                    }
                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }

        // versione WebService.asmx/sparaQueryReader
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReader", true);
        var jsonAsObject = {
            query: querySelect, // string
            pageSize: 100, // int
            pageNumber: 0, // int
            datiFiltri: datiFiltri, // object[] datiFiltri
            ordinamento: [], // String[] ordinamento
            parametriChiocciola: parametriChiocciola // String
        }
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}

function iwebTABELLA_AggiornaConteggioSelezionati(el) {
    if (el == null) el = event.srcElement;
    //idTabella = cercaTablePadreRicors(el).id
    var elTabella = cercaTablePadreRicors(el);
    //console.log(elTabella.id)
    var listaElementiCheckBoxSelezionati = elTabella.getElementsByClassName("iwebCBSELEZIONABILE");
    var listaCheckBoxSelezionati = [];
    for (var i = 0; i < listaElementiCheckBoxSelezionati.length; i++) {
        if (listaElementiCheckBoxSelezionati[i].checked)
            listaCheckBoxSelezionati.push(listaElementiCheckBoxSelezionati[i].title)
    }

    var divContenitoreDati = precedenteElemento(elTabella);
    if (divContenitoreDati != null && divContenitoreDati.nodeName.toLowerCase() == "div" && divContenitoreDati.className.indexOf("iwebTABELLAAzioniPerSelezionati") >= 0) {
        divContenitoreDati.getElementsByTagName("span")[0].innerHTML = listaCheckBoxSelezionati.length + " selezionati";

        // se 0 disabilita selezione, altrimenti abilita selezione
        if (listaCheckBoxSelezionati.length == 0) {
            divContenitoreDati.getElementsByTagName("select")[0].disabled = true;
            divContenitoreDati.getElementsByTagName("input")[0].disabled = true;
        } else {
            divContenitoreDati.getElementsByTagName("select")[0].disabled = false;
            divContenitoreDati.getElementsByTagName("input")[0].disabled = false;
        }
    }
}

function iwebTABELLA_ConfermaAzionePerSelezionati() {
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
            for (var i = 0; i < listaCheckBoxSelezionati.length; i++) {
                var rigaSelezionata = listaCheckBoxSelezionati[i] - 1;
                var parametriQuery = "";
                for (var j = 0; j < campiChiaveTabella.length; j++) {
                    var campoChiave = campiChiaveTabella[j];
                    parametriQuery += "@" + campoChiave + "=";
                    parametriQuery += tbodyVisibile.getElementsByTagName("tr")[rigaSelezionata].getElementsByClassName("iwebCAMPO_" + campoChiave)[0].innerHTML + ",";
                    if (j == campiChiaveTabella.length - 1)
                        parametriQuery = parametriQuery.substring(0, parametriQuery.length - 1);
                }

                if (azioneSelezionata == "Elimina") {
                    // cerco nel popup delete la query delete
                    var elQueryDelete = el.parentElement.getElementsByClassName("iwebSQLDELETE")[0];
                    //var queryDelete = generaQueryDaSpanSql(elQueryDelete);
                    if (elQueryDelete != null) {
                        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryDelete);
                        //var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryDelete);
                        //console.log(parametriQuery);

                        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
                        xmlhttp.onreadystatechange = function () {
                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
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
                        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryDelete", true);
                        var jsonAsObject = {
                            query: sqlQuery, // string
                            parametri: parametriQuery // string
                        }
                        //console.log(jsonAsObject)
                        xmlhttp.setRequestHeader("Content-type", "application/json");
                        var jsonAsString = JSON.stringify(jsonAsObject);
                        xmlhttp.send(jsonAsString);
                    }

                } // fine elimina
            } // fine ciclo for
        } // fine azioneSelezionata != ""
    }
}


// esempio: var elQuerySelect = iwebOttieniSqlRicors(prossimoElemento(document.getElementById(idDDL)), "select");
// esempio: var elQuerySelect = iwebOttieniSqlRicors(prossimoElemento(elSpanTotale), "select");
// esempio: var elQueryUpdate = iwebOttieniSqlRicors(prossimoElemento(document.getElementById(idDDL)), "update");
// il valore ritornato è un elemento che contiene almeno uno span (quello della query) e può contenere span aggiuntivi (contenente i parametri)
function iwebOttieniSqlRicors(el, tipoSql) {
    var querySelect = "";

    if (el.className.indexOf("iwebSQL") >= 0)
        if (el.className.indexOf("iwebSQL" + tipoSql.toUpperCase()) >= 0)
            querySelect = el;
        else
            querySelect = iwebOttieniSqlRicors(prossimoElemento(el), tipoSql)

    return querySelect;
}
function iwebGeneraSqlQueryDaSpanSql(elQuery) {
    return elQuery.getElementsByClassName("iwebSQL")[0].innerHTML;
}
function iwebGeneraParametriQueryDaSpanSql(elQuery) {
    // esempio di risultato: @id=2&&&@test=ciao 
    var parametri = "";
    var elSpanParametri = elQuery.getElementsByClassName("iwebPARAMETRO")
    var nChiocciole = elSpanParametri.length;
    for (var i = 0; i < nChiocciole; i++) {
        // elSpanParametri[i].innertHTML: @ID = tabellaClienti_selectedValue_ID
        var stringaParametro = elSpanParametri[i].innerHTML;
        // prendo la stringa e divido nome da valore
        var nomeParametro = trim(stringaParametro.split("=")[0])
        var parametroDaValutare = trim(stringaParametro.split("=")[1])
        var valoreParametro = iwebValutaParametroAjax(parametroDaValutare, elQuery);

        // inserisci il parametro se non è stato già aggiunto (accade quando inserisco più volte lo stesso parametro. non è necessario, anzi è un errore)
        if (parametri.indexOf(nomeParametro + "=") < 0)
            parametri += nomeParametro + "=" + valoreParametro + "&&&";
    }
    return leftString(parametri, parametri.length - 3);
}

// la stringa potrebbe essere ad esempio:
// tabellaClienti_selectedValue_ID_string
// si intende idTabella_nomeAzione_nomeCampo
function iwebValutaParametroAjax(stringa, elQuery) { // il secondo campo serve solo per il log
    var risultatoValuzione = "'0'";
    var aggiungiLIKE = false;

    // primo controllo. "like_" si trova all'inizio della stringa. rimuovo questa sottostringa e alla fine di questa funzione aggiungerò % all'inizio e alla fine della stringa risultato
    if (leftString(stringa, "LIKE_".length).toUpperCase() == "LIKE_") {
        stringa = rightString(stringa, stringa.length - "LIKE_".length);
        aggiungiLIKE = true;
    }

    // azioni semplici
    if (leftString(stringa, "VALORE_".length).toUpperCase() == "VALORE_") {
        // es: VALORE_12
        risultatoValuzione = rightString(stringa, stringa.length - "VALORE_".length);
    } else if (leftString(stringa, "FUNZIONE_".length).toUpperCase() == "FUNZIONE_") {
        // es: FUNZIONE_radicequadratadi4()
        risultatoValuzione = rightString(stringa, stringa.length - "FUNZIONE_".length);
        risultatoValuzione = eval(risultatoValuzione);
    } else {
        // azioni con underscore
        var idElemento = stringa.split("_")[0];
        var azione = stringa.split("_")[1];
        var nomeCampo = stringa.split("_")[2];
        // var tipoCampo = stringa.split("_")[3];
        // console.log(idElemento + " - " + azione + " - " + nomeCampo);
        // alert(idElemento + " - " + azione + " - " + nomeCampo);

        var el = document.getElementById(idElemento);

        // in caso di elemento null
        if (el == null) {
            console.log("%cErrore di valutazione parametro nella stringa: " + stringa + ". Non esiste l'elemento " + stringa.split("_")[0] + ". className dell'elemento query: " + elQuery.className, "color:darkred");
        }

        // in caso di dato in popup
        if (el.className.indexOf("popup") >= 0 && azione.toLowerCase() == "findvalue") {
            // verifico che ci sia un solo elemento, altrimenti è un probabile errore
            if (el.getElementsByClassName("iwebCAMPO_" + nomeCampo).length > 1)
                console.log("%cErrore. Più di un valore con classe: iwebCAMPO_" + nomeCampo, "color:darkred");

            // ottengo l'elemento e ne cerco il valore
            var elTrovato = el.getElementsByClassName("iwebCAMPO_" + nomeCampo)[0];
            if (elTrovato == null)
                console.log("%cErrore in iwebValutaParametroAjax. Non trovo il campo '" + nomeCampo + "'. className dell'elemento query: " + elQuery.className, "color:darkred");
            var nomeNodo = elTrovato.nodeName.toLowerCase();
            if (nomeNodo == "span") {
                risultatoValuzione = elTrovato.innerHTML;
            }
            if (nomeNodo == "input") {
                if (elTrovato.type.toLowerCase() == "text")
                    risultatoValuzione = elTrovato.value;
                if (elTrovato.type.toLowerCase() == "checkbox")
                    risultatoValuzione = elTrovato.checked ? "1" : "0";
                // caso di valutazione di una data
                if (elTrovato.className.indexOf("iwebTIPOCAMPO_date") >= 0) {
                    if (risultatoValuzione.length == 10) {
                        risultatoValuzione = risultatoValuzione.split("/").join("-"); // cambia eventuali slash in trattino
                        risultatoValuzione = risultatoValuzione.substr(6) + "-" + risultatoValuzione.substr(3, 2) + "-" + risultatoValuzione.substr(0, 2);
                    }
                }
            }
            // l'ho usato per l'insert
            if (nomeNodo == "select") {
                var selectedindex = elTrovato.selectedIndex;
                risultatoValuzione = elTrovato.getElementsByTagName("option")[selectedindex].value;
            }
            if (nomeNodo.toLowerCase() == "textarea") {
                risultatoValuzione = elTrovato.value;
            }

            // caso di uploadfile
            if (nomeNodo == "div" && elTrovato.className.toLowerCase().indexOf("iwebfileupload") >= 0) {
                risultatoValuzione = elTrovato.getElementsByTagName("span")[1].innerHTML; // nome del file caricato
                console.log(risultatoValuzione);
            }

            /*if (nomeNodo == "div" && elTrovato.className.toLowerCase().indexOf("iwebautocompletamento") >= 0) {
                // in caso di campo ad autocompletamento
                if (azione.toLowerCase() == "getvalore") {
                    var elInput = elTrovato.getElementsByTagName("input")[0];
                    risultatoValuzione = elInput.value;
                } else {
                    // commento l'if: di default se cerco nell'autocompletamento voglio la chiave, se no specifico getvalore per ottenere il valore
                    //if (azione.toLowerCase() == "getchiave") {
                        var elChiave = elTrovato.getElementsByTagName("span")[1];
                        risultatoValuzione = elChiave.innerHTML;
                    //}
                }
            }*/


        }

        // in caso di tabella ajax combinata con l'azione selectedvalue
        if (el.className.indexOf("iwebTABELLA") >= 0 && azione.toLowerCase() == "selectedvalue") {
            // ottengo il primo elemento selezionato (se ce ne sono di più, gli altri vengono ignorati)
            var elSelezionato = el.getElementsByClassName("iwebRigaSelezionata")[0];
            if (elSelezionato != null) {
                if (elSelezionato.getElementsByClassName("iwebCAMPO_" + nomeCampo).length == 0)
                    console.log("%cErrore nella valutazione di un campo: iwebCAMPO_" + nomeCampo, "color:darkred");
                else
                    risultatoValuzione = elSelezionato.getElementsByClassName("iwebCAMPO_" + nomeCampo)[0].innerHTML;
            }
            console.log(risultatoValuzione);
        }

        // in caso di tabella ajax combinata con l'azione selectedvalue
        if (el.className.indexOf("iwebTABELLA") >= 0 && azione.toLowerCase() == "findfirstvalue") {
            // ottengo il primo elemento trovato
            var elSelezionato = el.getElementsByTagName("tbody")[1];
            if (elSelezionato != null && elSelezionato.getElementsByClassName("iwebCAMPO_" + nomeCampo).length > 0) {
                var campoSelezionato = elSelezionato.getElementsByClassName("iwebCAMPO_" + nomeCampo)[0];
                risultatoValuzione = campoSelezionato.innerHTML;

                // caso di valutazione di una data
                if (campoSelezionato.className.indexOf("iwebTIPOCAMPO_date") >= 0 || campoSelezionato.className.indexOf("iwebData") >= 0) {
                    if (risultatoValuzione.length == 10) {
                        risultatoValuzione = risultatoValuzione.split("/").join("-"); // cambia eventuali slash in trattino
                        risultatoValuzione = risultatoValuzione.substr(6) + "-" + risultatoValuzione.substr(3, 2) + "-" + risultatoValuzione.substr(0, 2);
                    }
                }
                // console.log([nomeCampo, risultatoValuzione]);
            }
        }

        // in caso di DDL
        if (el.className.indexOf("iwebDDL") >= 0 && azione.toLowerCase() == "selectedvalue") {
            var selectedindex = el.selectedIndex;
            risultatoValuzione = el.getElementsByTagName("option")[selectedindex].value;
        }
        if (el.className.indexOf("iwebDDL") >= 0 && azione.toLowerCase() == "selectedtext") {
            var selectedindex = el.selectedIndex;
            risultatoValuzione = el.getElementsByTagName("option")[selectedindex].innerHTML;
        }

        // in caso di campo ad autocompletamento
        if (el.className.indexOf("iwebAUTOCOMPLETAMENTO") >= 0 && azione.toLowerCase() == "getchiave") {
            var elChiave = el.getElementsByTagName("span")[1];
            risultatoValuzione = elChiave.innerHTML;
        }
        if (el.className.indexOf("iwebAUTOCOMPLETAMENTO") >= 0 && azione.toLowerCase() == "getvalore") {
            var elInput = el.getElementsByTagName("input")[0];
            risultatoValuzione = elInput.value;
        }

        // caso Label
        if (el.className.indexOf("iwebLABEL") >= 0 && azione.toLowerCase() == "value") {
            risultatoValuzione = el.getElementsByTagName("span")[0].innerHTML;
        }

        // in caso di semplice value
        if (azione.toLowerCase() == "value") {
            var nomeNodo = el.nodeName;
            if (nomeNodo.toLowerCase() == "span") {
                risultatoValuzione = el.innerHTML;
            } else if (nomeNodo.toLowerCase() == "textarea") {
                risultatoValuzione = el.value;
            } else if (nomeNodo.toLowerCase() == "input") {
                if (el.type == "text")
                    risultatoValuzione = el.value;
                else if (el.type == "checkbox")
                    risultatoValuzione = el.checked ? "1" : "0";
                // caso di valutazione di una data
                if (el.className.indexOf("iwebTIPOCAMPO_date") >= 0) {
                    if (risultatoValuzione.length == 10) {
                        risultatoValuzione = risultatoValuzione.split("/").join("-"); // cambia eventuali slash in trattino
                        risultatoValuzione = risultatoValuzione.substr(6) + "-" + risultatoValuzione.substr(3, 2) + "-" + risultatoValuzione.substr(0, 2);
                    }
                }
            } else if (nomeNodo.toLowerCase() == "select") {
                var selectedindex = el.selectedIndex;
                risultatoValuzione = el.getElementsByTagName("option")[selectedindex].value;
            }
        }

    }

    if (aggiungiLIKE)
        risultatoValuzione = "%" + risultatoValuzione + "%";

    return risultatoValuzione;
}


// la formattazione non prevede la possibilità di spazi o underscore
// esempio: valore = iwebFORMATTA(formato, valoreJson)
// esempio: valore = iwebFORMATTA("datetime_dd/MM/yyyy", "2015-01-01T00:00:00")
function iwebFORMATTA(formato, valoreJson) {
    var risultato = valoreJson;

    if (risultato != null && risultato != "") {
        // restituisce un array con ad esempio: formato = [datetime,dd/mm/yyyy]
        var formato = formato.split("_");
        if (formato[0] == "datetime") {
            // il formato di base di un datetime è 2015-01-01T00:00:00, estraggo i dati
            var yyyy = valoreJson.substr(0, 4); var MM = valoreJson.substr(5, 2); var dd = valoreJson.substr(8, 2);
            var hh = valoreJson.substr(11, 2); var mm = valoreJson.substr(14, 2); var ss = valoreJson.substr(17, 2);
            var arrayDateTime1 = ["yyyy", "MM", "dd", "hh", "mm", "ss"];
            var arrayDateTime2 = [yyyy, MM, dd, hh, mm, ss];
            for (var k = 0; k < arrayDateTime1.length; k++) {
                formato[1] = formato[1].replace(arrayDateTime1[k], arrayDateTime2[k]);
            }
            risultato = formato[1];
        }
    }

    return risultato;
}

// cerco ricorsivamente il primo padre con tag "table"
function cercaTablePadreRicors(el) {
    if (el == null) el = event.srcElement;
    var nomeTag = el.nodeName.toLowerCase();
    if (nomeTag == "document")
        return el
    else
        if (nomeTag == "table") {
            return el
        } else
            el = cercaTablePadreRicors(el.parentElement);
    return el;
}

function cercaPopupPadreRicors(el) {
    var nomeTag = el.nodeName.toLowerCase();
    if (nomeTag == "document")
        return el
    else
        if (nomeTag == "div" && el.className != "" && el.className.toLowerCase().indexOf("popup ") >= 0) {
            return el
        } else
            el = cercaPopupPadreRicors(el.parentElement);
    return el;
}

/*<span class="iwebLABEL" id="labelRagioneSociale">
    <span><%-- il risultato finisce qui --%></span>
    <span class="iwebSQLSELECT">
        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
            "SELECT codice as VALORE FROM prodotto WHERE id = @idmanodopera") %>
        </span>
        <span class="iwebPARAMETRO">@idmanodopera = IDMANODOPERA_value</span>
    </span>
</span>*/
function iwebLABEL_Carica(idElemento) {
    var el = document.getElementById(idElemento);

    // cerco nel popup la query di select
    var elQuerySelect = el.getElementsByClassName("iwebSQLSELECT")[0];
    if (elQuerySelect != null) {
        //var querySelect = generaQueryDaSpanSql(elQuerySelect);
        var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuerySelect);
        var parametriChiocciola = iwebGeneraParametriQueryDaSpanSql(elQuerySelect);
        // console.log([querySelect, parametriChiocciola]);

        var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari */ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                // elaborazione terminata
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery[0].errore == null) {
                    
                    if (jsonRisultatoQuery[1] != null)
                        if (jsonRisultatoQuery[1].VALORE != null)
                            el.getElementsByTagName("span")[0].innerHTML = jsonRisultatoQuery[1].VALORE;

                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }

        // versione WebService.asmx/sparaQueryReader
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryReader", true);
        var jsonAsObject = {
            query: querySelect, // string
            pageSize: 100, // int
            pageNumber: 0, // int
            datiFiltri: [], // object[] datiFiltri
            ordinamento: [], // String[] ordinamento
            parametriChiocciola: parametriChiocciola // String
        }

        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);
    }
}