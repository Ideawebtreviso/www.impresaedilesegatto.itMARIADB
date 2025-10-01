function generaGerarchiaComputo(idComputo) {
    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {
                // codice qui

                // nodi che arrivano da DB
                var nodiTutti = [];
                for (var i = 0; i < jsonRisultatoQuery.length; i++) {
                    var id = jsonRisultatoQuery[i].id;
                    var idpadre = jsonRisultatoQuery[i].idpadre;
                    var posizione = jsonRisultatoQuery[i].posizione;
                    var descrizione = jsonRisultatoQuery[i].descrizione;
                    // console.log([id, idpadre, posizione, descrizione]);
                    nodiTutti.push({ id: id, idpadre: idpadre, posizione: posizione, descrizione: descrizione, figli: [] });
                }

                /*nodiTutti.push({ id: 1, idpadre: null, posizione: 0, descrizione: "Fondazione 1", figli: [] });
                nodiTutti.push({ id: 2, idpadre: 1, posizione: 0, descrizione: "Scavi 2", figli: [] });
                nodiTutti.push({ id: 5, idpadre: 1, posizione: 10, descrizione: "Trasporto 5", figli: [] });
                nodiTutti.push({ id: 3, idpadre: 2, posizione: 0, descrizione: "Scavo pos=0 3", figli: [] });
                nodiTutti.push({ id: 4, idpadre: 2, posizione: 10, descrizione: "Scavo pos=10 4", figli: [] });
                nodiTutti.push({ id: 6, idpadre: 4, posizione: 20, descrizione: "Scavo pos=20 6", figli: [] });
                nodiTutti.push({ id: 7, idpadre: 2, posizione: 30, descrizione: "Scavo pos=30 7", figli: [] });*/

                // nodo root
                var nodoRoot = { id: 0, idpadre: null, posizione: 0, descrizione: "Organizza suddivisioni:", figli: [] };

                // funzione che genera l'albero dati la lista di nodi e il nodo di root
                elaboraalbero(nodiTutti, nodoRoot);

                // funzione che genera i div a partire dal nodoRoot riempito di tutti i sottonodi
                var htmlcode = "";
                htmlcode = generaalbero(nodoRoot, htmlcode);
                document.getElementById("rootDivGerarchia").innerHTML = htmlcode;

                rigeneraFrecce();

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }

    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/ottieniSuddivisioniComputo", true);
    var jsonAsObject = { idComputo: idComputo };

    xmlhttp.setRequestHeader("Content-type", "application/json");
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.send(jsonAsString);
}



//function elaboraalbero(nodo[] tutti, nodo root) {
function elaboraalbero(nodiTutti, nodoRoot) {
    // itera su tutti.
    for (var i = 0; i < nodiTutti.length; i++) {
        // per ogni nodo cerca il padre ed aggancia il nodo al padre (caso particolare col null che aggancia a root)
        var nodoPadre = getNotoPadre(nodiTutti[i], nodiTutti);

        /*                if (nodoPadre == null) nodoRoot.figli.push(nodiTutti[i]); // sostituire la push
                        else nodoPadre.figli.push(nodiTutti[i]); // sostituire la push */
        if (nodoPadre == null) pushSullaPosizioneCorretta(nodoRoot, nodiTutti[i]);
        else pushSullaPosizioneCorretta(nodoPadre, nodiTutti[i]);
    }
}

// function getNotoPadre(nodo figlio, nodo[] tutti){
function getNotoPadre(nodoFiglio, nodiTutti) {
    for (var i = 0; i < nodiTutti.length; i++) {
        if (nodiTutti[i].id == nodoFiglio.idpadre) return nodiTutti[i];
    }
    return null;
}

function pushSullaPosizioneCorretta(nodopadre, nodofiglio) {
    // nodopadre.figli.splice(posizione, 0, nodofiglio);   al posto di:   nodopadre.figli.push(nodofiglio);
    var posizione = 0;
    for (var i = 0; i < nodopadre.figli.length; i++) {
        if (nodofiglio.posizione > nodopadre.figli[i].posizione)
            posizione = i + 1;
    }
    nodopadre.figli.splice(posizione, 0, nodofiglio);
}


function generaalbero(nodo, htmlcode) {
    htmlcode += "<div class='bloccoGerarchia'> <div><div class='idSuddivisioneGerarchia'>" + nodo.id + "</div>" + nodo.descrizione + "</div> ";
    for (var i = 0; i < nodo.figli.length; i++) {
        htmlcode = generaalbero(nodo.figli[i], htmlcode)
    }
    htmlcode += "</div>"
    return htmlcode;
}


function rigeneraFrecce() {
    // scorro tutti i div con class blocco.
    // per ogni div trovato verifico se ci sono span. se non ce ne sono genero il blocco di codice
    var listaBlocchi = document.getElementById("rootDivGerarchia").getElementsByClassName("bloccoGerarchia");
    //console.log(listaBlocchi);

    // i = 0 è il nodo root
    listaBlocchi[0].style.padding = "10px";
    listaBlocchi[0].className = "";

    for (var i = 0; i < listaBlocchi.length; i++) {
        var datiBlocco = listaBlocchi[i].getElementsByTagName("div")[0];

        if (datiBlocco.getElementsByTagName("span").length == 0) {
            // questa parte di codice viene eseguita la prima volta che lancio la funzione rigeneraFrecce()
            var idSuddivisione = datiBlocco.getElementsByTagName("div")[0].innerHTML;
            var titoloBloccoGerarchia = datiBlocco.innerHTML;
            var code = "<span class='titoloBloccoGerarchia'>" + titoloBloccoGerarchia + "</span>";

            code += "<span class='glyphicon glyphicon-search' onclick='apriVociAssociate(" + idSuddivisione + ");'></span>"
            code += "<span class='glyphicon glyphicon-pencil' onclick='modificaSuddivisione(" + idSuddivisione + ");'></span>"
            code += "<span class='glyphicon glyphicon-share' onclick='duplicaSuddivisione(" + idSuddivisione + ");'></span>"
            code += "<span class='glyphicon glyphicon-trash' onclick='eliminaSuddivisione(" + idSuddivisione + ");'></span>"
            //code += "var el = document.getElementById(" + '"' + "tabellaVoci" + '"' + "); ";
            //code += "iwebCaricaElemento(el.id);'></span>";
            code += "<span class='spazio10'></span>";

            // freccia sinistra solo se non mi trovo al primo livello di gerarchia
            var disabled = listaBlocchi[i].parentElement.parentElement.id == "rootDivGerarchia";
            if (disabled) code += "<span class='glyphicon glyphicon-arrow-left disabled'></span>";
            else code += "<span class='glyphicon glyphicon-arrow-left' onclick='divGerarchia_sinistra(" + idSuddivisione + ")'></span>";

            // freccia su solo se non è il primo della lista
            var disabled = true;
            if (precedenteElemento(listaBlocchi[i]) != null)
                disabled = precedenteElemento(listaBlocchi[i]).className.indexOf("bloccoGerarchia") < 0;
            if (disabled) code += "<span class='glyphicon glyphicon-arrow-up disabled'></span>";
            else code += "<span class='glyphicon glyphicon-arrow-up' onclick='divGerarchia_sopra(" + idSuddivisione + ")'></span>";

            // freccia giu' solo se non è l'ultimo della lista
            var disabled = prossimoElemento(listaBlocchi[i]) == null;
            if (disabled) code += "<span class='glyphicon glyphicon-arrow-down disabled'></span>";
            else code += "<span class='glyphicon glyphicon-arrow-down' onclick='divGerarchia_sotto(" + idSuddivisione + ")'></span>";

            // freccia destra solo se non è il primo della lista
            var disabled = true;
            if (precedenteElemento(listaBlocchi[i]) != null)
                disabled = precedenteElemento(listaBlocchi[i]).className.indexOf("bloccoGerarchia") < 0;
            if (disabled) code += "<span class='glyphicon glyphicon-arrow-right disabled'></span>";
            else code += "<span class='glyphicon glyphicon-arrow-right' onclick='divGerarchia_destra(" + idSuddivisione + ")'></span>";

            datiBlocco.innerHTML = code;
        } else {
            console.log("blocco con dati");
        }
    }
}

function divGerarchia_sinistra(idSuddivisione) {
    console.log(idSuddivisione + " a sinistra");

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {

                // codice qui
                var idComputo = document.getElementById("IDCOMPUTO").innerHTML;
                generaGerarchiaComputo(idComputo);

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }
    var jsonAsObject = { idSuddivisione: idSuddivisione };
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/spostaSuddivisioneSinistra", true);
    xmlhttp.setRequestHeader("Content-type", "application/json");
    xmlhttp.send(jsonAsString);
}

function divGerarchia_destra(idSuddivisione) {
    console.log(idSuddivisione + " a destra");

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {

                // codice qui
                var idComputo = document.getElementById("IDCOMPUTO").innerHTML;
                generaGerarchiaComputo(idComputo);

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }
    var jsonAsObject = { idSuddivisione: idSuddivisione };
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/spostaSuddivisioneDestra", true);
    xmlhttp.setRequestHeader("Content-type", "application/json");
    xmlhttp.send(jsonAsString);
}

function divGerarchia_sopra(idSuddivisione) {
    console.log(idSuddivisione + " sopra");

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {

                // codice qui
                var idComputo = document.getElementById("IDCOMPUTO").innerHTML;
                generaGerarchiaComputo(idComputo);

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }
    var jsonAsObject = { idSuddivisione: idSuddivisione };
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/spostaSuddivisioneSopra", true);
    xmlhttp.setRequestHeader("Content-type", "application/json");
    xmlhttp.send(jsonAsString);
}
function divGerarchia_sotto(idSuddivisione) {
    console.log(idSuddivisione + " sotto");

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {

                // codice qui
                var idComputo = document.getElementById("IDCOMPUTO").innerHTML;
                generaGerarchiaComputo(idComputo);

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }
    var jsonAsObject = { idSuddivisione: idSuddivisione };
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/spostaSuddivisioneSotto", true);
    xmlhttp.setRequestHeader("Content-type", "application/json");
    xmlhttp.send(jsonAsString);
}

function apriVociAssociate(idsuddivisione) {
    var el = event.srcElement;

    // serve per la select
    document.getElementById("idsuddivisione").innerHTML = idsuddivisione;
    document.getElementById("nomesuddivisione").innerHTML = el.parentElement.getElementsByTagName("span")[0].innerHTML.split("</div>")[1];

    // carico la tabella delle voci e apro il popup
    iwebCaricaElemento("tabellaVoci");
    apriPopupType2('popupVociAssociate');
}

function modificaSuddivisione(idsuddivisione) {
    var el = event.srcElement;

    // serve per la select
    var popupModificaSuddivisione = document.getElementById("popupModificaSuddivisione");

    popupModificaSuddivisione.getElementsByClassName("iwebCAMPO_id")[0].innerHTML = idsuddivisione;
    popupModificaSuddivisione.getElementsByClassName("iwebCAMPO_descrizione")[0].value = el.parentElement.getElementsByTagName("span")[0].innerHTML.split("</div>")[1];

    // carico la tabella delle suddivisioni e apro il popup
    apriPopupType2('popupModificaSuddivisione');
}
function aggiornaNomeSuddivisione() {
    var elQueryUpdate = document.getElementById("popupModificaSuddivisione").getElementsByClassName("iwebSQLUPDATE")[0];

    if (elQueryUpdate != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryUpdate);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryUpdate);

        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {

                    // codice qui
                    var idComputo = document.getElementById("IDCOMPUTO").innerHTML;
                    generaGerarchiaComputo(idComputo);

                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }
        var jsonAsObject = { query: sqlQuery, parametri: parametriQuery };
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryUpdate", true);
        xmlhttp.setRequestHeader("Content-type", "application/json");
        xmlhttp.send(jsonAsString);
    }
}

function duplicaSuddivisione(idSuddivisione) {
    // mostro il caricamento
    iwebMostraCaricamentoAjax();

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {

                // codice qui
                var idComputo = document.getElementById("IDCOMPUTO").innerHTML;
                generaGerarchiaComputo(idComputo);

                // nascondo il caricamento
                iwebNascondiCaricamentoAjax();

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }
    var jsonAsObject = { idSuddivisione: idSuddivisione, nuovasuddivisionepadre: null };
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/duplicaSuddivisione", true);
    xmlhttp.setRequestHeader("Content-type", "application/json");
    xmlhttp.send(jsonAsString);
}

function eliminaSuddivisione(idsuddivisione) {
    var el = event.srcElement;

    // serve per la select
    var popupEliminaSuddivisione = document.getElementById("popupEliminaSuddivisione");

    popupEliminaSuddivisione.getElementsByClassName("iwebCAMPO_id")[0].innerHTML = idsuddivisione;
    popupEliminaSuddivisione.getElementsByClassName("iwebCAMPO_descrizione")[0].innerHTML = el.parentElement.getElementsByTagName("span")[0].innerHTML.split("</div>")[1];

    // carico la tabella delle suddivisioni e apro il popup
    apriPopupType2('popupEliminaSuddivisione');
}
function confermaEliminazioneSuddivisione() {
    var elQueryDelete = document.getElementById("popupEliminaSuddivisione").getElementsByClassName("iwebSQLDELETE")[0];

    if (elQueryDelete != null) {
        var sqlQuery = iwebGeneraSqlQueryDaSpanSql(elQueryDelete);
        var parametriQuery = iwebGeneraParametriQueryDaSpanSql(elQueryDelete);

        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
                var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {

                    // codice qui
                    var idComputo = document.getElementById("IDCOMPUTO").innerHTML;
                    generaGerarchiaComputo(idComputo);

                } else {
                    console.log("errore json " + jsonRisultatoQuery[0].errore);
                }
            }
        }
        var jsonAsObject = { query: sqlQuery, parametri: parametriQuery };
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryUpdate", true);
        xmlhttp.setRequestHeader("Content-type", "application/json");
        xmlhttp.send(jsonAsString);
    }
}


function onclick_spostaVoceSopra() {
    var el = event.srcElement;
    var IDVoceDaSpostare = el.parentElement.parentElement.parentElement.getElementsByClassName("iwebCAMPO_id")[0].innerHTML;

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {

                // codice qui
                //var idComputo = document.getElementById("IDCOMPUTO").innerHTML;
                //generaGerarchiaComputo(idComputo);
                iwebCaricaElemento("tabellaVoci");

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }
    var jsonAsObject = { IDVoceDaSpostare: IDVoceDaSpostare };
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/spostaVoceSopra", true);
    xmlhttp.setRequestHeader("Content-type", "application/json");
    xmlhttp.send(jsonAsString);
}

function onclick_spostaVoceSotto() {
    var el = event.srcElement;
    var IDVoceDaSpostare = el.parentElement.parentElement.parentElement.getElementsByClassName("iwebCAMPO_id")[0].innerHTML;

    var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            // elaborazione terminata, riempi la tabella con jsonRisultatoQuery
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            if (jsonRisultatoQuery.d == "") jsonRisultatoQuery = ""; else jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            if (jsonRisultatoQuery == "" || jsonRisultatoQuery[0].errore == null) {

                // codice qui
                //var idComputo = document.getElementById("IDCOMPUTO").innerHTML;
                //generaGerarchiaComputo(idComputo);
                iwebCaricaElemento("tabellaVoci");

            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }
    var jsonAsObject = { IDVoceDaSpostare: IDVoceDaSpostare };
    var jsonAsString = JSON.stringify(jsonAsObject);
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/spostaVoceSotto", true);
    xmlhttp.setRequestHeader("Content-type", "application/json");
    xmlhttp.send(jsonAsString);
}
