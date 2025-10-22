<%@ Control Language="C#" ClassName="_anagrafica_fornitori_tabella_fornitori" %>

<%@ Register TagPrefix="anagraficafornitori" TagName="tabellabollafatturacollegati" Src="_anagraficafornitori_tabellabollafatturacollegati.ascx" %>
<%@ Register TagPrefix="anagraficafornitori" TagName="tabellaprodotticollegati" Src="_anagraficafornitori_tabellaprodotticollegati.ascx" %>

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
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM fornitore WHERE fornitore.id=@fornitore.id") %></span>
            </span>
        </div>
        <table id="tabellaFornitori" class="iwebTABELLA iwebCHIAVE__fornitore.id iwebBIND__elementoConITab">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaFornitoriInserimento');"></div>
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <th><div class="l">Ragione sociale</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_fornitore.ragionesociale_ASC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>
                    </th>
                    <th>Indirizzo</th>
                    <th>Citta</th>
                    <th>Provincia</th>
                    <th>Telefono</th>
                    <th>Email</th>
                    <th>Tipo fornitore</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%>
                    </th>
                    <th class="iwebNascosto"></th>
                    <th>
                        <%-- filtro di testo sul campo nominativo --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_fornitore.ragionesociale">
                            <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                        </div>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo indirizzo --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_fornitore.indirizzo">
                            <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                        </div>
                    </th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th>
                        <%-- filtro di testo sul campo email --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_fornitore.email">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_fornitore.tipofornitore">
                            <select id="peroranonservelidqui"
                                onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option value="">Seleziona...</option>
                                <option value="Materiale">Materiale</option>
                                <option value="Servizio">Servizio generico</option>
                                <option value="Professionista">Professionista</option>
                                <option value="Lavorazione">Lavorazione</option>
                                <option value="Manodopera">Manodopera</option>
                            </select>
                        </div>
                    </th>
                    <th></th><%-- ALTRO --%>
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td>
                        <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaFornitoriModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaFornitori');"></div>--%>
                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaFornitori');"></div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_fornitore.id"></span>
                        <span class="iwebCAMPO_fornitore.cf"></span>
                        <span class="iwebCAMPO_fornitore.piva"></span>
                        <span class="iwebCAMPO_fornitore.fax"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.indirizzo iwebDescrizione iwebTroncaCrtsAt_15"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.citta iwebDescrizione iwebTroncaCrtsAt_15"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.provincia iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.telefono iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.email iwebDescrizione iwebTroncaCrtsAt_15"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.tipofornitore iwebDescrizione"></span>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaFornitori');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaFornitoriElimina')"></div>
                        <%--<input type="button" value="Elimina" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaFornitori');
                                                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaFornitoriElimina')" />--%>
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
                    <td><%--<b class="r">Totale</b>--%></td>
                    <td>
                        <%--<span id="Span1" class="iwebTOTALE iwebQuantita"></span>
                        <span class="iwebSQLTOTAL">fornitore.id</span>--%>
                    </td>
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
        <%--<span class="iwebSQLSELECT">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT * FROM fornitore") %></span>
        </span>--%>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT fornitore.id as 'fornitore.id', "
                                                                + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "
                                                                + "       fornitore.indirizzo as 'fornitore.indirizzo', "
                                                                + "       fornitore.citta as 'fornitore.citta', "
                                                                + "       fornitore.provincia as 'fornitore.provincia', "
                                                                + "       fornitore.telefono as 'fornitore.telefono', "
                                                                + "       fornitore.email as 'fornitore.email', "
                                                                + "       fornitore.cf as 'fornitore.cf', "
                                                                + "       fornitore.piva as 'fornitore.piva', "
                                                                + "       fornitore.fax as 'fornitore.fax', "
                                                                + "       fornitore.tipofornitore as 'fornitore.tipofornitore' "
                                                                + "FROM fornitore ") %></span>
        </span>

        <%-- inserimento --%>
        <div id="popupTabellaFornitoriInserimento" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Inserisci nuovo fornitore</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <table>
                        <tr>
                            <td>Ragione sociale *</td>
                            <td><input id="popupTabellaFornitoriInserimentoRagionesociale" type="text" 
                                class="iwebCAMPO_fornitore.ragionesociale iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Indirizzo</td>
                            <td><input id="popupTabellaFornitoriInserimentoIndirizzo" type="text" class="iwebCAMPO_fornitore.indirizzo iwebTIPOCAMPO_varchar"/></td>
                        </tr>
                        <tr>
                            <td>Citta</td>
                            <td><input id="popupTabellaFornitoriInserimentoCitta" type="text" class="iwebCAMPO_fornitore.citta iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Provincia</td>
                            <td><input id="popupTabellaFornitoriInserimentoProvincia" type="text" class="iwebCAMPO_fornitore.provincia iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Telefono</td>
                            <td><input id="popupTabellaFornitoriInserimentoTelefono" type="text" class="iwebCAMPO_fornitore.telefono iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><input id="popupTabellaFornitoriInserimentoEmail" type="text" class="iwebCAMPO_fornitore.email iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Cf</td>
                            <td><input id="popupTabellaFornitoriInserimentoCf" type="text" class="iwebCAMPO_fornitore.cf iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Piva</td>
                            <td><input id="popupTabellaFornitoriInserimentoPiva" type="text" class="iwebCAMPO_fornitore.piva iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Fax</td>
                            <td><input id="popupTabellaFornitoriInserimentoFax" type="text" class="iwebCAMPO_fornitore.fax iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Tipo</td>
                            <td>
                                <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_fornitore.tipofornitore">
                                    <select id="popupTabellaFornitoriInserimentoDDLtipoFornitore"
                                        onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                        <option value="Materiale">Materiale</option>
                                        <option value="Servizio">Servizio generico</option>
                                        <option value="Professionista">Professionista</option>
                                        <option value="Lavorazione">Lavorazione</option>
                                        <option value="Manodopera">Manodopera</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <%-- IdPopupAssociato, nomeQuery, parametriQuery, attesaRispostaServer --%>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaFornitoriInserimento', 'tabellaFornitori', 'ragionesociale, indirizzo, citta, provincia, telefono, email, cf, piva, fax', true)">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("INSERT INTO fornitore (ragionesociale, indirizzo, citta, provincia, telefono, email, cf, piva, fax, tipofornitore) VALUES(@ragionesociale, @indirizzo, @citta, @provincia, @telefono, @email, @cf, @piva, @fax, @tipofornitore)") %></span>
                        <span class="iwebPARAMETRO">@ragionesociale = popupTabellaFornitoriInserimentoRagionesociale_value</span>
                        <span class="iwebPARAMETRO">@indirizzo = popupTabellaFornitoriInserimentoIndirizzo_value</span>
                        <span class="iwebPARAMETRO">@citta = popupTabellaFornitoriInserimentoCitta_value</span>
                        <span class="iwebPARAMETRO">@provincia = popupTabellaFornitoriInserimentoProvincia_value</span>
                        <span class="iwebPARAMETRO">@telefono = popupTabellaFornitoriInserimentoTelefono_value</span>
                        <span class="iwebPARAMETRO">@email = popupTabellaFornitoriInserimentoEmail_value</span>
                        <span class="iwebPARAMETRO">@cf = popupTabellaFornitoriInserimentoCf_value</span>
                        <span class="iwebPARAMETRO">@piva = popupTabellaFornitoriInserimentoPiva_value</span>
                        <span class="iwebPARAMETRO">@fax = popupTabellaFornitoriInserimentoFax_value</span>
                        <span class="iwebPARAMETRO">@tipofornitore = popupTabellaFornitoriInserimentoDDLtipoFornitore_value</span>
                    </span>
                </div>

            </div>
        </div>

        <%-- elimina --%>
        <script>
            //tabellaFornitoriCollegati
            function funzionePopupTabellaProdottiElimina() {
                var elPopup = document.getElementById("popupTabellaFornitoriElimina");

                // ottengo il bottone di eliminazione
                var bottoneElimina = document.getElementById("popupTabellaFornitoriElimina_BottoneElimina");
                bottoneElimina.setAttribute("disabled", "disabled");

                // ottengo le tabelle collegate
                var elCantiere = document.getElementById("tabellaProdottiCollegati");
                var elComputi = document.getElementById("tabellaBollafatturaCollegati");

                // carico tabellaProdottiCollegati
                iwebCaricaElemento("tabellaProdottiCollegati", false, function () {
                    // terminato il caricamento della tabella interna:
                    var n = document.getElementById('tabellaProdottiCollegati').getElementsByTagName('tbody')[1].getElementsByTagName('td').length;
                    if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                        document.getElementById('tabellaProdottiCollegati').style.display = 'none';
                        document.getElementById('messaggioErroreSeTabellaProdottiCollegatiHaRighe').style.display = 'none';
                        //bottoneElimina.removeAttribute("disabled");


                        // carico tabellaBollafatturaCollegati
                        iwebCaricaElemento("tabellaBollafatturaCollegati", false, function () {
                            // terminato il caricamento della tabella interna:
                            var n = document.getElementById('tabellaBollafatturaCollegati').getElementsByTagName('tbody')[1].getElementsByTagName('td').length;
                            if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                                document.getElementById('tabellaBollafatturaCollegati').style.display = 'none';
                                document.getElementById('messaggioErroreSeTabellaBollafatturaCollegatiHaRighe').style.display = 'none';
                                bottoneElimina.removeAttribute("disabled");
                            } else {
                                document.getElementById('tabellaBollafatturaCollegati').style.display = 'initial';
                                document.getElementById('messaggioErroreSeTabellaBollafatturaCollegatiHaRighe').style.display = 'initial';
                                // bottoneElimina.removeAttribute("disabled"); -> di default è già stato bloccato a inizio funzionePopupTabellaBolleElimina()
                            }
                        });


                    } else {
                        document.getElementById('tabellaProdottiCollegati').style.display = 'initial';
                        document.getElementById('messaggioErroreSeTabellaProdottiCollegatiHaRighe').style.display = 'initial';
                        // bottoneElimina.removeAttribute("disabled"); -> di default è già stato bloccato a inizio funzionePopupTabellaBolleElimina()


                        // carico tabellaBollafatturaCollegati
                        iwebCaricaElemento("tabellaBollafatturaCollegati", false, function () {
                            // terminato il caricamento della tabella interna:
                            var n = document.getElementById('tabellaBollafatturaCollegati').getElementsByTagName('tbody')[1].getElementsByTagName('td').length;
                            if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                                document.getElementById('tabellaBollafatturaCollegati').style.display = 'none';
                                document.getElementById('messaggioErroreSeTabellaBollafatturaCollegatiHaRighe').style.display = 'none';
                                //bottoneElimina.removeAttribute("disabled"); -> non più possibile in questo momento.
                            } else {
                                document.getElementById('tabellaBollafatturaCollegati').style.display = 'initial';
                                document.getElementById('messaggioErroreSeTabellaBollafatturaCollegatiHaRighe').style.display = 'initial';
                                // bottoneElimina.removeAttribute("disabled"); -> di default è già stato bloccato a inizio funzionePopupTabellaBolleElimina()
                            }
                        });


                    }
                });


            }
        </script>
        <div id="popupTabellaFornitoriElimina" class="popup popupType2 iwebfunzione_funzionePopupTabellaProdottiElimina" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione fornitore, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">
                    <table>
                        <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                        <tr>
                            <td>Ragione sociale</td>
                            <td><span class="iwebCAMPO_fornitore.ragionesociale"></span></td>
                        </tr>
                        <tr>
                            <td>Indirizzo</td>
                            <td><span class="iwebCAMPO_fornitore.indirizzo"></span></td>
                        </tr>
                        <tr>
                            <td>Citta</td>
                            <td><span class="iwebCAMPO_fornitore.citta"></span></td>
                        </tr>
                        <tr>
                            <td>Provincia</td>
                            <td><span class="iwebCAMPO_fornitore.provincia"></span></td>
                        </tr>
                        <tr>
                            <td>Telefono</td>
                            <td><span class="iwebCAMPO_fornitore.telefono"></span></td>
                        </tr>
                        <tr>
                            <td>Cf</td>
                            <td><span class="iwebCAMPO_fornitore.cf"></span></td>
                        </tr>
                        <tr>
                            <td>Piva</td>
                            <td><span class="iwebCAMPO_fornitore.piva"></span></td>
                        </tr>
                        <tr>
                            <td>Fax</td>
                            <td><span class="iwebCAMPO_fornitore.fax"></span></td>
                        </tr>
                        <tr>
                            <td>Tipo</td>
                            <td><span class="iwebCAMPO_fornitore.tipofornitore"></span></td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top">Bolle/Fatture collegate:</td>
                            <td>
                                <anagraficafornitori:tabellabollafatturacollegati runat="server" />
                                <div class="b"></div>
                                <div id="messaggioErroreSeTabellaBollafatturaCollegatiHaRighe">Cancellazione non possibile finchè ci sono bolle o fatture collegate a questo fornitore.</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top">Prodotti collegati:</td>
                            <td>
                                <anagraficafornitori:tabellaprodotticollegati runat="server" />
                                <div class="b"></div>
                                <div id="messaggioErroreSeTabellaProdottiCollegatiHaRighe">Cancellazione non possibile finchè c'è almeno un prodotto collegato a questo fornitore.</div>
                            </td>
                        </tr>
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div id="popupTabellaFornitoriElimina_BottoneElimina" class="btn btn-danger" 
                        onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaFornitoriElimina', 'tabellaFornitori', true);">Elimina</div>
                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM fornitore WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = tabellaFornitori_selectedValue_fornitore.id</span>
                    </span>
                </div>
            </div>
        </div>
    </div><%-- fine tabellaSinistra --%>
