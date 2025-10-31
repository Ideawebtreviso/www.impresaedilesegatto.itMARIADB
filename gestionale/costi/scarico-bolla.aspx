<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="scarico-bolla.aspx.cs" Inherits="gestionale_costi_scarico_bolla" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="scarico-bolla.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDBOLLA" class="iwebNascosto"><asp:Literal ID="LiteralIDBOLLA" runat="server"></asp:Literal></span>
    <div class="TitoloPagina">
        Scarico bolla
    </div><br />

    <table id="tabellaBolle" class="iwebTABELLA iwebCHIAVE__bollafattura.id">
        <thead>
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                <th class="commandHead iwebNascosto">
                </th>
                <th class="iwebNascosto">ID</th>
                <th>Numero</th>
                <th>Data</th>
                <th>Fornitore</th>
                <th>Importo</th>
                <th>Chiusa</th>
                <th>Tipo</th>
            </tr>
            <%-- filtri --%>
            <tr class="iwebNascosto">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </thead>
        <tbody class="iwebNascosto">
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE iwebNascosto" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                <td>
                    <span class="iwebCAMPO_bollafattura.numero"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_bollafattura.databollafattura iwebData"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione iwebTroncaCrtsAt_30"></span>
                    <span class="iwebCAMPO_fornitore.id iwebNascosto"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_bollafattura.importo iwebValuta"></span>
                </td>
                <td>
                    <input type="checkbox" class="iwebCAMPO_bollafattura.chiusa iwebCheckbox" disabled />
                </td>
                <td>
                    <span class="iwebCAMPO_tipo"></span>
                </td>
            </tr>
        </tbody>
        <tbody>
            <%-- il codice viene generato automaticamente qui --%>
        </tbody>
        <tfoot class="iwebNascosto">
            <tr class="iwebNascosto"></tr>
            <tr><td><div class="iwebTABELLAFooterPaginazione">
                <div>Pagina</div>
                <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                <div class="iwebPAGESIZE"><select id="Select1ALSDKJ44" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                <div class="iwebTOTRECORD">Trovate 0 righe</div>
            </div></td></tr>
        </tfoot>
    </table>
    <span class="iwebSQLSELECT">
	    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
             SELECT bollafattura.id as 'bollafattura.id',
                    bollafattura.numero as 'bollafattura.numero',
                    bollafattura.databollafattura as 'bollafattura.databollafattura',
                    fornitore.ragionesociale as 'fornitore.ragionesociale',
                    fornitore.id as 'fornitore.id',
                    bollafattura.importo as 'bollafattura.importo',
                    bollafattura.chiusa as 'bollafattura.chiusa',
                IF (bollafattura.isfattura, 'Bolla accompagnatoria', 'Bolla') as 'tipo'
             FROM bollafattura INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id
             WHERE bollafattura.id = @idbolla
        ") %></span>
	    <span class="iwebPARAMETRO">@idbolla = IDBOLLA_value</span>
    </span>

    <div class="TitoloPagina">
        Scarica una nuova riga
    </div><br />

    <div class="popupCorpo">
        <table>
            <tr>
                <td>Cantiere *</td>
                <td>
                    <div class="iwebAUTOCOMPLETAMENTO" id="nuovoCantiere">
                        <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                        <%-- Chiave dell'el selezionato --%>
                        <span class="iwebNascosto"></span>

                        <%-- Valore dell'el selezionato --%>
                        <input type="text" autocomplete="off"
                            onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                            onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)" /><br />
                        <span class="iwebSQLSELECT">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                SELECT id as chiave, codice as valore 
                                FROM cantiere 
                                WHERE codice like @codice LIMIT 3
                            ") %></span>
                            <span class="iwebPARAMETRO">@codice = like_nuovoCantiere_getValore</span>
                        </span>
                        <div><%--RISULTATI RICERCA--%></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>Prodotto *</td>
                <td>
                    <div class="iwebAUTOCOMPLETAMENTO" id="nuovoProdotto">
                        <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                        <%-- Chiave dell'el selezionato --%>
                        <span class="iwebNascosto"></span>

                        <%-- Valore dell'el selezionato --%>
                        <input type="text" autocomplete="off"
                            onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                            onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)" /><br />
                        <span class="iwebSQLSELECT">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                SELECT id as chiave, descrizione as valore 
                                FROM prodotto 
                                WHERE descrizione like @descrizione AND 
                                    idfornitore = @idfornitore LIMIT 3
                            ") %></span>
                            <span class="iwebPARAMETRO">@descrizione = like_nuovoProdotto_getValore</span>
                            <span class="iwebPARAMETRO">@idfornitore = tabellaBolle_findFirstValue_fornitore.id</span>
                        </span>
                        <div><%--RISULTATI RICERCA--%></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>Quantita' *</td>
                <td><input type="text" id="nuovoQuantita" /></td>
            </tr>
            <tr>
                <td>Prezzo</td>
                <td><input type="text" id="nuovoPrezzo" /></td>
            </tr>
            <tr>
                <td>Sconto1</td>
                <td><input type="text" id="nuovoSconto1" /></td>
            </tr>
            <tr>
                <td>Sconto2</td>
                <td><input type="text" id="nuovoSconto2" /></td>
            </tr>
            <tr>
                <td>Aggiorna prezzo e sconti in anagrafica</td>
                <td><input type="checkbox" id="aggiornaPrezzoAnagrafica" checked="checked" /></td>
            </tr>
            <tr>
                <td></td>
                <td><div class="btn btn-default" onclick="scaricoBolla_scarica()">Scarica</div></td>
            </tr>
        </table>
        <span class="iwebSQLQUERY1 iwebNascosto">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("INSERT INTO costo "
                + "(idbollafattura, idprodotto, idcantiere, idcostobollariferita, quantita, prezzo, sconto1, sconto2) "                  
                + "VALUES (@idbollafattura, @idprodotto, @idcantiere, @idcostobollariferita, @quantita, @prezzo, @sconto1, @sconto2)") %></span>
            <span class="iwebPARAMETRO">@idbollafattura = IDBOLLA_value</span>
            <span class="iwebPARAMETRO">@idprodotto = nuovoProdotto_getChiave</span>
            <span class="iwebPARAMETRO">@idcantiere = nuovoCantiere_getChiave</span>
            <span class="iwebPARAMETRO">@idcostobollariferita = VALORE_0</span>
            <span class="iwebPARAMETRO">@quantita = nuovoQuantita_value</span>
            <span class="iwebPARAMETRO">@prezzo = nuovoPrezzo_value</span>
            <span class="iwebPARAMETRO">@sconto1 = nuovoSconto1_value</span>
            <span class="iwebPARAMETRO">@sconto2 = nuovoSconto2_value</span>
        </span>
        <%-- la seconda query dovrebbe aggiornare i prezzi in caso di --%>
        <span class="iwebSQLQUERY2 iwebNascosto">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE prodotto SET listino = @listino, sconto1 = @sconto1, sconto2 = @sconto2 WHERE id = @idprodotto")%></span>
            <span class="iwebPARAMETRO">@idprodotto = nuovoProdotto_getChiave</span>
            <span class="iwebPARAMETRO">@listino = nuovoPrezzo_value</span>
            <span class="iwebPARAMETRO">@sconto1 = nuovoSconto1_value</span>
            <span class="iwebPARAMETRO">@sconto2 = nuovoSconto2_value</span>
        </span>
    </div>

    <div class="TitoloPagina">
        Elenco delle righe già scaricate
    </div><br />

    <table id="tabellaRigheScaricate" class="iwebTABELLA iwebCHIAVE__costo.id">
        <thead>
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                <th class="commandHead">
                </th>
                <th class="iwebNascosto">ID</th>
                <th>Cantiere</th>
                <th>Cliente</th>
                <th>Prodotto</th>
                <th>Qta</th>
                <th>Prezzo</th>
                <th>Sconto1</th>
                <th>Sconto2</th>
            </tr>
            <%-- filtri --%>
            <tr>
                <td></td>
                <td>
                    <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_cantiere.id">
                        <%-- potrei aggiungere il codice per fare in alternativa: --%>
                        <select id="tabellaRigheScaricateDDLCantiere" class="iwebDDL"
                            onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                            <option class="iwebAGGIUNTO" value="-1">tutti</option>
                        </select>
                        <span class="iwebSQLSELECT">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT codice as NOME, id as VALORE FROM cantiere ORDER BY codice") %></span>
                        </span>
                    </div>
                </td>
                <td>
                    <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_cliente.id">
                        <%-- potrei aggiungere il codice per fare in alternativa: --%>
                        <select id="tabellaRigheScaricateDDLCliente" class="iwebDDL"
                            onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                            <option class="iwebAGGIUNTO" value="-1">tutti</option>
                        </select>
                        <span class="iwebSQLSELECT">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT nominativo as NOME, id as VALORE FROM cliente ORDER BY nominativo") %></span>
                        </span>
                    </div>
                </td>
                <td>
                    <%-- filtro di testo sul campo prodotto.descrizione --%>
                    <%--<div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.descrizione">
                        <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                    </div>--%>
                    <div class="iwebAUTOCOMPLETAMENTO iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.descrizione" id="tabellaRigheScaricateAUTOCOMPLETAMENTOProdotto">
                        <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                        <%-- Chiave dell'el selezionato --%>
                        <span class="iwebNascosto"></span>

                        <%-- Valore dell'el selezionato --%>
                        <input type="text" autocomplete="off"
                            onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                            onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this);
                                if (event.which == 13 || event.keyCode == 13) iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)" />
                            <span class="iwebSQLSELECT">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT id as chiave, descrizione as valore FROM prodotto WHERE descrizione like @descrizione LIMIT 3") %></span>
                                <span class="iwebPARAMETRO">@descrizione = like_tabellaRigheScaricateAUTOCOMPLETAMENTOProdotto_getValore</span>
                            </span>
                        <div onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true);"><%--RISULTATI RICERCA--%></div>
                    </div>
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </thead>
        <tbody class="iwebNascosto">
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE iwebNascosto" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                <td>
                    <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaRigheScaricateModifica'); iwebTABELLA_SelezionaRigaComeUnica();"></div>
                </td>
                <td class="iwebNascosto">
                    <span class="iwebCAMPO_costo.id"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                    <span class="iwebCAMPO_cantiere.id iwebNascosto"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_cliente.nominativo iwebDescrizione iwebTroncaCrtsAt_30"></span>
                    <span class="iwebCAMPO_cliente.id iwebNascosto"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                    <span class="iwebCAMPO_prodotto.id iwebNascosto"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.quantita iwebValuta"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.sconto1 iwebValuta"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.sconto2 iwebValuta"></span>
                </td>
            </tr>
        </tbody>
        <tbody>
            <%-- il codice viene generato automaticamente qui --%>
        </tbody>
        <tfoot>
            <tr class="iwebNascosto"></tr>
            <tr><td><div class="iwebTABELLAFooterPaginazione">
                <div>Pagina</div>
                <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                <div class="iwebPAGESIZE"><select id="Select2" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                <div class="iwebTOTRECORD">Trovate 0 righe</div>
            </div></td></tr>
        </tfoot>
    </table>
    <span class="iwebSQLSELECT">
        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL( 
            "SELECT costo.idbollafattura as 'costo.idbollafattura', costo.idprodotto as 'costo.idprodotto', "
          + "       costo.idcantiere as 'costo.idcantiere', costo.idcostobollariferita as 'costo.idcostobollariferita', "
          + "       costo.quantita as 'costo.quantita', costo.prezzo as 'costo.prezzo', "
          + "       costo.sconto1 as 'costo.sconto1', costo.sconto2 as 'costo.sconto2', "
          + "       cantiere.id as 'cantiere.id', cantiere.idcliente as 'cantiere.idcliente', "
          + "       cantiere.codice as 'cantiere.codice', cantiere.descrizione as 'cantiere.descrizione', "
          + "       cliente.id as 'cliente.id', cliente.nominativo as 'cliente.nominativo', "
          + "       prodotto.id as 'prodotto.id', prodotto.descrizione as 'prodotto.descrizione' "
          + "FROM costo LEFT JOIN cantiere ON costo.idcantiere = cantiere.id "
          + "           LEFT JOIN cliente ON cantiere.idcliente = cliente.id "
          + "           LEFT JOIN prodotto ON costo.idprodotto = prodotto.id "
          + "WHERE idbollafattura = @idbollafattura"
        ) %></span>
        <span class="iwebPARAMETRO">@idbollafattura = IDBOLLA_value</span>
    </span>

    <%-- modifica --%>
    <div id="popupTabellaRigheScaricateModifica" class="popup popupType2" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Modifica riga scaricata</div>
                <div class="b"></div>
            </div>
            <div class="popupCorpo">
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <table>
                    <tr>
                        <td>Cantiere *</td>
                        <%--<td><input type="text" class="iwebCAMPO_fornitore.id iwebTIPOCAMPO_varchar" /></td>--%>
                        <td>
                            <div class="iwebCAMPO_cantiere.codice">
                                <select id="popupTabellaRigheScaricateModificaDDLCantiere" class="iwebDDL iwebCAMPO_cantiere.id iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                    <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                </select>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT codice as NOME, id as VALORE FROM cantiere ORDER BY codice") %></span>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Cliente *</td>
                        <%--<td><input type="text" class="iwebCAMPO_fornitore.id iwebTIPOCAMPO_varchar" /></td>--%>
                        <td>
                            <div class="iwebCAMPO_cliente.nominativo">
                                <select id="popupTabellaRigheScaricateModificaDDLCliente" class="iwebDDL iwebCAMPO_cliente.id iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                    <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                </select>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT nominativo as NOME, id as VALORE FROM cliente ORDER BY nominativo") %></span>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Prodotto *</td>
                        <%--<td><input type="text" class="iwebCAMPO_fornitore.id iwebTIPOCAMPO_varchar" /></td>--%>
                        <td>
                            <div class="iwebCAMPO_prodotto.descrizione">
                                <select id="popupTabellaRigheScaricateModificaDDLProdotto" class="iwebDDL iwebCAMPO_prodotto.id iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                    <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                </select>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT descrizione as NOME, id as VALORE FROM prodotto WHERE descrizione <> '' ORDER BY descrizione") %></span>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Quantita'</td>
                        <td>
                            <input type="text" class="iwebCAMPO_costo.quantita iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" />
                        </td>
                    </tr>
                    <tr>
                        <td>Prezzo</td>
                        <td>
                            <input type="text" class="iwebCAMPO_costo.prezzo iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" />
                        </td>
                    </tr>
                    <tr>
                        <td>Sconto 1</td>
                        <td>
                            <input type="text" class="iwebCAMPO_costo.sconto1 iwebTIPOCAMPO_varchar" />
                        </td>
                    </tr>
                    <tr>
                        <td>Sconto 2</td>
                        <td>
                            <input type="text" class="iwebCAMPO_costo.sconto2 iwebTIPOCAMPO_varchar" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaRigheScaricateModifica', 'tabellaRigheScaricate', 'nominativo,tel,mail', 'cliente.id', true);">Aggiorna</div>
                <span class="iwebSQLUPDATE">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE cliente SET nominativo = @nominativo, tel = @tel, mail = @mail WHERE id = @id") %></span>
	                <span class="iwebPARAMETRO">@nominativo = popupTabellaClientiModifica_findValue_nominativo</span>
	                <span class="iwebPARAMETRO">@tel = popupTabellaClientiModifica_findValue_tel</span>
	                <span class="iwebPARAMETRO">@mail = popupTabellaClientiModifica_findValue_mail</span>
	                <span class="iwebPARAMETRO">@id = popupTabellaClientiModifica_findValue_cliente.id</span>
                </span>
            </div>
        </div>
    </div>


    <script>
        function pageload() {
            iwebCaricaElemento("tabellaBolle");
            iwebCaricaElemento("tabellaRigheScaricate");
            iwebCaricaElemento("tabellaRigheScaricateDDLCantiere");
            iwebCaricaElemento("tabellaRigheScaricateDDLCliente");
        }

    </script>
</asp:Content>

