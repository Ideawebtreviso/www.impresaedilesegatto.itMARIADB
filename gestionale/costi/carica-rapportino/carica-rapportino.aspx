<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="carica-rapportino.aspx.cs" Inherits="gestionale_costi_carica_rapportino_carica_rapportino" %>

<%@ Register TagPrefix="caricaRapportino" TagName="tabellaCosti" Src="_carica_rapportino_tabella_costi.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDMANODOPERA" class="iwebNascosto"><asp:Literal ID="LiteralIDMANODOPERA" runat="server"></asp:Literal></span>

    <div class="TitoloPagina">
        Carica rapportino:
        <span class="iwebLABEL" id="labelRagioneSociale">
            <span><%-- il risultato va qui --%></span>
            <span class="iwebSQLSELECT">
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                    SELECT IF (codice is null OR codice = '', 
                        CONCAT(descrizione),
                        CONCAT(descrizione, ' (', codice, ') ')
                        ) as VALORE 
                    FROM prodotto 
                    WHERE id = @idmanodopera
                ") %></span>
                <span class="iwebPARAMETRO">@idmanodopera = IDMANODOPERA_value</span>
            </span>
        </span>
    </div>


    <div class="tabellainserimento">
        <table class="iwebTABELLA">
            <tr>
                <td>Cantiere<b></b></td>
                <td>
                    <div class="iwebAUTOCOMPLETAMENTO" id="iwebAUTOCOMPLETAMENTOCantiere">
                        <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                        <%-- Chiave dell'el selezionato --%>
                        <span class="iwebNascosto"></span>

                        <%-- Valore dell'el selezionato --%>
                        <input type="text" autocomplete="off" class="iwebTIPOCAMPO_varchar" tabindex="1"
                            onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this); 
                                        if (event.keyCode == 13) document.getElementById('TextBoxQuantita').focus();" 
                            onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)"
                            onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)" />

                        <%-- Query di ricerca --%>
                        <span class="iwebSQLSELECT">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                SELECT cantiere.id as chiave,
                                    CONCAT(cliente.nominativo, ' - ' ,codice, ' - ', cantiere.descrizione) as valore
                                FROM cantiere INNER JOIN cliente on cantiere.idcliente = cliente.id
                                WHERE cantiere.stato <> 'Chiuso' AND
                                    (codice like @codice OR
                                    cantiere.descrizione like @codice OR
                                    cliente.nominativo like @codice)
                                LIMIT 5") %></span>
                            <%--<span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                "SELECT cantiere.id as chiave, CONCAT(cliente.nominativo, ' - ' ,codice, ' - ', cantiere.descrizione ) as valore "
                              + "FROM cantiere INNER JOIN cliente ON cantiere.idcliente = cliente.id "
                              + "WHERE codice like @codice OR cantiere.descrizione like @codice OR cliente.nominativo like @codice "
                              + "LIMIT 5"
                            ) %></span>--%>
                            <span class="iwebPARAMETRO">@codice = like_iwebAUTOCOMPLETAMENTOCantiere_getValore</span>
                        </span>
                        <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>Data</td>
                <td>
                    <asp:TextBox ID="TextBoxData" runat="server" ClientIDMode="Static" tabindex="1"
                        placeholder="Data" class="iwebTIPOCAMPO_date" 
                        onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" 
                    ></asp:TextBox>
                    <%--<asp:TextBox ID="TextBoxData" runat="server" ClientIDMode="Static" tabindex="1"
                        placeholder="data" class="iwebTIPOCAMPO_date" 
                        onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" 
                    ></asp:TextBox>--%>
                </td>
            </tr>
            <tr>
                <td>Ore Da Fatturare</td>
                <td>
                    <input type="text" id="oredafatturare" class="iwebTIPOCAMPO_varchar" tabindex="1"
                        onfocus="scwHide(this, event);" />
                </td>
            </tr>
            <tr>
                <td>Ore Mastrino</td>
                <td>
                    <input type="text" id="qtaoremastrino" class="iwebTIPOCAMPO_varchar" tabindex="1"
                        onfocus="scwHide(this, event);" />
                </td>
            </tr>
            <tr class="iwebNascosto">
                <td>prezzo</td>
                <td>
                    <div class="iwebLABEL" id="labelPrezzo">
                        € <span><%-- il risultato va qui --%></span>
                        <span class="iwebSQLSELECT">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                "SELECT listino as VALORE FROM prodotto WHERE id = @idmanodopera") %>
                            </span>
                            <span class="iwebPARAMETRO">@idmanodopera = IDMANODOPERA_value</span>
                        </span>
                    </div>
                </td>
            </tr>
            <tr class="iwebNascosto"></tr> <%-- va nascosta insieme alla riga precedente, perchè le righe sono a due a due con colori diversi --%>
            <tr>
                <td>Descrizione</td>
                <td>
                    <textarea id="descrizione" class="iwebTIPOCAMPO_memo" tabindex="1"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="errore" id="stringaValutazioneInserimento"></span>
                </td>
                <td>
                    <div class="btn btn-default iwebCliccabile" tabindex="1"
                        onclick="caricaRapportino_inserisci()"
                        onkeydown="if (event.which == 13 || event.keyCode == 13) {
                            caricaRapportino_inserisci();
                            document.getElementById('TextBoxData').focus();
                        }"
                    >Aggiungi</div>
                    <span class="iwebSQLSELECT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                            INSERT INTO costo (idbollafattura, idprodotto, idcantiere, idcostobollariferita, quantita, qtaoremastrino, prezzo, sconto1, sconto2, datacosto, descrizione)
                            VALUES (0, @idprodotto, @idcantiere, 0, @quantita, @qtaoremastrino, @prezzo, 0, 0, @datacosto, @descrizione)
                        ") %></span>
                        <span class="iwebPARAMETRO">@idprodotto = IDMANODOPERA_value</span>
                        <span class="iwebPARAMETRO">@idcantiere = iwebAUTOCOMPLETAMENTOCantiere_getChiave</span>
                        <span class="iwebPARAMETRO">@quantita = oredafatturare_value</span>
                        <span class="iwebPARAMETRO">@qtaoremastrino = qtaoremastrino_value</span>
                        <span class="iwebPARAMETRO">@prezzo = labelPrezzo_value</span>
                        <span class="iwebPARAMETRO">@datacosto = TextBoxData_value</span>
                        <span class="iwebPARAMETRO">@descrizione = descrizione_value</span>
                        descrizione
                    </span>
                    <script>
                        function caricaRapportino_inserisci() {
                            var el = event.srcElement;
                            var eseguiQuery = true;

                            var stringaidcantiere = iwebAUTOCOMPLETAMENTO_GetChiaveSelezionato("iwebAUTOCOMPLETAMENTOCantiere");
                            eseguiQuery = eseguiQuery && stringaidcantiere != "";
                            eseguiQuery = eseguiQuery && stringaidcantiere != "-1";
                            eseguiQuery = eseguiQuery && document.getElementById("TextBoxData").value != "";
                            eseguiQuery = eseguiQuery && document.getElementById("oredafatturare").value != "" && parseFloat(document.getElementById("oredafatturare").value) > 0;
                            if (eseguiQuery) {
                                elQuery = el.parentElement.getElementsByClassName("iwebSQLSELECT")[0];
                                if (elQuery != null) {
                                    //var querySelect = generaQueryDaSpanSql(elQuery);
                                    var querySelect = iwebGeneraSqlQueryDaSpanSql(elQuery);
                                    var parametri = iwebGeneraParametriQueryDaSpanSql(elQuery);
                                    // console.log([querySelect, parametri]);

                                    var xmlhttp; if (window.XMLHttpRequest) {/* code for IE7+, Firefox, Chrome, Opera, Safari */ xmlhttp = new XMLHttpRequest(); } else {/* code for IE6, IE5*/ xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
                                    xmlhttp.onreadystatechange = function () {
                                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                                            // elaborazione terminata
                                            var jsonRisultatoQuery = JSON.parse(xmlhttp.responseText);
                                            jsonRisultatoQuery = JSON.parse(jsonRisultatoQuery.d);

                                            // inserimento completato, azzera i campi
                                            iwebAUTOCOMPLETAMENTO_AzzeraSelezionato("iwebAUTOCOMPLETAMENTOCantiere");
                                            document.getElementById("TextBoxData").value = "";
                                            document.getElementById("oredafatturare").value = "";
                                            document.getElementById("qtaoremastrino").value = "";
                                            document.getElementById("descrizione").value = "";
                                            document.getElementById("stringaValutazioneInserimento").innerHTML = "";

                                            iwebCaricaElemento("tabellaCosti");

                                            if (jsonRisultatoQuery[0].errore != null)
                                                console.log("errore json " + jsonRisultatoQuery[0].errore);

                                        }
                                    }

                                    // versione WebService.asmx/sparaQueryReader
                                    xmlhttp.open("POST", getRootPath() + "/WebService.asmx/sparaQueryInsert", true);
                                    var jsonAsObject = {
                                        query: querySelect, // string
                                        parametri: parametri // String
                                    }

                                    xmlhttp.setRequestHeader("Content-type", "application/json");
                                    var jsonAsString = JSON.stringify(jsonAsObject);
                                    xmlhttp.send(jsonAsString);
                                }
                            } else {
                                var stringa = "Errore inserimento";

                                if (document.getElementById("oredafatturare").value == "")
                                    stringa = "Inserire una quantita' di ore";
                                else if (parseFloat(document.getElementById("oredafatturare").value) <= 0)
                                    stringa = "Inserire una quantita' di ore maggiore di zero";

                                if (document.getElementById("TextBoxData").value == "")
                                    stringa = "Data non valida";

                                if (stringaidcantiere == "" || stringaidcantiere == "-1")
                                    stringa = "Cantiere non selezionato";

                                // aggiorno la stringa
                                document.getElementById("stringaValutazioneInserimento").innerHTML = stringa;
                            }

                        }
                    </script>
                </td>
            </tr>
        </table>
    </div>


    <div class="iwebNascosto">
        <table class="tabellaDaA">
            <tr>
                <td>
                    Da:
                    <asp:TextBox ID="TextBoxDataDa" runat="server" ClientIDMode="Static" 
                        placeholder="dataDa" class="iwebTIPOCAMPO_date" 
                        onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" 
                    ></asp:TextBox>
                </td>
                <td>
                    A:
                    <asp:TextBox ID="TextBoxDataA" runat="server" ClientIDMode="Static" 
                        placeholder="dataA" class="iwebTIPOCAMPO_date" 
                        onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" 
                    ></asp:TextBox>
                </td>
                <td> <%--<asp:Button runat="server" ID="ButtonFiltra" Text="Filtra" CssClass="btn btn-default iwebCliccabile" OnCommand="ButtonFiltra_Command" />--%>
                    <%--(tabella ajax)<div class="btn btn-default iwebCliccabile" onclick="iwebQuadro_Carica('quadroRapportini');">filtra</div>--%>
                </td>
            </tr>
        </table>
    </div>

    <caricaRapportino:tabellaCosti runat="server" ID="caricaRapportino_tabellaCosti" />

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaCosti");
            iwebCaricaElemento("labelRagioneSociale");
            iwebCaricaElemento("labelPrezzo");

            // IL CODICE QUA SOTTO FA SI CHE PREMENDO TAB ALL'INTERNO DI INSERISCI NUOVA VOCE, GLI ELEMENTI SI ALTERNINO DAL PRIMO ALL'ULTIMO E SUBITO DOPO DI NUOVO IL PRIMO A ROTAZIONE
            // funzione che mi ritorna tutti gli elementi con tabIndex == 1
            var allElements = document.getElementsByTagName("*");
            var iwebTABINDEX_gruppo1 = Array.prototype.slice.call(allElements, 0);
            iwebTABINDEX_gruppo1 = iwebTABINDEX_gruppo1.map(function (o) {
                return o.tabIndex === 1 ? o : null;
            }).filter(function (o) {
                return o != null
            });

            // funzione che: al tab dell'ultimo elemento con tabindex = 1, mi riporta al secondo elemento con tabindex = 1
            addEvent(iwebTABINDEX_gruppo1[iwebTABINDEX_gruppo1.length - 1],
                'keydown',
                function (event) { if (event.which == 9 || event.keyCode == 9) iwebTABINDEX_gruppo1[0].focus() }
            );

        }

        // esempio: addEvent( document.getElementById('myElement'), 'click', function () { alert('hi!'); } );
        function addEvent(element, evnt, funct) {
            if (element.attachEvent)
                return element.attachEvent('on' + evnt, funct);
            else
                return element.addEventListener(evnt, funct, false);
        }

    </script>

</asp:Content>

