<%@ Control Language="C#" ClassName="_gestione_bolle_tabella_costi" %>


                <table id="tabellaCosti" class="iwebTABELLA iwebCHIAVE__costo.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="iwebNascosto commandHead">
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                                    onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaCostiInserimento');"></div>
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th>Prodotto</th>
                            <th>Qta cons</th>
                            <th>Prezzo cons</th>
                            <th>Num fatt</th>
                            <th>Data fatt</th>
                            <th>Qta fatt</th>
                            <th>Prezzo fatt</th>
                            <th></th><%-- ALTRO --%>
                        </tr>
                        <tr>
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th class="iwebNascosto"><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
                            <th>
                                <%-- filtro di testo sul campo prodotto.descrizione --%>
                                <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.descrizione">
                                    <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                                </div>
                            </th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th>
                                <%--maggiore uguale di--%>
                                <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_fatturacontrollata.databollafattura">
                                    <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" 
                                        onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                        onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                </div>
                                <%--minore di--%>
                                <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_data_creazione">
                                    <%--<input type="text" placeholder="A" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>--%>
                                    <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" 
                                        onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                        onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
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
                            <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td class="iwebNascosto">
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaCostiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');"></div>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');"></div>--%>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_costo.id"></span>
                                <%--  lo uso per bloccare l'eliminazione nel popup se questo campo è valorizzato --%>
                                <span class="iwebCAMPO_costobollafatturariferita.id"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.quantita iwebQuantita"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_fatturacontrollata.numero iwebCodice"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_fatturacontrollata.databollafattura iwebData"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costobollafatturariferita.quantita iwebQuantita"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costobollafatturariferita.prezzo iwebValuta"></span>
                            </td>
                            <td>
                                <%-- iwebBind('tabellaCosti'); --%>
                                <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                     onclick="iwebTABELLA_SelezionaRigaComeUnica(); 
                                              iwebTABELLA_EliminaRigaInPopup('popupTabellaCostiElimina')"></div>
                                <%--<input type="button" value="Elimina" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');
                                                                                iwebTABELLA_EliminaRigaInPopup('popupTabellaCostiElimina')" />--%>
                            </td><%-- ALTRO --%>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                        <%-- eventualmente va messo display:none --%>
                        <tr>
                            <td class="iwebNascosto"></td>
                            <td class="iwebNascosto"></td>
                            <td></td>
                            <td>Tot</td>
                            <td class="iwebValuta_tdPadre">
                                <span id="SpanTotalePrezzoCons" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">costo.prezzo</span>
	                            <span class="iwebPARAMETRO iwebNascosto">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
                            </td>
                            <td></td>
                            <td></td>
                            <td>
                                <span id="SpanTotaleQtaFatt" class="iwebTOTALE"></span>
                                <span class="iwebSQLTOTAL">costobollafatturariferita.quantita</span>
	                            <span class="iwebPARAMETRO iwebNascosto">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
                            </td>
                            <td class="iwebValuta_tdPadre">
                                <span id="Span1" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">costobollafatturariferita.prezzo</span>
	                            <span class="iwebPARAMETRO iwebNascosto">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
                            </td>
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
                        "SELECT costo.id as 'costo.id', "
                      + "       prodotto.descrizione as 'prodotto.descrizione', "
                      + "       costo.quantita as 'costo.quantita', "
                      + "       costo.prezzo as 'costo.prezzo', "
                      + "       fatturacontrollata.numero as 'fatturacontrollata.numero', "
                      + "       fatturacontrollata.databollafattura as 'fatturacontrollata.databollafattura', "
                      + "       costobollafatturariferita.id as 'costobollafatturariferita.id', "
                      + "       costobollafatturariferita.quantita as 'costobollafatturariferita.quantita', "
                      + "       costobollafatturariferita.prezzo as 'costobollafatturariferita.prezzo' "
                      + "FROM ((costo LEFT JOIN costo as costobollafatturariferita ON costobollafatturariferita.idcostobollariferita = costo.id) "
                      + "             LEFT JOIN prodotto ON costo.idprodotto = prodotto.id) "
                      + "             LEFT JOIN bollafattura as fatturacontrollata ON costobollafatturariferita.idbollafattura = fatturacontrollata.id "
                      + "WHERE costo.idbollafattura = @idbollafattura"
                      + "ORDER BY costo.id "
                    ) %></span>
                    <span class="iwebPARAMETRO">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
                </span>

                <%-- elimina --%>
                <script>
                    function funzionePopupTabellaCostiElimina() {
                        var bottoneElimina = document.getElementById("popupTabellaCostiElimina_BottoneElimina");
                        var elementoMessaggioErrore = document.getElementById("messaggioErroreSeTabellaCostiCollegatiHaRighe");

                        var idcostobollafatturariferita = iwebValutaParametroAjax("tabellaCosti_selectedValue_costobollafatturariferita.id");

                        if (idcostobollafatturariferita == "") {
                            bottoneElimina.removeAttribute("disabled");
                            aggiungiClasseAElemento(elementoMessaggioErrore, "iwebNascosto");
                        } else {
                            bottoneElimina.setAttribute("disabled", "disabled");
                            rimuoviClasseDaElemento(elementoMessaggioErrore, "iwebNascosto");
                        }
                    }
                </script>
                <div id="popupTabellaCostiElimina" class="popup popupType2 iwebfunzione_funzionePopupTabellaCostiElimina" style="display:none">
                    <div>
                        <div class="popupHeader">
                            <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                            <div class="popupTitolo l">Eliminazione costo bolla, ricontrolla i dati</div>
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
                                    <td>Prodotto</td>
                                    <td>
                                        <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Qta consegna</td>
                                    <td>
                                        <span class="iwebCAMPO_costo.quantita iwebQuantita"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Prezzo consegna</td>
                                    <td>
                                        <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Num fattura</td>
                                    <td>
                                        <span class="iwebCAMPO_fatturacontrollata.numero iwebCodice"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Data fattura</td>
                                    <td>
                                        <span class="iwebCAMPO_fatturacontrollata.databollafattura iwebData"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Qta fattura</td>
                                    <td>
                                        <span class="iwebCAMPO_costobollafatturariferita.quantita iwebCodice"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Prezzo fattura</td>
                                    <td>
                                        <span class="iwebCAMPO_costobollafatturariferita.prezzo iwebValuta"></span>
                                    </td>
                                </tr>
                                <%-- se voglio aggiungere un campo ho necessità di averlo in tabella  --%>
                            </table>
                                    <%--<td style="vertical-align:top">Costi fattura collegati:</td>--%>
                                    <div id="messaggioErroreSeTabellaCostiCollegatiHaRighe" class="l">
                                        <span class="errore">Cancellazione non possibile finchè ci sono costi collegati a una o più fatture.</span>
                                    </div>
                            <div class="b"></div>
                        </div>
                        <div class="popupFooter">
                            <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                            <div id="popupTabellaCostiElimina_BottoneElimina" class="btn btn-danger" 
                                onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaCostiElimina', 'tabellaCosti', true);">Elimina</div>
                            <span class="iwebSQLDELETE">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM costo WHERE id = @id") %></span>
	                            <span class="iwebPARAMETRO">@id = popupTabellaCostiElimina_findValue_costo.id</span>
                            </span>
                        </div>
                    </div>
                </div>

