document.onmousedown = get_mouseclick;

function get_mouseclick(e) {
    var event = window.event || e;
    var theTarget = (event.target || event.srcElement);

    // popupType1: si chiude cliccando sullo sfondo;
    // popupType2: si chiude aggiungendo: <input type="button" onclick="this.parentElement.parentElement.style.display='none'" value="X" />
    if (theTarget.className == "popup popupType1" || theTarget.className == "popup popupType1 apriPopup")
        chiudiPopupType1(theTarget);
}

function chiudiPopupType1(theTarget) {
    var el = theTarget;
    //el.className = "popup popupType1 chiudiPopup";
    if (el.className.indexOf("chiudiPopup") == -1)
        el.className += " chiudiPopup";
    el.className = el.className.replace("apriPopup", "");

    setTimeout(function () { el.style.display = 'none' }, 480);
}
function chiudiPopupType2(theTarget) {
    if (theTarget == null) theTarget = event.srcElement;
    var el = theTarget.parentElement.parentElement.parentElement;
    //el.className = "popup popupType2 chiudiPopup";
    if (el.className.indexOf("chiudiPopup") == -1)
        el.className += " chiudiPopup";
    el.className = el.className.replace("apriPopup", "");

    setTimeout(function () { el.style.display = "none" }, 480);
}

function chiudiPopupType2B(popup_o_idpopup_dachiudere, azzera_campi_popup_opzionale, funzioneAFineEsecuzione) {

    // primo parametro
    let popup;
    if (popup_o_idpopup_dachiudere == null) { alertEConsole("Errore in chiudiPopupType2B. Non è stato passato il popup da chiudere."); return; }
    if (popup_o_idpopup_dachiudere instanceof HTMLElement) {
        /* ho ricevuto in input un elemento HTML */
        popup = popup_o_idpopup_dachiudere;
    } else {
        /* ho ricevuto in input un id */
        popup = document.getElementById(popup_o_idpopup_dachiudere);
        if (popup == null) { alertEConsole("Errore in chiudiPopupType2B. L'id del popup non è stato trovato in pagina."); return; }
    }

    // secondo parametro
    if (azzera_campi_popup_opzionale == null) azzera_campi_popup_opzionale = true;

    // chiusura popup

    // chiusura popup
    let isPopupInizialmenteAperto = elementoContieneClasse(popup, "chiudiPopup") == false;
    rimuoviClasseDaElemento(popup, "apriPopup");
    aggiungiClasseAElemento(popup, "chiudiPopup");

    //for (let i = 0; i < popup_STACK.length; i++) {
    //    if (popup_STACK[i].id == popup.id) popup_STACK.splice(i, 1);
    //}

    // azzera popup
    if (false && azzera_campi_popup_opzionale) azzeraContenutoCampiNellElemento(popup.id);

    //COSTANTE_ANIMAZIONE_TEMPO_CHIUSURA_POPUP = 480;
    //if (isPopupInizialmenteAperto) {
    //    setTimeout(function () { aggiungiClasseAElemento(popup, "iwebNascostoImportant"); if (funzioneAFineEsecuzione) funzioneAFineEsecuzione(); }, COSTANTE_ANIMAZIONE_TEMPO_CHIUSURA_POPUP);
    //}
    //else {
    //    if (funzioneAFineEsecuzione) funzioneAFineEsecuzione();
    //}

    //popup.className = "popup popupType2 chiudiPopup";
    if (popup.className.indexOf("chiudiPopup") == -1) popup.className += " chiudiPopup";
    popup.className = popup.className.replace("apriPopup", "");
    setTimeout(function () { popup.style.display = "none" }, 480);
    if (funzioneAFineEsecuzione) funzioneAFineEsecuzione();
}

function apriPopupType1_bind(idPopup, bindIdPopup) {
    // bind eventuale dei dati nel popup
    if (bindIdPopup == true) iwebBind(idPopup);
    return apriPopupType2(idPopup);
}
function apriPopupType1(idPopup) {
    var el = document.getElementById(idPopup);
    el.style.display = "initial";
    //el.className = "popup popupType1 apriPopup";
    if (el.className.indexOf("apriPopup") == -1)
        el.className += " apriPopup";
    el.className = el.className.replace("chiudiPopup", "");
    return false;
}
function apriPopupType2_bind(idPopup, bindIdPopup) {
    // bind eventuale dei dati nel popup
    if (bindIdPopup == true) iwebBind(idPopup);
    return apriPopupType2(idPopup);
}
function apriPopupType2(idPopup) {
    var el = document.getElementById(idPopup);
    el.style.display = "initial";
    //el.className = "popup popupType2 apriPopup";

    if (el.className.indexOf("apriPopup") == -1)
        el.className += " apriPopup";
    el.className = el.className.replace("chiudiPopup", "");

    return false;
}


// funzione più avanzata rispetto alla precedente 
// (funziona in modo un po' diverso: la precedente restituisce già il livello +1, questa restituisce il livello corrente
// esempio di utilizzo: var livelloProssimoPopup = getLivelloQuestoPopup("C0006tabellaRigheInserimento") + 1;
function getLivelloQuestoPopup(idOEl) {
    if (typeof (idOEl) == "string") idOEl = document.getElementById(idOEl);
    var elPopup = idOEl;
    var livelloPopup = elPopup.style.zIndex;
    if (livelloPopup != "") livelloPopup = parseInt(livelloPopup) - 1000; else livelloPopup = 0;
    return livelloPopup;
}
function getLivelloNuovoPopup(idOEl) { return getLivelloQuestoPopup(idOEl) + 1; }
// esempio di utilizzo: setLivelloNuovoPopup("C0016Popup", livelloPopup);
function setLivelloNuovoPopup(idOEl, livelloPopup) {
    if (typeof (idOEl) == "string") idOEl = document.getElementById(idOEl);
    var elPopup = idOEl;
    if (livelloPopup != null) {
        livelloPopup = parseInt(livelloPopup);
        elPopup.style.zIndex = 1000 + livelloPopup;
    }
    //for (let i = 0; i < popup_STACK.length; i++) {
    //    if (popup_STACK[i].id == elPopup.id) popup_STACK[i].zIndex = elPopup.style.zIndex;
    //}
}
