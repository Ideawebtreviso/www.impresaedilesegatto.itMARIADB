// per l'eliminazione devo prima verificare che non ci siano collegamenti in altre tabelle con questa Unita di misura
function paginaUnitaDiMisura_iwebTABELLA_ConfermaEliminaRigaInPopup(IdPopupAssociato, idTabella, attesaRispostaServer) {
    var popupAssociato = document.getElementById(IdPopupAssociato);
    var idUnitadimisura = parseInt(iwebValutaParametroAjax("tabellaUnitadimisura_selectedValue_unitadimisura.id"));

    /*if (attesaRispostaServer)
        iwebMostraCaricamentoAjax();*/

    var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari*/ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
            jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

            /*if (attesaRispostaServer)
                iwebNascondiCaricamentoAjax();*/

            // chiudi e nascondi il popup
            popupAssociato.className = "popup popupType2 chiudiPopup";
            setTimeout(function () { popupAssociato.style.display = "none" }, 480);

            if (jsonRisultatoQuery[0].errore == null) {
                // tutto ok
                /*if (jsonRisultatoQuery[0].risultato == "0")
                    alert("cancellato");
                else
                    alert("non cancellato");*/

                // ricarica la tabella
                iwebTABELLA_Carica(idTabella, 0, true)
            } else {
                console.log("errore json " + jsonRisultatoQuery[0].errore);
            }
        }
    }
    xmlhttp.open("POST", getRootPath() + "/WebServiceComputi.asmx/eliminaUnitaDiMisura", true);
    xmlhttp.setRequestHeader("Content-type", "application/json");
    xmlhttp.send(JSON.stringify({ id: idUnitadimisura }));
}
