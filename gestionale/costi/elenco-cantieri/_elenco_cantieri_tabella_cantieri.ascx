<%@ Control Language="C#" ClassName="_elenco_cantieri_tabella_cantieri" %>


        <div class="r iwebTABELLAAzioniPerSelezionati">
            <span></span>
            <select disabled>
                <option value="">Seleziona...</option>
                <option value="Elimina">Elimina</option>
            </select>
            <%-- elencoCantieri_eliminaCantiereTabellaCantieri(); --%>
            <input type="button" class="btn btn-default" value="Conferma azione" disabled onclick="elencoCantieri_iwebTABELLA_ConfermaAzionePerSelezionati()"/>
            <div class="b"></div>
            <%-- alla fine metto le varie query (per ora la delete) --%>
            <span class="iwebSQLDELETE">
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM cantiere WHERE cantiere.id=@cantiere.id") %></span>
            </span>
        </div>
        <table id="tabellaCantieri" class="iwebTABELLA iwebCHIAVE__cantiere.id iwebBIND__elementoConITab">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                            onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaCantieriInserimento');
                            document.getElementById('popupTabellaCantieriInserimentoSpanCodiceErrato').style.display = 'none';"></div>
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <th>Cliente</th>
                    <th><div class="l">Codice</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_cantiere.codice_ASC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>
                    </th>
                    <th>Indirizzo</th>
                    <th>Data inizio/fine</th>
                    <th>Descrizione</th>
                    <th>Stato</th>
                    <th>Report</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%>
                    </th>
                    <th class="iwebNascosto"></th>
                    <th>
                        <%-- filtro di testo sul campo nominativo --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_cliente.nominativo">
                            <input type="text" onkeyup="iwebCaricaElemento(cercaTablePadreRicors().id, true)" />
                        </div>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo codice --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_cantiere.codice">
                            <input type="text" onkeyup="iwebCaricaElemento(cercaTablePadreRicors().id, true)" />
                        </div>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo indirizzo --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_cantiere.indirizzo">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                        </div>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo data inizio/fine --%>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo descrizione --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_cantiere.descrizione">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                        </div>
                    </th>
                    <th class="contenitoreSelectMultiple">
                        <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_cantiere.stato">
                            <%--<select id="tabellaCantieriDDLChiuso"
                                onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option value="">Tutti</option>
                                <option value="0" selected>Aperto</option>
                                <option value="1">Chiuso</option>
                            </select>--%>
                            <select id="tabellaCantieriStato" class="iwebCAMPO_cantiere.stato" multiple="multiple"
                                onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option value="">Tutti</option>
                                <option value="Aperto" selected="selected">Aperto</option>
                                <option value="Da firmare" selected="selected">Da firmare</option>
                                <option value="Chiuso">Chiuso</option>
                            </select>
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
                        <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaCantieriModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');"></div>--%>
                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');"></div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_cantiere.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cliente.nominativo iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.codice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.indirizzo iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.cantdatainizio iwebData"></span>
                        <span class="iwebCAMPO_cantiere.cantdatafine iwebData"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.descrizione iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.stato iwebCodice"></span>
                    </td>
                    <td>
                        <div class="iwebCAMPO_LINKIDCANTIERE btn btn-default iwebCliccabile"
                            onclick="elencoCantieri_Report(iwebCAMPO_LINKIDCANTIERE)">
                            Report
                        </div>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaCantieriElimina')"></div>
                        <%--<input type="button" value="Elimina" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');
                                                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaCantieriElimina')" />--%>
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
                    <td></td>
                    <td></td>
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="Select1ASTHJJ" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                SELECT
                    cliente.nominativo as 'cliente.nominativo',
                    cliente.id as 'cliente.id',
                    cantiere.id as 'cantiere.id',
                    cantiere.codice as 'cantiere.codice',
                    cantiere.indirizzo as 'cantiere.indirizzo',
                    cantiere.cantdatainizio as 'cantiere.cantdatainizio',
                    cantiere.cantdatafine as 'cantiere.cantdatafine',
                    cantiere.descrizione as 'cantiere.descrizione',
                    cantiere.stato as 'cantiere.stato',
                    cantiere.id as 'LINKIDCANTIERE'
                FROM cantiere LEFT JOIN cliente ON cantiere.idcliente = cliente.id
            ") %></span>
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
                        <%--<tr>
                            <td>Nominativo *</td>
                            <td>
                                <div class="iwebCAMPO_cliente.nominativo">
                                    <select id="popupTabellaCantieriInserimentoDDLCliente" class="iwebDDL iwebCAMPO_cliente.id iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                        <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT nominativo as NOME, id as VALORE FROM cliente ORDER BY nominativo") %></span>
                                    </span>
                                </div>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>Nominativo *</td>
                            <td>
                                <div class="iwebAUTOCOMPLETAMENTO iwebCAMPOOBBLIGATORIO" id="iwebAUTOCOMPLETAMENTONominativo">
                                    <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                    <%-- Chiave dell'el selezionato --%>
                                    <span class="iwebNascosto iwebCAMPO_cliente.id"></span>

                                    <%-- Valore dell'el selezionato --%>
                                    <input type="text" autocomplete="off" class="iwebTIPOCAMPO_varchar iwebCAMPO_cliente.nominativo"
                                        onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this); " 
                                        onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)"
                                        onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)" />

                                    <%-- Query di ricerca --%>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                            "SELECT id as chiave, nominativo as valore FROM cliente WHERE nominativo like @nominativo ORDER BY nominativo LIMIT 3"
                                        )%></span>
                                        <span class="iwebPARAMETRO">@nominativo = like_iwebAUTOCOMPLETAMENTONominativo_getValore</span>
                                    </span>
                                    <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Codice *</td>
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
                            <td>Data inizio</td>
                            <td>
                                <input type="text" maxlength="10" placeholder="gg/mm/aaaa"
                                    class="iwebCAMPO_cantiere.cantdatainizio iwebTIPOCAMPO_date"
                                    onfocus="scwLanguage='it'; scwShow(this, event);"
                                    onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                    onclick="scwLanguage = 'it'; scwShow(this, event);"
                                    />
                            </td>
                        </tr>
                        <tr>
                            <td>Data fine</td>
                            <td>
                                <input type="text" maxlength="10" placeholder="gg/mm/aaaa"
                                    class="iwebCAMPO_cantiere.cantdatafine iwebTIPOCAMPO_date"
                                    onfocus="scwLanguage='it'; scwShow(this, event);"
                                    onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                    onclick="scwLanguage = 'it'; scwShow(this, event);"
                                    />
                            </td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><input id="popupTabellaCantieriInserimentoDescrizione" type="text" class="iwebCAMPO_cantiere.descrizione iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                    </table>
                </div>

                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="popupTabellaCantieriInserimento_conferma()">Inserisci</div>
                    <%--<div class="btn btn-success" onclick="elencoCantieri_iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaCantieriInserimento', 'tabellaCantieri', '', true)">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                            INSERT INTO cantiere (idcliente, codice, indirizzo, descrizione, stato)
                            VALUES (@idcliente, @codice, @indirizzo, @descrizione, 'Da firmare')
                        ") %></span>
                        <span class="iwebPARAMETRO">@idcliente = popupTabellaCantieriInserimento_findvalue_cliente.id</span>
                        <span class="iwebPARAMETRO">@codice = popupTabellaCantieriInserimento_findvalue_cantiere.codice</span>
                        <span class="iwebPARAMETRO">@indirizzo = popupTabellaCantieriInserimento_findvalue_cantiere.indirizzo</span>
                        <span class="iwebPARAMETRO">@descrizione = popupTabellaCantieriInserimento_findvalue_cantiere.descrizione</span>
                    </span>--%>
                    <script>
                        function popupTabellaCantieriInserimento_conferma() {
                            let codice = iwebValutaParametroAjax("popupTabellaCantieriInserimento_findvalue_cantiere.codice");
                            let indirizzo = iwebValutaParametroAjax("popupTabellaCantieriInserimento_findvalue_cantiere.indirizzo");
                            let cantdatainizio = iwebValutaParametroAjax("popupTabellaCantieriInserimento_findvalue_cantiere.cantdatainizio", null, "DateTime?");
                            let cantdatafine = iwebValutaParametroAjax("popupTabellaCantieriInserimento_findvalue_cantiere.cantdatafine", null, "DateTime?");
                            let descrizione = iwebValutaParametroAjax("popupTabellaCantieriInserimento_findvalue_cantiere.descrizione");
                            let idcliente = iwebValutaParametroAjax("popupTabellaCantieriInserimento_findvalue_cliente.id", null, "int?");

                            let parametri = {
                                idcliente: idcliente,
                                codice: codice,
                                indirizzo: indirizzo,
                                cantdatainizio: cantdatainizio,
                                cantdatafine: cantdatafine,
                                descrizione: descrizione
                            };
                            iwebMostraCaricamentoAjax();
                            ajax2024("/WebServiceComputi.asmx/popupTabellaCantieriInserimento_conferma", parametri, function () {

                                iwebCaricaElemento("tabellaCantieri");
                                chiudiPopupType2B("popupTabellaCantieriInserimento");

                                iwebNascondiCaricamentoAjax();
                            });
                        }
                    </script>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <div id="popupTabellaCantieriElimina" class="popup popupType2" style="display:none">
            <div>
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
                            <td>Indirizzo</td>
                            <td><span class="iwebCAMPO_cantiere.indirizzo"></span></td>
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
                    <div class="btn btn-danger" onclick="elencoCantieri_eliminaCantiereTabellaCantieri();">Elimina</div>
                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM cantiere WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = tabellaCantieri_selectedValue_cantiere.id</span>
                    </span>
                </div>
            </div>
        </div>
