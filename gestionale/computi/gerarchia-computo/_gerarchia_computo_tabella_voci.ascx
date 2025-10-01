<%@ Control Language="C#" ClassName="_gerarchia_computo_tabella_voci" %>


    <div id="popupVociAssociate" class="popup popupType2" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Voci associate alla suddivisione selezionata</div>
                <div class="b"></div>
            </div>
            <div class="iwebTABELLA_ContenitoreParametri"></div>
            <div class="popupCorpo">
                <span id="idsuddivisione" class="idsuddivisione iwebNascosto">0</span>
                <span id="nomesuddivisione"></span>

                <table id="tabellaVoci" class="iwebTABELLA iwebCHIAVE__id">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="commandHead iwebNascosto">
                                <%--<input type="button" value="Aggiungi" onclick="apriPopupType2('popupTabellaClientiInserimento');" />--%>
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" onclick="apriPopupType2_bind('popupTabellaClientiInserimento', true);"></div>
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th>Sposta</th>
                            <th>Codice</th>
                            <th>Titolo</th>
                            <th>Descrizione</th>
                        </tr>
                        <tr>
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th class="iwebNascosto"><%-- AZIONI --%></th>
                            <th></th>
                            <th></th>
                            <th>
                                <%-- filtro di testo sul campo titolo --%>
                                <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_titolo">
                                    <input type="text" onkeypress="iwebTABELLA_VerificaAutocompletamento()"/>
                                </div>
                            </th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td class="iwebNascosto">
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaClientiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');"></div>--%>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');"></div>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_id"></span>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_idvoceorigine"></span>
                            </td>
                            <td>
                                <div class="contenitoreFreccePosizione">
                                    <span class="glyphicon glyphicon-chevron-up l iwebCliccabile" onclick="onclick_spostaVoceSopra()"></span>
                                    <span class="glyphicon glyphicon-chevron-down r iwebCliccabile" onclick="onclick_spostaVoceSotto()"></span>
                                    <span class="b"></span>
                                </div>
                            </td>
                            <td>
                                <span class="iwebCAMPO_codice"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_titolo"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_descrizione iwebDescrizione"></span>
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
                        </tr>
                        <tr><td><div class="iwebTABELLAFooterPaginazione">
                            <div>Pagina</div>
                            <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                            <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                            <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                            <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                            <div class="iwebPAGESIZE"><select id="Select1bdfibdf7" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                            <div class="iwebTOTRECORD">Trovate 0 righe</div>
                        </div></td></tr>
                    </tfoot>
                </table>
                <span class="iwebSQLSELECT">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT * FROM voce WHERE idsuddivisione = @idsuddivisione ORDER BY posizione") %></span>
	                <span class="iwebPARAMETRO">@idsuddivisione = idsuddivisione_value</span>
                </span>

            </div>
            <div class="popupFooter">
                <%--<div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-danger" onclick="
                                                    // chiudi e nascondi il popup
                                                    var popupAssociato = document.getElementById('popupVociAssociate');
                                                    popupAssociato.className = 'popup popupType2 chiudiPopup';
                                                    setTimeout(function () { popupAssociato.style.display = 'none' }, 480);
                                            ">Chiudi</div>--%>
                <div class="btn btn-info" onclick="chiudiPopupType2()" >Chiudi</div>
            </div>
        </div>
    </div>
