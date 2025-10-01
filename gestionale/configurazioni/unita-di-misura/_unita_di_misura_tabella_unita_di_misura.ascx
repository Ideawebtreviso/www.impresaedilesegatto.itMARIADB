<%@ Control Language="C#" ClassName="_unita_di_misura_tabella_unita_di_misura" %>

<%@ Register TagPrefix="unitadimisura" TagName="tabellaprodotticollegati" Src="_unitadimisura_tabellaunitadimisura_tabellaprodotticollegati.ascx" %>
<%@ Register TagPrefix="unitadimisura" TagName="tabellamisurecollegate" Src="_unitadimisura_tabellaunitadimisura_tabellamisurecollegate.ascx" %>


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
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM unitadimisura WHERE unitadimisura.id=@unitadimisura.id") %></span>
            </span>
        </div>
        <table id="tabellaUnitadimisura" class="iwebTABELLA iwebCHIAVE__unitadimisura.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaUnitadimisuraInserimento');"></div>
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <th><div class="l">Codice</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_unitadimisura.codice_ASC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>
                    </th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%></th>
                    <th class="iwebNascosto">ID</th>
                    <th>
                        <%-- filtro di testo con autocompletamento sul campo nominativo --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_unitadimisura.codice">
                            <input type="text" onkeypress="iwebTABELLA_VerificaAutocompletamento()"/>
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
                        <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaUnitadimisuraModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaUnitadimisura');"></div>
                        <%--<div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaUnitadimisura');"></div>--%>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_unitadimisura.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_unitadimisura.codice iwebDescrizione"></span>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaUnitadimisura');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaUnitadimisuraElimina')"></div>
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
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT unitadimisura.id as 'unitadimisura.id', "
                                                                + "       unitadimisura.codice as 'unitadimisura.codice' "
                                                                + "FROM unitadimisura") %></span>
            <%--<span class="iwebPARAMETRO">@idfornitore = tabellaFornitori_selectedValue_fornitore.id</span>--%>
        </span>

        <%-- modifica --%>
        <div id="popupTabellaUnitadimisuraModifica" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Modifica l'unita' di misura</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <div class="iwebTABELLA_ContenitoreParametri"></div>
                    <table>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td>
                                <span class="iwebCAMPO_unitadimisura.id"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Codice</td>
                            <td><input type="text" class="iwebCAMPO_unitadimisura.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaUnitadimisuraModifica', 'tabellaUnitadimisura', 'codice', 'unitadimisura.id', true);">Aggiorna</div>
                    <span class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE unitadimisura SET codice = @codice WHERE id = @id") %></span>
	                    <span class="iwebPARAMETRO">@codice = popupTabellaUnitadimisuraModifica_findValue_unitadimisura.codice</span>
	                    <span class="iwebPARAMETRO">@id = popupTabellaUnitadimisuraModifica_findValue_unitadimisura.id</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- inserimento --%>
        <div id="popupTabellaUnitadimisuraInserimento" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Inserisci l'unita' di misura</div>
                    <div class="b"></div>
                </div>
                    <div class="popupCorpo">
                    <table>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td>
                                <span class="iwebCAMPO_unitadimisura.id"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Codice</td>
                            <td><input type="text" class="iwebCAMPO_unitadimisura.codice iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="
                        iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaUnitadimisuraInserimento', 'tabellaUnitadimisura', 'unitadimisura.codice', true)">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("INSERT INTO unitadimisura (codice) VALUES (@codice)") %></span>
                        <span class="iwebPARAMETRO">@codice = popupTabellaUnitadimisuraInserimento_findValue_unitadimisura.codice</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <script>
            function funzionePopupTabellaUnitadimisuraElimina() {
                var elPopup = document.getElementById("popupTabellaUnitadimisuraElimina");

                // ottengo il bottone di eliminazione
                var bottoneElimina = document.getElementById("popupTabellaUnitadimisuraElimina_BottoneElimina");
                bottoneElimina.setAttribute("disabled", "disabled");

                // carico tabellaProdottiCollegati
                iwebCaricaElemento("tabellaProdottiCollegati", false, function () {
                    // terminato il caricamento della tabella interna:
                    var n = document.getElementById('tabellaProdottiCollegati').getElementsByTagName('tbody')[1].getElementsByTagName('td').length;
                    if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                        document.getElementById('tabellaProdottiCollegati').style.display = 'none';
                        document.getElementById('messaggioErroreSeTabellaProdottiCollegatiHaRighe').style.display = 'none';
                        //bottoneElimina.removeAttribute("disabled");


                        // carico tabellaMisureCollegate
                        iwebCaricaElemento("tabellaMisureCollegate", false, function () {
                            // terminato il caricamento della tabella interna:
                            var n = document.getElementById('tabellaMisureCollegate').getElementsByTagName('tbody')[1].getElementsByTagName('td').length;
                            if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                                document.getElementById('tabellaMisureCollegate').style.display = 'none';
                                document.getElementById('messaggioErroreSeTabellaMisureCollegateHaRighe').style.display = 'none';
                                bottoneElimina.removeAttribute("disabled");
                            } else {
                                document.getElementById('tabellaMisureCollegate').style.display = 'initial';
                                document.getElementById('messaggioErroreSeTabellaMisureCollegateHaRighe').style.display = 'initial';
                                // bottoneElimina.removeAttribute("disabled"); -> di default è già stato bloccato a inizio funzionePopupTabellaUnitadimisuraElimina()
                            }
                        });


                    } else {
                        document.getElementById('tabellaProdottiCollegati').style.display = 'initial';
                        document.getElementById('messaggioErroreSeTabellaProdottiCollegatiHaRighe').style.display = 'initial';
                        // bottoneElimina.removeAttribute("disabled"); -> di default è già stato bloccato a inizio funzionePopupTabellaUnitadimisuraElimina()


                        // carico tabellaMisureCollegate
                        iwebCaricaElemento("tabellaMisureCollegate", false, function () {
                            // terminato il caricamento della tabella interna:
                            var n = document.getElementById('tabellaMisureCollegate').getElementsByTagName('tbody')[1].getElementsByTagName('td').length;
                            if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                                document.getElementById('tabellaMisureCollegate').style.display = 'none';
                                document.getElementById('messaggioErroreSeTabellaMisureCollegateHaRighe').style.display = 'none';
                                //bottoneElimina.removeAttribute("disabled"); -> non più possibile in questo momento.
                            } else {
                                document.getElementById('tabellaMisureCollegate').style.display = 'initial';
                                document.getElementById('messaggioErroreSeTabellaMisureCollegateHaRighe').style.display = 'initial';
                                // bottoneElimina.removeAttribute("disabled"); -> di default è già stato bloccato a inizio funzionePopupTabellaUnitadimisuraElimina()
                            }
                        });


                    }
                });


            }
        </script>
<%--            function funzionePopupTabellaUnitadimisuraElimina() {
                iwebCaricaElemento("tabellaProdottiCollegati");
                iwebCaricaElemento("tabellaMisureCollegate");
                // messaggioErroreSeTabellaProdottiCollegatiHaRighe messaggioErroreSeTabellaMisureCollegateHaRighe
            } 
        </script>--%>

        <div id="popupTabellaUnitadimisuraElimina" class="popup popupType2 iwebfunzione_funzionePopupTabellaUnitadimisuraElimina" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione unita' di misura, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">
                    <table>
                        <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                        <tr>
                            <td>id</td>
                            <td><span class="iwebCAMPO_unitadimisura.id"></span></td>
                        </tr>
                        <tr>
                            <td>Codice</td>
                            <td><span class="iwebCAMPO_unitadimisura.codice"></span></td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top">Prodotti collegati:</td>
                            <td>
                                <unitadimisura:tabellaprodotticollegati runat="server" />
                                <div class="b"></div>
                                <div id="messaggioErroreSeTabellaProdottiCollegatiHaRighe">Cancellazione non possibile finchè c'è almeno un prodotto collegato a questa unità di misura.</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top">Misure collegate:</td>
                            <td>
                                <unitadimisura:tabellamisurecollegate runat="server" />
                                <div class="b"></div>
                                <div id="messaggioErroreSeTabellaMisureCollegateHaRighe">Cancellazione non possibile finchè c'è almeno una misura collegata a questa unità di misura.</div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>

                    <div id="popupTabellaUnitadimisuraElimina_BottoneElimina" class="btn btn-danger" 
                        onclick="paginaUnitaDiMisura_iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaUnitadimisuraElimina', 'tabellaUnitadimisura', true);">Elimina</div>

                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM unitadimisura WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = tabellaUnitadimisura_selectedValue_unitadimisura.id</span>
                    </span>
                </div>
            </div>
        </div>
    </div>
