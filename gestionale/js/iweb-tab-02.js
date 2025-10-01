function iwebTABPADRE_Carica(idTabs) {
    elTabs = document.getElementById(idTabs);
    // headerTab
    var elHeaderTab = elTabs.getElementsByClassName("headerTab")[0];
    iwebTABFIGLIO_CaricaTutti(idTabs)
    var listaTabs = elHeaderTab.getElementsByClassName("iwebTABFIGLIO");

    // scorro i tab e li imposto a false
    for (var i = 0; i < listaTabs.length; i++)
        listaTabs[i].className = listaTabs[i].className.replace("iwebTABAGGIORNATO_si", "iwebTABAGGIORNATO_no");

    // aggiorno il tab visibile
    iwebTABFIGLIO_Aggiorna(elHeaderTab.getElementsByClassName("selectedTab")[0]);
}
function iwebTABFIGLIO_Carica(idTabs) {
}
function iwebTABFIGLIO_CaricaTutti(idTabs) {
    var el =document.getElementById(idTabs);
    var tab_head = el.getElementsByClassName("headerTab")[0];
    var tab_body = el.getElementsByClassName("corpoTab")[0];
    var tab_body_figli = tab_body.getElementsByClassName("iwebTABFIGLIO");
    var code = ""

    code += "<div class='iwebINIZIOTAB'></div>\n";
    nTabTrovati = tab_body_figli.length;
    for (var i = 0; i < nTabTrovati; i++) {
        // <div class="iwebTABFIGLIO iwebTABAGGIORNATO_no Tab_1 iwebBIND_dettaglioAnagrafica selectedTab" onmouseup="iwebTABFIGLIO_Aggiorna(this)">Anagrafica</div>
        //<div class="iwebTABFIGLIO Tab_1 selectedTab iwebBIND_dettaglioAnagrafica">
        // raccolgo informazioni dal body figlio per generare l'elemento figlio head
        var figlioTemp       = tab_body_figli[i].className;
        var Tab_             = figlioTemp.indexOf("Tab_") >= 0 ? "Tab_" + figlioTemp.split("Tab_")[1].split(" ")[0] + " " : "";
        var selectedTab      = figlioTemp.indexOf("selectedTab") >= 0 ? "selectedTab " : "";
        var iwebBIND_        = figlioTemp.indexOf("iwebBIND_") >= 0 ? "iwebBIND_" + figlioTemp.split("iwebBIND_")[1].split(" ")[0] + " " : "";
        var iwebTABNOMEHEAD_ = figlioTemp.indexOf("iwebTABNOMEHEAD_") >= 0 ? figlioTemp.split("iwebTABNOMEHEAD_")[1].split(" ")[0] : "";
        var headTemp = "<div class='iwebTABFIGLIO iwebTABAGGIORNATO_no " + Tab_ + selectedTab + iwebBIND_ + "' onmouseup='iwebTABFIGLIO_Aggiorna(this)'>";
        headTemp += iwebTABNOMEHEAD_ + "<div class='lineaSotto'></div>";
        headTemp += "</div>\n";
        code += headTemp;
    }
    //code += "<div class='iwebINIZIOTAB'></div>";
    code += "<div class='iwebFINETAB'></div>";
    tab_head.innerHTML = code;
}

function iwebTABFIGLIO_Aggiorna(thisTab) {
    // se questo tab contiene il nome classe "iwebTABAGGIORNATO_no", cambia il no in si e aggiorna questo tab
    if (thisTab.className.indexOf("iwebTABAGGIORNATO_no") != -1) {
        thisTab.className = thisTab.className.replace("iwebTABAGGIORNATO_no", "iwebTABAGGIORNATO_si");

        if (thisTab.className.indexOf("iwebBIND_") != -1)
            iwebBindThisEl(thisTab);
    }

    // se il tab non era già stato selezionato, selezionalo
    if (thisTab.className.indexOf("selectedTab") == -1) {
        // ottieni il numero tab
        var numeroTab = thisTab.className;
        if (numeroTab.indexOf("Tab_") != -1) {
            numeroTab = numeroTab.substr(numeroTab.indexOf("Tab_") + "tab_".length)
            numeroTab = numeroTab.split(" ")[0];
        } else
            numeroTab = "1";

        // rimuovi il selectedTab dal vecchio tab selezionato
        var headerTab = iwebTABPADRE_CercaHeaderRicors(thisTab);
        var oldClassName = headerTab.getElementsByClassName("selectedTab")[0].className;
        oldClassName = oldClassName.replace("selectedTab", "");
        headerTab.getElementsByClassName("selectedTab")[0].className = oldClassName.replace("  ", " ");
        // aggiungi il selectedTab al nuovo tab selezionato
        thisTab.className += " selectedTab";

        // cambia anche il corpo del tab
        var corpoTab = prossimoElemento(headerTab);
        // rimuovi il selectedTab dal vecchio corpo tab selezionato
        var oldClassName = corpoTab.getElementsByClassName("selectedTab")[0].className;
        oldClassName = oldClassName.replace("selectedTab", "").replace("  ", " ");
        corpoTab.getElementsByClassName("selectedTab")[0].className = oldClassName;
        // aggiungi il selectedTab al nuovo corpo tab selezionato
        var elCorpo = corpoTab.getElementsByClassName("Tab_" + numeroTab)[0];
        elCorpo.className = elCorpo.className + " selectedTab";
    }
}

function iwebTABPADRE_CercaHeaderRicors(el) {
    var nomeTag = el.nodeName.toLowerCase();
    if (nomeTag == "document")
        return el
    else
        if (nomeTag == "div" && el.className.indexOf("headerTab") != -1) {
            return el
        } else
            el = iwebTABPADRE_CercaHeaderRicors(el.parentElement);
    return el;
}
