<%@ Control Language="C#" ClassName="_elenco_computi_tabella_computi" %>

    <div class="iwebTABELLAWrapper width1560 l">
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
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM computo WHERE computo.id=@computo.id") %></span>
            </span>
        </div>
        <table id="tabellaComputi" class="iwebTABELLA iwebCHIAVE__computo.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaComputiInserimento');"></div>
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <th>Voci</th>
                    <th>Organizza</th>
                    <th style="width:50px">Duplica</th>
                    <th>Cliente</th>
                    <th>Cantiere</th>
                    <th>Codice computo</th>
                    <th>Titolo</th>
                    <th>Descrizione</th>
                    <th>Stato</th>
                    <th>Tipo</th>
                    <th>Data consegna</th>
                    <th>Stampa</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th>
                        <%-- filtro di testo con autocompletamento sul campo nominativo --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_cliente.nominativo iwebFILTRORICORDA_paginaElencoComputi_tabellaComputi_nominativo">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)" />
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_cantiere.codice">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)" />
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_computo.codice">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)" />
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_computo.titolo">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)" />
                        </div>
                    </th>
                    <th></th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_computo.stato">
                            <select id="popupTabellaComputiStato"
                                onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option value="">Tutti</option>
                                <option value="Aperto" selected="selected">Aperto</option>
                                <option value="Bloccato">Bloccato</option>
                            </select>
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_computo.tipo">
                            <select id="popupTabellaComputiTipo"
                                onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option value="">Tutti</option>
                                <option value="Preventivo">Preventivo</option>
                                <option value="Consuntivo">Consuntivo</option>
                            </select>
                        </div>
                    </th>
                    <th>
                        <%--maggiore uguale di--%>
                        <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_computo.datadiconsegna">
                            <%--<input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />--%>
                            <input class="iwebCAMPO_datadiconsegna iwebTIPOCAMPO_date" placeholder="Da"
                                    onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                    type="text" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <%--minore di--%>
                        <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_computo.datadiconsegna">
                            <%--<input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />--%>
                            <input class="iwebCAMPO_datadiconsegna iwebTIPOCAMPO_date" placeholder="A"
                                    onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                    type="text" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
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
                        <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaComputiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaComputi');"></div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_cliente.id"></span>
                        <span class="iwebCAMPO_computo.id"></span>
                        <span class="iwebCAMPO_computo.condizioniprimapagina"></span>
                        <span class="iwebCAMPO_computo.condizioniultimapagina"></span>
                    </td>
                    <td>
                        <a href="../gestione-computo/gestione-computo.aspx?IDCOMPUTO=@iwebCAMPO_LinkPerComputo" class="iwebCAMPO_LinkPerComputo">
                            <div class="glyphicon glyphicon-th-list iwebCliccabile" title="Voci"></div>
                        </a>
                    </td>
                    <td>
                        <a href="../gerarchia-computo/gerarchia-computo.aspx?IDCOMPUTO=@iwebCAMPO_LinkPerComputo2" class="iwebCAMPO_LinkPerComputo2">
                            <div class="glyphicon glyphicon-list-alt iwebCliccabile" title="Organizza"></div>
                        </a>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-share" title="Duplica" onclick="
                            iwebTABELLA_SelezionaRigaComeUnica(); 
                            apriPopupType2('popupTabellaComputiDuplica');
                        "></div>

                        <div class="iwebCliccabile glyphicon glyphicon-share" style="color:red" title="Duplica" onclick="
                            iwebTABELLA_SelezionaRigaComeUnica(); 
                            if (confirm('Confermi azione?') == true) clonaComputo();
                        "></div>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cliente.nominativo"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.id iwebNascosto"></span>
                        <span class="iwebCAMPO_cantiere.codice"></span>
                        <div>
                            <span class="iwebCAMPO_cantiere.indirizzo" style="font-style:italic"></span>
                        </div>
                    </td>
                    <td>
                        <span class="iwebCAMPO_computo.codice iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_computo.titolo iwebTitolo"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_computo.descrizione iwebDescrizione iwebTroncaCrtsAt_20"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_computo.stato"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_computo.tipo"></span>
                    </td>
                    <td>
                        <%--<span class="iwebCAMPO_datadiconsegna iwebFORMATO_datetime_dd-MM-yyyy"></span>--%>
                        <span class="iwebCAMPO_computo.datadiconsegna iwebData"></span>
                    </td>
                    <td>
                        <%--<input type="button" value="PDF" onclick="generaPDF()"/>--%>
                        <div class="btn btn-default iwebCAMPO_LinkPerComputo4" onclick="stampaPDF(iwebCAMPO_LinkPerComputo4)" >
                            PDF
                        </div>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(this); iwebBind('tabellaComputi');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaComputiElimina')"></div>
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
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="Select1" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                SELECT
                    cliente.id as 'cliente.id',
                    cliente.nominativo as 'cliente.nominativo', 
                    computo.id as 'computo.id',
                    computo.id as LinkPerComputo, 
                    computo.id as LinkPerComputo2,
                    computo.id as LinkPerComputo3,
                    computo.id as LinkPerComputo4,

                    computo.codice as 'computo.codice',
                    computo.titolo as 'computo.titolo',
                    computo.descrizione as 'computo.descrizione',
                    computo.stato as 'computo.stato',
                    computo.tipo as 'computo.tipo',
                    computo.datadiconsegna as 'computo.datadiconsegna',
                    computo.condizioniprimapagina as 'computo.condizioniprimapagina',
                    computo.condizioniultimapagina as 'computo.condizioniultimapagina',

                    cantiere.id as 'cantiere.id',
                    cantiere.indirizzo as 'cantiere.indirizzo',
                    cantiere.codice as 'cantiere.codice'

                FROM computo
                    INNER JOIN cliente ON cliente.id = computo.idcliente 
                    LEFT JOIN cantiere ON computo.idcantiere = cantiere.id
                ORDER BY computo.id DESC
            ") %></span>
        </span>

        <%-- modifica --%>
        <div id="popupTabellaComputiModifica" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Modifica anagrafica computo</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <div class="iwebTABELLA_ContenitoreParametri"></div>
                    <table>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td>
                                <span class="iwebCAMPO_computo.id"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Cliente</td>
                            <td>
                                <div class="iwebAUTOCOMPLETAMENTO" 
                                    id="popupTabellaComputiModificaIwebAUTOCOMPLETAMENTOcliente">
                                    <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                    <%-- Chiave dell'el selezionato --%>
                                    <span class="iwebNascosto iwebCAMPO_cliente.id"></span>

                                    <%-- Valore dell'el selezionato --%>
                                    <input type="text" autocomplete="off" class="iwebTIPOCAMPO_varchar iwebCAMPO_cliente.nominativo"
                                        onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                                        onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)" 
                                        onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)"/>

                                    <%-- Query di ricerca --%>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                            SELECT id as chiave, nominativo as valore 
                                            FROM cliente 
                                            WHERE nominativo like @nominativo 
                                        ") %></span>
                                        <span class="iwebPARAMETRO">@nominativo = like_popupTabellaComputiModificaIwebAUTOCOMPLETAMENTOcliente_getValore</span>
                                    </span>
                                    <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Cantiere</td>
                            <td>
                                <div class="iwebAUTOCOMPLETAMENTO iwebCAMPO_cantiere.id" id="popupTabellaComputiModificaIwebAUTOCOMPLETAMENTOcantiere">
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
                                        <span class="iwebPARAMETRO">@codice = like_popupTabellaComputiModificaIwebAUTOCOMPLETAMENTOcantiere_getValore</span>
                                    </span>
                                    <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Tipo</td>
                            <td>
                                <select class="iwebCAMPO_computo.tipo">
                                    <option value="Preventivo">Preventivo</option>
                                    <option value="Consuntivo">Consuntivo</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Codice *</td>
                            <td><input type="text" 
                                class="iwebCAMPO_computo.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Titolo *</td>
                            <td><input type="text" class="iwebCAMPO_computo.titolo iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><%--<input id="popupTabellaComputiInserimentoDescrizione" type="text" class="iwebCAMPO_descrizione" />--%>
                                <textarea class="iwebCAMPO_computo.descrizione iwebTIPOCAMPO_memo"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>Data di consegna</td>
                            <td>
                                <input class="iwebCAMPO_computo.datadiconsegna iwebTIPOCAMPO_date" placeholder="gg/mm/aaaa"
                                    onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                    type="text" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>Condizioni prima pagina offerta</td>
                            <td>
                                <textarea class="iwebCAMPO_computo.condizioniprimapagina iwebTIPOCAMPO_memo"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>Condizioni ultima pagina offerta</td>
                            <td>
                                <textarea class="iwebCAMPO_computo.condizioniultimapagina iwebTIPOCAMPO_memo"></textarea>

                            </td>
                        </tr>
                        <tr>
                            <td>Stato</td>
                            <td>
                                <select class="iwebCAMPO_computo.stato">
                                    <option value="Aperto">Aperto</option>
                                    <option value="Bloccato">Bloccato</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="elencoComputi_popupTabellaComputiModifica_aggiorna()">Aggiorna</div>
                    <script>
                        function elencoComputi_popupTabellaComputiModifica_aggiorna() {

                            let idcliente = iwebValutaParametroAjax("popupTabellaComputiModifica_findValue_cliente.id", null, "int?");
                            let idcantiere = iwebValutaParametroAjax("popupTabellaComputiModificaIwebAUTOCOMPLETAMENTOcantiere_getchiave", null, "int?");
                            let tipo = iwebValutaParametroAjax("popupTabellaComputiModifica_findValue_computo.tipo");
                            let codice = iwebValutaParametroAjax("popupTabellaComputiModifica_findValue_computo.codice");
                            let titolo = iwebValutaParametroAjax("popupTabellaComputiModifica_findValue_computo.titolo");
                            let descrizione = iwebValutaParametroAjax("popupTabellaComputiModifica_findValue_computo.descrizione");
                            let datadiconsegna = iwebValutaParametroAjax("popupTabellaComputiModifica_findValue_computo.datadiconsegna", null, "DateTime?");
                            let condizioniprimapagina = iwebValutaParametroAjax("popupTabellaComputiModifica_findValue_computo.condizioniprimapagina");
                            let condizioniultimapagina = iwebValutaParametroAjax("popupTabellaComputiModifica_findValue_computo.condizioniultimapagina");
                            let stato = iwebValutaParametroAjax("popupTabellaComputiModifica_findValue_computo.stato");
                            let idcomputo = iwebValutaParametroAjax("popupTabellaComputiModifica_findValue_computo.id", null, "int?");

                            // if (idcliente == null) { alert("Cliente obbligatorio"); return; }
                            // if (idcantiere == null) { alert("Cantiere obbligatorio"); return; }
                            // if (datadiconsegna == null) { alert("Data di consegna obbligatoria"); return; }
                            // if (idcomputo == null) { alert("Computo non definito?"); return; }

                            // iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaComputiModifica', 'tabellaComputi', 'idcliente,idcantiere,tipo,codice,titolo,descrizione,datadiconsegna,condizioniprimapagina,condizioniultimapagina,stato', 'computo.id', true);

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
                                stato: stato,
                                idcomputo: idcomputo
                            };
                            iwebMostraCaricamentoAjax();
                            ajax2024("/WebServiceComputi.asmx/elencoComputi_popupTabellaComputiModifica_aggiorna", parametri, function () {

                                iwebCaricaElemento("tabellaComputi");
                                chiudiPopupType2B("popupTabellaComputiModifica");

                                iwebNascondiCaricamentoAjax();
                            });
                        }
                    </script>
                    <%--<span class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                            UPDATE computo 
                            SET idcliente = @idcliente, 
                                idcantiere = @idcantiere, 
                                tipo = @tipo, 
                                codice = @codice, 
                                titolo = @titolo, 
                                descrizione = @descrizione, 
                                datadiconsegna = @datadiconsegna, 
                                condizioniprimapagina = @condizioniprimapagina, 
                                condizioniultimapagina = @condizioniultimapagina, 
                                stato = @stato 
                            WHERE computo.id = @id 
                        ") %></span>
	                    <span class="iwebPARAMETRO">@idcliente = popupTabellaComputiModifica_findValue_cliente.id</span>
                        <span class="iwebPARAMETRO">@idcantiere = popupTabellaComputiModificaIwebAUTOCOMPLETAMENTOcantiere_getchiave</span>
	                    <span class="iwebPARAMETRO">@tipo = popupTabellaComputiModifica_findValue_computo.tipo</span>
	                    <span class="iwebPARAMETRO">@codice = popupTabellaComputiModifica_findValue_computo.codice</span>
	                    <span class="iwebPARAMETRO">@titolo = popupTabellaComputiModifica_findValue_computo.titolo</span>
	                    <span class="iwebPARAMETRO">@descrizione = popupTabellaComputiModifica_findValue_computo.descrizione</span>
	                    <span class="iwebPARAMETRO">@datadiconsegna = popupTabellaComputiModifica_findValue_computo.datadiconsegna</span>
	                    <span class="iwebPARAMETRO">@condizioniprimapagina = popupTabellaComputiModifica_findValue_computo.condizioniprimapagina</span>
	                    <span class="iwebPARAMETRO">@condizioniultimapagina = popupTabellaComputiModifica_findValue_computo.condizioniultimapagina</span>
	                    <span class="iwebPARAMETRO">@stato = popupTabellaComputiModifica_findValue_computo.stato</span>
	                    <span class="iwebPARAMETRO">@id = popupTabellaComputiModifica_findValue_computo.id</span>
                    </span>--%>
                </div>
            </div>
        </div>

        <%-- inserimento --%>
        <script>
            function funzionePopupTabellaComputiInserimento() {
                // TESTODEFAULTCONDIZIONIULTIMAPAGINAOFFERTA = "Validità offerta:" + "\n" + "Pagamenti:" + "\n" + "Note:";
                document.getElementById("popupTabellaComputiInserimentoCondizioniUltimaPaginaOfferta").value = TESTODEFAULTCONDIZIONIULTIMAPAGINAOFFERTA;
            }
        </script>
        <div id="popupTabellaComputiInserimento" class="popup popupType2 iwebfunzione_funzionePopupTabellaComputiInserimento" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Inserisci nuovo computo</div>
                    <div class="b"></div>
                </div>
                    <div class="popupCorpo">
                    <table>
                        <%--<tr class="iwebNascosto">
                            <td>id</td>
                            <td>
                                <span class="iwebCAMPO_cliente.id"></span>
                                <span class="iwebCAMPO_computo.id"></span>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>Cliente</td>
                            <td>
                                <div class="iwebAUTOCOMPLETAMENTO iwebCAMPO_cliente.id" id="iwebAUTOCOMPLETAMENTOClienteInserimento">
                                    <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                    <%-- Chiave dell'el selezionato --%>
                                    <span class="iwebNascosto"></span>

                                    <%-- Valore dell'el selezionato --%>
                                    <input type="text" autocomplete="off" class="iwebTIPOCAMPO_varchar"
                                        onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                                        onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)" 
                                        onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)"/>

                                    <%-- Query di ricerca --%>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT id as chiave, nominativo as valore FROM cliente WHERE nominativo like @nominativo LIMIT 5") %></span>
                                        <span class="iwebPARAMETRO">@nominativo = like_iwebAUTOCOMPLETAMENTOClienteInserimento_getValore</span>
                                    </span>
                                    <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                                </div>
                            </td>
                        </tr>
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
                            <td>
                                <select id="popupTabellaComputiInserimentoTipo">
                                    <option value="Preventivo">Preventivo</option>
                                    <option value="Consuntivo">Consuntivo</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Codice *</td>
                            <td><input type="text" id="popupTabellaComputiInserimentoCodice"
                                class="iwebCAMPO_codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Titolo *</td>
                            <td><input type="text" id="popupTabellaComputiInserimentoTitolo"
                                class="iwebCAMPO_titolo iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td>
                                <textarea class="iwebCAMPO_descrizione iwebTIPOCAMPO_memo" id="popupTabellaComputiInserimentoDescrizione"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>Data di consegna</td>
                            <td>
                                <input id="popupTabellaComputiInserimentoDataDiConsegna"
                                    class="iwebCAMPO_datadiconsegna iwebTIPOCAMPO_date" placeholder="gg/mm/aaaa"
                                    type="text" onfocus="scwLanguage='it'; scwShow(this, event);" 
                                    onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                    onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>Condizioni prima pagina offerta</td>
                            <td>
                                <textarea class="iwebCAMPO_condizioniprimapagina iwebTIPOCAMPO_memo"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>Condizioni ultima pagina offerta</td>
                            <td>
                                <textarea id="popupTabellaComputiInserimentoCondizioniUltimaPaginaOfferta"
                                    class="iwebCAMPO_condizioniultimapagina iwebTIPOCAMPO_memo"></textarea>

                            </td>
                        </tr>
                        <tr>
                            <td>Stato</td>
                            <td>
                                <select class="iwebCAMPO_stato" id="popupTabellaComputiInserimentoStato">
                                    <option value="Aperto">Aperto</option>
                                    <option value="Bloccato">Bloccato</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="popupTabellaComputiInserimento_inserisci()">Inserisci</div>
                    <%--<span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                            INSERT INTO computo (idcantiere, codice, titolo, descrizione, idcliente, datadiconsegna, stato, tipo, condizioniprimapagina, condizioniultimapagina)
                            VALUES (@idcantiere, @codice, @titolo, @descrizione, @idcliente, @datadiconsegna, @stato, @tipo, @condizioniprimapagina, @condizioniultimapagina)
                        ") %></span>
                        <span class="iwebPARAMETRO">@idcantiere = popupTabellaComputiInserimentoiwebAUTOCOMPLETAMENTOCantiere_getchiave</span>
	                    <span class="iwebPARAMETRO">@codice = popupTabellaComputiInserimento_findValue_codice</span>
	                    <span class="iwebPARAMETRO">@titolo = popupTabellaComputiInserimento_findValue_titolo</span>
	                    <span class="iwebPARAMETRO">@descrizione = popupTabellaComputiInserimento_findValue_descrizione</span>
                        <span class="iwebPARAMETRO">@idcliente = iwebAUTOCOMPLETAMENTOClienteInserimento_getchiave</span>
	                    <span class="iwebPARAMETRO">@datadiconsegna = popupTabellaComputiInserimento_findValue_datadiconsegna</span>
	                    <span class="iwebPARAMETRO">@stato = popupTabellaComputiInserimento_findValue_stato</span>
	                    <span class="iwebPARAMETRO">@tipo = popupTabellaComputiInserimento_findValue_tipo</span>
	                    <span class="iwebPARAMETRO">@condizioniprimapagina = popupTabellaComputiInserimento_findValue_condizioniprimapagina</span>
	                    <span class="iwebPARAMETRO">@condizioniultimapagina = popupTabellaComputiInserimento_findValue_condizioniultimapagina</span>
                    </span>--%>
                    <script>
                        function popupTabellaComputiInserimento_inserisci() {

                            let idcliente = iwebValutaParametroAjax("iwebAUTOCOMPLETAMENTOClienteInserimento_getchiave", null, "int?");
                            let idcantiere = iwebValutaParametroAjax("popupTabellaComputiInserimentoiwebAUTOCOMPLETAMENTOCantiere_getchiave", null, "int?");
                            let tipo = iwebValutaParametroAjax("popupTabellaComputiInserimentoTipo_value");
                            let codice = iwebValutaParametroAjax("popupTabellaComputiInserimentoCodice_value");
                            let titolo = iwebValutaParametroAjax("popupTabellaComputiInserimentoTitolo_value");
                            let descrizione = iwebValutaParametroAjax("popupTabellaComputiInserimentoDescrizione_value");
                            let datadiconsegna = iwebValutaParametroAjax("popupTabellaComputiInserimentoDataDiConsegna_value", null, "DateTime?");
                            let condizioniprimapagina = iwebValutaParametroAjax("popupTabellaComputiInserimento_findValue_condizioniprimapagina");
                            let condizioniultimapagina = iwebValutaParametroAjax("popupTabellaComputiInserimento_findValue_condizioniultimapagina");
                            let stato = iwebValutaParametroAjax("popupTabellaComputiInserimentoStato_value");

                            // if (idcliente == null) { alert("Cliente obbligatorio"); return; }
                            // if (idcantiere == null) { alert("Cantiere obbligatorio"); return; }
                            // if (datadiconsegna == null) { alert("Data di consegna obbligatoria"); return; }
                            // if (idcomputo == null) { alert("Computo non definito?"); return; }

                            // iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaComputiInserimento', 'tabellaComputi', '', true)

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
        <div id="popupTabellaComputiElimina" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione computo, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">
                    <table>
                        <tr>
                            <td>id</td>
                            <td><span class="iwebCAMPO_computo.id"></span></td>
                        </tr>
                        <tr>
                            <td>Nominativo</td>
                            <td><span class="iwebCAMPO_cliente.nominativo"></span></td>
                        </tr>
                        <tr>
                            <td>Cantiere</td>
                            <td><span class="iwebCAMPO_cantiere.codice"></span></td>
                        </tr>
                        <tr>
                            <td>Codice</td>
                            <td><span class="iwebCAMPO_computo.codice"></span></td>
                        </tr>
                        <tr>
                            <td>Titolo</td>
                            <td><span class="iwebCAMPO_computo.titolo"></span></td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><span class="iwebCAMPO_computo.descrizione"></span></td>
                        </tr>
                        <tr>
                            <td>Stato</td>
                            <td><span class="iwebCAMPO_computo.stato"></span></td>
                        </tr>
                        <tr>
                            <td>Tipo</td>
                            <td><span class="iwebCAMPO_computo.tipo"></span></td>
                        </tr>
                        <tr>
                            <td>Data consegna</td>
                            <td><span class="iwebCAMPO_computo.datadiconsegna iwebData"></span></td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2(this)" >Annulla</div>
                    <div class="btn btn-danger" onclick="elencoComputi_popupTabellaComputiElimina_elimina()">Elimina</div>
                    <script>
                        function elencoComputi_popupTabellaComputiElimina_elimina() {
                            let idcomputo = iwebValutaParametroAjax("tabellaComputi_selectedValue_computo.id", null, "int?");

                            // if (idcomputo == null) { alert("Computo non definito?"); return; }

                            let parametri = {
                                idcomputo: idcomputo
                            };
                            iwebMostraCaricamentoAjax();
                            ajax2024("/WebServiceComputi.asmx/elencoComputi_popupTabellaComputiElimina_elimina", parametri, function () {

                                iwebCaricaElemento("tabellaComputi");
                                chiudiPopupType2B("popupTabellaComputiElimina");

                                iwebNascondiCaricamentoAjax();
                            });
                        }
                    </script>
                </div>
            </div>
        </div>
    </div>



    <%-- Duplica --%>
    <div id="popupTabellaComputiDuplica" class="popup popupType2" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Duplica computo</div>
                <div class="b"></div>
            </div>
            <div class="iwebTABELLA_ContenitoreParametri"></div>
            <div class="popupCorpo">
                <table>
                    <tr>
                        <td>Ricarico %</td>
                        <td>
                            <input type="text" id="popupTabellaComputiDuplicaRicaricoPercentuale" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-danger" onclick="
                    elencoComputi_duplicaComputo('tabellaComputi');
                ">Duplica</div>
                <%--<span class="iwebSQLDELETE">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM computo WHERE id = @id") %></span>
                    <span class="iwebPARAMETRO">@id = tabellaComputi_selectedValue_computo.id</span>
                </span>--%>
            </div>
        </div>
    </div>


    <%--<script>
        function getXmlhttpItem(responseText, key_, castType) {
            if (isObject(responseText) && responseText.responseText) responseText = responseText.responseText;
            if (key_ != null) {
                if (castType != null)
                    return parseToType(JSON.parse(JSON.parse(responseText).d)[key_], castType);
                else
                    return JSON.parse(JSON.parse(responseText).d)[key_];
            } else {
                JSON.parse(JSON.parse(responseText).d);
            }
        }
        function isObject(val) {
            if (val === null) { return false; }
            return ((typeof val === 'function') || (typeof val === 'object'));
        }
        function parseToType(value, valuetype) {
            if (valuetype == null) console.log("%cErrore in parseToType: secondo parametro mancante", "color:darkred");
            valuetype = valuetype.toLowerCase();
            if (valuetype == "char") return (value + "")[0];
            if (valuetype == "string") return value == null ? value : value + "";
            if (valuetype == "stringnull") return (value + "") ? value + "" : null; // OBSOLETO, ED ERRATO
            if (valuetype == "bool" || valuetype == "boolean") {
                if (value && value != "0" && value != "false")
                    return true; else return false;
            }
            if (valuetype == "int") {
                value = parseInt(value);
                if (isNaN(value)) value = 0;
                return value;
            }
            if (valuetype == "int?") {
                if (value === "" || value === null) {
                    value = null;
                } else {
                    value = parseToType(value, "int");
                }
                return value;
            }
            if (valuetype == "double") {
                if (value != null && value + "" != "") value = value.toString().replace(",", ".");
                value = parseFloat(value);
                if (isNaN(value)) value = 0;
                return value;
            }
            if (valuetype == "double?") {
                if (value === "" || value === null) {
                    value = null;
                } else {
                    value = parseToType(value, "double");
                }
            }
            if (valuetype == "date") {
                if (parseToType(value, "bool")) return new Date(value + ""); /* consigliato yyyy mm dd */
                return null;
            }
            if (valuetype == "tojson") return JSON.stringify(value);
            if (valuetype == "fromjson") return JSON.parse(value);
            return value;
        }
    </script>--%>
    <script>
        function clonaComputo() {
            iwebMostraCaricamentoAjax();

            let idcomputosorg = iwebValutaParametroAjax('tabellaComputi_selectedValue_computo.id');

            let xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status != 200) alertEConsole(xmlhttp.responseText.replace("\\r\\n", "\r\n\r\n")); else if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    alert('Azione completata');
                    //let isentrata = getXmlhttpItem(xmlhttp, 'isentrata', 'bool');
                    //let nome = getXmlhttpItem(xmlhttp, 'nome'); // ATTENZIONE: per gli string NON dichiarare il tipo. Dichiarando il tipo getXmlhttpItem(xmlhttp, 'nome', 'string'); il valore estratto nel caso di null sarebbe "null" e non null. 

                    iwebNascondiCaricamentoAjax();
                }
            }
            let jsonAsObject = {
                idcomputosorg: parseInt(idcomputosorg)
            }
            xmlhttp.open('POST', getRootPath() + '/WebServiceComputi.asmx/clonaComputo', true);
            xmlhttp.setRequestHeader('Content-type', 'application/json'); let jsonAsString = JSON.stringify(jsonAsObject); xmlhttp.send(jsonAsString);
        }
        function alertEConsole(messaggio) {
            alert(messaggio);
            console.log("%c[" + messaggio + "]", "color:darkred");
        }

    </script>
