<%@ Control Language="C#" ClassName="_anagrafica_clienti_tabella_computi" %>

                <table id="tabellaComputi" class="iwebTABELLA iwebCHIAVE__computo.id">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto">
                                <input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()" /></th>
                            <th class="commandHead">
                                <%-- permetti di aprire il popup solo se è stato selezionato un elemento nella tabella associata 
                                    if(!isNaN(parseInt(iwebValutaParametroAjax('tabellaClienti_selectedvalue_cliente.id'))))--%>
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                                    onclick="
                                    if (document.getElementById('tabellaClienti').getElementsByClassName('iwebRigaSelezionata').length &gt; 0)
                                    iwebTABELLA_AggiungiRigaInPopup('popupTabellaComputiInserimento');
                                "></div>
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th>Codice</th>
                            <th>Titolo</th>
                            <th>Descrizione</th>
                            <th>Stato</th>
                            <th>Tipo</th>
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
                            <th></th>
                            <%-- PAGAMENTO PREDEFINITO --%>
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
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaClientiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');"></div>--%>
                                <%--<div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaComputi');"></div>--%>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_computo.id"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_computo.codice iwebCodice"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_computo.titolo iwebDescrizione"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_computo.descrizione iwebDescrizione"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_computo.stato"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_computo.tipo"></span>
                            </td>
                            <td class="iwebNascosto">
                                <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                    onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaComputi');
                                          iwebTABELLA_EliminaRigaInPopup('popupTabellaComputiElimina')">
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
                                        <select id="Select2" onchange="iwebTABELLA_FooterCambiaPageSize()">
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
                        SELECT
                            computo.id as 'computo.id',
                            computo.codice as 'computo.codice',
                            computo.titolo as 'computo.titolo',
                            computo.descrizione as 'computo.descrizione',
                            computo.stato as 'computo.stato',
                            computo.tipo as 'computo.tipo',

                            cantiere.id as 'cantiere.id',
                            cantiere.codice as 'cantiere.codice'

                        FROM computo
                            LEFT JOIN cantiere on computo.idcantiere = cantiere.id

                        WHERE computo.idcliente = @idcliente 
                    ") %></span>
                    <span class="iwebPARAMETRO">@idcliente = tabellaClienti_selectedValue_cliente.id</span>
                </span>


                <%-- inserimento --%>
                <div id="popupTabellaComputiInserimento" class="popup popupType2" style="display: none">
                    <div>
                        <div class="popupHeader">
                            <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()"></div>
                            <div class="popupTitolo l">Inserisci nuovo computo</div>
                            <div class="b"></div>
                        </div>
                        <div class="popupCorpo">
                            <table>
                                <tr>
                                    <td>Cantiere</td>
                                    <td>
                                        <div class="iwebAUTOCOMPLETAMENTO iwebCAMPO_cantiere.id" id="popupTabellaComputiInserimentoiwebAUTOCOMPLETAMENTOCantiere">
                                            <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                            <%-- Chiave dell'el selezionato --%>
                                            <span class="iwebNascosto"></span>

                                            <%-- Valore dell'el selezionato --%>
                                            <input type="text" autocomplete="off" class="iwebTIPOCAMPO_varchar iwebCAMPO_cantiere.codice"
                                                onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                                                onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)" 
                                                onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)"/>

                                            <%-- Query di ricerca --%>
                                            <span class="iwebSQLSELECT">
                                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                                    SELECT id as chiave, codice as valore
                                                    FROM cantiere
                                                    WHERE codice like @codice
                                                ") %></span>
                                                <span class="iwebPARAMETRO">@codice = like_popupTabellaComputiInserimentoiwebAUTOCOMPLETAMENTOCantiere_getValore</span>
                                            </span>
                                            <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tipo</td>
                                    <td class="iwebCAMPO_computo.tipo">
                                        <select id="popupTabellaComputiInserimentoTipo">
                                            <option value="Preventivo">Preventivo</option>
                                            <option value="Consuntivo">Consuntivo</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Codice *</td>
                                    <td>
                                        <input id="popupTabellaComputiInserimentoCodice" type="text" 
                                            class="iwebCAMPO_codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                            onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                </tr>
                                <tr>
                                    <td>Titolo *</td>
                                    <td>
                                        <input id="popupTabellaComputiInserimentoTitolo" type="text" 
                                            class="iwebCAMPO_titolo iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                            onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                </tr>
                                <tr>
                                    <td>Descrizione</td>
                                    <td><%--<input id="popupTabellaComputiInserimentoDescrizione" type="text" class="iwebCAMPO_descrizione" />--%>
                                        <textarea id="popupTabellaComputiInserimentoDescrizione" class="iwebCAMPO_descrizione iwebTIPOCAMPO_memo"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Data di consegna</td>
                                    <td>
                                        <input id="popupTabellaComputiInserimentoDataDiConsegna" class="iwebCAMPO_datadiconsegna iwebTIPOCAMPO_date" placeholder="gg/mm/aaaa"
                                            onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                            type="text" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Condizioni prima pagina offerta</td>
                                    <td><%--<input id="popupTabellaComputiInserimentoCondizioniPrimaPagina" type="text" class="iwebCAMPO_condizioniprimapagina" />--%>
                                        <textarea id="popupTabellaComputiInserimentoCondizioniPrimaPagina" class="iwebCAMPO_condizioniprimapagina iwebTIPOCAMPO_memo"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Condizioni ultima pagina offerta</td>
                                    <td><%--<input id="popupTabellaComputiInserimentoCondizioniUltimaPagina" type="text" class="iwebCAMPO_condizioniultimapagina" />--%>
                                        <textarea id="popupTabellaComputiInserimentoCondizioniUltimaPagina" class="iwebCAMPO_condizioniultimapagina iwebTIPOCAMPO_memo"></textarea>

                                    </td>
                                </tr>
                                <tr>
                                    <td>Stato</td>
                                    <td>
                                        <select id="popupTabellaComputiInserimentoStato">
                                            <option value="Aperto" selected>Aperto</option>
                                            <option value="Bloccato">Bloccato</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="popupFooter">
                            <div class="btn btn-warning" onclick="chiudiPopupType2()">Annulla</div>
                            <%-- IdPopupAssociato, nomeQuery, parametriQuery, attesaRispostaServer --%>
                            <div class="btn btn-success" onclick="popupTabellaComputiInserimento_inserisci()">Inserisci</div>
                            <%--<span class="iwebSQLINSERT">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                    INSERT INTO computo (idcantiere, codice, titolo, descrizione, idcliente, datadiconsegna, stato, tipo, condizioniprimapagina, condizioniultimapagina)
                                    VALUES (@idcantiere, @codice, @titolo, @descrizione, @idcliente, @datadiconsegna, @stato, @tipo, @condizioniprimapagina, @condizioniultimapagina)
                                ") %></span>
                                <span class="iwebPARAMETRO">@idcantiere = popupTabellaComputiInserimentoiwebAUTOCOMPLETAMENTOCantiere_getchiave</span>
                                <span class="iwebPARAMETRO">@codice = popupTabellaComputiInserimentoCodice_value</span>
                                <span class="iwebPARAMETRO">@titolo = popupTabellaComputiInserimentoTitolo_value</span>
                                <span class="iwebPARAMETRO">@descrizione = popupTabellaComputiInserimentoDescrizione_value</span>
                                <span class="iwebPARAMETRO">@idcliente = tabellaClienti_selectedValue_cliente.id</span>
                                <span class="iwebPARAMETRO">@datadiconsegna = popupTabellaComputiInserimentoDataDiConsegna_value</span>
                                <span class="iwebPARAMETRO">@stato = popupTabellaComputiInserimentoStato_value</span>
                                <span class="iwebPARAMETRO">@tipo = popupTabellaComputiInserimentoTipo_value</span>
                                <span class="iwebPARAMETRO">@condizioniprimapagina = popupTabellaComputiInserimentoCondizioniPrimaPagina_value</span>
                                <span class="iwebPARAMETRO">@condizioniultimapagina = popupTabellaComputiInserimentoCondizioniUltimaPagina_value</span>
                            </span>--%>
                            <script>
                                function popupTabellaComputiInserimento_inserisci() {

                                    let idcliente = iwebValutaParametroAjax("tabellaClienti_selectedValue_cliente.id", null, "int?");
                                    let idcantiere = iwebValutaParametroAjax("popupTabellaComputiInserimentoiwebAUTOCOMPLETAMENTOCantiere_getchiave", null, "int?");
                                    let tipo = iwebValutaParametroAjax("popupTabellaComputiInserimentoTipo_value");
                                    let codice = iwebValutaParametroAjax("popupTabellaComputiInserimentoCodice_value");
                                    let titolo = iwebValutaParametroAjax("popupTabellaComputiInserimentoTitolo_value");
                                    let descrizione = iwebValutaParametroAjax("popupTabellaComputiInserimentoDescrizione_value");
                                    let datadiconsegna = iwebValutaParametroAjax("popupTabellaComputiInserimentoDataDiConsegna_value", null, "DateTime?");
                                    let condizioniprimapagina = iwebValutaParametroAjax("popupTabellaComputiInserimentoCondizioniPrimaPagina_value");
                                    let condizioniultimapagina = iwebValutaParametroAjax("popupTabellaComputiInserimentoCondizioniUltimaPagina_value");
                                    let stato = iwebValutaParametroAjax("popupTabellaComputiInserimentoStato_value");

                                    // if (idcliente == null) { alert("Cliente obbligatorio"); return; }
                                    // if (idcantiere == null) { alert("Cantiere obbligatorio"); return; }
                                    // if (datadiconsegna == null) { alert("Data di consegna obbligatoria"); return; }
                                    // if (idcomputo == null) { alert("Computo non definito?"); return; }

                                    // iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaComputiInserimento', 'tabellaComputi', 'nominativo, indirizzo, citta, provincia, email, telefono, cf, piva', true)

                                    let parametri = {
                                        idcliente: idcliente,
                                        idcantiere: idcantiere,
                                        tipo: tipo,
                                        codice: codice,
                                        titolo: titolo,
                                        descrizione: descrizione,
                                        datadiconsegna: datadiconsegna,
                                        condizioniprimapagina: condizioniprimapagina,
                                        condizioniultimapagina: condizioniultimapagina,
                                        stato: stato
                                    };
                                    iwebMostraCaricamentoAjax();
                                    ajax2024("/WebServiceComputi.asmx/popupTabellaComputiInserimento_inserisci", parametri, function () {

                                        iwebCaricaElemento("tabellaComputi");
                                        chiudiPopupType2B("popupTabellaComputiInserimento");

                                        iwebNascondiCaricamentoAjax();
                                    });
                                }
                            </script>
                        </div>
                    </div>
                </div>

                <%-- elimina --%>
                <div id="popupTabellaComputiElimina" class="popup popupType2" style="display: none">
                    <div>
                        <div class="popupHeader">
                            <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()"></div>
                            <div class="popupTitolo l">Eliminazione computo, ricontrolla i dati</div>
                            <div class="b"></div>
                        </div>
                        <div class="iwebTABELLA_ContenitoreParametri"></div>
                        <div class="popupCorpo">
                            <table>
                                <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                    in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                                <tr>
                                    <td>id</td>
                                    <td><span class="iwebCAMPO_computo.id"></span></td>
                                </tr>
                                <tr>
                                    <td>Nominativo</td>
                                    <td><span class="iwebCAMPO_codice"></span></td>
                                </tr>
                                <tr>
                                    <td>Indirizzo</td>
                                    <td><span class="iwebCAMPO_titolo"></span></td>
                                </tr>
                                <tr>
                                    <td>Citta</td>
                                    <td><span class="iwebCAMPO_descrizione"></span></td>
                                </tr>
                                <tr>
                                    <td>Provincia</td>
                                    <td><span class="iwebCAMPO_stato"></span></td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td><span class="iwebCAMPO_tipo"></span></td>
                                </tr>
                                <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                            </table>
                        </div>
                        <div class="popupFooter">
                            <div class="btn btn-warning" onclick="chiudiPopupType2()">Annulla</div>
                            <div class="btn btn-danger" onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaComputiElimina', 'tabellaComputi', true);">Elimina</div>
                            <span class="iwebSQLDELETE">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM computo WHERE id = @id") %></span>
                                <span class="iwebPARAMETRO">@id = tabellaComputi_selectedValue_computo.id</span>
                            </span>
                        </div>
                    </div>
                </div>
