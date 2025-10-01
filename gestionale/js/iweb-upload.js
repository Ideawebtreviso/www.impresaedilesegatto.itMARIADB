/* esempio di html
<div id="fileUpload1" class="iwebFileUpload">
    <input type="file" onchange="iwebPREPARAUPLOAD(event)" />
    <span class="iwebNascosto"></span> <%-- contenuto file selezionato --%>
    <span class="iwebCAMPO_bollafattura.nomefilescansione"></span> <%-- nome file selezionato --%>
    <span class="iwebNascosto iwebCAMPO_bollafattura.pathfilescansione"></span> <%-- nome file uploadato --%>
    //While there is no valid way to omit an image's source, there are sources which won't cause server hits. I recently had a similar issue with iframes and determined //:0 to be the best option. No, really!
    //Starting with // (omitting the protocol) causes the protocol of the current page to be used, preventing "insecure content" warnings in HTTPS pages. Skipping the host name isn't necessary, but makes it shorter. Finally, a port of :0 ensures that a server request can't be made (it isn't a valid port, according to the spec).
    <div class="iwebDivImmagineFileUpload"><img src="//:0" alt="preview" /></div> <%-- mostro questo solo se immagine --%>
</div>

[...]
modificare l'inserimento della riga:

<%-- prima tento di uploadare il file, se ci riesco con esito positivo, confermo l'aggiunta del record --%>
<div class="btn btn-success" onclick="
    iwebINVIADATI('fileUpload1',
        function(){ iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaBolleInserimento', 'tabellaBolle', '', true) }
    );
">Inserisci</div>

[...]

poi per mostrare il nome su iwebDETTAGLIO:
<td>Scansione</td>
<td>
    <a href="/public/gestionale-scansioni/@iwebCAMPO_bollafattura.pathfilescansione" class="iwebCAMPO_bollafattura.pathfilescansione" target="_blank">
        <span class="iwebCAMPO_bollafattura.nomefilescansione"></span>
    </a>
</td>

*/

function iwebPREPARAUPLOAD(e) {
    var targ; if (!e) var e = window.event; if (e.target) targ = e.target; else if (e.srcElement) targ = e.srcElement;
    var elFileUpload = targ.parentElement;
    var filesOttenuti = e.target.files; // This saves the file data to a file variable for later use.
    var nomefile = filesOttenuti[0].name;
    var tipofile = filesOttenuti[0].type;
    console.log(filesOttenuti[0]);
    var reader = new FileReader();

    // preparo l'evento che si azionerà alla lettura del file
    reader.onload = function (e) {
        //var targ; if (!e) var e = window.event; if (e.target) targ = e.target; else if (e.srcElement) targ = e.srcElement; // sistema le compatibilità
        var contenuto = e.target.result;

        var dati = elFileUpload.getElementsByTagName("span");
        dati[0].innerHTML = window.btoa(contenuto);
        dati[1].innerHTML = nomefile;

        if (elFileUpload.getElementsByTagName("img").length > 0) {
            var immagine = elFileUpload.getElementsByTagName("img")[0];
            immagine.src = "data:" + tipofile + ";base64," + window.btoa(contenuto);
            immagine.title = nomefile;
        }
    };

    /*
    I tested the form using IE10 and this message pops up on the browser console right after clicking the submit button. The browser never does a POST.
    SCRIPT438: Object down't support property or method 'readAsBinaryString'.
    I googled this issue and found that for IE10 and later you need to be using  reader.readAsArrayBuffer(f) instead of readAsBinaryString.
    */
    // leggo il file
    reader.readAsBinaryString(filesOttenuti[0]);
}

// esempio: iwebINVIADATI("fileUpload1", function(){ console.log("funziona") });
function iwebINVIADATI(idFileUpload, onUploadCompletato) {
    var dati = document.getElementById(idFileUpload).getElementsByTagName("span");
    var datiFile = dati[0].innerHTML;
    var nomeFile = dati[1].innerHTML;

    console.log([datiFile, nomeFile]);

    // se non trova dati non fa nessun upload, ma comunque considera l'upload completato e lancia la funzione onUploadCompletato
    if (dati[0].innerHTML != "" && dati[1].innerHTML != "") {
        //var formData = new FormData();
        //formData.append("nomeFile", nomeFile);
        //formData.append("datifile", datiFile);

        var xmlhttp; if (window.XMLHttpRequest) { xmlhttp = new XMLHttpRequest(); } else { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                // elaborazione terminata
                var nomeFileUploadato = JSON.parse(xmlhttp.responseText).d;

                // azzero i dati, così se manca uno dei campi obbligatori e devo ri-inserire il record, l'upload del file
                // non viene fatto un'altra volta. (di fatto mi trovo qui solo se dati[0].innerHTML != "" && dati[1].innerHTML != "")
                dati[0].innerHTML = "";

                // aggiorno in pagina il nome del file generato e salvato su public
                dati[2].innerHTML = nomeFileUploadato;

                if (onUploadCompletato && typeof onUploadCompletato === "function")
                    onUploadCompletato();
            }
        }

        //xmlhttp.open("POST", "accettafile.aspx", true);
        //xmlhttp.send(formData);

        xmlhttp.open("POST", getRootPath() + "/WebService.asmx/fileUpload", true);
        var jsonAsObject = {
            nomeFile: nomeFile,
            datiFile: datiFile
        }
        //console.log(jsonAsObject)
        xmlhttp.setRequestHeader("Content-type", "application/json");
        var jsonAsString = JSON.stringify(jsonAsObject);
        xmlhttp.send(jsonAsString);

    } else
        if (onUploadCompletato && typeof onUploadCompletato === "function")
            onUploadCompletato();
}
