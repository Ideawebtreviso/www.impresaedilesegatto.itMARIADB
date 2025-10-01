<%@ Control Language="C#" ClassName="_anagrafica_fornitori_dettaglio_fornitori" %>


                <div class="l">
                    <table id="dettaglioAnagrafica" class="iwebDETTAGLIO">
                        <%--ajaxDettaglioBindFrom_tabellaProdotti">--%>
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
                                    <%--<span class="iwebCAMPO_tel"></span>
                                    <span class="iwebCAMPO_mail"></span>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>ID</td>
                                <td><span class="iwebCAMPO_id"></span></td>
                            </tr>
                            <tr>
                                <td>Ragione sociale</td>
                                <td><span class="iwebCAMPO_ragionesociale iwebDescrizione iwebTroncaCrtsAt_30"></span></td>
                            </tr>
                            <tr>
                                <td>Indirizzo</td>
                                <td><span class="iwebCAMPO_indirizzo iwebDescrizione iwebTroncaCrtsAt_30"></span></td>
                            </tr>
                            <tr>
                                <td>Citta</td>
                                <td><span class="iwebCAMPO_citta iwebDescrizione iwebTroncaCrtsAt_30"></span></td>
                            </tr>
                            <tr>
                                <td>Provincia</td>
                                <td><span class="iwebCAMPO_provincia"></span></td>
                            </tr>
                            <tr>
                                <td>Telefono</td>
                                <td><span class="iwebCAMPO_telefono"></span></td>
                            </tr>
                            <tr>
                                <td>Email</td>
                                <td><span class="iwebCAMPO_email"></span></td>
                            </tr>
                            <tr>
                                <td>Cf</td>
                                <td><span class="iwebCAMPO_cf"></span></td>
                            </tr>
                            <tr>
                                <td>Piva</td>
                                <td><span class="iwebCAMPO_piva"></span></td>
                            </tr>
                            <tr>
                                <td>Fax</td>
                                <td><span class="iwebCAMPO_fax"></span></td>
                            </tr>
                            <tr>
                                <td>Tipo fornitore</td>
                                <td><span class="iwebCAMPO_tipofornitore"></span></td>
                            </tr>
                        </tbody>
                        <tbody></tbody>
                    </table>
                    <span class="iwebSQLSELECT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT * FROM fornitore WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = tabellaFornitori_selectedValue_fornitore.id</span>
                    </span>
                </div>
                <div class="r">
                    <%--<input type="button" class="btn btn-default btn-sm r" value="Modifica" 
                        onclick="iwebApriPopupModificaiwebDETTAGLIO('dettaglioAnagrafica', 'popupModificaAnagraficaFornitore');"/>--%>
                    <div class="btn btn-default r" onclick="iwebApriPopupModificaiwebDETTAGLIO('dettaglioAnagrafica', 'popupModificaAnagraficaFornitore');">Modifica</div>

                    <div id="popupModificaAnagraficaFornitore" class="popup popupType2 iwebBINDRIGASELEZIONATA__tabellaFornitori iwebBIND__dettaglioAnagrafica" style="display:none">
                        <div>
                            <div class="popupHeader">
                                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                                <div class="popupTitolo l">Modifica anagrafica fornitore</div>
                                <div class="b"></div>
                            </div>
                            <div class="popupCorpo">
                                <table>
                                    <tr>
                                        <td>id</td>
                                        <td><span class="iwebCAMPO_id"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Ragione sociale *</td>
                                        <td><input type="text" class="iwebCAMPO_ragionesociale iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                            onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                    </tr>
                                    <tr>
                                        <td>Indirizzo</td>
                                        <td><input type="text" class="iwebCAMPO_indirizzo iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <tr>
                                        <td>Citta</td>
                                        <td><input type="text" class="iwebCAMPO_citta iwebTIPOCAMPO_varchar"/></td>
                                    </tr>
                                    <tr>
                                        <td>Provincia</td>
                                        <td><input type="text" class="iwebCAMPO_provincia iwebTIPOCAMPO_varchar"/></td>
                                    </tr>
                                    <tr>
                                        <td>Telefono</td>
                                        <td><input type="text" class="iwebCAMPO_telefono iwebTIPOCAMPO_varchar"/></td>
                                    </tr>
                                    <tr>
                                        <td>Email</td>
                                        <td><input type="text" class="iwebCAMPO_email iwebTIPOCAMPO_varchar"/></td>
                                    </tr>
                                    <tr>
                                        <td>Cf</td>
                                        <td><input type="text" class="iwebCAMPO_cf iwebTIPOCAMPO_varchar"/></td>
                                    </tr>
                                    <tr>
                                        <td>Piva</td>
                                        <td><input type="text" class="iwebCAMPO_piva iwebTIPOCAMPO_varchar"/></td>
                                    </tr>
                                    <tr>
                                        <td>Fax</td>
                                        <td><input type="text" class="iwebCAMPO_fax iwebTIPOCAMPO_varchar"/></td>
                                    </tr>
                                    <tr>
                                        <td>Tipo fornitore</td>
                                        <td>
                                            <div class="iwebTIPOCAMPO_varchar">
                                                <select class="iwebCAMPO_fornitore.tipofornitore"
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
                                <%--<input type="button" value="Aggiorna" onclick="iwebBindPopupModificaiwebDETTAGLIO()" />--%>
                                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                                <div class="btn btn-success" onclick="iwebBindPopupModificaiwebDETTAGLIO()">Aggiorna</div>
                            </div>
                        </div>
                    </div>
                    <div class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE fornitore SET ragionesociale = @ragionesociale, indirizzo = @indirizzo, provincia = @provincia, citta = @citta, provincia = @provincia, email = @email, piva = @piva, fax = @fax, tipofornitore = @tipofornitore WHERE id = @id") %></span>
	                    <span class="iwebPARAMETRO">@ragionesociale = popupModificaAnagraficaFornitore_findValue_ragionesociale</span>
	                    <span class="iwebPARAMETRO">@indirizzo = popupModificaAnagraficaFornitore_findValue_indirizzo</span>
	                    <span class="iwebPARAMETRO">@provincia = popupModificaAnagraficaFornitore_findValue_provincia</span>
	                    <span class="iwebPARAMETRO">@citta = popupModificaAnagraficaFornitore_findValue_citta</span>
	                    <span class="iwebPARAMETRO">@email = popupModificaAnagraficaFornitore_findValue_email</span>
	                    <span class="iwebPARAMETRO">@piva = popupModificaAnagraficaFornitore_findValue_piva</span>
	                    <span class="iwebPARAMETRO">@fax = popupModificaAnagraficaFornitore_findValue_fax</span>
	                    <span class="iwebPARAMETRO">@tipofornitore = popupModificaAnagraficaFornitore_findValue_fornitore.tipofornitore</span>
	                    <span class="iwebPARAMETRO">@id = popupModificaAnagraficaFornitore_findValue_id</span>
                    </div>
                </div>
                <div class="b"></div>
