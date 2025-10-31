<%@ Control Language="C#" ClassName="_carica_rapportino_tabella_costi" %>


    <div class="iwebTABELLAWrapper width915">
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
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM costo WHERE costo.id=@costo.id") %></span>
            </span>
        </div>
        <table id="tabellaCosti" class="iwebTABELLA iwebCHIAVE__costo.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <%--<div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                            onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaCostiInserimento');"></div>--%>
                    </th>
                    <th>Ore Da Fatturare</th>
                    <th>Ore Mastrino</th>
                    <%--<th>Prezzo</th>--%>
                    <th>Data costo</th>
                    <th>Codice cantiere</th>
                    <th>Descrizione</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%>
                    </th>
                    <th class="iwebNascosto"></th>
                    <%--<th></th>--%>
                    <th></th>
                    <th></th>
                    <th>
                        <%--maggiore uguale di--%>
                        <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_costo.datacosto">
                            <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" 
                                onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <%--minore di--%>
                        <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_costo.datacosto">
                            <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" 
                            onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                            onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_cantiere.codice">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)">
                        </div>
                    </th>
                    <th></th>
                    <th></th><%-- ALTRO --%>
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaCostiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');"></div>
                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');"></div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_costo.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_costo.quantita r"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_costo.qtaoremastrino r"></span>
                    </td>
                    <%--<td>
                        <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                    </td>--%>
                    <td>
                        <span class="iwebCAMPO_costo.datacosto iwebData"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.id iwebNascosto"></span>
                        <span class="iwebCAMPO_cantiere.codice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_costo.descrizione iwebDescrizione iwebTroncaCrtsAt_500"></span>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                             onclick="iwebTABELLA_SelezionaRigaComeUnica();
                                      iwebTABELLA_EliminaRigaInPopup('popupTabellaCostiElimina')"></div>
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
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="Select1ASFW3G34" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                SELECT
                    costo.id as 'costo.id',
                    costo.quantita as 'costo.quantita',
                    costo.prezzo as 'costo.prezzo',
                    costo.datacosto as 'costo.datacosto',
                    costo.qtaoremastrino as 'costo.qtaoremastrino',
                    costo.descrizione as 'costo.descrizione',
                    cantiere.id as 'cantiere.id',
                    cantiere.codice as 'cantiere.codice'

                FROM costo LEFT JOIN cantiere ON costo.idcantiere = cantiere.id
                WHERE costo.idprodotto = @idmanodopera 
                ORDER BY costo.datacosto DESC
            ") %></span>
            <span class="iwebPARAMETRO">@idmanodopera = IDMANODOPERA_value</span>
        </span>

        <%-- modifica --%>
        <div id="popupTabellaCostiModifica" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Modifica rapportino</div>
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
                            <td>Ore Da Fatturare</td>
                            <td><input type="text" class="iwebCAMPO_costo.quantita iwebCAMPOOBBLIGATORIO iwebTIPOCAMPO_varchar" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Ore Mastrino</td>
                            <td><input type="text" class="iwebCAMPO_costo.qtaoremastrino iwebCAMPOOBBLIGATORIO iwebTIPOCAMPO_varchar" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Data costo</td>
                            <td>
                                <input type="text" placeholder="A" class="iwebCAMPO_costo.datacosto iwebTIPOCAMPO_date"
                                    onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                    onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><textarea class="iwebCAMPO_costo.descrizione iwebTIPOCAMPO_memo"></textarea></td>
                        </tr>
                        <tr>
                            <td>Codice cantiere</td>
                            <td>
                                <div class="iwebCAMPO_cantiere.codice">
                                    <select id="DDLCantiere" class="iwebDDL iwebTIPOCAMPO_varchar iwebCAMPO_cantiere.id"
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"SELECT codice as NOME, id as VALORE FROM cantiere ORDER BY codice") %>
                                        </span>
                                    </span>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaCostiModifica', 'tabellaCosti', 'costo.idcantiere, costo.quantita, costo.datacosto, costo.descrizione', 'costo.id', true);">Aggiorna</div>
                    <span class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                            UPDATE costo
                            SET idcantiere = @idcantiere, quantita = @quantita, qtaoremastrino = @qtaoremastrino, datacosto = @datacosto, descrizione = @descrizione
                            WHERE id = @id
                        ") %></span>
	                    <span class="iwebPARAMETRO">@idcantiere = popupTabellaCostiModifica_findValue_cantiere.id</span>
	                    <span class="iwebPARAMETRO">@quantita = popupTabellaCostiModifica_findValue_costo.quantita</span>
	                    <span class="iwebPARAMETRO">@qtaoremastrino = popupTabellaCostiModifica_findValue_costo.qtaoremastrino</span>
	                    <span class="iwebPARAMETRO">@datacosto = popupTabellaCostiModifica_findValue_costo.datacosto</span>
	                    <span class="iwebPARAMETRO">@descrizione = popupTabellaCostiModifica_findValue_costo.descrizione</span>
	                    <span class="iwebPARAMETRO">@id = popupTabellaCostiModifica_findValue_costo.id</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <div id="popupTabellaCostiElimina" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione rapportino, ricontrolla i dati</div>
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
                            <td>Data</td>
                            <td><span class="iwebCAMPO_costo.datacosto"></span></td>
                        </tr>
                        <tr>
                            <td>Ore Da Fatturare</td>
                            <td><span class="iwebCAMPO_costo.quantita"></span></td>
                        </tr>
                        <tr>
                            <td>Ore Mastrino</td>
                            <td><span class="iwebCAMPO_costo.qtaoremastrino"></span></td>
                        </tr>
                        <tr>
                            <td>Codice cantiere</td>
                            <td>
                                <span class="iwebCAMPO_cantiere.codice"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><span class="iwebCAMPO_costo.descrizione"></span></td>
                        </tr>
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-danger" onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaCostiElimina', 'tabellaCosti', true);">Elimina</div>
                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM costo WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = popupTabellaCostiElimina_findvalue_costo.id</span>
                    </span>
                </div>
            </div>
        </div>

    </div>
