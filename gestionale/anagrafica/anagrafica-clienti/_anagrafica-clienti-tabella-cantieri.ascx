<%@ Control Language="C#" ClassName="_anagrafica_clienti_tabella_cantieri" %>


                <table id="tabellaCantieri" class="iwebTABELLA iwebCHIAVE__cantiere.id">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto">
                                <input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()" /></th>
                            <th class="commandHead">
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                                    onclick="
                                    if (document.getElementById('tabellaClienti').getElementsByClassName('iwebRigaSelezionata').length &gt; 0){
                                        iwebTABELLA_AggiungiRigaInPopup('popupTabellaCantieriInserimento');
                                        document.getElementById('popupTabellaCantieriInserimentoSpanCodiceErrato').style.display = 'none';
                                    }"></div>
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th>Codice</th>
                            <th>Indirizzo</th>
                            <th>Descrizione</th>
                            <th>Stato</th>
                            <th class="iwebNascosto"></th>
                            <%-- ALTRO --%>
                        </tr>
                        <tr class="iwebNascosto">
                            <th class="iwebNascosto"></th>
                            <%-- CHECKBOX --%>
                            <th><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th class="iwebNascosto"></th>
                            <%-- ALTRO --%>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td class="iwebNascosto">
                                <input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()" /></td>
                            <td>
                                <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" 
                                    onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaCantieriModifica'); 
                                    iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');
                                    document.getElementById('popupTabellaCantieriModificaSpanCodiceErrato').style.display = 'none';"></div>
                                <%--<div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');"></div>--%>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_cantiere.id"></span>
                                <span class="iwebCAMPO_cantiere.idcliente"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cantiere.indirizzo iwebDescrizione"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cantiere.descrizione iwebDescrizione"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cantiere.stato iwebCodice"></span>
                            </td>
                            <td class="iwebNascosto">
                                <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                    onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');
                                          iwebTABELLA_EliminaRigaInPopup('popupTabellaCantieriElimina')">
                                </div>
                            </td>
                            <%-- ALTRO --%>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot>
                        <%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
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
                        <tr>
                            <td>
                                <div class="iwebTABELLAFooterPaginazione">
                                    <div>Pagina</div>
                                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                                    <div class="iwebPAGENUMBER">
                                        <input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div>
                                    <div>di</div>
                                    <div class="iwebTOTPAGINE">1</div>
                                    <div>|</div>
                                    <div>Vedi</div>
                                    <div class="iwebPAGESIZE">
                                        <select id="Select3" onchange="iwebTABELLA_FooterCambiaPageSize()">
                                            <option value="10">10</option>
                                            <option value="20">20</option>
                                            <option value="50">50</option>
                                            <option value="100">100</option>
                                            <option value="10000">Tutti</option>
                                        </select></div>
                                    <div>righe</div>
                                    <div>|</div>
                                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                                </div>
                            </td>
                        </tr>
                    </tfoot>
                </table>
                <span class="iwebSQLSELECT">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                        SELECT cantiere.id as 'cantiere.id',
                               cantiere.idcliente as 'cantiere.idcliente',
                               cantiere.codice as 'cantiere.codice',
                               cantiere.indirizzo as 'cantiere.indirizzo',
                               cantiere.descrizione as 'cantiere.descrizione',
                               cantiere.stato as 'cantiere.stato'
                        FROM cantiere
                        WHERE idcliente = @idcliente
                    ") %></span>
                    <span class="iwebPARAMETRO">@idcliente = tabellaClienti_selectedValue_cliente.id</span>
                </span>

                <%-- inserimento --%>
                <div id="popupTabellaCantieriInserimento" class="popup popupType2" style="display:none">
                    <div>
                        <div class="popupHeader">
                            <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                            <div class="popupTitolo l">Inserisci nuovo cantiere</div>
                            <div class="b"></div>
                        </div>
                        <div class="popupCorpo">
                            <table>
                                <tr>
                                    <td>Codice*</td>
                                    <td><input id="popupTabellaCantieriInserimentoCodice" type="text" 
                                        class="iwebCAMPO_cantiere.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                    <td><span id="popupTabellaCantieriInserimentoSpanCodiceErrato" style="display:none">Il codice esiste già.</span></td>
                                </tr>
                                <tr>
                                    <td>Indirizzo</td>
                                    <td><input id="popupTabellaCantieriInserimentoIndirizzo" type="text" class="iwebCAMPO_cantiere.indirizzo iwebTIPOCAMPO_varchar" /></td>
                                </tr>
                                <tr>
                                    <td>Descrizione*</td>
                                    <td><input id="popupTabellaCantieriInserimentoDescrizione" type="text" 
                                        class="iwebCAMPO_cantiere.descrizione iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                </tr>
                            </table>
                        </div>

                        <div class="popupFooter">
                            <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                            <%-- IdPopupAssociato, nomeQuery, parametriQuery, attesaRispostaServer --%>
                            <div class="btn btn-success" onclick="anagraficaClienti_iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaCantieriInserimento', 'tabellaCantieri', 'nominativo,tel,mail', true)">Inserisci</div>
                            <span class="iwebSQLINSERT">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                    INSERT INTO cantiere (idcliente, codice, indirizzo, descrizione, stato)
                                    VALUES (@idcliente, @codice, @indirizzo, @descrizione, 'Da firmare')
                                ") %></span>
                                <span class="iwebPARAMETRO">@idcliente = tabellaClienti_selectedValue_cliente.id</span>
                                <span class="iwebPARAMETRO">@codice = popupTabellaCantieriInserimentoCodice_value</span>
                                <span class="iwebPARAMETRO">@indirizzo = popupTabellaCantieriInserimentoIndirizzo_value</span>
                                <span class="iwebPARAMETRO">@descrizione = popupTabellaCantieriInserimentoDescrizione_value</span>
                            </span>
                        </div>
                    </div>
                </div>


                <%-- modifica --%>
                <div id="popupTabellaCantieriModifica" class="popup popupType2" style="display:none">
                    <div>
                        <div class="popupHeader">
                            <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                            <div class="popupTitolo l">Modifica anagrafica cantiere</div>
                            <div class="b"></div>
                        </div>
                        <div class="popupCorpo">
                            <div class="iwebTABELLA_ContenitoreParametri"></div>
                            <table>
                                <tr class="iwebNascosto">
                                    <td>id</td>
                                    <td>
                                        <span class="iwebCAMPO_cantiere.id"></span>
                                        <span class="iwebCAMPO_cantiere.idcliente"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Codice *</td>
                                    <td><input type="text" 
                                        class="iwebCAMPO_cantiere.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                    <td><span id="popupTabellaCantieriModificaSpanCodiceErrato" style="display:none">Il codice esiste già.</span></td>
                                </tr>
                                <tr>
                                    <td>Indirizzo</td>
                                    <td><input type="text" class="iwebCAMPO_cantiere.indirizzo iwebTIPOCAMPO_varchar" /></td>
                                </tr>
                                <tr>
                                    <td>Descrizione *</td>
                                    <td><input type="text" 
                                        class="iwebCAMPO_cantiere.descrizione iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                </tr>
                                <tr>
                                    <td>Stato</td>
                                    <td>
                                        <select id="popupTabellaCantieriModificaStato" class="iwebCAMPO_cantiere.stato iwebTIPOCAMPO_varchar">
                                            <option value="Aperto">Aperto</option>
                                            <option value="Da firmare">Da firmare</option>
                                            <option value="Chiuso">Chiuso</option>
                                        </select>
                                    </td>
                                    <%--<td><input type="text" class="iwebCAMPO_cantiere.stato iwebTIPOCAMPO_varchar" /></td>--%>
                                </tr>
                            </table>
                        </div>
                        <div class="popupFooter">
                            <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                            <div class="btn btn-success" onclick="anagraficaClienti_iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaCantieriModifica', 'tabellaCantieri', 'codice,descrizione,stato', 'cantiere.id', true);">Aggiorna</div>
                            <span class="iwebSQLUPDATE">
	                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                    UPDATE cantiere
                                    SET
                                        idcliente = @idcliente,
                                        codice = @codice,
                                        indirizzo = @indirizzo,
                                        descrizione = @descrizione,
                                        stato = @stato
                                    WHERE id = @id
                                ") %></span>
	                            <span class="iwebPARAMETRO">@idcliente = popupTabellaCantieriModifica_findValue_cantiere.idcliente</span>
	                            <span class="iwebPARAMETRO">@codice = popupTabellaCantieriModifica_findValue_cantiere.codice</span>
	                            <span class="iwebPARAMETRO">@indirizzo = popupTabellaCantieriModifica_findValue_cantiere.indirizzo</span>
	                            <span class="iwebPARAMETRO">@descrizione = popupTabellaCantieriModifica_findValue_cantiere.descrizione</span>
	                            <span class="iwebPARAMETRO">@stato = popupTabellaCantieriModifica_findValue_cantiere.stato</span>
	                            <span class="iwebPARAMETRO">@id = popupTabellaCantieriModifica_findValue_cantiere.id</span>
                            </span>
                        </div>
                    </div>
                </div>

                <%-- elimina --%>
                <div id="popupTabellaCantieriElimina" class="popup popupType2" style="display:none">
                    <div class="popupHeader">
                        <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                        <div class="popupTitolo l">Eliminazione cantiere, ricontrolla i dati</div>
                        <div class="b"></div>
                    </div>
                    <div class="iwebTABELLA_ContenitoreParametri"></div>
                    <div class="popupCorpo">
                        <table>
                            <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                 in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                            <tr>
                                <td>id</td>
                                <td><span class="iwebCAMPO_cantiere.id"></span></td>
                            </tr>
                            <tr>
                                <td>Codice</td>
                                <td><span class="iwebCAMPO_cantiere.codice"></span></td>
                            </tr>
                            <tr>
                                <td>Descrizione</td>
                                <td><span class="iwebCAMPO_cantiere.descrizione"></span></td>
                            </tr>
                            <tr>
                                <td>Stato</td>
                                <td><span class="iwebCAMPO_cantiere.stato"></span></td>
                            </tr>
                            <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                        </table>
                    </div>
                    <div class="popupFooter">
                        <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                        <div class="btn btn-danger" onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaCantieriElimina', 'tabellaCantieri', true);">Elimina</div>
                        <span class="iwebSQLDELETE">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM cantiere WHERE id = @id") %></span>
                            <span class="iwebPARAMETRO">@id = tabellaCantieri_selectedValue_cantiere.id</span>
                        </span>
                    </div>
                </div>

