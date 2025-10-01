<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="carica-rapportino.aspx.cs" Inherits="gestionale_costi_carica_rapportino" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="carica-rapportino.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDMANODOPERA" class="iwebNascosto"><asp:Literal ID="LiteralIDMANODOPERA" runat="server"></asp:Literal></span>
    <div class="TitoloPagina">
        Carica rapportino:
        <span class="iwebLABEL" id="labelRagioneSociale">
            <span></span> <%-- il risultato va qui --%>
            <span class="iwebSQLSELECT">
                    <%--"SELECT descrizione as VALORE FROM prodotto WHERE id = @idmanodopera") %>--%>
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                    "SELECT codice as VALORE FROM prodotto WHERE id = @idmanodopera") %>
                </span>
                <span class="iwebPARAMETRO">@idmanodopera = IDMANODOPERA_value</span>
            </span>
        </span>
    </div>

    <div class="tabellainserimento">
        <table class="iwebTABELLA">
            <tr>
                <td>Cantiere</td>
                <td>
                    <div class="iwebAUTOCOMPLETAMENTO" id="iwebAUTOCOMPLETAMENTOCantiere">
                        <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                        <%-- Chiave dell'el selezionato --%>
                        <span class="iwebNascosto"></span>

                        <%-- Valore dell'el selezionato --%>
                        <input type="text" autocomplete="off" class="iwebTIPOdCAMPO_varchar"
                            onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this); 
                                        if (event.keyCode == 13) document.getElementById('TextBoxQuantita').focus();" 
                            onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)" />

                        <%-- Query di ricerca --%>
                        <span class="iwebSQLSELECT">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT cantiere.id as chiave, CONCAT(cliente.nominativo, ' ' ,codice, ' ', cantiere.descrizione ) as valore FROM cantiere inner join cliente on cantiere.idcliente = cliente.id WHERE codice like @codice or cantiere.descrizione like @codice or cliente.nominativo like @codice LIMIT 5") %></span>
                            <span class="iwebPARAMETRO">@codice = like_iwebAUTOCOMPLETAMENTOCantiere_getValore</span>
                        </span>
                        <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>Data</td>
                <td>
                    <asp:TextBox ID="TextBoxData" runat="server" ClientIDMode="Static" 
                        placeholder="dataDa" class="iwebTIPOCAMPO_date" 
                        onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" 
                    ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Ore</td>
                <td>
                    <input type="text" id="ore" class="iwebTIPOCAMPO_varchar" />
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
                    <textarea id="descrizione" class="iwebTIPOCAMPO_memo"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="errore" id="stringaValutazioneInserimento"></span>
                </td>
                <td>
                    <div class="btn btn-default iwebCliccabile" onclick="caricaRapportino_inserisci()">INSERISCI</div>
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
                <td>
                    <%--<asp:Button runat="server" ID="ButtonFiltra" Text="Filtra" CssClass="btn btn-default iwebCliccabile" OnCommand="ButtonFiltra_Command" />--%>
                    <%--(tabella ajax)<div class="btn btn-default iwebCliccabile" onclick="iwebQuadro_Carica('quadroRapportini');">filtra</div>--%>
                </td>
            </tr>
        </table>
    </div>

    <div class="iwebTABELLAWrapper width915">
        <div class="r iwebTABELLAAzioniPerSelezionati">
            <span></span>
            <select disabled>
                <option value="">Seleziona...</option>
                <option value="Elimina">Elimina</option>
            </select>
            <input type="button" class="btn btn-default" value="Conferma azione" disabled onclick="iwebTABELLA_ConfermaAzionePerSelezionati()"/>
            <div class="b"></div>
            <%-- alla fine metto le varie query (per ora la delete) --%>
            <span class="iwebSQLDELETE">
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM costo WHERE costo.id=@costo.id") %></span>
            </span>
        </div>
        <table id="tabellaCosti" class="iwebTABELLA iwebCHIAVE__costo.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <%--<div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                            onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaCostiInserimento');"></div>--%>
                    </th>
                    <th>Ore</th>
                    <%--<th>Prezzo</th>--%>
                    <th>Data costo</th>
                    <th>Codice cantiere</th>
                    <th>Descrizione</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%>
                    </th>
                    <th class="iwebNascosto"></th>
                    <%--<th></th>--%>
                    <th></th>
                    <th>
                        <%--maggiore uguale di--%>
                        <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_costo.datacosto">
                            <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <%--minore di--%>
                        <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_costo.datacosto">
                            <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                        </div>
                    </th>
                    <th></th>
                    <th></th>
                    <th></th><%-- ALTRO --%>
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaCostiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');"></div>
                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');"></div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_costo.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_costo.quantita r"></span>
                    </td>
                    <%--<td>
                        <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                    </td>--%>
                    <td>
                        <span class="iwebCAMPO_costo.datacosto iwebData"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.id iwebNascosto"></span>
                        <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_costo.descrizione iwebDescrizione"></span>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                             onclick="iwebTABELLA_SelezionaRigaComeUnica();
                                      iwebTABELLA_EliminaRigaInPopup('popupTabellaCostiElimina')"></div>
                    </td><%-- ALTRO --%>
                </tr>
            </tbody>
            <tbody>
                <%-- il codice viene generato automaticamente qui --%>
            </tbody>
            <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                <%-- eventualmente va messo display:none --%>
                <tr class="iwebNascosto">
                    <td></td>
                    <td></td>
                    <%--<td></td>--%>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="Select1" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT costo.id as 'costo.id', costo.quantita as 'costo.quantita', costo.prezzo as 'costo.prezzo', "
              + "       costo.datacosto as 'costo.datacosto', costo.descrizione as 'costo.descrizione', " 
              + "       cantiere.id as 'cantiere.id', cantiere.codice as 'cantiere.codice' "
              + "FROM costo LEFT JOIN cantiere ON costo.idcantiere = cantiere.id " 
              + "WHERE costo.idprodotto = @idmanodopera "
            ) %></span>
            <span class="iwebPARAMETRO">@idmanodopera = IDMANODOPERA_value</span>
        </span>

        <%-- modifica --%>
        <div id="popupTabellaCostiModifica" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Modifica rapportino</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <div class="iwebTABELLA_ContenitoreParametri"></div>
                    <table>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td><span class="iwebCAMPO_costo.id"></span></td>
                        </tr>
                        <tr>
                            <td>Ore</td>
                            <td><input type="text" class="iwebCAMPO_costo.quantita iwebCAMPOOBBLIGATORIO iwebTIPOCAMPO_varchar" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Data costo</td>
                            <td>
                                <input type="text" placeholder="A" class="iwebCAMPO_costo.datacosto iwebTIPOCAMPO_date"
                                    onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><textarea class="iwebCAMPO_costo.descrizione iwebTIPOCAMPO_memo"></textarea></td>
                        </tr>
                        <tr>
                            <td>Codice cantiere</td>
                            <td>
                                <div class="iwebCAMPO_cantiere.codice">
                                    <select id="DDLCantiere" class="iwebDDL iwebCAMPO_cantiere.id"
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                            "SELECT codice as NOME, id as VALORE FROM cantiere ORDER BY codice") %>
                                        </span>
                                    </span>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaCostiModifica', 'tabellaCosti', 'costo.idcantiere, costo.quantita, costo.datacosto, costo.descrizione', 'costo.id', true);">Aggiorna</div>
                    <span class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE costo SET idcantiere = @idcantiere, quantita = @quantita, datacosto = @datacosto, descrizione = @descrizione WHERE id = @id") %></span>
	                    <span class="iwebPARAMETRO">@idcantiere = popupTabellaCostiModifica_findValue_cantiere.id</span>
	                    <span class="iwebPARAMETRO">@quantita = popupTabellaCostiModifica_findValue_costo.quantita</span>
	                    <span class="iwebPARAMETRO">@datacosto = popupTabellaCostiModifica_findValue_costo.datacosto</span>
	                    <span class="iwebPARAMETRO">@descrizione = popupTabellaCostiModifica_findValue_costo.descrizione</span>
	                    <span class="iwebPARAMETRO">@id = popupTabellaCostiModifica_findValue_costo.id</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <div id="popupTabellaCostiElimina" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione rapportino, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">
                    <table>
                        <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td><span class="iwebCAMPO_costo.id"></span></td>
                        </tr>
                        <tr>
                            <td>Data</td>
                            <td><span class="iwebCAMPO_costo.datacosto"></span></td>
                        </tr>
                        <tr>
                            <td>Ore</td>
                            <td><span class="iwebCAMPO_costo.quantita"></span></td>
                        </tr>
                        <tr>
                            <td>Codice cantiere</td>
                            <td>
                                <span class="iwebCAMPO_cantiere.codice"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><span class="iwebCAMPO_costo.descrizione"></span></td>
                        </tr>
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-danger" onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaCostiElimina', 'tabellaCosti', true);">Elimina</div>
                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM costo WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = popupTabellaCostiElimina_findvalue_costo.id</span>
                    </span>
                </div>
            </div>
        </div>

    </div>


    <script>
        function pageload() {
            iwebCaricaElemento("tabellaCosti");
            iwebCaricaElemento("labelRagioneSociale");
            iwebCaricaElemento("labelPrezzo");
        }
    </script>

</asp:Content>

