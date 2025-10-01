<%@ Control Language="C#" ClassName="_gestione_computo_tabella_misure" %>


                    <table id="tabellaMisure" class="iwebTABELLA iwebCHIAVE__misura.id">
                        <thead>
                            <tr>
                                <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                                <th>
                                    <%-- permetti di aprire il popup solo se è stato selezionato un elemento nella tabella associata --%>
                                    <div id="primoElementoPlusTabellaMisure" class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" tabindex="2" 
                                        onclick="
                                            if (document.getElementById('tabellaVoci').getElementsByClassName('iwebRigaSelezionata').length &gt; 0){
                                                apriPopupType2_bind('popupTabellaMisureInserimento', true);
                                                azzeraCampiInserimentoTabellaMisure();
                                                preCaricaCodiceMisura();
                                                document.getElementById('popupTabellaMisureInserimento').getElementsByClassName('iwebCAMPO_sottocodice')[0].focus();
                                            }"
                                        onkeypress="
                                            if (document.getElementById('tabellaVoci').getElementsByClassName('iwebRigaSelezionata').length &gt; 0){
                                                apriPopupType2_bind('popupTabellaMisureInserimento', true);
                                                azzeraCampiInserimentoTabellaMisure();
                                                preCaricaCodiceMisura();
                                                document.getElementById('popupTabellaMisureInserimento').getElementsByClassName('iwebCAMPO_sottocodice')[0].focus();
                                            }"
                                    ></div>
                                </th>
                                <th class="iwebNascosto">id</th>
                                <th>Sposta</th> <%-- posizione --%>
                                <th>Sotto codice</th>
                                <%--<th>Descrizione</th>--%>
                                <th>Totale misura</th>
                                <th>Prezzo unitario</th>
                                <th>Totale importo</th>
                                <th>Immagine</th>
                                <th></th>
                            </tr>
                            <tr class="iwebNascosto">
                                <th class="iwebNascosto"></th>
                                <th></th>
                                <th class="iwebNascosto"></th>
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
                                <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                                <td>
                                    <div class="glyphicon glyphicon-pencil iwebCliccabile" title="Modifica" 
                                        onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaMisureModifica'); 
                                        iwebBind('tabellaMisure'); // non fa nulla ora
                                        iwebTABELLA_SelezionaRigaComeUnica();
                                        calcolaTextareaComputo(document.getElementById('popupTabellaMisureModifica').getElementsByClassName('iwebCAMPO_descrizione')[0], 'popupTabellaMisureModificaTextareaCalcolo', 'popupTabellaMisureModifica');
                                        modificaMisura_aggiornaSpan();"
                                    ></div>
                                </td>
                                <td class="iwebNascosto">
                                    <span class="iwebCAMPO_misura.id"></span>
                                    <span class="iwebCAMPO_misura.idvoce"></span>
                                    <span class="iwebCAMPO_unitadimisura.id"></span>
                                    <span class="iwebCAMPO_posizione"></span>
                                    <span class="iwebCAMPO_unitadimisura.codice"></span>
                                    <span class="iwebCAMPO_descrizione iwebDescrizione iwebTroncaCrtsAt_30"></span>
                                </td>
                                <td>
                                    <div class="contenitoreFreccePosizione">
                                        <span class="glyphicon glyphicon-chevron-up l iwebCliccabile" onclick="onclick_spostaMisuraSopra('misura.id')"></span>
                                        <span class="glyphicon glyphicon-chevron-down r iwebCliccabile" onclick="onclick_spostaMisuraSotto('misura.id')"></span>
                                        <span class="b"></span>
                                    </div>
                                </td>
                                <td>
                                    <span class="iwebCAMPO_sottocodice iwebCodice"></span>
                                </td>
                                <td>
                                    <span class="iwebCAMPO_totalemisura iwebValuta"></span>
                                </td>
                                <td>
                                    <span class="iwebCAMPO_prezzounitario iwebValuta"></span>
                                </td>
                                <%--<td class="tbMisureDescrizione">
                                </td>--%>
                                <td>
                                    <span class="iwebCAMPO_totaleimporto iwebValuta"></span>
                                </td>
                                <td>
                                    <span class="iwebCAMPO_misura.pathimmagine iwebNascosto"></span>
                                    <a href="/public/gestionale-scansioni/@iwebCAMPO_LinkImmagineMisura" class="iwebCAMPO_LinkImmagineMisura" target="_blank">
                                        <span class="iwebCAMPO_misura.nomeimmagine"></span>
                                    </a>
                                    <span class="glyphicon glyphicon-picture iwebCliccabile" title="Modifica immagine"
                                        onclick="
                                            iwebTABELLA_ModificaRigaInPopup('popupTabellaMisureModificaSoloImmagine');
                                            modificaImmagine_mostraDatiVoce();
                                        "></span>
                                </td>
                                <td>
                                    <div class="glyphicon glyphicon-trash iwebCliccabile" title="Elimina"
                                        onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaMisure'); iwebTABELLA_EliminaRigaInPopup('popupTabellaMisureElimina')">
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                        <tbody></tbody>
                        <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><b class="r">Totale</b></td>
                                <td>
                                    <span id="SpanTotaleImportoMisure" class="iwebTOTALE iwebValuta"></span>
                                    <span class="iwebSQLTOTAL">misura.totaleimporto</span>
                                    <span class="iwebPARAMETRO iwebNascosto">@idvoce = tabellaVoci_selectedValue_voce.id</span>
                                    <%--<span class="iwebSQLSELECT">totaleimporto</span>--%>
                                </td>
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
                            "SELECT misura.id as 'misura.id', misura.idvoce as 'misura.idvoce', " 
                          + "unitadimisura.codice as 'unitadimisura.codice', unitadimisura.id as 'unitadimisura.id', " 
                          + "       misura.sottocodice, misura.descrizione, misura.prezzounitario, misura.totalemisura, misura.totaleimporto, misura.totaleimporto as 'misura.totaleimporto', misura.posizione, "
                          + "       misura.pathimmagine as 'misura.pathimmagine', misura.nomeimmagine as 'misura.nomeimmagine', misura.pathimmagine as 'LinkImmagineMisura' " 
                          + "FROM misura LEFT JOIN unitadimisura ON misura.idunitamisura = unitadimisura.id" 
                          + "WHERE idvoce = @idvoce " 
                          + "ORDER BY posizione"
                        ) %></span>
                        <span class="iwebPARAMETRO">@idvoce = tabellaVoci_selectedValue_voce.id</span>
                    </span>

                    <div id="popupTabellaMisureModificaSoloImmagine" class="popup popupType2" style="display:none">
                        <div>
                            <div class="popupHeader">
                                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                                <div class="popupTitolo l">Modifica immagine</div>
                                <div class="b"></div>
                            </div>
                            <div class="iwebTABELLA_ContenitoreParametri"></div>
                            <div class="popupCorpo">
                                <table>
                                    <tr class="iwebNascosto">
                                        <td>id</td>
                                        <td><span class="iwebCAMPO_misura.id"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Voce: </td>
                                        <td style="max-width:300px">
                                            <span class="popupTabellaMisureModificaSoloImmagine_vocetitolo"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Suddivisione: </td>
                                        <td style="max-width:300px">
                                            <span class="popupTabellaMisureModificaSoloImmagine_suddivisionedescrizione"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Sottocodice</td>
                                        <td><span class="iwebCAMPO_sottocodice iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Unita di misura</td>
                                        <td><span class="iwebCAMPO_unitadimisura.codice iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Prezzo unitario</td>
                                        <td><span class="iwebCAMPO_prezzounitario iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Descrizione</td>
                                        <td>
                                            <textarea id="Textarea1" class="iwebCAMPO_descrizione iwebTIPOCAMPO_memo" disabled></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Totale misura</td>
                                        <td><span class="iwebCAMPO_totalemisura iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Totale importo</td>
                                        <td><span class="iwebCAMPO_totaleimporto iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <tr class="iwebNascosto">
                                        <td>posizione</td>
                                        <td><span class="iwebCAMPO_posizione iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <%--<tr>
                                        <td>Path Immagine</td>
                                        <td>
                                            <div id="popupTabellaMisureModificaSoloImmagineFileUpload" class="iwebFileUpload iwebCAMPO_pathimmagine">
                                                <input type="file" onchange="iwebPREPARAUPLOAD(event)" /><br /><br />
                                                <img src="/extra-sito/imageNotFound.gif" alt="preview" />
                                                <span class="iwebNascosto"></span><br />
                                                <span class="iwebNascosto"></span><br />
                                            </div>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td>Path Immagine</td>
                                        <td>
                                            <div id="popupTabellaMisureModificaSoloImmagineFileUpload1" class="iwebFileUpload">
                                                <input type="file" onchange="iwebPREPARAUPLOAD(event)" />
                                                <span class="iwebNascosto"></span> <%-- contenuto file selezionato --%>
                                                <span class="iwebCAMPO_misura.nomeimmagine"></span> <%-- nome file selezionato --%>
                                                <span class="iwebNascosto iwebCAMPO_misura.pathimmagine"></span> <%-- nome file uploadato --%>
                                                <div class="iwebDivImmagineFileUpload"><img src="//:0" alt="preview" /></div> <%-- mostro questo solo se immagine --%>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div class="popupFooter">
                                <%--<input type="button" value="Aggiorna" onclick="iwebBindPopupModificaiwebDETTAGLIO()" />--%>
                                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>

                                <%-- prima tento di uploadare il file, se ci riesco con esito positivo, confermo l'aggiunta del record --%>
                                <div class="btn btn-success" onclick="
                                    iwebINVIADATI('popupTabellaMisureModificaSoloImmagineFileUpload1',
                                        function(){ 
                                            iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaMisureModificaSoloImmagine', 'tabellaMisure', 'misura.pathimmagine,misura.nomeimmagine', 'misura.id', true,
                                            function(){ 
                                                iwebCaricaElemento('tabellaMisure');
                                            });
                                        }
                                    );
                                ">Aggiorna</div>
                                <%--<div class="btn btn-success" onclick="
                                    iwebINVIADATI('popupTabellaMisureModificaSoloImmagineFileUpload1',
                                        function(){ aggiornaImmagine('popupTabellaMisureModificaSoloImmagine', 'popupTabellaMisureModificaSoloImmagineFileUpload', 'iwebSQLUPDATE2'); }
                                    );
                                ">Aggiorna</div>--%>

                                <span class="iwebSQLUPDATE iwebNascosto">
	                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                        "UPDATE misura SET pathimmagine = @pathimmagine, nomeimmagine = @nomeimmagine WHERE id = @id "
                                    ) %></span>
	                                <span class="iwebPARAMETRO">@pathimmagine = popupTabellaMisureModificaSoloImmagine_findValue_misura.pathimmagine</span>
	                                <span class="iwebPARAMETRO">@nomeimmagine = popupTabellaMisureModificaSoloImmagine_findValue_misura.nomeimmagine</span>
	                                <span class="iwebPARAMETRO">@id = popupTabellaMisureModificaSoloImmagine_findValue_misura.id</span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <%-- iwebBIND__popupTabellaMisureModificaDDLUnitaMisura --%>
                    <div id="popupTabellaMisureModifica" class="popup popupType2" style="display:none">
                        <div>
                            <div class="popupHeader">
                                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                                <div class="popupTitolo l">Modifica misura</div>
                                <div class="b"></div>
                            </div>
                            <div class="iwebTABELLA_ContenitoreParametri"></div>
                            <div class="popupCorpo">
                                <table>
                                    <tr class="iwebNascosto">
                                        <td>id</td>
                                        <td><span class="iwebCAMPO_misura.id"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Voce: </td>
                                        <td style="max-width:300px">
                                            <span class="popupTabellaMisureModifica_vocetitolo"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Suddivisione: </td>
                                        <td style="max-width:300px">
                                            <span class="popupTabellaMisureModifica_suddivisionedescrizione"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Sottocodice *</td>
                                        <td><input type="text" 
                                            class="iwebCAMPO_sottocodice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                            onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                    </tr>
                                    <tr>
                                        <td>unita di misura</td>
                                        <td>

                                            <div class="iwebAUTOCOMPLETAMENTO" id="iwebAUTOCOMPLETAMENTOMisureModificaUM">
                                                <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                                <%-- Chiave dell'el selezionato --%>
                                                <span class="iwebNascosto iwebCAMPO_unitadimisura.id"></span>

                                                <%-- Valore dell'el selezionato --%>
                                                <input type="text" autocomplete="off" class="iwebCAMPO_unitadimisura.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                                    onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                                                    onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)"
                                                    onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)" />

                                                <%-- Query di ricerca --%>
                                                <span class="iwebSQLSELECT">
                                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                                        "SELECT id as chiave, codice as valore "
                                                      + "FROM unitadimisura "
                                                      + "WHERE codice like @codice "
                                                      + "LIMIT 5"
                                                    ) %></span>
                                                    <span class="iwebPARAMETRO">@codice = like_iwebAUTOCOMPLETAMENTOMisureModificaUM_getValore</span>
                                                </span>
                                                <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                                            </div>

                                            <%--<select id="popupTabellaMisureModificaDDLUnitaMisura" class="iwebDDL iwebCAMPO_unitadimisura.id">
                                            </select>
                                            <span class="iwebSQLSELECT">
                                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT unitadimisura.id as VALORE, unitadimisura.codice as NOME " +
                                                                                            "FROM unitadimisura") %></span>
                                            </span>--%>
                                            <%--<span class="iwebCAMPO_unitadimisura.codice"></span>--%></td>
                                    </tr>
                                    <tr>
                                        <td>Prezzo unitario</td>
                                        <td><input type="text" class="iwebCAMPO_prezzounitario iwebTIPOCAMPO_varchar"
                                            onchange = "var el = this.parentElement.parentElement.parentElement.getElementsByClassName('iwebTIPOCAMPO_memo')[0];
                                                        calcolaTextareaComputo(el, 'popupTabellaMisureModificaTextareaCalcolo', 'popupTabellaMisureModifica')"/></td>
                                    </tr>
                                    <tr>
                                        <td>Computo</td>
                                        <td>
                                            <textarea class="iwebCAMPO_descrizione iwebTIPOCAMPO_memo" onkeyup="calcolaTextareaComputo(this, 'popupTabellaMisureModificaTextareaCalcolo', 'popupTabellaMisureModifica')" 
                                                onmousemove="ricalcolaAltezzaTextareaComputo('popupTabellaMisureModificaTextareaCalcolo')"></textarea>
                                        </td>
                                        <td>
                                            <textarea id="popupTabellaMisureModificaTextareaCalcolo" class="iwebTIPOCAMPO_memo" disabled></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Totale misura</td>
                                        <%--<td><input type="text" class="iwebCAMPO_totalemisura iwebTIPOCAMPO_varchar"/></td>--%>
                                        <td>calcolato : <span id="popupTabellaMisureModificaSpanTotaleMisura" class="iwebCAMPO_totalemisura iwebTIPOCAMPO_varchar">0</span></td>
                                    </tr>
                                    <tr>
                                        <td>Totale importo</td>
                                        <td>
                                            <span class="iwebCAMPO_totaleimporto iwebTIPOCAMPO_varchar" >0</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="popupFooter">
                                <%--<input type="button" value="Aggiorna" onclick="iwebBindPopupModificaiwebDETTAGLIO()" />--%>
                                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                                <div class="btn btn-success" onclick="gestioneComputo_aggiornaMisuraEAggiornaElementiAssociati()">Aggiorna</div>
                                <span class="iwebSQLUPDATE">
	                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE misura " +
                                                                                "SET sottocodice = @sottocodice, " +
                                                                                "idunitamisura = @idunitamisura, " +
                                                                                "prezzounitario = @prezzounitario, " +
                                                                                "descrizione = @descrizione, " +
                                                                                "totalemisura = @totalemisura, " +
                                                                                "totaleimporto = @totaleimporto " +
                                                                                "WHERE id = @id ") %></span>
	                                <span class="iwebPARAMETRO">@sottocodice = popupTabellaMisureModifica_findValue_sottocodice</span>
	                                <span class="iwebPARAMETRO">@idunitamisura = popupTabellaMisureModifica_findValue_unitadimisura.id</span>
	                                <span class="iwebPARAMETRO">@prezzounitario = popupTabellaMisureModifica_findValue_prezzounitario</span>
	                                <span class="iwebPARAMETRO">@descrizione = popupTabellaMisureModifica_findValue_descrizione</span>
	                                <span class="iwebPARAMETRO">@totalemisura = popupTabellaMisureModifica_findValue_totalemisura</span>
	                                <span class="iwebPARAMETRO">@totaleimporto = popupTabellaMisureModifica_findValue_totaleimporto</span>
	                                <span class="iwebPARAMETRO">@id = popupTabellaMisureModifica_findValue_misura.id</span>
                                </span>
                                <%--<span class="iwebSQLUPDATE2 iwebNascosto">
	                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE misura " +
                                                                                "SET pathimmagine = @pathimmagine " +
                                                                                "WHERE id = @id ") %></span>
	                                <span class="iwebPARAMETRO">@pathimmagine = VALORE_percorsoImmagine</span>
	                                <span class="iwebPARAMETRO">@id = popupTabellaMisureModifica_findValue_misura.id</span>
                                </span>--%>
                            </div>
                        </div>
                    </div>

                    <%-- inserimento --%>
                    <%-- iwebBIND__popupTabellaMisureInserimentoDDLUnitaMisura --%>
                    <div id="popupTabellaMisureInserimento" class="popup popupType2" style="display:none">
                        <div>
                            <div class="popupHeader">
                                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                                <div class="popupTitolo l">Inserisci nuova misura</div>
                                <div class="b"></div>
                            </div>
                                <div class="popupCorpo">
                                <table>
                                    <tr class="iwebNascosto">
                                        <td>id</td>
                                        <td><span class="iwebCAMPO_misura.id"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Voce: </td>
                                        <td style="max-width:300px">
                                            <span class="popupTabellaMisureInserimento_vocetitolo"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Suddivisione: </td>
                                        <td style="max-width:300px">
                                            <span class="popupTabellaMisureInserimento_suddivisionedescrizione"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Sottocodice *</td>
                                        <td><input type="text" tabindex="2" 
                                            class="iwebCAMPO_sottocodice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                            onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                    </tr>
                                    <tr>
                                        <td>unita di misura</td>
                                        <td>

                                            <div class="iwebAUTOCOMPLETAMENTO" id="iwebAUTOCOMPLETAMENTOMisureInserimentoUM">
                                                <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                                <%-- Chiave dell'el selezionato --%>
                                                <span class="iwebNascosto iwebCAMPO_unitadimisura.id"></span>

                                                <%-- Valore dell'el selezionato --%>
                                                <input type="text" autocomplete="off" class="iwebCAMPO_unitadimisura.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" tabindex="2"
                                                    onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                                                    onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)"
                                                    onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)"/>

                                                <%-- Query di ricerca --%>
                                                <span class="iwebSQLSELECT">
                                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                                        "SELECT id as chiave, codice as valore "
                                                      + "FROM unitadimisura "
                                                      + "WHERE codice like @codice "
                                                      + "LIMIT 5"
                                                    ) %></span>
                                                    <span class="iwebPARAMETRO">@codice = like_iwebAUTOCOMPLETAMENTOMisureInserimentoUM_getValore</span>
                                                </span>
                                                <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                                            </div>

                                            <%--<div>
                                                <select id="popupTabellaMisureInserimentoDDLUnitaMisura" class="iwebDDL iwebCAMPO_unitadimisura.id" tabindex="2">
                                                </select>
                                                <span class="iwebSQLSELECT">
                                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                                        "SELECT unitadimisura.id as VALORE, unitadimisura.codice as NOME " +
                                                        "FROM unitadimisura") %></span>
                                                </span>
                                            </div>--%>
                                            <%--<span class="iwebCAMPO_unitadimisura.codice"></span>--%></td>
                                    </tr>
                                    <tr>
                                        <td>Prezzo unitario</td>
                                        <td><input type="text" class="iwebCAMPO_prezzounitario iwebTIPOCAMPO_varchar" value="1" tabindex="2"
                                            onchange = "var el = this.parentElement.parentElement.parentElement.getElementsByClassName('iwebTIPOCAMPO_memo')[0];
                                                        calcolaTextareaComputo(el, 'popupTabellaMisureInserimentoTextareaCalcolo', 'popupTabellaMisureInserimento')"/></td>
                                    </tr>
                                    <tr>
                                        <td>Computo</td>
                                        <td>
                                            <textarea class="iwebCAMPO_descrizione iwebTIPOCAMPO_memo" onkeyup="calcolaTextareaComputo(this, 'popupTabellaMisureInserimentoTextareaCalcolo', 'popupTabellaMisureInserimento')"
                                                onmousemove="ricalcolaAltezzaTextareaComputo('popupTabellaMisureInserimentoTextareaCalcolo')" tabindex="2"></textarea>
                                        </td>
                                        <td>
                                            <textarea id="popupTabellaMisureInserimentoTextareaCalcolo" class="iwebTIPOCAMPO_memo" disabled></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Totale misura</td>
                                        <%--<td><input type="text" class="iwebCAMPO_totalemisura iwebTIPOCAMPO_varchar"/></td>--%>
                                        <td>calcolato : <span id="popupTabellaMisureInserimentoSpanTotaleMisura" class="iwebCAMPO_totalemisura iwebTIPOCAMPO_varchar">0</span></td>
                                    </tr>
                                    <tr>
                                        <td>Totale importo</td>
                                        <td>
                                            <span class="iwebCAMPO_totaleimporto iwebTIPOCAMPO_varchar" >0</span>
                                        </td>
                                    </tr>
                                    <%--<tr>
                                        <td>Path Immagine</td>
                                        <td>
                                            <div id="popupTabellaMisureInserimentoFileUpload1" class="iwebFileUpload">
                                                <input type="file" onchange="iwebPREPARAUPLOAD(event)" />
                                                <img src="//:0" alt="preview" /> 
                                                <span class="iwebNascosto"></span> 
                                                <span class="iwebCAMPO_bollafattura.nomefilescansione"></span> 
                                                <span class="iwebNascosto iwebCAMPO_bollafattura.pathfilescansione"></span>
                                            </div>
                                        </td>
                                    </tr>--%>
                                </table>
                            </div>
                            <div class="popupFooter">
                                <div class="btn btn-warning" 
                                    onclick="chiudiPopupType2()" 
                                    onkeypress="if (event.which == 13 || event.keyCode == 13) {
                                        chiudiPopupType2();
                                        setTimeout(function(){ document.getElementById('primoElementoPlusTabellaVoci').focus() }, 100);
                                    }" 
                                    tabindex="2">Annulla</div>

                                <div class="btn btn-success" 
                                    onclick="gestioneComputo_inserisciMisuraEAggiorna('Inserisci');" 
                                    onkeypress="if (event.which == 13 || event.keyCode == 13) {
                                        gestioneComputo_inserisciMisuraEAggiorna('Inserisci');
                                        setTimeout(function(){ document.getElementById('primoElementoPlusTabellaVoci').focus() }, 100);
                                    }"
                                    tabindex="2">Inserisci</div>

                                <div class="btn btn-success" 
                                    onclick="gestioneComputo_inserisciMisuraEAggiorna_poiRiproponiNuovaMisura('Inserisci + Nuova misura');" 
                                    onkeypress="if (event.which == 13 || event.keyCode == 13) {
                                        gestioneComputo_inserisciMisuraEAggiorna_poiRiproponiNuovaMisura('Inserisci + Nuova misura');
                                    }"
                                    tabindex="2">Inserisci + Nuova misura</div>

                                <span class="iwebSQLINSERT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                        "INSERT INTO misura (idvoce, sottocodice, idunitamisura, prezzounitario, descrizione, totalemisura, totaleimporto, posizione) " +
                                        "VALUES (@idvoce, @sottocodice, @idunitamisura, @prezzounitario, @descrizione, @totalemisura, @totaleimporto, @posizione)") %></span>
                                    <span class="iwebPARAMETRO">@idvoce = tabellaVoci_selectedValue_voce.id</span>
	                                <span class="iwebPARAMETRO">@sottocodice = popupTabellaMisureInserimento_findValue_sottocodice</span>
	                                <span class="iwebPARAMETRO">@idunitamisura = popupTabellaMisureInserimento_findValue_unitadimisura.id</span>
	                                <span class="iwebPARAMETRO">@prezzounitario = popupTabellaMisureInserimento_findValue_prezzounitario</span>
	                                <span class="iwebPARAMETRO">@descrizione = popupTabellaMisureInserimento_findValue_descrizione</span>
	                                <span class="iwebPARAMETRO">@totalemisura = popupTabellaMisureInserimento_findValue_totalemisura</span>
	                                <span class="iwebPARAMETRO">@totaleimporto = popupTabellaMisureInserimento_findValue_totaleimporto</span>
	                                <span class="iwebPARAMETRO">@posizione = VALORE_99999</span>
                                </span>
                            </div>
                        </div>
                    </div>

                    <%-- elimina --%>
                    <div id="popupTabellaMisureElimina" class="popup popupType2" style="display:none">
                        <div>
                            <div class="popupHeader">
                                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                                <div class="popupTitolo l">Eliminazione misura, ricontrolla i dati</div>
                                <div class="b"></div>
                            </div>
                            <div class="iwebTABELLA_ContenitoreParametri"></div>
                            <div class="popupCorpo">
                                <table>
                                    <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                            in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                                    <tr class="iwebNascosto">
                                        <td>
                                            <span class="iwebCAMPO_misura.id"></span>
                                            <span class="iwebCAMPO_misura.idvoce"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Sottocodice</td>
                                        <td><span class="iwebCAMPO_sottocodice iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Unita di misura</td>
                                        <td><span class="iwebCAMPO_unitadimisura.codice iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Prezzo unitario</td>
                                        <td><span class="iwebCAMPO_prezzounitario iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Descrizione</td>
                                        <td>
                                            <textarea id="Textarea2" class="iwebCAMPO_descrizione iwebTIPOCAMPO_memo" disabled></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Totale misura</td>
                                        <td><span class="iwebCAMPO_totalemisura iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Totale importo</td>
                                        <td><span class="iwebCAMPO_totaleimporto iwebTIPOCAMPO_varchar"></span></td>
                                    </tr>
                                    <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                                </table>
                            </div>
                            <div class="popupFooter">
                                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                                <div class="btn btn-danger" onclick="gestioneComputo_eliminaMisuraEAggiorna();">Elimina</div>
                                <%--<span class="iwebSQLDELETE">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM misura WHERE id = @id") %></span>
                                    <span class="iwebPARAMETRO">@id = tabellaMisure_selectedValue_misura.id</span>
                                </span>--%>
                            </div>
                        </div>
                    </div>


