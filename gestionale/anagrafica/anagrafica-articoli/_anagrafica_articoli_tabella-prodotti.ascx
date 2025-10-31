<%@ Control Language="C#" ClassName="_anagrafica_articoli_tabella_prodotti" %>

<%@ Register TagPrefix="anagraficaarticoli" TagName="costicollegati" Src="_anagraficaarticoli_tabellaprodotti_costicollegati.ascx" %>

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
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM prodotto WHERE prodotto.id=@prodotto.id") %></span>
            </span>
        </div>
        <table id="tabellaProdotti" class="iwebTABELLA iwebCHIAVE__prodotto.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaProdottiInserimento');"></div>
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <%--<th>Categoria</th>--%>
                    <th><div class="l">Fornitore</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_fornitore.ragionesociale_ASC glyphicon glyphicon-sort-by-alphabet r" 
                                onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>
                    </th>
                    <th class="iwebNascosto">Codice prodotto</th>
                    <th>Descrizione</th>
                    <th>Unita di misura</th>
                    <th>Listino</th>
                    <th>Sconto1</th>
                    <th>Sconto2</th>
                    <th>Valido</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%></th>
                    <%--<th>
                        <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_categoriaprodotto.id">
                            <select id="ddlFiltroTabellaProdottiCategoria" class="iwebDDL"
                                onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option class="iwebAGGIUNTO" value="-1">Tutti</option>
                            </select>
                            <span class="iwebSQLSELECT">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT descrizione as NOME, id as VALORE FROM categoriaprodotto") %></span>
                            </span>
                        </div>
                    </th>--%>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_fornitore.ragionesociale">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                        </div>
                    </th>
                    <th class="iwebNascosto">
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.codice">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                        </div>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo descrizione --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.descrizione">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_unitadimisura.id">
                            <%-- potrei aggiungere il codice per fare in alternativa: --%>
                            <select id="ddlFiltroTabellaProdottiUnitaDiMisura" class="iwebDDL"
                                onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option class="iwebAGGIUNTO" value="-1">Tutti</option>
                            </select>
                            <span class="iwebSQLSELECT">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT codice as NOME, id as VALORE FROM unitadimisura") %></span>
                            </span>
                        </div>
                    </th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th><%-- filtro truefalse --%></th>
                    <th></th><%-- ALTRO --%>
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaProdottiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaProdotti');"></div>
                        <div class="iwebCliccabile glyphicon glyphicon-tasks" title="Aggiornamento costo dipendente" onclick="iwebTABELLA_SelezionaRigaComeUnica(this); apriPopupAggiornamentoCostoDipendente()"></div>

                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaProdotti');"></div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_prodotto.id"></span>
                        <span class="iwebCAMPO_fornitore.id"></span>
                        <span class="iwebCAMPO_categoriaprodotto.id"></span>
                        <span class="iwebCAMPO_unitadimisura.id"></span>
                    </td>
                    <%--<td>
                        <span class="iwebCAMPO_categoriaprodotto.descrizione iwebDescrizione iwebTroncaCrtsAt_30"></span>
                    </td>--%>
                    <td>
                        <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione"></span>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_prodotto.codice iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_unitadimisura.codice iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_prodotto.listino iwebQuantita"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_prodotto.sconto1 iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_prodotto.sconto2 iwebValuta"></span>
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_prodotto.valido" disabled="disabled"/>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaProdotti');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaProdottiElimina')"></div>
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
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="Select1GERGERGRREG" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option selected value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                "SELECT prodotto.id as 'prodotto.id',  "
                                + "     prodotto.codice as 'prodotto.codice',  "
                                + "     prodotto.descrizione as 'prodotto.descrizione', "
                                + "     prodotto.listino as 'prodotto.listino', "
                                + "     prodotto.sconto1 as 'prodotto.sconto1', "
                                + "     prodotto.sconto2 as 'prodotto.sconto2', "
                                + "     prodotto.valido as 'prodotto.valido', "
                                + "     fornitore.id as 'fornitore.id', "
                                + "     categoriaprodotto.id as 'categoriaprodotto.id', "
                                + "     unitadimisura.id as 'unitadimisura.id', "
                                + "     fornitore.ragionesociale as 'fornitore.ragionesociale', "
                                + "     categoriaprodotto.descrizione as 'categoriaprodotto.descrizione', "
                                + "     unitadimisura.codice as 'unitadimisura.codice' "
                                + "FROM ((prodotto LEFT JOIN fornitore ON prodotto.idfornitore = fornitore.id) "
                                + "                LEFT JOIN categoriaprodotto ON prodotto.idcategoria = categoriaprodotto.id) "
                                + "                LEFT JOIN unitadimisura ON prodotto.idunitadimisura = unitadimisura.id") %></span>
            <%--<span class="iwebPARAMETRO">@idfornitore = tabellaFornitori_selectedValue_fornitore.id</span>--%>
        </span>

        <%-- modifica --%>
        <div id="popupTabellaProdottiModifica" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Modifica anagrafica prodotto</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <div class="iwebTABELLA_ContenitoreParametri"></div>
                    <table>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td>
                                <%--<span class="iwebCAMPO_cliente.id"></span>--%>
                                <span class="iwebCAMPO_prodotto.id"></span>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>Codice *</td>
                            <td><input type="text" class="iwebCAMPO_prodotto.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>--%>
                        <tr>
                            <td>Descrizione *</td>
                            <td><input type="text" class="iwebCAMPO_prodotto.descrizione iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Listino</td>
                            <td><input type="text" class="iwebCAMPO_prodotto.listino iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Sconto 1</td>
                            <td><input type="text" class="iwebCAMPO_prodotto.sconto1 iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Sconto 2</td>
                            <td><input type="text" class="iwebCAMPO_prodotto.sconto2 iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Valido</td>
                            <td><input type="checkbox" class="iwebCAMPO_prodotto.valido" /></td>
                        </tr>
                        <tr>
                            <td>Fornitore *</td>
                            <%--<td><input type="text" class="iwebCAMPO_fornitore.id iwebTIPOCAMPO_varchar" /></td>--%>
                            <td>
                                <div class="iwebCAMPO_fornitore.ragionesociale">
                                    <select id="popupTabellaProdottiModificaDDLFornitore" class="iwebDDL iwebCAMPO_fornitore.id iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                        <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT ragionesociale as NOME, id as VALORE FROM fornitore ORDER BY ragionesociale") %></span>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>Categoria *</td>
                            <td>
                                <div class="iwebCAMPO_categoriaprodotto.descrizione">
                                    <select id="popupTabellaProdottiModificaDDLCategoria" class="iwebDDL iwebCAMPO_categoriaprodotto.id iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                        <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT descrizione as NOME, id as VALORE FROM categoriaprodotto ORDER BY descrizione") %></span>
                                    </span>
                                </div>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>Unita di misura *</td>
                            <%--<td><input type="text" class="iwebCAMPO_unitadimisura.id iwebTIPOCAMPO_varchar" /></td>--%>
                            <td>
                                <div class="iwebCAMPO_unitadimisura.codice">
                                    <select id="popupTabellaProdottiModificaDDLUnitaDiMisura" class="iwebDDL iwebCAMPO_unitadimisura.id iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                        <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT codice as NOME, id as VALORE FROM unitadimisura ORDER BY codice") %></span>
                                    </span>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaProdottiModifica', 'tabellaProdotti', 'descrizione, listino, sconto1, sconto2, idfornitore, idcategoria, idunitadimisura', 'prodotto.id', true);">Aggiorna</div>
                    <span class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE prodotto SET descrizione = @descrizione, listino = @listino, sconto1 = @sconto1, sconto2 = @sconto2, valido = @valido, idfornitore = @idfornitore, idunitadimisura = @idunitadimisura WHERE id = @id") %></span>
	                    <%--<span class="iwebPARAMETRO">@codice = popupTabellaProdottiModifica_findValue_prodotto.codice</span>--%>
	                    <span class="iwebPARAMETRO">@descrizione = popupTabellaProdottiModifica_findValue_prodotto.descrizione</span>
	                    <span class="iwebPARAMETRO">@listino = popupTabellaProdottiModifica_findValue_prodotto.listino</span>
	                    <span class="iwebPARAMETRO">@sconto1 = popupTabellaProdottiModifica_findValue_prodotto.sconto1</span>
	                    <span class="iwebPARAMETRO">@sconto2 = popupTabellaProdottiModifica_findValue_prodotto.sconto2</span>
	                    <span class="iwebPARAMETRO">@valido = popupTabellaProdottiModifica_findValue_prodotto.valido</span>
	                    <span class="iwebPARAMETRO">@idfornitore = popupTabellaProdottiModifica_findValue_fornitore.id</span>
	                    <%--<span class="iwebPARAMETRO">@idcategoria = popupTabellaProdottiModifica_findValue_categoriaprodotto.id</span>--%>
	                    <span class="iwebPARAMETRO">@idunitadimisura = popupTabellaProdottiModifica_findValue_unitadimisura.id</span>
	                    <span class="iwebPARAMETRO">@id = popupTabellaProdottiModifica_findValue_prodotto.id</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- iwebBIND__popupTabellaProdottiInserimentoDDLCategoria__popupTabellaProdottiInserimentoDDLFornitore__popupTabellaProdottiInserimentoDDLUnitaDiMisura --%>
        <%-- inserimento --%>
        <div id="popupTabellaProdottiInserimento" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Inserisci nuovo prodotto</div>
                    <div class="b"></div>
                </div>
                    <div class="popupCorpo">
                    <table>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td>
                                <span class="iwebCAMPO_prodotto.id"></span>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>Tipo</td>
                            <td>
                                <select class="iwebCAMPO_tipo">
                                    <option value="Preventivo">Preventivo</option>
                                    <option value="Consuntivo">Consuntivo</option>
                                </select>
                            </td>
                        </tr>--%>
                        <%--<tr>
                            <td>Codice*</td>
                            <td><input type="text" class="iwebCAMPO_prodotto.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>--%>
                        <tr>
                            <td>Descrizione*</td>
                            <td><input type="text" class="iwebCAMPO_prodotto.descrizione iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Listino</td>
                            <td><input type="text" class="iwebCAMPO_prodotto.listino iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Sconto 1</td>
                            <td><input type="text" class="iwebCAMPO_prodotto.sconto1 iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Sconto 2</td>
                            <td><input type="text" class="iwebCAMPO_prodotto.sconto2 iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Valido</td>
                            <td><input type="checkbox" class="iwebCAMPO_prodotto.valido" checked="checked" /></td>
                        </tr>
                        <tr>
                            <td>Fornitore *</td>
                            <%--<td><input type="text" class="iwebCAMPO_fornitore.id iwebTIPOCAMPO_varchar" /></td>--%>
                            <td>
                                <select id="popupTabellaProdottiInserimentoDDLFornitore" class="iwebDDL iwebCAMPO_fornitore.id iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                    <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                </select>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT ragionesociale as NOME, id as VALORE FROM fornitore ORDER BY ragionesociale") %></span>
                                </span>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>Categoria *</td>
                            <td>
                                <select id="popupTabellaProdottiInserimentoDDLCategoria" class="iwebDDL iwebCAMPO_categoriaprodotto.id iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                    <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                </select>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT descrizione as NOME, id as VALORE FROM categoriaprodotto ORDER BY descrizione") %></span>
                                </span>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>Unita di misura *</td>
                            <%--<td><input type="text" class="iwebCAMPO_unitadimisura.id iwebTIPOCAMPO_varchar" /></td>--%>
                            <td>
                                <select id="popupTabellaProdottiInserimentoDDLUnitaDiMisura" class="iwebDDL iwebCAMPO_unitadimisura.id iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                    <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                </select>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT codice as NOME, id as VALORE FROM unitadimisura ORDER BY codice") %></span>
                                </span>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter" title="l'inserimento non è possibile senza la selezione di un cliente">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <%-- todo ### insert senza la selezione del cliente??? --%>
                    <div class="btn btn-success" onclick="
                        iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaProdottiInserimento', 'tabellaProdotti', 'prodotto.codice, prodotto.descrizione, prodotto.listino, prodotto.sconto1, prodotto.sconto2, fornitore.id, categoriaprodotto.id, unitadimisura.id', true)">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                                "INSERT INTO prodotto (descrizione, listino, sconto1, sconto2, valido, idfornitore, idunitadimisura) " +
                                                "VALUES (@descrizione, @listino, @sconto1, @sconto2, @valido, @idfornitore, @idunitadimisura)") %></span>
                        <%--<span class="iwebPARAMETRO">@codice = popupTabellaProdottiInserimento_findValue_prodotto.codice</span>--%>
	                    <span class="iwebPARAMETRO">@descrizione = popupTabellaProdottiInserimento_findValue_prodotto.descrizione</span>
	                    <span class="iwebPARAMETRO">@listino = popupTabellaProdottiInserimento_findValue_prodotto.listino</span>
	                    <span class="iwebPARAMETRO">@sconto1 = popupTabellaProdottiInserimento_findValue_prodotto.sconto1</span>
	                    <span class="iwebPARAMETRO">@sconto2 = popupTabellaProdottiInserimento_findValue_prodotto.sconto2</span>
	                    <span class="iwebPARAMETRO">@valido = popupTabellaProdottiInserimento_findValue_prodotto.valido</span>
	                    <span class="iwebPARAMETRO">@idfornitore = popupTabellaProdottiInserimento_findValue_fornitore.id</span>
	                    <%--<span class="iwebPARAMETRO">@idcategoria = popupTabellaProdottiInserimento_findValue_categoriaprodotto.id</span>--%>
	                    <span class="iwebPARAMETRO">@idunitadimisura = popupTabellaProdottiInserimento_findValue_unitadimisura.id</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <script>
            function funzionePopupTabellaProdottiElimina() {
                // ottengo il bottone di eliminazione
                var bottoneElimina = document.getElementById("popupTabellaProdottiElimina_BottoneElimina");
                bottoneElimina.setAttribute("disabled", "disabled");

                iwebCaricaElemento("tabellaCostiCollegati", false, function () {
                    var elTabellaCostiCollegati = document.getElementById("tabellaCostiCollegati");
                    var n = elTabellaCostiCollegati.getElementsByTagName('tbody')[1].getElementsByTagName('td').length;

                    if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                        elTabellaCostiCollegati.style.display = 'none';
                        document.getElementById('messaggioErroreSeTabellaCostiCollegatiHaRighe').style.display = 'none';

                        // ri-abilita il bottone di eliminazione
                        bottoneElimina.removeAttribute("disabled");

                    } else {
                        elTabellaCostiCollegati.style.display = 'block';
                        document.getElementById('messaggioErroreSeTabellaCostiCollegatiHaRighe').style.display = 'block';
                    }
                });
            }
        </script>
        <div id="popupTabellaProdottiElimina" class="popup popupType2 iwebfunzione_funzionePopupTabellaProdottiElimina" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione prodotto, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">
                    <table>
                        <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td><span class="iwebCAMPO_prodotto.id"></span></td>
                        </tr>
                        <tr>
                            <td>Codice</td>
                            <td><span class="iwebCAMPO_prodotto.codice"></span></td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><span class="iwebCAMPO_prodotto.descrizione"></span></td>
                        </tr>
                        <tr>
                            <td>Listino</td>
                            <td><span class="iwebCAMPO_prodotto.listino"></span></td>
                        </tr>
                        <tr>
                            <td>Sconto 1</td>
                            <td><span class="iwebCAMPO_prodotto.sconto1"></span></td>
                        </tr>
                        <tr>
                            <td>Sconto 2</td>
                            <td><span class="iwebCAMPO_prodotto.sconto2"></span></td>
                        </tr>
                        <tr>
                            <td>Valido</td>
                            <td><input type="checkbox" class="iwebCAMPO_prodotto.valido" disabled="disabled" /></td>
                        </tr>
                        <tr>
                            <td>Fornitore</td>
                            <td><span class="iwebCAMPO_fornitore.ragionesociale"></span></td>
                        </tr>
                        <tr>
                            <td>Categoria</td>
                            <td><span class="iwebCAMPO_categoriaprodotto.descrizione"></span></td>
                        </tr>
                        <tr>
                            <td>Unita di misura</td>
                            <td><span class="iwebCAMPO_unitadimisura.codice"></span></td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top">Costi collegati:</td>
                            <td>
                                <anagraficaarticoli:costicollegati runat="server" />
                                <div class="b"></div>
                                <div id="messaggioErroreSeTabellaCostiCollegatiHaRighe">Cancellazione non possibile finchè c'è almeno un costo collegato a questo articolo.</div>
                            </td>
                        </tr>
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div id="popupTabellaProdottiElimina_BottoneElimina" class="btn btn-danger" 
                        onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaProdottiElimina', 'tabellaProdotti', true);">Elimina</div>
                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM prodotto WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = tabellaProdotti_selectedValue_prodotto.id</span>
                    </span>
                </div>
            </div>
        </div>
    </div>

<script>
    function apriPopupAggiornamentoCostoDipendente() {
        alert("Aggiornamento Costo Dipendente in sviluppo"); return;
        let idprodotto = iwebValutaParametroAjax("tabellaProdotti_selectedValue_prodotto.id", null, "int?");
        let listino = iwebValutaParametroAjax("tabellaProdotti_selectedValue_prodotto.listino", null, "double?");
    }
</script>
