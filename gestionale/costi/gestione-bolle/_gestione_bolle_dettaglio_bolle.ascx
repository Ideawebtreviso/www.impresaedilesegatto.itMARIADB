<%@ Control Language="C#" ClassName="_gestione_bolle_dettaglio_bolle" %>


                <div class="l">
                    <table id="dettaglioAnagrafica" class="iwebDETTAGLIO">
                        <thead>
                            <tr>
                                <td>NOME CAMPO</td>
                                <td>VALORE CAMPO</td>
                            </tr>
                        </thead>
                        <tbody class="iwebNascosto">
                            <%-- commenta questo primo tr o aggiungi la classe iwebNascosto per nascondere le righe caricate automaticamente --%>
                            <tr class="iwebNascosto">
                                <td>@NOMECAMPO</td>
                                <td><span class="iwebCAMPO_@NOMECAMPO">@VALORECAMPO</span></td>
                            </tr>
                            <tr class="iwebNascosto">
                                <%-- tr con dati nascosti solo perchè necessari alla modifica --%>
                                <td>
                                    <span class="iwebCAMPO_bollafattura.id"></span>
                                    <span class="iwebCAMPO_fornitore.id"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>Numero</td>
                                <td><span class="iwebCAMPO_bollafattura.numero"></span></td>
                            </tr>
                            <tr>
                                <td>Prot.</td>
                                <td><span class="iwebCAMPO_bollafattura.protocollo"></span></td>
                            </tr>
                            <tr>
                                <td>Data</td>
                                <td><span class="iwebCAMPO_bollafattura.databollafattura iwebData"></span></td>
                            </tr>
                            <tr>
                                <td>Fornitore</td>
                                <td><span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione iwebTroncaCrtsAt_30"></span></td>
                            </tr>
                            <tr>
                                <td>Importo</td>
                                <td><span class="iwebCAMPO_bollafattura.importo"></span></td>
                            </tr>
                            <tr>
                                <td>Chiusa</td>
                                <td><input type="checkbox" class="iwebCAMPO_bollafattura.chiusa" disabled /></td>
                            </tr>
                            <tr>
                                <td>E' fattura</td>
                                <td><input type="checkbox" class="iwebCAMPO_bollafattura.isfattura" disabled /></td>
                            </tr>
                            <tr>
                                <td>Scansione</td>
                                <td>
                                    <a href="/public/gestionale-scansioni/@iwebCAMPO_Linkpathfilescansione" class="iwebCAMPO_Linkpathfilescansione" target="_blank">
                                        <span class="iwebCAMPO_bollafattura.pathfilescansione iwebNascosto"></span>
                                        <span class="iwebCAMPO_bollafattura.nomefilescansione"></span>
                                    </a>
                                </td>
                            </tr>
                        </tbody>
                        <tbody></tbody>
                    </table>
                    <span class="iwebSQLSELECT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "SELECT bollafattura.id as 'bollafattura.id', bollafattura.numero as 'bollafattura.numero', bollafattura.isfattura as 'bollafattura.isfattura', "
                            + "       bollafattura.databollafattura as 'bollafattura.databollafattura', bollafattura.chiusa as 'bollafattura.chiusa', " 
                            + "       bollafattura.importo as 'bollafattura.importo', bollafattura.pathfilescansione as 'bollafattura.pathfilescansione', "
                            + "       bollafattura.pathfilescansione as 'Linkpathfilescansione', bollafattura.nomefilescansione as 'bollafattura.nomefilescansione', "
                            + "       bollafattura.protocollo as 'bollafattura.protocollo', "
                            + "       fornitore.id as 'fornitore.id', fornitore.ragionesociale as 'fornitore.ragionesociale' "
                            + "FROM bollafattura LEFT JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
                            + "WHERE bollafattura.id = @id AND bollafattura.isddt = true ") %></span>
                        <%-- <span class="sqlParameter">@parametro = idElemento_azione[_nomecampo]</span> --%>
                        <span class="iwebPARAMETRO">@id = tabellaBolle_selectedValue_bollafattura.id</span>
                    </span>
                </div>
                <div class="r">
                    <div class="btn btn-default r" onclick="iwebApriPopupModificaiwebDETTAGLIO('dettaglioAnagrafica', 'popupModificaAnagraficaBolle');">Modifica</div>

                    <div id="popupModificaAnagraficaBolle" class="popup popupType2 iwebBINDRIGASELEZIONATA__tabellaBolle iwebBIND__dettaglioAnagrafica" style="display:none">
                        <div>
                            <div class="popupHeader">
                                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                                <div class="popupTitolo l">Modifica bolla</div>
                                <div class="b"></div>
                            </div>
                            <div class="popupCorpo">
                                <table>
                                    <tr class="iwebNascosto">
                                        <td>id</td>
                                        <td><span class="iwebCAMPO_bollafattura.id"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Numero</td>
                                        <td><input type="text" class="iwebCAMPO_bollafattura.numero iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <tr>
                                        <td>Prot.</td>
                                        <td><input type="text" class="iwebCAMPO_bollafattura.protocollo iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <tr>
                                        <td>Data</td>
                                        <td><%--<input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_varchar"/>--%>
                                            <input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_date" 
                                                onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                                placeholder="gg/mm/aaaa" onfocus="scwLanguage='it';scwShow(this, event);" 
                                                onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Fornitore</td>
                                        <td>
                                            <%--<span class="iwebCAMPO_fornitore.ragionesociale"></span>--%>
                                            <div class="iwebCAMPO_fornitore.ragionesociale">
                                                <select id="popupTabellaBolleModificaDDLFornitore" class="iwebDDL iwebCAMPO_fornitore.id iwebCAMPOOBBLIGATORIO" 
                                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                                    <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                                </select>
                                                <span class="iwebSQLSELECT">
                                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT ragionesociale as NOME, id as VALORE FROM fornitore ORDER BY ragionesociale") %></span>
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>E' fattura</td>
                                        <td><input type="checkbox" class="iwebCAMPO_bollafattura.isfattura" /></td>
                                    </tr>
                                    <tr>
                                        <td>Chiusa</td>
                                        <td><input type="checkbox" class="iwebCAMPO_bollafattura.chiusa" /></td>
                                    </tr>
                                    <tr>
                                        <td>Importo</td>
                                        <td><input type="text" class="iwebCAMPO_bollafattura.importo iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <tr>
                                        <td>Scansione</td>
                                        <td>
                                            <div id="popupModificaAnagraficaBolleFileUpload1" class="iwebFileUpload">
                                                <input type="file" onchange="iwebPREPARAUPLOAD(event)" />
                                                <img class="iwebNascosto" src="//:0" alt="preview" /> <%-- mostro questo solo se immagine --%>
                                                <span class="iwebNascosto"></span> <%-- contenuto file selezionato --%>
                                                <span class="iwebCAMPO_bollafattura.nomefilescansione"></span> <%-- nome file selezionato --%>
                                                <span class="iwebNascosto iwebCAMPO_bollafattura.pathfilescansione"></span> <%-- nome file uploadato --%>
                                            </div>
                                        </td>
                                    </tr>
                                    <%-- basta aggiungere nomi di campi esistenti e funziona --%>
                                </table>
                            </div>
                            <div class="popupFooter">
                                <%--<input type="button" value="Aggiorna" onclick="iwebBindPopupModificaiwebDETTAGLIO()" />--%>
                                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                                <%--<div class="btn btn-success" onclick="iwebBindPopupModificaiwebDETTAGLIO()">Aggiorna</div>--%>
                                <div class="btn btn-success" onclick="
                                    /* prima tento di uploadare il file, se ci riesco con esito positivo, confermo l'aggiunta del record */
                                    iwebINVIADATI('popupModificaAnagraficaBolleFileUpload1',
                                        function(){
                                            iwebBindPopupModificaiwebDETTAGLIO('popupModificaAnagraficaBolle');
                                            // aggiorno anche la data di tutte le righe associate a quella bolla
                                            iwebEseguiQuery('dettaglioAnagrafica_iwebSQLUPDATE_righecosto');
                                        }
                                    );
                                ">Aggiorna</div>
                            </div>
                        </div>
                    </div>
                    <div class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                            "UPDATE bollafattura SET numero = @numero, "
                                          + "       protocollo = @protocollo, databollafattura = @databollafattura, "
                                          + "       idfornitore = @idfornitore, isfattura = @isfattura, chiusa = @chiusa, importo = @importo, "
                                          + "       pathfilescansione = @pathfilescansione, nomefilescansione = @nomefilescansione "
                                          + "WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@numero = popupModificaAnagraficaBolle_findValue_bollafattura.numero</span>
                        <span class="iwebPARAMETRO">@protocollo = popupModificaAnagraficaBolle_findValue_bollafattura.protocollo</span>
                        <span class="iwebPARAMETRO">@databollafattura = popupModificaAnagraficaBolle_findValue_bollafattura.databollafattura</span>
                        <span class="iwebPARAMETRO">@idfornitore = popupModificaAnagraficaBolle_findValue_fornitore.id</span>
                        <span class="iwebPARAMETRO">@isfattura = popupModificaAnagraficaBolle_findValue_bollafattura.isfattura</span>
                        <span class="iwebPARAMETRO">@chiusa = popupModificaAnagraficaBolle_findValue_bollafattura.chiusa</span>
                        <span class="iwebPARAMETRO">@importo = popupModificaAnagraficaBolle_findValue_bollafattura.importo</span>
                        <span class="iwebPARAMETRO">@id = popupModificaAnagraficaBolle_findValue_bollafattura.id</span>
                        <span class="iwebPARAMETRO">@pathfilescansione = popupModificaAnagraficaBolle_findValue_bollafattura.pathfilescansione</span>
                        <span class="iwebPARAMETRO">@nomefilescansione = popupModificaAnagraficaBolle_findValue_bollafattura.nomefilescansione</span>
                    </div>
                    <div id="dettaglioAnagrafica_iwebSQLUPDATE_righecosto" class="iwebNascosto">
                            <%--"UPDATE costo LEFT JOIN bollafattura ON bollafattura.id = costo.idbollafattura SET costo.datacosto = bollafattura.databollafattura "--%>
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "UPDATE costo LEFT JOIN bollafattura ON bollafattura.id = costo.idbollafattura "
                          + "SET costo.datacosto = bollafattura.databollafattura "
                          + "WHERE costo.datacosto <> bollafattura.databollafattura AND bollafattura.id = @idbollafattura"
                        ) %></span>
                        <span class="iwebPARAMETRO">@idbollafattura = popupModificaAnagraficaBolle_findValue_bollafattura.id</span>
                    </div>
                </div>
                <div class="b"></div>
