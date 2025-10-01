<%@ Control Language="C#" %>

    <div class="iwebTABELLAWrapper">
        <%--<div class="r iwebTABELLAAzioniPerSelezionati">
            <span></span>
            <select disabled>
                <option value="">Seleziona...</option>
                <option value="Elimina">Elimina</option>
            </select>
            <input type="button" class="btn btn-default" value="Conferma azione" disabled onclick="iwebTABELLA_ConfermaAzionePerSelezionati()"/>
            <div class="b"></div>
            <span class="iwebSQLDELETE">
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM bollafattura WHERE bollafattura.id = @bollafattura.id") %></span>
            </span>
        </div>
        <div class="b"></div>--%>
        <table id="tabellaBolleAperte" class="iwebTABELLA iwebCHIAVE__fornitore.id iwebBIND__elementoConITab">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead iwebNascosto">
                        <%--<div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaFornitoriInserimento');"></div>--%>
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <th>Ragione sociale</th>
                    <th><div class="l">Data bolla</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_bollafattura.databollafattura_ASC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>
                    </th>
                    <th>Numero</th>
                    <th>Importo</th>
                    <th></th>
                </tr>
                <tr>
                    <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                    <th class="iwebNascosto"><%-- AZIONI --%></th>
                    <th class="iwebNascosto"></th>
                    <th>
                        <%-- filtro di testo sul campo ragionesociale --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_fornitore.ragionesociale iwebFILTRORICORDA_paginaBolle_tabellaBolleAperte_fornitore.ragionesociale">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento()"/>
                        </div>
                    </th>
                    <th></th>
                    <th>
                        <%-- filtro di testo sul campo bollafattura.numero --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_bollafattura.numero">
                            <input type="text" onkeypress="iwebTABELLA_VerificaAutocompletamento()"/>
                        </div>
                    </th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td class="iwebNascosto">
                        <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaFornitoriModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaFornitori');"></div>--%>
                        <%--<div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaFornitori');"></div>--%>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_fornitore.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.ragionesociale"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.databollafattura iwebData"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.numero"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_costobolla.importo iwebValuta"></span>
                    </td>
                    <td>
                        <div class="iwebCAMPO_idbollafattura btn btn-default iwebCliccabile"
                            onclick="location.replace('/gestionale/costi/scarico-bolla/scarico-bolla.aspx?IDBOLLA='+iwebCAMPO_idbollafattura)">
                            Scarica
                        </div>
                    </td>
                </tr>
            </tbody>
            <tbody><%-- il codice viene generato automaticamente qui --%></tbody>
            <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                <%-- eventualmente va messo display:none --%>
                <tr>
                    <td class="iwebNascosto"></td>
                    <td></td>
                    <td></td>
                    <td>TOTALE:</td>
                    <td>
                        <!-- posso prendere from e where dalla query della tabella, scrivo a mano la select as 'TOTALE', scrivo i parametri e dovrebbe funzionare -->
                        <!-- uso i filtri della tabella, ma eseguo una query diversa -->
                        <span id="SpanTotale1" class="iwebTOTALE iwebUSAFILTRI iwebValuta"></span>
                        <span class="iwebSQLSELECT iwebNascosto">
	                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                "SELECT SUM(costobolla.quantita * (costobolla.prezzo * (100-costobolla.sconto1) * (100-costobolla.sconto2) / 10000)) as 'costobolla.importo' "
                              + "FROM bollafattura INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
                              + "                  INNER JOIN costo as costobolla ON costobolla.idbollafattura = bollafattura.id "
                              + "                  LEFT JOIN costo as costofattura ON costobolla.id = costofattura.idcostobollariferita "
                              + "WHERE bollafattura.isfattura = false AND bollafattura.chiusa = 0 AND costofattura.id IS NULL "                                
                            )%></span>
                        </span>
                    </td>
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
                "SELECT bollafattura.id as 'idbollafattura', "

              + "       fornitore.id as 'fornitore.id', "
              + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "

              + "       bollafattura.databollafattura as 'bollafattura.databollafattura' , "
              + "       bollafattura.numero as 'bollafattura.numero', "

              + "       SUM(costobolla.quantita * (costobolla.prezzo * (100-costobolla.sconto1) * (100-costobolla.sconto2) / 10000)) as 'costobolla.importo' "

              + "FROM bollafattura INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
              + "                  INNER JOIN costo as costobolla ON costobolla.idbollafattura = bollafattura.id "
              + "                  LEFT JOIN costo as costofattura ON costobolla.id = costofattura.idcostobollariferita "
              + "WHERE bollafattura.isfattura = false AND bollafattura.chiusa = 0 AND costofattura.id IS NULL "
              + "GROUP BY bollafattura.id "
            ) %></span>
        </span>

        <%-- modifica --%>
        <div id="popupTabellaFornitoriModifica" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Modifica anagrafica fornitore</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <div class="iwebTABELLA_ContenitoreParametri"></div>
                    <table>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td><span class="iwebCAMPO_fornitore.id"></span></td>
                        </tr>
                        <tr>
                            <td>Nominativo *</td>
                            <td><input type="text" class="iwebCAMPO_fornitore.nominativo iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Telefono</td>
                            <td><input type="text" class="iwebCAMPO_fornitore.tel iwebTIPOCAMPO_varchar"/></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><input type="text" class="iwebCAMPO_fornitore.mail iwebTIPOCAMPO_varchar"/></td>
                        </tr>
                        <tr>
                            <td>Note</td>
                            <td><textarea class="iwebCAMPO_fornitore.note iwebTIPOCAMPO_memo"></textarea></td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaFornitoriModifica', 'tabellaFornitori', 'nominativo,tel,mail,note', 'fornitore.id', true);">Aggiorna</div>
                    <span class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "UPDATE fornitore SET nominativo = @nominativo, tel = @tel, mail = @mail, note = @note WHERE id = @id"
                        ) %></span>
	                    <span class="iwebPARAMETRO">@nominativo = popupTabellaFornitoriModifica_findValue_fornitore.nominativo</span>
	                    <span class="iwebPARAMETRO">@tel = popupTabellaFornitoriModifica_findValue_fornitore.tel</span>
	                    <span class="iwebPARAMETRO">@mail = popupTabellaFornitoriModifica_findValue_fornitore.mail</span>
	                    <span class="iwebPARAMETRO">@note = popupTabellaFornitoriModifica_findValue_fornitore.note</span>
	                    <span class="iwebPARAMETRO">@id = popupTabellaFornitoriModifica_findValue_fornitore.id</span>
                    </span>
                </div>
            </div>
        </div>

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
                            <td>Nominativo *</td>
                            <td><input id="popupTabellaFornitoriInserimentoNominativo" type="text" 
                                class="iwebCAMPO_fornitore.nominativo iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Telefono</td>
                            <td><input type="text" class="iwebCAMPO_fornitore.tel iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Citta</td>
                            <td><input type="text" id="popupTabellaFornitoriInserimentoFATTCITTA" class="iwebCAMPO_fornitore.citta iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><input type="text" class="iwebCAMPO_fornitore.mail iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Note</td>
                            <td><textarea class="iwebCAMPO_fornitore.note iwebTIPOCAMPO_memo" ></textarea></td>
                        </tr>
                    </table>
                </div>

                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <%-- IdPopupAssociato, nomeQuery, parametriQuery, attesaRispostaServer --%>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaFornitoriInserimento', 'tabellaFornitori', '', true)">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
						    "INSERT INTO fornitore (nominativo, tel, citta, mail, note) "
						  + "VALUES(@nominativo, @tel, @citta, @mail, @note)"
						) %></span>
                        <span class="iwebPARAMETRO">@nominativo = popupTabellaFornitoriInserimento_findValue_fornitore.nominativo</span>
                        <span class="iwebPARAMETRO">@tel = popupTabellaFornitoriInserimento_findValue_fornitore.tel</span>
                        <span class="iwebPARAMETRO">@citta = popupTabellaFornitoriInserimentoFATTCITTA_value</span>
                        <span class="iwebPARAMETRO">@mail = popupTabellaFornitoriInserimento_findValue_fornitore.mail</span>
                        <span class="iwebPARAMETRO">@note = popupTabellaFornitoriInserimento_findValue_fornitore.note</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <div id="popupTabellaFornitoriElimina" class="popup popupType2" style="display:none">
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
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td><span class="iwebCAMPO_fornitore.id"></span></td>
                        </tr>
                        <tr>
                            <td>Nominativo</td>
                            <td><span class="iwebCAMPO_fornitore.nominativo"></span></td>
                        </tr>
                        <tr>
                            <td>Telefono</td>
                            <td><span class="iwebCAMPO_fornitore.tel"></span></td>
                        </tr>
                        <tr>
                            <td>Citta</td>
                            <td><span class="iwebCAMPO_fornitore.citta"></span></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><span class="iwebCAMPO_fornitore.mail"></span></td>
                        </tr>
                        <tr>
                            <td>Note</td>
                            <td><textarea class="iwebCAMPO_fornitore.note iwebTIPOCAMPO_memo" disabled="disabled" readonly="readonly"></textarea></td>
                            <%--<td><span class="iwebCAMPO_fornitore.note iwebDescrizione"></span></td>--%>
                        </tr>
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-danger" onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaFornitoriElimina', 'tabellaFornitori', true);">Elimina</div>
                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM fornitore WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = tabellaFornitori_selectedValue_fornitore.id</span>
                    </span>
                </div>
            </div>
        </div>
    </div>