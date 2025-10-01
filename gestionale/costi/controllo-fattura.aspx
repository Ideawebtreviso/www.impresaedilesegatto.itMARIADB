<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="controllo-fattura.aspx.cs" Inherits="gestionale_costi_controllo_fattura" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="controllo-fattura.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDFATTURA" class="iwebNascosto"><asp:Literal ID="LiteralIDFATTURA" runat="server"></asp:Literal></span>
    <div class="TitoloPagina">
        Controllo fattura
    </div><br />

    <table id="tabellaFatture" class="iwebTABELLA iwebCHIAVE__bollafattura.id">
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
                <th>Tipo</th>
            </tr>
            <%-- filtri --%>
            <tr class="iwebNascosto">
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
                    <span class="iwebCAMPO_bollafattura.id iwebNascosto"></span>
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
                    <span>Fattura</span>
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
          + "       bollafattura.importo as 'bollafattura.importo' "
          + "FROM bollafattura INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
          + "WHERE bollafattura.id = @idfattura") %></span>
	    <span class="iwebPARAMETRO">@idfattura = IDFATTURA_value</span>
    </span>

    <div class="TitoloPagina">
        Bolle aperte
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
        <table id="tabellaBolleAperte" class="iwebTABELLA iwebCHIAVE__bollafattura.id iwebBIND__elementoConITab">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <th>Numero</th>
                    <th>Data</th>
                    <th><div class="l">Fornitore</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_fornitore.ragionesociale_ASC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div></th>
                    <th>Chiusa</th>
                    <th>Importo</th>
                    <th>Righe aperte</th>
                    <th>Scansione</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%>
                    </th>
                    <th class="iwebNascosto"></th>
                    <th>
                        <%-- filtro di testo sul campo numero --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_bollafattura.numero">
                            <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                        </div>
                    </th>
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
                    <th></th>
                    <th></th>
                    <th></th>
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
                        <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaClientiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');"></div>--%>
                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolleAperte');"></div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_bollafattura.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.numero iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.databollafattura iwebData"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione iwebTroncaCrtsAt_15"></span>
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_bollafattura.chiusa iwebCheckbox" />
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.importo iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_numeroRigheVerificate"></span> /
                        <span class="iwebCAMPO_numeroRighe"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.scansione"></span>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolleAperte');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaClientiElimina')"></div>
                        <%--<input type="button" value="Elimina" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');
                                                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaClientiElimina')" />--%>
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
                    <td><b class="r">Totale</b></td>
                    <td>
                        <span id="Span1" class="iwebTOTALE iwebQuantita"></span>
                        <span class="iwebSQLTOTAL">bollafattura.id</span>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
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
                    <div class="iwebPAGESIZE"><select id="Select2" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
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
              + "       COUNT(costo.id) as 'numeroRighe', "
              + "       COUNT(righeverificate.id) as 'numeroRigheVerificate' "
              + "FROM bollafattura INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
              + "                   LEFT JOIN costo ON bollafattura.id = costo.idbollafattura "
              + "                   LEFT JOIN costo as righeverificate ON righeverificate.idcostobollariferita = costo.id "
              + "WHERE bollafattura.idfornitore = @idfornitore AND bollafattura.isddt = true AND bollafattura.chiusa = false "
              + "GROUP BY bollafattura.id" 
            ) %></span>
            <span class="iwebPARAMETRO">@idfornitore = tabellaFatture_findFirstValue_fornitore.id</span>
        </span>
    </div>

    <%-- elemento con i tab a destra --%>
    <div id="elementoConITab" class="iwebTABPADRE width610 r">
        <div class="headerTab"></div>
        <div class="corpoTab">
            <div class="iwebTABFIGLIO Tab_1 selectedTab iwebBIND__tabellaRigheAperte iwebTABNOMEHEAD_Righe_aperte">
                Righe aperte della bolla selezionata
                <div class="btn btn-default r" onclick="controlloFattura_inserisciCosto()">Salva</div><br /><br />
                <%-- inserimento --%>
                <span id="iwebSQLINSERISCICOSTO" class="iwebNascosto"><%= IwebCrypter.iwebcsCriptaSQL(
                    "INSERT INTO costo (idbollafattura, idprodotto, idcantiere, idcostobollariferita, quantita, prezzo, sconto1, sconto2)"
                    + "       VALUES (@idbollafattura, @idprodotto, @idcantiere, @idcostobollariferita, @quantita, @prezzo, @sconto1, @sconto2)"
                ) %></span>
                <span id="iwebSQLAGGIORNADATOPRODOTTO" class="iwebNascosto"><%= IwebCrypter.iwebcsCriptaSQL(
                    "UPDATE prodotto SET listino = @prezzo, sconto1 = @sconto1, sconto2 = @sconto2 WHERE id = @idprodotto"
                ) %></span>

                <table id="tabellaRigheAperte" class="iwebTABELLA iwebCHIAVE__costo.id">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="commandHead iwebNascosto">
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th>Cantiere</th>
                            <th>Cliente</th>
                            <th>Prodotto</th>
                            <th>Qta bolla</th>
                            <th>Prezzo bolla</th>
                            <th>Sconto 1 bolla</th>
                            <th>Sconto 2 bolla</th>
                            <th>Qta fattura</th>
                            <th>Prezzo fattura</th>
                            <th>Sconto 1 fattura</th>
                            <th>Sconto 2 fattura</th>
                            <th>Aggiorna dato prodotto</th>
                        </tr>
                        <tr class="iwebNascosto">
                            <th></th><%-- CHECKBOX --%>
                            <th><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
                            <th class="iwebNascosto"></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td class="iwebNascosto">
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaClientiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');"></div>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaRigheAperte');"></div>--%>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_costo.id"></span>
                                <span class="iwebCAMPO_costo.idbollafattura iwebNascosto"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                                <span class="iwebCAMPO_costo.idcantiere iwebNascosto"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cliente.nominativo iwebDescrizione iwebTroncaCrtsAt_30"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione iwebTroncaCrtsAt_30"></span>
                                <span class="iwebCAMPO_costo.idprodotto iwebNascosto"></span>
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
                            <td>
                                <input type="text" class="iwebCAMPO_costoinfattura.quantita" placeholder="quantita" />
                            </td>
                            <td>
                                <input type="text" class="iwebCAMPO_costoinfattura.prezzo" placeholder="prezzo" />
                            </td>
                            <td>
                                <input type="text" class="iwebCAMPO_costoinfattura.sconto1" placeholder="sconto1" />
                            </td>
                            <td>
                                <input type="text" class="iwebCAMPO_costoinfattura.sconto2" placeholder="sconto2" />
                            </td>
                            <td>
                                <input type="checkbox" class="iwebCheckbox cbAggiornaDatoProdotto" />
                            </td>
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
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
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
                            <div class="iwebPAGESIZE"><select id="Select3" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                            <div class="iwebTOTRECORD">Trovate 0 righe</div>
                        </div></td></tr>
                    </tfoot>
                </table>
                <span class="iwebSQLSELECT">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                        "SELECT costo.id as 'costo.id', costo.idbollafattura as 'costo.idbollafattura', costo.idprodotto as 'costo.idprodotto', costo.idcantiere as 'costo.idcantiere', "
                        + "       costo.quantita as 'costo.quantita', costo.prezzo as 'costo.prezzo', costo.sconto1 as 'costo.sconto1', costo.sconto2 as 'costo.sconto2', "
                        + "       cantiere.codice as 'cantiere.codice', cliente.nominativo as 'cliente.nominativo', "
                        + "       prodotto.descrizione as 'prodotto.descrizione' "
                        + ""
                        + "FROM (((costo LEFT JOIN cantiere ON costo.idcantiere = cantiere.id) "
                        + "              LEFT JOIN cliente ON cantiere.idcliente = cliente.id) "
                        + "              LEFT JOIN prodotto ON costo.idprodotto = prodotto.id) "
                        + "              LEFT JOIN costo as costoinfattura ON costoinfattura.idcostobollariferita = costo.id "
                        + "WHERE costo.idbollafattura = @idbollafattura AND "
                        + "      costoinfattura.id is null "
                    ) %></span>
                    <span class="iwebPARAMETRO">@idbollafattura = tabellaBolleAperte_selectedValue_bollafattura.id</span>
                </span>
            </div><%-- fine tab 1 --%>


            <div class="iwebTABFIGLIO Tab_2 iwebBIND__tabellaRigheChiuse iwebTABNOMEHEAD_Righe_chiuse">

                <table id="tabellaRigheChiuse" class="iwebTABELLA iwebCHIAVE__costo.id">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="commandHead iwebNascosto">
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th>Cantiere</th>
                            <th>Cliente</th>
                            <th>Prodotto</th>
                            <th>Qta bolla</th>
                            <th>Prezzo bolla</th>
                            <th>Sconto 1 bolla</th>
                            <th>Sconto 2 bolla</th>
                            <th>Qta fattura</th>
                            <th>Prezzo fattura</th>
                            <th>Sconto 1 fattura</th>
                            <th>Sconto 2 fattura</th>
                        </tr>
                        <tr class="iwebNascosto">
                            <th></th><%-- CHECKBOX --%>
                            <th><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
                            <th class="iwebNascosto"></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td class="iwebNascosto">
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaClientiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');"></div>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaRigheAperte');"></div>--%>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_costo.id"></span>
                                <span class="iwebCAMPO_costo.idbollafattura iwebNascosto"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                                <span class="iwebCAMPO_costo.idcantiere iwebNascosto"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cliente.nominativo iwebDescrizione iwebTroncaCrtsAt_30"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione iwebTroncaCrtsAt_30"></span>
                                <span class="iwebCAMPO_costo.idprodotto iwebNascosto"></span>
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
                            <td>
                                <span class="iwebCAMPO_costoinfattura.quantita iwebQuantita"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costoinfattura.prezzo iwebValuta"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costoinfattura.sconto1 iwebValuta"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costoinfattura.sconto2 iwebValuta"></span>
                            </td>
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
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
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
                            <div class="iwebPAGESIZE"><select id="Select4" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                            <div class="iwebTOTRECORD">Trovate 0 righe</div>
                        </div></td></tr>
                    </tfoot>
                </table>
                <span class="iwebSQLSELECT">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                        "SELECT costo.id as 'costo.id', costo.idbollafattura as 'costo.idbollafattura', costo.idprodotto as 'costo.idprodotto', costo.idcantiere as 'costo.idcantiere', "
                        + "       costo.quantita as 'costo.quantita', costo.prezzo as 'costo.prezzo', costo.sconto1 as 'costo.sconto1', costo.sconto2 as 'costo.sconto2', "
                        + "       cantiere.codice as 'cantiere.codice', cliente.nominativo as 'cliente.nominativo', "
                        + "       prodotto.descrizione as 'prodotto.descrizione', "
                        + "       costoinfattura.quantita as 'costoinfattura.quantita', costoinfattura.prezzo as 'costoinfattura.prezzo', costoinfattura.sconto1 as 'costoinfattura.sconto1', costoinfattura.sconto2 as 'costoinfattura.sconto2' "
                        + ""
                        + "FROM (((costo LEFT JOIN cantiere ON costo.idcantiere = cantiere.id) "
                        + "              LEFT JOIN cliente ON cantiere.idcliente = cliente.id) "
                        + "              LEFT JOIN prodotto ON costo.idprodotto = prodotto.id) "
                        + "              LEFT JOIN costo as costoinfattura ON costoinfattura.idcostobollariferita = costo.id "
                        + "WHERE costo.idbollafattura = @idbollafattura AND "
                        + "      costoinfattura.id is not null "
                    ) %></span>
                    <span class="iwebPARAMETRO">@idbollafattura = tabellaBolleAperte_selectedValue_bollafattura.id</span>
                </span>

            </div><%-- fine tab 2 --%>
        </div>
    </div>

    <script>
        function pageload() {
            //iwebCaricaElemento("tabellaFatture");
            //iwebCaricaElemento("tabellaBolleAperte");
            controlloFattura_iwebTABELLA_Carica("tabellaFatture", 0, true);

            iwebCaricaElemento("elementoConITab");
        }
    </script>
</asp:Content>

