<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="gestione-fatture.aspx.cs" Inherits="gestionale_costi_gestione_fatture" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="gestione-fatture.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Elenco fatture
    </div>

    <div class="iwebTABELLAWrapper width915 l">
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
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM bollafattura WHERE bollafattura.id=@bollafattura.id") %></span>
            </span>
        </div>
        <table id="tabellaFatture" class="iwebTABELLA iwebCHIAVE__bollafattura.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <%--<input type="button" value="Aggiungi" onclick="apriPopupType2('popupTabellaFattureInserimento');" />--%>
                        <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                            onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaFattureInserimento');"></div>
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <th>Numero</th>
                    <th>Data</th>
                    <th>Fornitore</th>
                    <th>Importo</th>
                    <th>Scansione</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%>
                    </th>
                    <th class="iwebNascosto"></th>
                    <th></th>
                    <th>
                        <%--maggiore uguale di--%>
                        <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_bollafattura.databollafattura">
                            <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <%--minore di--%>
                        <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_bollafattura.databollafattura">
                            <%--<input type="text" placeholder="A" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>--%>
                            <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                        </div>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo ragionesociale --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_fornitore.ragionesociale">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
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
                        <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaFattureModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaFatture');"></div>
                        <%--<div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaFatture');"></div>--%>
                        <div class="btn btn-default iwebCAMPO_LinkPerControllo" onclick="gestioneFatture_controlloFattura(iwebCAMPO_LinkPerControllo)" >Controlla fattura</div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_bollafattura.id"></span>
                        <span class="iwebCAMPO_fornitore.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.numero"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.databollafattura iwebData"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione iwebTroncaCrtsAt_30"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.importo iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.scansione iwebDescrizione"></span>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaFatture');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaFattureElimina')"></div>
                        <%--<input type="button" value="Elimina" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaFatture');
                                                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaFattureElimina')" />--%>
                    </td><%-- ALTRO --%>
                </tr>
            </tbody>
            <tbody>
                <%-- il codice viene generato automaticamente qui --%>
            </tbody>
            <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                <tr class="iwebNascosto">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <%--<td><b class="r">Totale</b></td>
                    <td>
                        <span id="Span1" class="iwebTOTALE iwebValuta"></span>
                        <span class="iwebSQLTOTAL">bollafattura.importo</span>
                    </td>--%>
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
                "SELECT bollafattura.id as 'bollafattura.id', bollafattura.idfornitore as 'bollafattura.idfornitore', "
                + "       bollafattura.id as 'LinkPerControllo', "
                + "       bollafattura.numero as 'bollafattura.numero', bollafattura.databollafattura as 'bollafattura.databollafattura', bollafattura.importo as 'bollafattura.importo', bollafattura.pathfilescansione as 'bollafattura.pathfilescansione', "
                + "       fornitore.id as 'fornitore.id', fornitore.ragionesociale as 'fornitore.ragionesociale' "
                + "FROM bollafattura LEFT JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
                + "WHERE bollafattura.isddt = false") %>
	        </span>
        </span>

        <%-- inserimento --%>
        <div id="popupTabellaFattureInserimento" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Inserisci nuova fattura</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <table>
                        <tr>
                            <td>Numero *</td>
                            <td><input type="text" 
                                    class="iwebCAMPO_bollafattura.numero iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Data *</td>
                            <td>
                                <input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_date iwebCAMPOOBBLIGATORIO" 
                                    placeholder="gg/mm/aaaa" onfocus="scwLanguage='it';scwShow(this, event);" 
                                    onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>Fornitore *</td>
                            <%--<td><input type="text" class="iwebCAMPO_fornitore.id iwebTIPOCAMPO_varchar" /></td>--%>
                            <td>
                                <div class="iwebCAMPO_fornitore.ragionesociale">
                                    <select id="popupTabellaFattureInserimentoDDLFornitore" class="iwebDDL iwebCAMPO_fornitore.id iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                        <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT ragionesociale as NOME, id as VALORE FROM fornitore ORDER BY ragionesociale") %></span>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Importo</td>
                            <td>
                                <input type="text" class="iwebCAMPO_bollafattura.importo iwebTIPOCAMPO_varchar"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Scansione</td>
                            <td></td>
                        </tr>
                    </table>
                </div>

                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <%-- IdPopupAssociato, nomeQuery, parametriQuery, attesaRispostaServer --%>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaFattureInserimento', 'tabellaFatture', '', true)">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "INSERT INTO bollafattura (idfornitore, numero, databollafattura, isddt, isfattura, importo, chiusa) "
                                             + "VALUES(@idfornitore, @numero, @databollafattura, false, true, @importo, true)" ) %></span>
                        <span class="iwebPARAMETRO">@idfornitore = popupTabellaFattureInserimento_findValue_fornitore.id</span>
                        <span class="iwebPARAMETRO">@numero = popupTabellaFattureInserimento_findValue_bollafattura.numero</span>
                        <span class="iwebPARAMETRO">@databollafattura = popupTabellaFattureInserimento_findValue_bollafattura.databollafattura</span>
                        <span class="iwebPARAMETRO">@importo = popupTabellaFattureInserimento_findValue_bollafattura.importo</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- modifica --%>
        <div id="popupTabellaFattureModifica" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Modifica fattura</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <div class="iwebTABELLA_ContenitoreParametri"></div>
                    <table>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td><span class="iwebCAMPO_bollafattura.id"></span></td>
                        </tr>
                        <tr>
                            <td>Numero</td>
                            <td><input type="text" class="iwebCAMPO_bollafattura.numero iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Data</td>
                            <td><%--<input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_varchar"/>--%>
                                <input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_date" 
                                    placeholder="gg/mm/aaaa" onfocus="scwLanguage='it';scwShow(this, event);" 
                                    onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>Fornitore</td>
                            <td>
                                <%--<span class="iwebCAMPO_fornitore.ragionesociale"></span>--%>
                                <div class="iwebCAMPO_fornitore.ragionesociale">
                                    <select id="popupTabellaBolleModificaDDLFornitore" class="iwebDDL iwebCAMPO_fornitore.id iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                        <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT ragionesociale as NOME, id as VALORE FROM fornitore ORDER BY ragionesociale") %></span>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Importo</td>
                            <td><input type="text" class="iwebCAMPO_bollafattura.importo iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Scansione</td>
                            <td></td>
                        </tr>
                        <%-- basta aggiungere nomi di campi esistenti e funziona --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaFattureModifica', 'tabellaFatture', 'bollafattura.numero, bollafattura.databollafattura, fornitore.id, fornitore.ragionesociale bollafattura.importo', 'bollafattura.id', true);">Aggiorna</div>
                    <%--<span class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE fattura SET nominativo = @nominativo, tel = @tel, mail = @mail WHERE id = @id") %></span>
	                    <span class="iwebPARAMETRO">@nominativo = popupTabellaClientiModifica_findValue_nominativo</span>
	                    <span class="iwebPARAMETRO">@tel = popupTabellaClientiModifica_findValue_tel</span>
	                    <span class="iwebPARAMETRO">@mail = popupTabellaClientiModifica_findValue_mail</span>
	                    <span class="iwebPARAMETRO">@id = popupTabellaClientiModifica_findValue_cliente.id</span>
                    </span>--%>
                    <div class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                            "UPDATE bollafattura SET numero = @numero, databollafattura = @databollafattura, "
                                          + "       idfornitore = @idfornitore, importo = @importo "
                                          + "WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@numero = popupTabellaFattureModifica_findValue_bollafattura.numero</span>
                        <span class="iwebPARAMETRO">@databollafattura = popupTabellaFattureModifica_findValue_bollafattura.databollafattura</span>
                        <span class="iwebPARAMETRO">@idfornitore = popupTabellaFattureModifica_findValue_fornitore.id</span>
                        <span class="iwebPARAMETRO">@importo = popupTabellaFattureModifica_findValue_bollafattura.importo</span>
                        <span class="iwebPARAMETRO">@id = popupTabellaFattureModifica_findValue_bollafattura.id</span>
                    </div>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <div id="popupTabellaFattureElimina" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione fattura, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">
                    <table>
                        <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td><span class="iwebCAMPO_bollafattura.id"></span></td>
                        </tr>
                        <tr>
                            <td>Numero</td>
                            <td><span class="iwebCAMPO_bollafattura.numero"></span></td>
                        </tr>
                        <tr>
                            <td>Data</td>
                            <td><span class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_date"></span></td>
                        </tr>
                        <tr>
                            <td>Fornitore</td>
                            <td><span class="iwebCAMPO_fornitore.ragionesociale"></span></td>
                        </tr>
                        <tr>
                            <td>Importo</td>
                            <td><span class="iwebCAMPO_bollafattura.importo"></span></td>
                        </tr>
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-danger" onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaFattureElimina', 'tabellaFatture', true);">Elimina</div>
                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM bollafattura WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = tabellaFatture_selectedValue_bollafattura.id</span>
                    </span>
                </div>
            </div>
        </div>
    </div><%-- fine tabellaSinistra --%>

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaFatture");
        }

    </script>
</asp:Content>

