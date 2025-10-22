<%@ Control Language="C#" ClassName="_anagrafica_clienti_tabella_clienti" %>

<%@ Register TagPrefix="anagraficaclienti" TagName="tabellacomputicollegati" Src="_anagraficaclienti_tabellaclienti_computicollegati.ascx" %>
<%@ Register TagPrefix="anagraficaclienti" TagName="tabellacantiericollegati" Src="_anagraficaclienti_tabellaclienti_cantiericollegati.ascx" %>

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
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM cliente WHERE cliente.id=@cliente.id") %></span>
            </span>
        </div>

        <table id="tabellaClienti" class="iwebTABELLA iwebCHIAVE__cliente.id iwebBIND__elementoConITab">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <%--<input type="button" value="Aggiungi" onclick="apriPopupType2('popupTabellaClientiInserimento');" />--%>
                        <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaClientiInserimento');"></div>
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <th>Nominativo</th>
                    <%--<th><div class="l">Nominativo</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_cliente.nominativo_ASC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>
                    </th>--%>
                    <th>Indirizzo</th>
                    <th>Citta</th>
                    <th>Provincia</th>
                    <th>Email</th>
                    <th>Telefono</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%></th>
                    <th>
                        <%-- filtro di testo sul campo nominativo --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_nominativo">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                        </div>
                    </th>
                    <th></th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_citta">
                            <%-- potrei aggiungere il codice per fare in alternativa: --%>
                            <select id="ddlFiltroClientiCitta" class="iwebDDL"
                                onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option class="iwebAGGIUNTO" value="-1">Tutti</option>
                            </select>
                            <span class="iwebSQLSELECT">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT DISTINCT(citta) as VALORE FROM cliente") %></span>
                            </span>
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_provincia">
                            <%-- potrei aggiungere il codice per fare in alternativa: --%>
                            <select id="ddlFiltroClientiProvincia" class="iwebDDL" 
                                onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option class="iwebAGGIUNTO" value="-1">Tutti</option>
                            </select>
                            <span class="iwebSQLSELECT">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT DISTINCT(provincia) as VALORE FROM cliente") %></span>
                            </span>
                            <div class="selectMultiple"></div>
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
                        <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaClientiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');"></div>--%>
                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');"></div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_cliente.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_nominativo"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_indirizzo"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_citta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_provincia"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_email"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_telefono"></span>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaClientiElimina')"></div>
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
                    <div class="iwebPAGESIZE"><select id="Select1" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT cliente.id as 'cliente.id', cliente.* " 
              + "FROM cliente "
              + "ORDER BY cliente.id DESC"
            ) %></span>
        </span>

        <%-- inserimento --%>
        <div id="popupTabellaClientiInserimento" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Inserisci nuovo cliente</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <table>
                        <tr>
                            <td>Nominativo *</td>
                            <td><input id="popupTabellaClientiInserimentoNominativo" type="text" 
                                class="iwebCAMPO_nominativo iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Indirizzo</td>
                            <td><input id="popupTabellaClientiInserimentoIndirizzo" type="text" class="iwebCAMPO_indirizzo iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Citta</td>
                            <td><input id="popupTabellaClientiInserimentoCitta" type="text" class="iwebCAMPO_citta iwebTIPOCAMPO_varchar" /></td>
                            <%--<td><textarea id="popupTabellaClientiInserimentoCitta" class="iwebCAMPO_citta iwebTIPOCAMPO_memo" ></textarea></td>--%>
                        </tr>
                        <tr>
                            <td>Provincia</td>
                            <td><input id="popupTabellaClientiInserimentoProvincia" type="text" class="iwebCAMPO_provincia iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><input id="popupTabellaClientiInserimentoEmail" type="text" class="iwebCAMPO_email iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Telefono</td>
                            <td><input id="popupTabellaClientiInserimentoTelefono" type="text" class="iwebCAMPO_telefono iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>cf</td>
                            <td><input id="popupTabellaClientiInserimentoCF" type="text" class="iwebCAMPO_cf iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>piva</td>
                            <td><input id="popupTabellaClientiInserimentoPiva" type="text" class="iwebCAMPO_piva iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                    </table>
                </div>

                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <%-- IdPopupAssociato, nomeQuery, parametriQuery, attesaRispostaServer --%>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaClientiInserimento', 'tabellaClienti', 'nominativo, indirizzo, citta, provincia, email, telefono, cf, piva', true)">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("INSERT INTO cliente (nominativo, indirizzo, citta, provincia, email, telefono, cf, piva) VALUES(@nominativo, @indirizzo, @citta, @provincia, @email, @telefono, @cf, @piva)") %></span>
                        <span class="iwebPARAMETRO">@nominativo = popupTabellaClientiInserimentoNominativo_value</span>
                        <span class="iwebPARAMETRO">@indirizzo = popupTabellaClientiInserimentoIndirizzo_value</span>
                        <span class="iwebPARAMETRO">@citta = popupTabellaClientiInserimentoCitta_value</span>
                        <span class="iwebPARAMETRO">@provincia = popupTabellaClientiInserimentoProvincia_value</span>
                        <span class="iwebPARAMETRO">@email = popupTabellaClientiInserimentoEmail_value</span>
                        <span class="iwebPARAMETRO">@telefono = popupTabellaClientiInserimentoTelefono_value</span>
                        <span class="iwebPARAMETRO">@cf = popupTabellaClientiInserimentoCF_value</span>
                        <span class="iwebPARAMETRO">@piva = popupTabellaClientiInserimentoPiva_value</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- modifica --%>
        <div id="popupTabellaClientiModifica" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Modifica anagrafica cliente</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <div class="iwebTABELLA_ContenitoreParametri"></div>
                    <table>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td><span class="iwebCAMPO_cliente.id"></span></td>
                        </tr>
                        <tr>
                            <td>Nominativo *</td>
                            <td><input type="text" class="iwebCAMPO_nominativo iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Telefono</td>
                            <td><input type="text" class="iwebCAMPO_tel"/></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><input type="text" class="iwebCAMPO_mail"/></td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaClientiModifica', 'tabellaClienti', 'nominativo,tel,mail', 'cliente.id', true);">Aggiorna</div>
                    <span class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE cliente SET nominativo = @nominativo, tel = @tel, mail = @mail WHERE id = @id") %></span>
	                    <span class="iwebPARAMETRO">@nominativo = popupTabellaClientiModifica_findValue_nominativo</span>
	                    <span class="iwebPARAMETRO">@tel = popupTabellaClientiModifica_findValue_tel</span>
	                    <span class="iwebPARAMETRO">@mail = popupTabellaClientiModifica_findValue_mail</span>
	                    <span class="iwebPARAMETRO">@id = popupTabellaClientiModifica_findValue_cliente.id</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <script>
            function funzionePopupTabellaClientiElimina() {
                var elPopup = document.getElementById("popupTabellaClientiElimina");

                // ottengo il bottone di eliminazione
                var bottoneElimina = document.getElementById("popupTabellaClientiElimina_BottoneElimina");
                bottoneElimina.setAttribute("disabled", "disabled");

                // ottengo le tabelle collegate
                //var elCantiere = document.getElementById("tabellaCantieriCollegati");
                //var elComputi = document.getElementById("tabellaComputiCollegati");

                // carico tabellaCantieriCollegati
                iwebCaricaElemento("tabellaCantieriCollegati", false, function () {
                    // terminato il caricamento della tabella interna:
                    var n = document.getElementById('tabellaCantieriCollegati').getElementsByTagName('tbody')[1].getElementsByTagName('td').length;
                    if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                        document.getElementById('tabellaCantieriCollegati').style.display = 'none';
                        document.getElementById('messaggioErroreSeTabellaCantieriCollegatiHaRighe').style.display = 'none';
                        //bottoneElimina.removeAttribute("disabled");


                        // carico tabellaComputiCollegati
                        iwebCaricaElemento("tabellaComputiCollegati", false, function () {
                            // terminato il caricamento della tabella interna:
                            var n = document.getElementById('tabellaComputiCollegati').getElementsByTagName('tbody')[1].getElementsByTagName('td').length;
                            if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                                document.getElementById('tabellaComputiCollegati').style.display = 'none';
                                document.getElementById('messaggioErroreSeTabellaComputiCollegatiHaRighe').style.display = 'none';
                                bottoneElimina.removeAttribute("disabled");
                            } else {
                                document.getElementById('tabellaComputiCollegati').style.display = 'initial';
                                document.getElementById('messaggioErroreSeTabellaComputiCollegatiHaRighe').style.display = 'initial';
                                // bottoneElimina.removeAttribute("disabled"); -> di default è già stato bloccato a inizio funzionePopupTabellaBolleElimina()
                            }
                        });


                    } else {
                        document.getElementById('tabellaCantieriCollegati').style.display = 'initial';
                        document.getElementById('messaggioErroreSeTabellaCantieriCollegatiHaRighe').style.display = 'initial';
                        // bottoneElimina.removeAttribute("disabled"); -> di default è già stato bloccato a inizio funzionePopupTabellaBolleElimina()


                        // carico tabellaComputiCollegati
                        iwebCaricaElemento("tabellaComputiCollegati", false, function () {
                            // terminato il caricamento della tabella interna:
                            var n = document.getElementById('tabellaComputiCollegati').getElementsByTagName('tbody')[1].getElementsByTagName('td').length;
                            if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                                document.getElementById('tabellaComputiCollegati').style.display = 'none';
                                document.getElementById('messaggioErroreSeTabellaComputiCollegatiHaRighe').style.display = 'none';
                                //bottoneElimina.removeAttribute("disabled"); -> non più possibile in questo momento.
                            } else {
                                document.getElementById('tabellaComputiCollegati').style.display = 'initial';
                                document.getElementById('messaggioErroreSeTabellaComputiCollegatiHaRighe').style.display = 'initial';
                                // bottoneElimina.removeAttribute("disabled"); -> di default è già stato bloccato a inizio funzionePopupTabellaBolleElimina()
                            }
                        });


                    }
                });

            }
        </script>
        <div id="popupTabellaClientiElimina" class="popup popupType2 iwebfunzione_funzionePopupTabellaClientiElimina" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione cliente, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">
                    <table>
                        <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                        <tr>
                            <td>id</td>
                            <td><span class="iwebCAMPO_cliente.id"></span></td>
                        </tr>
                        <tr>
                            <td>Nominativo</td>
                            <td><span class="iwebCAMPO_nominativo"></span></td>
                        </tr>
                        <tr>
                            <td>Indirizzo</td>
                            <td><span class="iwebCAMPO_indirizzo"></span></td>
                        </tr>
                        <tr>
                            <td>Citta</td>
                            <td><span class="iwebCAMPO_citta"></span></td>
                        </tr>
                        <tr>
                            <td>Provincia</td>
                            <td><span class="iwebCAMPO_provincia"></span></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><span class="iwebCAMPO_email"></span></td>
                        </tr>
                        <tr>
                            <td>Telefono</td>
                            <td><span class="iwebCAMPO_telefono"></span></td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top">Computi collegati:</td>
                            <td>
                                <anagraficaclienti:tabellacomputicollegati runat="server" />
                                <div class="b"></div>
                                <div id="messaggioErroreSeTabellaComputiCollegatiHaRighe">Cancellazione non possibile finchè c'è almeno un computo collegato a questo cliente.</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top">Cantieri collegati:</td>
                            <td>
                                <anagraficaclienti:tabellacantiericollegati runat="server" />
                                <div class="b"></div>
                                <div id="messaggioErroreSeTabellaCantieriCollegatiHaRighe">Cancellazione non possibile finchè c'è almeno un cantiere collegato a questo cliente.</div>
                            </td>
                        </tr>
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-danger" id="popupTabellaClientiElimina_BottoneElimina"
                        onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaClientiElimina', 'tabellaClienti', true);">Elimina</div>
                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM cliente WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = tabellaClienti_selectedValue_cliente.id</span>
                    </span>
                </div>
            </div>
        </div>
    </div><%-- fine tabellaSinistra --%>
