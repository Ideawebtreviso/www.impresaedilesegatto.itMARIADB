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

function chiudiPopupType2B(theTarget) {
    var el = theTarget;
    //el.className = "popup popupType2 chiudiPopup";
    if (el.className.indexOf("chiudiPopup") == -1)
        el.className += " chiudiPopup";
    el.className = el.className.replace("apriPopup", "");

    setTimeout(function () { el.style.display = "none" }, 480);
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
