<%@ Control Language="C#" ClassName="_anagrafica_fornitori_tabella_prodotti" %>

                <table id="tabellaProdotti" class="iwebTABELLA iwebCHIAVE__prodotto.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <%--<th class="commandHead">
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" onclick="apriPopupType2_bind('popupTabellaProdottiInserimento', true);"></div>
                            </th>--%>
                            <th class="iwebNascosto">ID</th>
                            <th><div class="l">Codice prodotto</div>
                                <div>
                                    <span class="iwebFILTROOrdinamento iwebSORT_prodotto.codice_ASC glyphicon glyphicon-sort-by-alphabet r" 
                                    onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                                </div>
                                <div class="b"></div>
                            </th>
                            <th>Descrizione prodotto</th>
                            <th>Listino prodotto</th>
                            <th>Unita' di misura</th>
                        </tr>
                        <tr>
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <%--<th> AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
                            <th>
                                <%-- filtro di testo sul campo nominativo --%>
                                <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.codice">
                                    <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                                </div>
                            </th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <%--<td>
                                <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaProdottiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaProdotti');"></div>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaProdotti');"></div>
                            </td>--%>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_prodotto.id"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_prodotto.codice iwebCodice"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione iwebTroncaCrtsAt_30"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_prodotto.listino iwebValuta"></span>
                            </td>
                            <%--<td>
                                <span class="iwebCAMPO_categoriaprodotto.descrizione iwebDescrizione iwebTroncaCrtsAt_30"></span>
                            </td>--%>
                            <td>
                                <span class="iwebCAMPO_unitadimisura.codice iwebCodice"></span>
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
                                        "SELECT prodotto.id as 'prodotto.id',  "
                                        + "     prodotto.codice as 'prodotto.codice',  "
                                        + "     prodotto.descrizione as 'prodotto.descrizione', "
                                        + "     prodotto.listino as 'prodotto.listino', "
                                        + "     categoriaprodotto.descrizione as 'categoriaprodotto.descrizione', "
                                        + "     unitadimisura.codice as 'unitadimisura.codice' "
                                        + "FROM prodotto LEFT JOIN categoriaprodotto ON prodotto.idcategoria = categoriaprodotto.id "
                                        + "              LEFT JOIN unitadimisura ON prodotto.idunitadimisura = unitadimisura.id"
                                        + "WHERE prodotto.idfornitore = @idfornitore") %></span>
                    <span class="iwebPARAMETRO">@idfornitore = tabellaFornitori_selectedValue_fornitore.id</span>
                </span>
