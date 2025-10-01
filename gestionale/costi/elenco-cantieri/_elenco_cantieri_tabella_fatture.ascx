<%@ Control Language="C#" ClassName="_elenco_cantieri_tabella_fatture" %>


                <table id="tabellaFatture" class="iwebTABELLA iwebCHIAVE__bollafattura.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="commandHead iwebNascosto">
                                <%--<input type="button" value="Aggiungi" onclick="apriPopupType2('popupTabellaBolleInserimento');" />--%>
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                                    onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaBolleInserimento');"></div>
                            </th>
                            <th class="iwebNascosto"></th>
                            <th class="iwebNascosto">ID</th>
                            <th>Fattura acc.</th>
                            <th>Numero</th>
                            <th>Data</th>
                            <th><div class="l">Fornitore</div>
                                <div>
                                    <span class="iwebFILTROOrdinamento iwebSORT_fornitore.ragionesociale_ASC glyphicon glyphicon-sort-by-alphabet r" 
                                    onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                                </div>
                                <div class="b"></div>
                            </th>
                            <th>Importo Testata</th>
                            <th>Importo Costi sul cantiere</th>
                        </tr>
                        <tr>
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th class="iwebNascosto"><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
                            <th></th>
                            <th>
                                <%-- filtro di testo sul campo nominativo --%>
                                <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_bollafattura.numero">
                                    <input class="largNumero" type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                                </div>
                            </th>
                            <th>
                                <%--maggiore uguale di--%>
                                <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_bollafattura.databollafattura">
                                    <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" 
                                        onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                        onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                </div>
                                <%--minore di--%>
                                <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_bollafattura.databollafattura">
                                    <%--<input type="text" placeholder="A" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>--%>
                                    <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" 
                                        onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                        onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                </div>
                                <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                </div>
                            </th>
                            <th>
                                <%-- filtro di testo sul campo telefono --%>
                                <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_fornitore.ragionesociale">
                                    <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                                </div>
                            </th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td class="iwebNascosto">
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaBolleModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');"></div>--%>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');"></div>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_bollafattura.id"></span>
                            </td>
                            <td>
                                <input type="checkbox" class="iwebCAMPO_bollafattura.isddt iwebCheckbox" disabled />
                            </td>
                            <td>
                                <span class="iwebCAMPO_bollafattura.numero iwebCodice"></span>
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
                                <span class="iwebCAMPO_sommaPrezziCantiere iwebValuta"></span>
                            </td>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE, iwebTOTRECORD sono di riferimento al js --%>
                        <%-- eventualmente va messo display:none --%>
                        <tr>
                            <td class="iwebNascosto"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><b class="r">Totale</b></td>
                            <td>
                                <span id="Span3" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">bollafattura.importo</span>
                            </td>
                            <td>
                                <span id="Span4" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">costo.prezzo</span>
                            </td>
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
                         "SELECT bollafattura.id as 'bollafattura.id', "
                       + "       bollafattura.numero as 'bollafattura.numero', "
                       + "       bollafattura.databollafattura as 'bollafattura.databollafattura', "
                       + "       bollafattura.isddt as 'bollafattura.isddt', "
                       + "       bollafattura.importo as 'bollafattura.importo', "
                       + "       fornitore.id as 'fornitore.id', "
                       + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "
                       + "       costo.id as 'costo.id', "
                       + "       SUM(costo.prezzo) as 'sommaPrezziCantiere' "
                       + "FROM (bollafattura LEFT JOIN fornitore ON bollafattura.idfornitore = fornitore.id) "
                       + "                   LEFT JOIN costo ON bollafattura.id = costo.idbollafattura "
                       + "WHERE bollafattura.isfattura = true AND costo.idcantiere = @idcantiere AND fornitore.tipofornitore = 'Materiale' "
                       + "GROUP BY bollafattura.numero" 
                       )%></span>
                                           <%--+ "       SUM(prodotto.listino) as 'importoTestata' "--%>

                       <%--+ "   IF (bollafattura.isfattura, COUNT(costo.id), COUNT(righeverificate.id)) as 'numeroRigheVerificate' "--%> 
                    <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span>
                </span>

