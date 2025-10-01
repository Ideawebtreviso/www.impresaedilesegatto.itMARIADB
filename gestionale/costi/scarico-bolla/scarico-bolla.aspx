<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="scarico-bolla.aspx.cs" Inherits="gestionale_costi_scarico_bolla_scarico_bolla" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="scarico-bolla-04.js"></script>
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
                    <span class="iwebCAMPO_bollafattura.importo iwebQuantita"></span>
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
                <div class="iwebPAGESIZE"><select id="Select1" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                <div class="iwebTOTRECORD">Trovate 0 righe</div>
            </div></td></tr>
        </tfoot>
    </table>
    <span class="iwebSQLSELECT">
	    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
            "SELECT bollafattura.id as 'bollafattura.id', "
          + "       bollafattura.numero as 'bollafattura.numero', "
          + "       bollafattura.databollafattura as 'bollafattura.databollafattura', "
          + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "
          + "       fornitore.id as 'fornitore.id', "
          + "       bollafattura.importo as 'bollafattura.importo', "
          + "       bollafattura.chiusa as 'bollafattura.chiusa', "
          + "   IF (bollafattura.isfattura, 'Bolla accompagnatoria', 'Bolla') as 'tipo' " 
          + "FROM bollafattura INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
          + "WHERE bollafattura.id = @idbolla") %></span>
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
                        <input type="text" autocomplete="off" tabindex="1" class="iwebTIPOCAMPO_varchar" 
                            onfocus="this.value = ''; precedenteElemento(this).innerHTML = ''; /* azzero chiave e valore */"
                            onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                            onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)" />

                        <span class="iwebSQLSELECT">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                SELECT cantiere.id as chiave, 
                                       CONCAT(cliente.nominativo, ' - ', cantiere.codice, ' - ', cantiere.descrizione) as valore 
                                FROM cantiere LEFT JOIN cliente ON cantiere.idcliente = cliente.id 
                                WHERE (cantiere.stato = 'Aperto' OR
                                      cantiere.stato = 'Da firmare') AND
                                      (cliente.nominativo like @codice OR cantiere.codice like @codice OR cantiere.descrizione = @codice) 
                                LIMIT 3
                            ") %></span>
                            <span class="iwebPARAMETRO">@codice = like_nuovoCantiere_getValore</span>
                        </span>
                        <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>Prodotto *</td>
                <td>
                    <script>
                        function funzioneOnNuovoProdottoSelezionato(el) {
                            scaricobolla_leggiPrezzoEScontiDaDB();
                        }
                    </script>
                    <div class="iwebAUTOCOMPLETAMENTO" id="nuovoProdotto">
                        <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                        <%-- Chiave dell'el selezionato --%>
                        <span class="iwebNascosto"></span>

                        <%-- Valore dell'el selezionato --%>
                        <input type="text" autocomplete="off" tabindex="1" class="iwebTIPOCAMPO_varchar" 
                            onfocus="this.value = ''; precedenteElemento(this).innerHTML = ''; /* azzero chiave e valore */"
                            onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this, 'funzioneOnNuovoProdottoSelezionato')" 
                            onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this, 'funzioneOnNuovoProdottoSelezionato')"/>

                        <span class="iwebSQLSELECT">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                 SELECT prodotto.id as chiave, 
                                    CONCAT(prodotto.descrizione, ' (', unitadimisura.codice, ')') as valore 

                                 FROM bollafattura 
                                    INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id
                                    INNER JOIN prodotto ON fornitore.id = prodotto.idfornitore
                                    INNER JOIN unitadimisura ON prodotto.idunitadimisura = unitadimisura.id

                                 WHERE prodotto.descrizione like @descrizione AND
                                    bollafattura.id = @idbolla
                                 LIMIT 20
                            ") %></span>
                            <span class="iwebPARAMETRO">@descrizione = like_nuovoProdotto_getValore</span>
                            <span class="iwebPARAMETRO">@idbolla = IDBOLLA_value</span>
                            <%--<span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT id as chiave, descrizione as valore FROM prodotto WHERE descrizione like @descrizione AND idfornitore = @idfornitore LIMIT 3") %></span>
                            <span class="iwebPARAMETRO">@descrizione = like_nuovoProdotto_getValore</span>
                            <span class="iwebPARAMETRO">@idfornitore = tabellaBolle_findFirstValue_fornitore.id</span>--%>
                        </span>
                        <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                    </div>
                    <span class="iwebSQLQUERYPRODOTTOSELEZIONATO iwebNascosto">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT listino, sconto1, sconto2 FROM prodotto WHERE id = @id ") %></span>
                        <span class="iwebPARAMETRO">@id = nuovoProdotto_getChiave</span>
                    </span>
                </td>
            </tr>
            <tr>
                <td>Quantita' *</td>
                <td><input type="text" id="nuovoQuantita" tabindex="1" class="iwebTIPOCAMPO_varchar"/></td>
            </tr>
            <tr>
                <td>Descrizione</td>
                <td>
                    <textarea id="nuovoDescrizione" class="iwebTIPOCAMPO_memo" tabindex="1"></textarea>
                </td>
            </tr>
            <tr>
                <td>Prezzo</td>
                <td><input type="text" id="nuovoPrezzo" tabindex="1"  class="iwebTIPOCAMPO_varchar"/></td>
            </tr>
            <tr>
                <td>Sconto1</td>
                <td><input type="text" id="nuovoSconto1" tabindex="1"  class="iwebTIPOCAMPO_varchar"/></td>
            </tr>
            <tr>
                <td>Sconto2</td>
                <td><input type="text" id="nuovoSconto2" tabindex="1"  class="iwebTIPOCAMPO_varchar"/></td>
            </tr>
            <tr>
                <td>Aggiorna prezzo e sconti in anagrafica</td>
                <td><input type="checkbox" id="aggiornaPrezzoAnagrafica" checked="checked" tabindex="1" 
                    onkeypress="if (event.which == 13 || event.keyCode == 13) this.checked = !this.checked;"/></td>
            </tr>
            <tr>
                <td>
                    <span id="labelErroreScaricoBolla" class="errore"></span>
                </td>
                <td><div class="btn btn-default" tabindex="1" 
                    onclick="scaricoBolla_scarica()"
                    onkeypress="if (event.which == 13 || event.keyCode == 13) scaricoBolla_scarica()"
                    >Scarica</div></td>
            </tr>
        </table>
        <%-- iwebSQLQUERY1 lancia poi iwebSQLQUERY2(solo se c'è la spunta in aggiorna prezzi in anagrafica) e iwebSQLQUERY3(in ogni caso) --%>
        <span class="iwebSQLQUERY1 iwebNascosto">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("INSERT INTO costo "
              + "(idbollafattura, idprodotto, idcantiere, idcostobollariferita, quantita, descrizione, prezzo, sconto1, sconto2, datacosto) "                  
              + "VALUES (@idbollafattura, @idprodotto, @idcantiere, @idcostobollariferita, @quantita, @descrizione, @prezzo, @sconto1, @sconto2, @datacosto)"
            ) %></span>
            <span class="iwebPARAMETRO">@idbollafattura = IDBOLLA_value</span>
            <span class="iwebPARAMETRO">@idprodotto = nuovoProdotto_getChiave</span>
            <span class="iwebPARAMETRO">@idcantiere = nuovoCantiere_getChiave</span>
            <span class="iwebPARAMETRO">@idcostobollariferita = VALORE_0</span>
            <span class="iwebPARAMETRO">@quantita = nuovoQuantita_value</span>
            <span class="iwebPARAMETRO">@descrizione = nuovoDescrizione_value</span>
            <span class="iwebPARAMETRO">@prezzo = nuovoPrezzo_value</span>
            <span class="iwebPARAMETRO">@sconto1 = nuovoSconto1_value</span>
            <span class="iwebPARAMETRO">@sconto2 = nuovoSconto2_value</span>
            <span class="iwebPARAMETRO">@datacosto = tabellaBolle_findFirstValue_bollafattura.databollafattura</span>
        </span>
        <%-- la seconda query dovrebbe aggiornare i prezzi in caso di checkbox spuntato --%>
        <span class="iwebSQLQUERY2 iwebNascosto">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE prodotto SET listino = @listino, sconto1 = @sconto1, sconto2 = @sconto2 WHERE id = @idprodotto")%></span>
            <span class="iwebPARAMETRO">@idprodotto = nuovoProdotto_getChiave</span>
            <span class="iwebPARAMETRO">@listino = nuovoPrezzo_value</span>
            <span class="iwebPARAMETRO">@sconto1 = nuovoSconto1_value</span>
            <span class="iwebPARAMETRO">@sconto2 = nuovoSconto2_value</span>
        </span>
        <%-- la terza query associa al prodotto selezionato, l'idfornitore presente in pagina --%>
        <span class="iwebSQLQUERY3 iwebNascosto">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE prodotto SET idfornitore = @idfornitore WHERE id = @idprodotto")%></span>
            <span class="iwebPARAMETRO">@idprodotto = nuovoProdotto_getChiave</span>
            <span class="iwebPARAMETRO">@idfornitore = tabellaBolle_findfirstvalue_fornitore.id</span>
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
                <th>U.M.</th>
                <th>Descrizione</th>
                <th>Prezzo</th>
                <th>Sconto1</th>
                <th>Sconto2</th>
                <th>Totale</th>
                <th></th>
            </tr>
            <tr><%-- filtri --%>
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
                    <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.descrizione">
                        <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                    </div>
                    <%--<div class="iwebAUTOCOMPLETAMENTO iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.descrizione" id="tabellaRigheScaricateAUTOCOMPLETAMENTOProdotto">
                        <span class="iwebNascosto">-1</span>

                        <span class="iwebNascosto"></span>

                        <input type="text" autocomplete="off"
                            onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                            onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this);
                                if (event.which == 13 || event.keyCode == 13) iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)" />
                            <span class="iwebSQLSELECT">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT id as chiave, descrizione as valore FROM prodotto WHERE descrizione like @descrizione LIMIT 3") %></span>
                                <span class="iwebPARAMETRO">@descrizione = like_tabellaRigheScaricateAUTOCOMPLETAMENTOProdotto_getValore</span>
                            </span>
                        <div onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true);"></div>
                    </div>--%>
                </td>
                <td></td>
                <td></td>
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
                    <span class="iwebCAMPO_costo.quantita iwebQuantita"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_unitadimisura.codice"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.descrizione iwebDescrizione"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.prezzo iwebQuantita"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.sconto1 iwebValuta"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.sconto2 iwebValuta"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_totale iwebValuta"></span>
                </td>
                <td id="nascondiSeBollaChiusa">
                    <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                            onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaRigheScaricate');
                                    iwebTABELLA_EliminaRigaInPopup('popupTabellaRigheScaricateElimina')"></div>
                </td>
                <%--<td id="nascondiSeBollaAperta">
                    <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina" style="cursor:default; color:gray"
                            onclick="alert('bolla chiusa, eliminazione non possibile')"></div>
                </td>--%>
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
            "SELECT costo.id as 'costo.id', costo.idbollafattura as 'costo.idbollafattura', costo.idprodotto as 'costo.idprodotto', "
          + "       costo.idcantiere as 'costo.idcantiere', costo.idcostobollariferita as 'costo.idcostobollariferita', "
          + "       costo.descrizione as 'costo.descrizione', "
          + "       costo.quantita as 'costo.quantita', costo.prezzo as 'costo.prezzo', "
          + "       costo.sconto1 as 'costo.sconto1', costo.sconto2 as 'costo.sconto2', "
          + "       unitadimisura.codice as 'unitadimisura.codice', "
          + "       cantiere.id as 'cantiere.id', cantiere.idcliente as 'cantiere.idcliente', "
          + "       cantiere.codice as 'cantiere.codice', cantiere.descrizione as 'cantiere.descrizione', "
          + "       cliente.id as 'cliente.id', cliente.nominativo as 'cliente.nominativo', "
          + "       prodotto.id as 'prodotto.id', prodotto.descrizione as 'prodotto.descrizione', "
          + "       (costo.quantita * costo.prezzo * (1-costo.sconto1/100) * (1-costo.sconto2/100)) as 'totale' "
          + "FROM costo LEFT JOIN cantiere ON costo.idcantiere = cantiere.id "
          + "           LEFT JOIN cliente ON cantiere.idcliente = cliente.id "
          + "           LEFT JOIN prodotto ON costo.idprodotto = prodotto.id "
          + "           LEFT JOIN unitadimisura ON prodotto.idunitadimisura = unitadimisura.id "
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
                    <tr class="iwebNascosto">
                        <td>id</td>
                        <td><span class="iwebCAMPO_costo.id"></span></td>
                    </tr>
                    <tr>
                        <td>Cantiere *</td>
                        <td>
                            <div class="iwebAUTOCOMPLETAMENTO" id="iwebAUTOCOMPLETAMENTOmodificaCantiere">
                                <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                <%-- Chiave dell'el selezionato --%>
                                <span class="iwebNascosto iwebCAMPO_cantiere.id"></span>

                                <%-- Valore dell'el selezionato --%>
                                <input type="text" autocomplete="off" tabindex="1" class="iwebTIPOCAMPO_varchar iwebCAMPO_cantiere.codice" 
                                    onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                                    onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)" />

                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                        "SELECT cantiere.id as chiave, CONCAT(cliente.nominativo, ' - ', cantiere.codice, ' - ', cantiere.descrizione) as valore "
                                      + "FROM cantiere LEFT JOIN cliente ON cantiere.idcliente = cliente.id "
                                      + "WHERE (cliente.nominativo like @codice OR cantiere.codice like @codice OR cantiere.descrizione = @codice) "
                                      + "       AND cantiere.codice <> 'CS'"
                                      + "LIMIT 3"
                                    ) %></span>
                                    <span class="iwebPARAMETRO">@codice = like_iwebAUTOCOMPLETAMENTOmodificaCantiere_getValore</span>
                                </span>
                                <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Prodotto *</td>
                        <%--<td><input type="text" class="iwebCAMPO_fornitore.id iwebTIPOCAMPO_varchar" /></td>--%>
                        <td>
                            <script>
                                function funzioneOniwebAUTOCOMPLETAMENTOmodificaProdottoSelezionato(el) {
                                    scaricobollaModifica_leggiPrezzoEScontiDaDB();
                                }
                            </script>
                            <div class="iwebAUTOCOMPLETAMENTO" id="iwebAUTOCOMPLETAMENTOmodificaProdotto">
                                <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                <%-- Chiave dell'el selezionato --%>
                                <span class="iwebNascosto iwebCAMPO_prodotto.id"></span>

                                <%-- Valore dell'el selezionato --%>
                                <input type="text" autocomplete="off" tabindex="1" class="iwebTIPOCAMPO_varchar iwebCAMPO_prodotto.descrizione"
                                    onfocus="this.value = ''; precedenteElemento(this).innerHTML = ''; /* azzero chiave e valore */"
                                    onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this, 'funzioneOniwebAUTOCOMPLETAMENTOmodificaProdottoSelezionato')" 
                                    onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this, 'funzioneOniwebAUTOCOMPLETAMENTOmodificaProdottoSelezionato')" />

                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT id as chiave, descrizione as valore FROM prodotto WHERE descrizione like @descrizione LIMIT 20") %></span>
                                    <span class="iwebPARAMETRO">@descrizione = like_iwebAUTOCOMPLETAMENTOmodificaProdotto_getValore</span>
                                </span>
                                <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                            </div>
                            <span class="iwebSQLQUERYPRODOTTOSELEZIONATOModifica iwebNascosto">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT listino, sconto1, sconto2 FROM prodotto WHERE id = @id ") %></span>
                                <span class="iwebPARAMETRO">@id = iwebAUTOCOMPLETAMENTOmodificaProdotto_getChiave</span>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td>Quantita' *</td>
                        <td>
                            <input type="text" class="iwebCAMPO_costo.quantita iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" />
                        </td>
                    </tr>
                    <tr>
                        <td>Descrizione</td>
                        <td>
                            <textarea class="iwebCAMPO_costo.descrizione iwebTIPOCAMPO_memo"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Prezzo</td>
                        <td>
                            <input type="text" class="iwebCAMPO_costo.prezzo iwebTIPOCAMPO_varchar"/>
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
                    <tr>
                        <td>Aggiorna prezzo e sconti in anagrafica</td>
                        <td>
                            <input type="checkbox" class="aggiornaPrezzoEScontiInAnagrafica" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-success" onclick="
                    scaricoBolla_iwebTABELLA_ConfermaModificaRigaInPopup(
                        'popupTabellaRigheScaricateModifica', 'tabellaRigheScaricate', 'cantiere.id,prodotto.id,costo.quantita,costo.descrizione,costo.prezzo,costo.sconto1,costo.sconto2', 'costo.id', true);
                ">Aggiorna</div>
                <%-- iwebSQLQUERY1 lancia poi iwebSQLQUERY2(solo se c'è la spunta in aggiorna prezzi in anagrafica) e iwebSQLQUERY3(in ogni caso) --%>
                <span class="iwebSQLQUERY1Modifica iwebNascosto">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                        "UPDATE costo SET idcantiere = @idcantiere, idprodotto = @idprodotto, quantita = @quantita, "
                      + "                 descrizione = @descrizione, prezzo = @listino, sconto1 = @sconto1, sconto2 = @sconto2 "
                      + "WHERE id = @id"
                    )%></span>
                    <span class="iwebPARAMETRO">@idcantiere = iwebAUTOCOMPLETAMENTOmodificaCantiere_getChiave</span>
                    <span class="iwebPARAMETRO">@idprodotto = iwebAUTOCOMPLETAMENTOmodificaProdotto_getChiave</span>
                    <span class="iwebPARAMETRO">@quantita = popupTabellaRigheScaricateModifica_findValue_costo.quantita</span>
                    <span class="iwebPARAMETRO">@descrizione = popupTabellaRigheScaricateModifica_findValue_costo.descrizione</span>
	                <span class="iwebPARAMETRO">@listino = popupTabellaRigheScaricateModifica_findValue_costo.prezzo</span>
	                <span class="iwebPARAMETRO">@sconto1 = popupTabellaRigheScaricateModifica_findValue_costo.sconto1</span>
	                <span class="iwebPARAMETRO">@sconto2 = popupTabellaRigheScaricateModifica_findValue_costo.sconto2</span>
	                <span class="iwebPARAMETRO">@id = popupTabellaRigheScaricateModifica_findValue_costo.id</span>
                </span>
                <%-- la seconda query dovrebbe aggiornare i prezzi in caso di checkbox spuntato --%>
                <span class="iwebSQLQUERY2Modifica iwebNascosto">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE prodotto SET listino = @listino, sconto1 = @sconto1, sconto2 = @sconto2 WHERE id = @idprodotto")%></span>
	                <span class="iwebPARAMETRO">@listino = popupTabellaRigheScaricateModifica_findValue_costo.prezzo</span>
	                <span class="iwebPARAMETRO">@sconto1 = popupTabellaRigheScaricateModifica_findValue_costo.sconto1</span>
	                <span class="iwebPARAMETRO">@sconto2 = popupTabellaRigheScaricateModifica_findValue_costo.sconto2</span>
                    <span class="iwebPARAMETRO">@idprodotto = iwebAUTOCOMPLETAMENTOmodificaProdotto_getChiave</span>
                </span>
                <%-- la terza query associa al prodotto selezionato, l'idfornitore presente in pagina --%>
                <span class="iwebSQLQUERY3Modifica iwebNascosto">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE prodotto SET idfornitore = @idfornitore WHERE id = @idprodotto")%></span>
                    <span class="iwebPARAMETRO">@idfornitore = tabellaBolle_findfirstvalue_fornitore.id</span>
                    <span class="iwebPARAMETRO">@idprodotto = iwebAUTOCOMPLETAMENTOmodificaProdotto_getChiave</span>
                </span>
                <%-- quarta query: query di fix. --%>
                <span class="iwebSQLQUERY4Modifica iwebNascosto">
                    <%-- SELECT costo.id as 'costo.id', costo.idcantiere as 'costo.idcantiere' FROM costo WHERE costo.idcostobollariferita = 1082 --%>
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                        "UPDATE costo SET idcantiere = @idcantiere WHERE costo.idcostobollariferita = @idcosto"
                    )%></span>
                    <span class="iwebPARAMETRO">@idcantiere = iwebAUTOCOMPLETAMENTOmodificaCantiere_getChiave</span>
	                <span class="iwebPARAMETRO">@idcosto = popupTabellaRigheScaricateModifica_findValue_costo.id</span>
                </span>
                <%-- Query di fix:
SELECT costo INNER JOIN 
(SELECT costoinfattura.id as 'idcostoinfattura', costo.idcantiere as 'idcantiere'
FROM costo INNER JOIN costo as costoinfattura ON costoinfattura.idcostobollariferita = costo.id 
WHERE costo.idbollafattura AND costo.idcantiere <> costoinfattura.idcantiere) as 'costoinfattura' 
ON costo.idcostobollariferita = costoinfattura.idcantiere

--%>
            </div>
        </div>
    </div>

    <script>
        function funzionepopupTabellaRigheScaricateElimina() {
            iwebCaricaElemento("iwebLabelEliminazione", true, function () {
                var isCostoChiuso = "1" == document.getElementById("iwebLabelEliminazione").getElementsByTagName("span")[0].innerHTML;
                console.log(isCostoChiuso)
                if (isCostoChiuso) {
                    // se il costo è stato chiuso non è possibile la cancellazione perchè resterebbe il record collegato zombie
                    document.getElementById("eliminazioneNonPossibile").className = "errore";
                    document.getElementById("bottoneEliminaPopupTabellaRigheScaricateElimina").className = "btn btn-danger disabled";
                    iwebCaricaElemento("iwebLabelGetNumeroFatturaAssociata");
                } else {
                    document.getElementById("eliminazioneNonPossibile").className = "iwebNascosto errore";
                    document.getElementById("bottoneEliminaPopupTabellaRigheScaricateElimina").className = "btn btn-danger";
                }
            });
        }
    </script>
    <div id="popupTabellaRigheScaricateElimina" class="popup popupType2 iwebfunzione_funzionepopupTabellaRigheScaricateElimina" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Eliminazione riga, ricontrolla i dati</div>
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
                    <tr class="iwebNascosto">
                        <td>record associati</td>
                        <td>
                            <span class="iwebLABEL" id="iwebLabelEliminazione">
                                <span><%-- il risultato va qui --%></span>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                        "SELECT COUNT(*) as VALORE FROM costo "
                                      + "WHERE costo.idcostobollariferita = @idcosto"
                                    ) %></span>
	                                <span class="iwebPARAMETRO">@idcosto = popupTabellaRigheScaricateElimina_findValue_costo.id</span>
                                </span>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td>Cantiere</td>
                        <td><span class="iwebCAMPO_cantiere.codice"></span></td>
                    </tr>
                    <tr>
                        <td>Cliente</td>
                        <td><span class="iwebCAMPO_cliente.nominativo"></span></td>
                    </tr>
                    <tr>
                        <td>Prodotto</td>
                        <td><span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span></td>
                    </tr>
                    <tr>
                        <td>Quantita</td>
                        <td><span class="iwebCAMPO_costo.quantita iwebValuta"></span></td>
                    </tr>
                    <tr>
                        <td>Descrizione</td>
                        <td><span class="iwebCAMPO_costo.descrizione iwebDescrizione"></span></td>
                    </tr>
                    <tr>
                        <td>Prezzo</td>
                        <td><span class="iwebCAMPO_costo.prezzo iwebQuantita"></span></td>
                    </tr>
                    <tr>
                        <td>Sconto 1</td>
                        <td><span class="iwebCAMPO_costo.sconto1 iwebQuantita"></span></td>
                    </tr>
                    <tr>
                        <td>Sconto 2</td>
                        <td><span class="iwebCAMPO_costo.sconto2 iwebQuantita"></span></td>
                    </tr>
                    <tr>
                        <td>Totale</td>
                        <td><span class="iwebCAMPO_totale iwebValuta"></span></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <span id="eliminazioneNonPossibile" class="iwebNascosto errore">Eliminazione non possibile. C'è un costo collegato alla fattura:</span>
                            <span class="iwebLABEL" id="iwebLabelGetNumeroFatturaAssociata">
                                <span class="errore"><%-- il risultato va qui --%></span>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                        "SELECT bollafattura.numero as VALORE "
                                      + "FROM costo LEFT JOIN costo as costofattura ON costo.idcostobollariferita = costofattura.id "
                                      + "           LEFT JOIN bollafattura ON costo.idbollafattura = bollafattura.id "
                                      + "WHERE costo.idcostobollariferita = @id"
                                    ) %></span>
	                                <span class="iwebPARAMETRO">@id = popupTabellaRigheScaricateElimina_findValue_costo.id</span>
                                </span>
                            </span>
                        </td>
                    </tr>
<%--                    <tr>
                        <td style="vertical-align:top">Costi collegati:</td>
                        <td>
                            <gestionefatture:costicollegati runat="server" />
                            <div class="b"></div>
                            <div id="messaggioErroreSeTabellaCostiCollegatiHaRighe">Attenzione! L'eliminazione di una fattura cancella anche tutti i costi collegati.</div>
                        </td>
                    </tr>--%>

                    <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                </table>
            </div>

            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div id="bottoneEliminaPopupTabellaRigheScaricateElimina" class="btn btn-danger" 
                    onclick="scaricobolla_eliminaRigaCosto();">Elimina</div>
                <span class="iwebSQLQUERY1Elimina iwebNascosto">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                        "DELETE FROM costo WHERE id = @id"
                    )%></span>
	                <span class="iwebPARAMETRO">@id = popupTabellaRigheScaricateElimina_findValue_costo.id</span>
                </span>
                <%-- in cascata, un eliminazione si porta dietro i costi collegati 
                <div class="btn btn-danger" onclick="
                    iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaFattureElimina', 'tabellaFatture', true);
                    iwebEseguiQuery('eliminazioneBolla_iwebSQLDELETE_eliminacosti');
                ">Elimina</div>
                <span class="iwebSQLDELETE">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM bollafattura WHERE id = @id") %></span>
                    <span class="iwebPARAMETRO">@id = tabellaFatture_selectedValue_bollafattura.id</span>
                </span>
                <span id="eliminazioneBolla_iwebSQLDELETE_eliminacosti" class="iwebNascosto">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                        "DELETE costo "
                        + "FROM costo  "
                        + "WHERE costo.idbollafattura = @idbollafattura "
                    ) %></span>
                    <span class="iwebPARAMETRO">@idbollafattura = tabellaFatture_selectedValue_bollafattura.id</span>
                </span>--%>
            </div>
        </div>
    </div>

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaBolle", true, function () {
                /*if (iwebValutaParametroAjax("tabellaBolle_findfirstvalue_bollafattura.chiusa"))
                    document.getElementById("nascondiSeBollaChiusa").className = "iwebNascosto";
                else
                    document.getElementById("nascondiSeBollaAperta").className = "iwebNascosto";*/

                iwebCaricaElemento("tabellaRigheScaricate");
                iwebCaricaElemento("tabellaRigheScaricateDDLCantiere");
                iwebCaricaElemento("tabellaRigheScaricateDDLCliente");
            });

            // IL CODICE QUA SOTTO FA SI CHE GLI ELEMENTI CON TABINDEX=1 SI ALTERNINO DAL PRIMO ALL'ULTIMO E SUBITO DOPO DI NUOVO IL PRIMO A ROTAZIONE
            // funzione che mi ritorna tutti gli elementi con tabIndex == 1
            var allElements = document.getElementsByTagName("*");
            var arr = Array.prototype.slice.call(allElements, 0);
            arr = arr.map(function (o) {
                return o.tabIndex === 1 ? o : null;
            }).filter(function (o) {
                return o != null
            });

            // HO SCELTO IL SECONDO ELEMENTO PER 2 MOTIVI: 1) SE TORNO SOPRA A CANTIERE PERDE IL SUO VALORE DI ID PERCHE' CONTIENE NON SOLO IL CODICE CANTIERE MA ANCHE ALTRI DATI. RIFACENDO LA QUERY CON QUESTA STRINGA LA QUERY MI TORNA 0 RECORD
            // SECONDO MOTIVO: CANTIERE NON LO AZZERO, QUINDI NON HA SENSO TORNARE LA SOPRA
            // funzione che: al tab dell'ultimo elemento con tabindex = 1, mi riporta al secondo elemento con tabindex = 1
            addEvent(arr[arr.length - 1], 'keydown', function (event) { if (event.which == 9 || event.keyCode == 9) setTimeout(function(){arr[1].focus()}, 10) });
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

