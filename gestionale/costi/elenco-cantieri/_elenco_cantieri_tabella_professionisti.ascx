<%@ Control Language="C#" ClassName="_elenco_cantieri_tabella_professionisti" %>

    <table id="tabellaProfessionisti" class="iwebTABELLA iwebCHIAVE__costo.id iwebBIND__elementoConITab">
        <thead>
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                <th class="commandHead">
                    <%--<div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                        onclick="iwebTABELLA_AggiungiRigaInPopup('popuptabellaProfessionistiInserimento');"></div>--%>
                </th>
                <th class="iwebNascosto">ID</th>
                <th>Prodotto</th>
                <th>Quantita</th>
                <th>Prezzo</th>
                <th>Data</th>
                <th></th>
            </tr>
            <tr>
                <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                <th><%-- AZIONI --%>
                </th>
                <th class="iwebNascosto"></th>
                <th class="iwebNascosto"></th>
                <th>
                    <%-- filtro di testo sul campo nominativo --%>
                    <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.descrizione">
                        <input class="largNumero" type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                    </div>
                </th>
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
                        <%--<input type="text" placeholder="A" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>--%>
                        <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" 
                            onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                            onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                    </div>
                    <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                    </div>
                </th>
                <th></th>
            </tr>
        </thead>
        <tbody class="iwebNascosto">
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                <td>
                    <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popuptabellaProfessionistiModifica'); iwebTABELLA_SelezionaRigaComeUnica();"></div>
                    <%--<div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica();"></div>--%>
                </td>
                <td class="iwebNascosto">
                    <span class="iwebCAMPO_costo.id"></span>
                    <span class="iwebCAMPO_prodotto.id iwebNascosto"></span>
                    <span class="iwebCAMPO_fornitore.id iwebNascosto"></span>
                    <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.quantita iwebQuantita"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.datacosto iwebData"></span>
                </td>
                <td>
                    <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                        onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaProfessionisti');
                                    iwebTABELLA_EliminaRigaInPopup('popupTabellaProfessionistiElimina')"></div>
                </td><%-- Eliminazione --%>
            </tr>
        </tbody>
        <tbody>
            <%-- il codice viene generato automaticamente qui --%>
        </tbody>
        <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE, iwebTOTRECORD sono di riferimento al js --%>
            <%-- eventualmente va messo display:none --%>
            <tr class="iwebNascosto">
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
                <div class="iwebPAGESIZE"><select id="Select5hrtth3451qwasdasdsd" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                <div class="iwebTOTRECORD">Trovate 0 righe</div>
            </div></td></tr>
        </tfoot>
    </table>
    <span class="iwebSQLSELECT">
	    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT costo.id as 'costo.id', "
            + "       costo.quantita as 'costo.quantita', "
            + "       costo.prezzo as 'costo.prezzo', "
            + "       costo.datacosto as 'costo.datacosto', "

            + "       prodotto.id as 'prodotto.id', "
            + "       prodotto.codice as 'prodotto.codice', "
            + "       prodotto.descrizione as 'prodotto.descrizione', "
            + "       prodotto.listino as 'prodotto.listino' "

            + "FROM costo LEFT JOIN prodotto ON costo.idprodotto = prodotto.id "
            + "           LEFT JOIN fornitore ON prodotto.idfornitore = fornitore.id "

            + "WHERE costo.idcantiere = @idcantiere AND fornitore.tipofornitore = 'Professionista' "
        )%></span>
        <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span>
    </span>


    <%-- inserimento --%>
    <div id="popuptabellaProfessionistiInserimento" class="popup popupType2" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Inserisci nuovo professionista</div>
                <div class="b"></div>
            </div>
            <div class="popupCorpo">
                <table>
                    <tr>
                        <td>Prodotto</td>
                        <td>
                            <div class="iwebAUTOCOMPLETAMENTO" id="iwebAUTOCOMPLETAMENTOProfessionistaInserimento">
                                <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                <%-- Chiave dell'el selezionato --%>
                                <span class="iwebNascosto iwebCAMPO_prodotto.id"></span>

                                <%-- Valore dell'el selezionato --%>
                                <input type="text" autocomplete="off" class="iwebTIPOCAMPO_varchar"
                                    onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this); " 
                                    onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)"
                                    onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)" />

                                <%-- Query di ricerca --%>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                        "SELECT prodotto.id as chiave, CONCAT(prodotto.descrizione, ' ', fornitore.ragionesociale) as valore "
                                        + "FROM fornitore JOIN prodotto ON prodotto.idfornitore = fornitore.id "
                                        + "WHERE (fornitore.ragionesociale like @codice OR prodotto.descrizione like @codice) AND fornitore.tipofornitore = 'professionista' "
                                        + "LIMIT 3"
                                    ) %></span>
                                    <span class="iwebPARAMETRO">@codice = like_iwebAUTOCOMPLETAMENTOProfessionistaInserimento_getValore</span>
                                </span>
                                <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Quantita *</td>
                        <td><input type="text" 
                                class="iwebCAMPO_costo.quantita iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                    </tr>
                    <tr>
                        <td>Prezzo</td>
                        <td><input type="text" class="iwebCAMPO_costo.prezzo iwebTIPOCAMPO_varchar" /></td>
                    </tr>
                    <tr>
                        <td>Descrizione</td>
                        <td>
                            <textarea class="iwebCAMPO_costo.descrizione iwebTIPOCAMPO_memo"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Data altro costo</td>
                        <td>
                            <input class="iwebCAMPO_costo.datacosto iwebTIPOCAMPO_date" placeholder="gg/mm/aaaa"
                                type="text" onfocus="scwLanguage='it';scwShow(this, event);" 
                                onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </td>
                    </tr>
                </table>
            </div>

            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-success" onclick="iwebTABELLA_ConfermaAggiungiRecordInPopup('popuptabellaProfessionistiInserimento', 'tabellaProfessionisti', '', true)">Inserisci</div>
                <span class="iwebSQLINSERT">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                        "INSERT INTO costo (idbollafattura, idprodotto, idcantiere, idcostobollariferita, quantita, prezzo, sconto1, sconto2, datacosto) "
                      + "VALUES (0, @idprodotto, @idcantiere, 0, @quantita, @prezzo, 0, 0, @datacosto)") %></span>
	                <span class="iwebPARAMETRO">@idprodotto = popuptabellaProfessionistiInserimento_findvalue_prodotto.id</span>
                    <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span> <%-- ottengo il valore dall'elemento selezionato della tabella cantieri --%>
                    <span class="iwebPARAMETRO">@quantita = popuptabellaProfessionistiInserimento_findvalue_costo.quantita</span>
                    <span class="iwebPARAMETRO">@prezzo = popuptabellaProfessionistiInserimento_findvalue_costo.prezzo</span>
                    <span class="iwebPARAMETRO">@datacosto = popuptabellaProfessionistiInserimento_findvalue_costo.datacosto</span>
                </span>
            </div>
        </div>
    </div>


    <%-- modifica --%>
    <div id="popuptabellaProfessionistiModifica" class="popup popupType2" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Modifica anagrafica professionista</div>
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
                        <td>Prodotto</td>
                        <td>
                            <div class="iwebAUTOCOMPLETAMENTO" id="iwebAUTOCOMPLETAMENTOProfessionistiModifica">
                                <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                <%-- Chiave dell'el selezionato --%>
                                <span class="iwebNascosto iwebCAMPO_prodotto.id"></span>

                                <%-- Valore dell'el selezionato --%>
                                <input type="text" autocomplete="off" class="iwebTIPOCAMPO_varchar iwebCAMPO_prodotto.descrizione"
                                    onkeyup="iwebAUTOCOMPLETAMENTO_Ricerca(event, this); " 
                                    onkeydown="iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this)"
                                    onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)" />

                                <%-- Query di ricerca --%>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                        "SELECT prodotto.id as chiave, CONCAT(prodotto.descrizione, ' ', fornitore.ragionesociale) as valore "
                                        + "FROM fornitore JOIN prodotto ON prodotto.idfornitore = fornitore.id "
                                        + "WHERE (fornitore.ragionesociale like @codice OR prodotto.descrizione like @codice) AND fornitore.tipofornitore = 'professionista' "
                                        + "LIMIT 3"
                                    ) %></span>
                                    <span class="iwebPARAMETRO">@codice = like_iwebAUTOCOMPLETAMENTOProfessionistiModifica_getValore</span>
                                </span>
                                <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Quantita *</td>
                        <td><input type="text" 
                                class="iwebCAMPO_costo.quantita iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                    </tr>
                    <tr>
                        <td>Prezzo</td>
                        <td><input type="text" class="iwebCAMPO_costo.prezzo iwebTIPOCAMPO_varchar" /></td>
                    </tr>
                    <tr>
                        <td>Data altro costo</td>
                        <td>
                            <input class="iwebCAMPO_costo.datacosto iwebTIPOCAMPO_date" placeholder="gg/mm/aaaa"
                                type="text" onfocus="scwLanguage='it';scwShow(this, event);" 
                                onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popuptabellaProfessionistiModifica', 'tabellaProfessionisti', 'prodotto.id, costo.quantita, costo.prezzo, costo.datacosto', 'costo.id', true);">Aggiorna</div>
                <span class="iwebSQLUPDATE">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL( 
                        "UPDATE costo "
                        + "SET idprodotto = @idprodotto, quantita = @quantita, prezzo = @prezzo, datacosto = @datacosto "
                        + "WHERE id = @id"
                    ) %></span>
                    <span class="iwebPARAMETRO">@idprodotto = popuptabellaProfessionistiModifica_findValue_prodotto.id</span>
                    <span class="iwebPARAMETRO">@quantita = popuptabellaProfessionistiModifica_findValue_costo.quantita</span>
                    <span class="iwebPARAMETRO">@prezzo = popuptabellaProfessionistiModifica_findValue_costo.prezzo</span>
                    <span class="iwebPARAMETRO">@datacosto = popuptabellaProfessionistiModifica_findValue_costo.datacosto</span>
                    <span class="iwebPARAMETRO">@id = popuptabellaProfessionistiModifica_findValue_costo.id</span>
                </span>
            </div>
        </div>
    </div>


    <%-- elimina --%>
    <div id="popupTabellaProfessionistiElimina" class="popup popupType2" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Eliminazione professionista, ricontrolla i dati</div>
                <div class="b"></div>
            </div>
            <div class="iwebTABELLA_ContenitoreParametri"></div>
            <div class="popupCorpo">
                <table>
                    <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                            in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                    <tr class="iwebNascosto">
                        <td><span class="iwebCAMPO_costo.id"></span></td>
                    </tr>
                    <tr>
                        <td>Descrizione</td>
                        <td><span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span></td>
                    </tr>
                    <tr>
                        <td>Quantita</td>
                        <td><span class="iwebCAMPO_costo.quantita iwebQuantita"></span></td>
                    </tr>
                    <tr>
                        <td>Prezzo</td>
                        <td><span class="iwebCAMPO_costo.prezzo iwebValuta"></span></td>
                    </tr>
                    <tr>
                        <td>Data</td>
                        <td><span class="iwebCAMPO_costo.datacosto iwebData"></span></td>
                    </tr>
                    <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                </table>
            </div>
            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-danger" onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaProfessionistiElimina', 'tabellaProfessionisti', true);">Elimina</div>
                <span class="iwebSQLDELETE">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM costo WHERE id = @id") %></span>
                    <span class="iwebPARAMETRO">@id = popupTabellaProfessionistiElimina_findValue_costo.id</span>
                </span>
            </div>
        </div>
    </div>
