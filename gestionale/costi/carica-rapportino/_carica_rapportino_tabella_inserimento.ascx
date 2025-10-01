<%@ Control Language="C#" ClassName="_carica_rapportino_tabella_inserimento" %>

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
                <td>Ore</td>
                <td>
                    <input type="text" id="ore" class="iwebTIPOCAMPO_varchar" tabindex="1"
                        onfocus="scwHide(this, event);"
                        />
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
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "INSERT INTO costo (idbollafattura, idprodotto, idcantiere, idcostobollariferita, quantita, prezzo, sconto1, sconto2, datacosto, descrizione) "
                            + "VALUES (0, @idprodotto, @idcantiere, 0, @quantita, @prezzo, 0, 0, @datacosto, @descrizione) ") %>
                        </span>
                        <span class="iwebPARAMETRO">@idprodotto = IDMANODOPERA_value</span>
                        <span class="iwebPARAMETRO">@idcantiere = iwebAUTOCOMPLETAMENTOCantiere_getChiave</span>
                        <span class="iwebPARAMETRO">@quantita = ore_value</span>
                        <span class="iwebPARAMETRO">@prezzo = labelPrezzo_value</span>
                        <span class="iwebPARAMETRO">@datacosto = TextBoxData_value</span>
                        <span class="iwebPARAMETRO">@descrizione = descrizione_value</span>
                        descrizione
                    </span>
                </td>
            </tr>
        </table>
    </div>
