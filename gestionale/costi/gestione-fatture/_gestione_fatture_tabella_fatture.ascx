<%@ Control Language="C#" ClassName="_gestione_fatture_tabella_fatture" %>

<%@ Register TagPrefix="gestionefatture" TagName="costicollegati" Src="_gestionefatture_tabellafatture_costicollegati.ascx" %>

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
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM bollafattura WHERE bollafattura.id=@bollafattura.id")%></span>
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
                    <th>Prot.</th>
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
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_bollafattura.numero">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebFILTROUgualaA iwebCAMPO_bollafattura.protocollo">
                            <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
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
                        <span class="iwebCAMPO_bollafattura.protocollo"></span>
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
                        <a href="/public/gestionale-scansioni/@iwebCAMPO_Linkpathfilescansione" class="iwebCAMPO_Linkpathfilescansione" target="_blank">
                            <span class="iwebCAMPO_bollafattura.pathfilescansione iwebNascosto"></span>
                            <span class="iwebCAMPO_bollafattura.nomefilescansione"></span>
                        </a>
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
                    <div class="iwebPAGESIZE"><select id="Select1VDSJ0934N" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
            <%-- La data costo deve essere sempre la data della bolla se si riferisce a una bolla e la data fattura se si riferisce alla fattura. --%>
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT bollafattura.id as 'bollafattura.id', bollafattura.idfornitore as 'bollafattura.idfornitore', "
                + "     bollafattura.id as 'LinkPerControllo', bollafattura.numero as 'bollafattura.numero', "
                + "     bollafattura.protocollo as 'bollafattura.protocollo', bollafattura.databollafattura as 'bollafattura.databollafattura', "
                + "     bollafattura.importo as 'bollafattura.importo', bollafattura.pathfilescansione as 'Linkpathfilescansione', "
                + "     bollafattura.nomefilescansione as 'bollafattura.nomefilescansione', "
                + "     fornitore.id as 'fornitore.id', fornitore.ragionesociale as 'fornitore.ragionesociale' "
                + "FROM bollafattura LEFT JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
                + "WHERE bollafattura.isddt = false"
                + "ORDER BY bollafattura.id DESC")%>
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
                            <td>Prot.</td>
                            <td>
                                <input type="text" class="iwebCAMPO_bollafattura.protocollo iwebTIPOCAMPO_varchar"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Data *</td>
                            <td>
                                <input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_date iwebCAMPOOBBLIGATORIO" 
                                    onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                    placeholder="gg/mm/aaaa" onfocus="scwLanguage='it';scwShow(this, event);" 
                                    onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>Fornitore *</td>
                            <%--<td><input type="text" class="iwebCAMPO_fornitore.id iwebTIPOCAMPO_varchar" /></td>--%>
                            <td>
                                <div class="iwebCAMPO_fornitore.ragionesociale">
                                    <select id="popupTabellaFattureInserimentoDDLFornitore" 
                                        class="iwebDDL iwebCAMPO_fornitore.id iwebCAMPOOBBLIGATORIO iwebTIPOCAMPO_varchar" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                        <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT ragionesociale as NOME, id as VALORE FROM fornitore ORDER BY ragionesociale")%></span>
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
                            <td>
                                <div id="popupTabellaFattureInserimentoPDFFileUpload" class="iwebFileUpload">
                                    <input type="file" onchange="iwebPREPARAUPLOAD(event)" />
                                    <img class="iwebNascosto" src="//:0" alt="preview" />
                                    <span class="iwebNascosto"></span> <%-- contenuto file selezionato --%>
                                    <span class="iwebCAMPO_bollafattura.nomefilescansione"></span> <%-- nome file selezionato --%>
                                    <span class="iwebNascosto iwebCAMPO_bollafattura.pathfilescansione"></span> <%-- nome file uploadato --%>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <%-- IdPopupAssociato, nomeQuery, parametriQuery, attesaRispostaServer --%>
                    <%--<div class="btn btn-success" onclick="iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaFattureInserimento', 'tabellaFatture', '', true)">Inserisci</div>--%>
                    <div class="btn btn-success" onclick="
                        popupTabellaFattureInserimentoVerificaInserimentiDoppi(function() {
                            /* prima tento di uploadare il file, se ci riesco con esito positivo, confermo l'aggiunta del record */
                            iwebINVIADATI('popupTabellaFattureInserimentoPDFFileUpload',
                                function(){ iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaFattureInserimento', 'tabellaFatture', '', true) }
                            );
                        });
                    ">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "INSERT INTO bollafattura (idfornitore, numero, protocollo, databollafattura, isddt, isfattura, importo, chiusa, pathfilescansione, nomefilescansione) "
                          + "VALUES(@idfornitore, @numero, @protocollo, @databollafattura, false, true, @importo, true, @pathfilescansione, @nomefilescansione)")%></span>
                        <span class="iwebPARAMETRO">@idfornitore = popupTabellaFattureInserimento_findValue_fornitore.id</span>
                        <span class="iwebPARAMETRO">@numero = popupTabellaFattureInserimento_findValue_bollafattura.numero</span>
                        <span class="iwebPARAMETRO">@protocollo = popupTabellaFattureInserimento_findValue_bollafattura.protocollo</span>
                        <span class="iwebPARAMETRO">@databollafattura = popupTabellaFattureInserimento_findValue_bollafattura.databollafattura</span>
                        <span class="iwebPARAMETRO">@importo = popupTabellaFattureInserimento_findValue_bollafattura.importo</span>
                        <span class="iwebPARAMETRO">@pathfilescansione = popupTabellaFattureInserimento_findValue_bollafattura.pathfilescansione</span>
                        <span class="iwebPARAMETRO">@nomefilescansione = popupTabellaFattureInserimento_findValue_bollafattura.nomefilescansione</span>
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
                            <td>Prot.</td>
                            <td><input type="text" class="iwebCAMPO_bollafattura.protocollo iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Data</td>
                            <td><%--<input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_varchar"/>--%>
                                <input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_date" 
                                    onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                    placeholder="gg/mm/aaaa" onfocus="scwLanguage='it'; scwShow(this, event);" 
                                    onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>Fornitore</td>
                            <td>
                                <%--<span class="iwebCAMPO_fornitore.ragionesociale"></span>--%>
                                <div class="iwebCAMPO_fornitore.ragionesociale">
                                    <select id="popupTabellaBolleModificaDDLFornitore" class="iwebDDL iwebCAMPO_fornitore.id iwebCAMPOOBBLIGATORIO iwebTIPOCAMPO_varchar" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                        <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT ragionesociale as NOME, id as VALORE FROM fornitore ORDER BY ragionesociale")%></span>
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
                            <td>
                                <div id="popupTabellaFattureModificaFileUpload1" class="iwebFileUpload">
                                    <input type="file" onchange="iwebPREPARAUPLOAD(event)" />
                                    <img class="iwebNascosto" src="//:0" alt="preview" /> <%-- mostro questo solo se immagine --%>
                                    <span class="iwebNascosto"></span> <%-- contenuto file selezionato --%>
                                    <span class="iwebCAMPO_bollafattura.nomefilescansione"></span> <%-- nome file selezionato --%>
                                    <span class="iwebNascosto iwebCAMPO_bollafattura.pathfilescansione"></span> <%-- nome file uploadato --%>
                                </div>
                            </td>
                        </tr>
                        <%-- basta aggiungere nomi di campi esistenti e funziona --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <%--<div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaFattureModifica', 'tabellaFatture', 'bollafattura.numero, bollafattura.databollafattura, fornitore.id, fornitore.ragionesociale bollafattura.importo', 'bollafattura.id', true);">Aggiorna</div>--%>
                    <div class="btn btn-success" onclick="
                        /* prima tento di uploadare il file, se ci riesco con esito positivo, confermo l'aggiunta del record */
                        /* in modifica sulla stessa tabella non sono riuscito ad aggiornare corettamente la scansione, ragion per cui ricarico di nuovo la tabella al termine dell'aggiornamento */
                        iwebINVIADATI('popupTabellaFattureModificaFileUpload1',
                            function(){
                                iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaFattureModifica', 'tabellaFatture', 'bollafattura.numero, bollafattura.databollafattura, fornitore.id, fornitore.ragionesociale, bollafattura.importo, bollafattura.pathfilescansione, bollafattura.nomefilescansione', 'bollafattura.id', true,
                                    function(){ iwebCaricaElemento('tabellaFatture'); 

                                // aggiorno anche la data di tutte le righe costo collegate a questa fattura
                                iwebEseguiQuery('dettaglioAnagrafica_iwebSQLUPDATE_righecosto');
                            } ); }
                        );
                    ">Aggiorna</div>
                    <div class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                            "UPDATE bollafattura SET numero = @numero, protocollo = @protocollo, "
                                          + "       databollafattura = @databollafattura, "
                                          + "       idfornitore = @idfornitore, importo = @importo, "
                                          + "       pathfilescansione = @pathfilescansione, nomefilescansione = @nomefilescansione "
                                          + "WHERE id = @id")%></span>
                        <span class="iwebPARAMETRO">@numero = popupTabellaFattureModifica_findValue_bollafattura.numero</span>
                        <span class="iwebPARAMETRO">@protocollo = popupTabellaFattureModifica_findValue_bollafattura.protocollo</span>
                        <span class="iwebPARAMETRO">@databollafattura = popupTabellaFattureModifica_findValue_bollafattura.databollafattura</span>
                        <span class="iwebPARAMETRO">@idfornitore = popupTabellaFattureModifica_findValue_fornitore.id</span>
                        <span class="iwebPARAMETRO">@importo = popupTabellaFattureModifica_findValue_bollafattura.importo</span>
                        <span class="iwebPARAMETRO">@pathfilescansione = popupTabellaFattureModifica_findValue_bollafattura.pathfilescansione</span>
                        <span class="iwebPARAMETRO">@nomefilescansione = popupTabellaFattureModifica_findValue_bollafattura.nomefilescansione</span>
                        <span class="iwebPARAMETRO">@id = popupTabellaFattureModifica_findValue_bollafattura.id</span>
                    </div>
                    <%-- l'aggiornamento di una fattura deve aggiornare anche la data dei costi collegati --%>
                    <div id="dettaglioAnagrafica_iwebSQLUPDATE_righecosto" class="iwebNascosto">
                            <%--"UPDATE costo LEFT JOIN bollafattura ON bollafattura.id = costo.idbollafattura SET costo.datacosto = bollafattura.databollafattura "--%>
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "UPDATE costo LEFT JOIN bollafattura ON bollafattura.id = costo.idbollafattura "
                          + "SET costo.datacosto = bollafattura.databollafattura "
                          + "WHERE costo.datacosto <> bollafattura.databollafattura AND bollafattura.id = @idbollafattura"
                        )%></span>
                        <span class="iwebPARAMETRO">@idbollafattura = popupTabellaFattureModifica_findValue_bollafattura.id</span>
                    </div>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <script>
            function funzionePopupTabellaFattureElimina() {
                iwebCaricaElemento("tabellaCostiCollegati", false, function () {
                    var elTabellaCostiCollegati = document.getElementById("tabellaCostiCollegati");
                    var n = elTabellaCostiCollegati.getElementsByTagName('tbody')[1].getElementsByTagName('td').length;

                    if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                        elTabellaCostiCollegati.style.display = 'none';
                        document.getElementById('messaggioErroreSeTabellaCostiCollegatiHaRighe').style.display = 'none';
                    } else {
                        elTabellaCostiCollegati.style.display = 'block';
                        document.getElementById('messaggioErroreSeTabellaCostiCollegatiHaRighe').style.display = 'block';
                    }
                });
            }
        </script>
        <div id="popupTabellaFattureElimina" class="popup popupType2 iwebfunzione_funzionePopupTabellaFattureElimina" style="display:none">
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
                            <td>Prot.</td>
                            <td><span class="iwebCAMPO_bollafattura.protocollo"></span></td>
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
                        <tr>
                            <td style="vertical-align:top">Costi collegati:</td>
                            <td>
                                <gestionefatture:costicollegati runat="server" />
                                <div class="b"></div>
                                <div id="messaggioErroreSeTabellaCostiCollegatiHaRighe">Attenzione! L'eliminazione di una fattura cancella anche tutti i costi collegati.</div>
                            </td>
                        </tr>

                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-danger" onclick="eliminaFattura();">Elimina</div>

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
    </div>
