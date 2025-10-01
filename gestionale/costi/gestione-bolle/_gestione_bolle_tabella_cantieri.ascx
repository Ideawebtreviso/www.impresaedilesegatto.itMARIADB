<%@ Control Language="C#" ClassName="_gestione_bolle_tabella_cantieri" %>


                <table id="tabellaCantieri" class="iwebTABELLA iwebCHIAVE__cantiere.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="iwebNascosto commandHead">
                                <%--<input type="button" value="Aggiungi" onclick="apriPopupType2('popupTabellaCantieriInserimento');" />--%>
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                                    onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaCantieriInserimento');"></div>
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th>Cliente</th>
                            <th>Codice</th>
                            <th>Descrizione</th>
                        </tr>
                        <tr class="iwebNascosto">
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th class="iwebNascosto"><%-- AZIONI --%>
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
                            <td class="iwebNascosto">
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaCantieriModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');"></div>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');"></div>--%>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_cantiere.id"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cliente.nominativo"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cantiere.descrizione iwebDescrizione"></span>
                            </td>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                        <%-- eventualmente va messo display:none --%>
                        <tr class="iwebNascosto">
                            <td class="iwebNascosto"></td>
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
                        "SELECT cantiere.id as 'cantiere.id', "
                      + "cantiere.codice as 'cantiere.codice', "
                      + "cantiere.descrizione as 'cantiere.descrizione', "
                      + "cliente.nominativo as 'cliente.nominativo' "
                      + "FROM costo LEFT JOIN cantiere ON costo.idcantiere = cantiere.id "
                      + "           LEFT JOIN cliente ON cantiere.idcliente = cliente.id "
                      + "WHERE idbollafattura = @idbollafattura "
                      + "GROUP BY cantiere.id") %></span>
                    <span class="iwebPARAMETRO">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
                </span>
