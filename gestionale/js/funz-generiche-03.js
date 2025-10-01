//var nomeProgetto = "/www.impresaedilesegatogestionale.it";
var nomeProgetto = ""; // questa stringa vuota e Percorso Virtuale = "/"

// funzioni su stringhe
function trim(x) {
    return x.replace(/^\s+|\s+$/gm, '');
}
function leftString(stringa, n) {
    return stringa.substr(0, n);
}
function rightString(stringa, n) {
    return stringa.substr(stringa.length - n, n);
}


// funzione per ottenere la data di oggi.
function ottieniDataDiOggi() {
    var adesso = new Date();

    var adessoGiorno = parseInt(adesso.getDate());
    var adessoMese = parseInt(adesso.getMonth() + 1);
    var adessoAnno = adesso.getFullYear();

    if (adessoGiorno < 10) adessoGiorno = "0" + adessoGiorno;
    if (adessoMese < 10) adessoMese = "0" + adessoMese;

    return adessoGiorno + "-" + adessoMese + "-" + adessoAnno;
}
function ottieniDataDiOggiPerDB() {
    var adesso = new Date();

    var adessoGiorno = parseInt(adesso.getDate());
    var adessoMese = parseInt(adesso.getMonth() + 1);
    var adessoAnno = adesso.getFullYear();

    if (adessoGiorno < 10) adessoGiorno = "0" + adessoGiorno;
    if (adessoMese < 10) adessoMese = "0" + adessoMese;

    return adessoAnno + "-" + adessoMese + "-" + adessoGiorno;
}

//applyToElements(document.getElementsByClassName("test"), function (el) { console.log(el) });
function applyToElements(elTutti, funzioneAFineEsecuzione) {
    var arr = [].slice.call(elTutti);
    if (funzioneAFineEsecuzione && typeof funzioneAFineEsecuzione === "function")
        arr.map(funzioneAFineEsecuzione); // el, i, arr
}

// funzioni matematiche
function valutaElevamentiPotenza(stringa) {
    // verifico velocemente se ci sono occorrenze del simbolo ^
    if (stringa.indexOf("^") >= 0) {
        // "3^2", "2+(3^2)"
        var sottostringhe = stringa.split("^");
        var elevamentiTrovati = sottostringhe.length - 1;

        for (var i = 0; i < elevamentiTrovati; i++) {
            var ii = trim(sottostringhe[i]);
            var ff = trim(sottostringhe[i + 1]);
            console.log(ii);
            console.log(ff);
            // della prima stringa 
            // ottengo il primo numero (parto dalla fine e percorro i caratteri finchè non smetto di trovare caratteri numerici)
            var primoNumero = "";
            var trovatoCarattErrato = false;
            for (var j = 0; j < ii.length; j++) {
                var caratt = ii[ii.length - (j+1)];
                if (trovatoCarattErrato == false && ((caratt >= '0' && caratt <= '9') || caratt == '.')) {
                    primoNumero = caratt + primoNumero;
                    //if (caratt == '-') trovatoCarattErrato = true;
                } else
                    trovatoCarattErrato = true;
            }
            // ottengo il secondo numero (percorro i caratteri finchè non smetto di trovare caratteri numerici)
            var secondoNumero = "";
            var trovatoCarattErrato = false;
            for (var j = 0; j < ff.length; j++) {
                var caratt = ff[j];
                if (trovatoCarattErrato == false && ((caratt >= '0' && caratt <= '9') || caratt == '.' || (caratt == '-' && j == 0))) {
                    secondoNumero = secondoNumero + caratt;
                } else
                    trovatoCarattErrato = true;
            }

            // replace nella stringa
            if (primoNumero == "") primoNumero = "0";
            if (secondoNumero == "") secondoNumero = "0";
            stringa = stringa.split(primoNumero + "^" + secondoNumero).join("Math.pow(" + primoNumero + "," + secondoNumero + ")");
        }
    }

    return stringa;
}

// var myNumber = 2;
// myNumber.toFixed(2); //returns 2.00
// myNumber.toFixed(1); //returns 2.0
function toValuta(numero) {
    var x = toFixed(numero, 2);
    var lungh = x.split(",")[0].length;
    if (lungh > 3) { // separatore migliaia
        x = x.split("");
        x.splice((lungh + 1) - 6, 0, ".");
        x = x.join("");
    }
    if (lungh > 6) { // separatore milioni
        x = x.split("");
        x.splice((lungh + 1) - 9, 0, ".");
        x = x.join("");
    }
    return x;
}
function toFixed(value, precision) {
    var precision = precision || 0,
        power = Math.pow(10, precision),
        absValue = Math.abs(Math.round(value * power)),
        result = (value < 0 ? '-' : '') + String(Math.floor(absValue / power));

    if (precision > 0) {
        var fraction = String(absValue % power),
            padding = new Array(Math.max(precision - fraction.length, 0) + 1).join('0');
        result += ',' + padding + fraction;
    }
    return result;
}

// Element type - NodeType / Element - 1 / Attribute - 2 / Text - 3 / Comment - 8 / Document - 9
function prossimoElemento(el) {
    var newEl = el.nextSibling;
    if (newEl == null) return null;
    var tipoNodo = newEl.nodeType;
    if (tipoNodo == 9)
        return newEl
    else if (tipoNodo == 1)
        return newEl
    else return prossimoElemento(newEl);
}
function precedenteElemento(el) {
    var newEl = el.previousSibling;
    if (newEl == null) return null;
    var tipoNodo = newEl.nodeType;
    if (tipoNodo == 9)
        return newEl
    else if (tipoNodo == 1)
        return newEl
    else return precedenteElemento(newEl);
}
/*function insertAfter(newNode, referenceNode) {
    referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling);
}*/
//create function, it expects 2 values.
function insertAfter(newElement, targetElement) {
    //target is what you want it to go after. Look for this elements parent.
    var parent = targetElement.parentNode;

    //if the parents lastchild is the targetElement...
    if (parent.lastchild == targetElement) {
        //add the newElement after the target element.
        parent.appendChild(newElement);
    } else {
        // else the target has siblings, insert the new element between the target and it's next sibling.
        parent.insertBefore(newElement, targetElement.nextSibling);
    }
}

function elementoContieneClasse(el, classeDaVerificare) {
    if (el == null) {
        console.log("%cErrore in elementoContieneClasse: l'elemento è null. Funzione chiamante:", "color:darkred");
        console.log(arguments.callee.caller)
    }
    var str = " " + el.className + " ";
    var patt = new RegExp("[\\s]+" + classeDaVerificare + "[\\s]+");
    var res = patt.test(str);
    return res;
}
function aggiungiClasseAElemento(el, classeDaAggiungere) {
    var stringaClassi = el.className;
    if (stringaClassi == "") {
        stringaClassi = classeDaAggiungere;
    } else {
        stringaClassi += " " + classeDaAggiungere;
    }
    el.className = stringaClassi;
}

function getRootPath() {
    if (document.location.hostname == "localhost") {
        if (!window.location.origin) {
            window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
        }
        //console.log("root trovata: " + window.location.origin + "/www.provaajax.it")
        //return window.location.origin + "/www.provaajax.it";
        //return location.protocol + "//" + location.host; // con IIS
        return location.protocol + "//" + location.host + nomeProgetto; // senza IIS
    }
    return location.protocol + "//" + location.host;
}

// vedi differenza tra match e test su htt p:// stackoverflow. com/questions/10940137/regex-test-v-s-string-match-to-know-if-a-string-matches-a-regular-expression
function regexNumeroIntero(stringa) {
    //var patternNumeroIntero = /[^0-9]/g;
    //if (el.value.match(patternNumeroIntero) != null || parseInt(el.value) < 1) el.value = '1';
    var re = /[-][^0-9]/g;
    return !re.test(stringa); // ritorna true se il numero è intero
}

//[-+]?(\d*[.])?\d+
//^(?:[1-9]\d*|0)?(?:\.\d+)?$
//^(?=.+)(?:[1-9]\d*|0)?(?:\.\d+)?$  --> nota! (?=.+) verifica stringa vuota!
function regexNumeroFloat(stringa) {
    var re = /^(?=.+)(?:[1-9]\d*|0)?(?:\.\d+)?$/g;
    return re.test(stringa); // ritorna true se il numero è float
}


/*
// sleep2(stringaFunzioneDaValutare, iwebEseguiSincrono_oggetto, new Date().getTime(), timeout);
function sleep2(stringafunzione, iwebEseguiSincrono_oggetto, datetime, timeout) {
    var tempoTrascorso = new Date().getTime() - datetime;

    if (tempoTrascorso > timeout || iwebEseguiSincrono_oggetto.finito == true) {
        eval(stringafunzione);
    } else
        setTimeout(function () { sleep2(stringafunzione, iwebEseguiSincrono_oggetto, datetime, timeout) }, 100);
}
/*function sleep3(funzione, oggetto, datetime, timeout) {
    var tempoTrascorso = new Date().getTime() - datetime;

    if (tempoTrascorso > timeout || oggetto.finito == true)
        eval(funzione);
    else
        setTimeout(function () { sleep3(stringafunzione, oggetto, datetime, timeout) }, 100);
}*/

/* FINO A QUI USATE ANCHE PER IWEB */

function log(stringa) {
    if (stringa == null)
        console.log("log: null")
    else
        console.log("log: " + stringa);
}


/*function regexEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email); // ritorna true se la mail è corretta
}*/
