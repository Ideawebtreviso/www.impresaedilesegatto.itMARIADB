<%@ Control Language="C#" ClassName="_anagrafica_clienti_dettaglio_cliente" %>

                <div class="l">
                    <table id="dettaglioAnagrafica" class="iwebDETTAGLIO">
                        <%--ajaxDettaglioBindFrom_tabellaClienti">--%>
                        <thead>
                            <tr>
                                <td>NOME CAMPO</td>
                                <td>VALORE CAMPO</td>
                            </tr>
                        </thead>
                        <tbody class="iwebNascosto">
                            <tr>
                                <td>@NOMECAMPO</td>
                                <td><span class="iwebCAMPO_@NOMECAMPO">@VALORECAMPO</span></td>
                            </tr>
                        </tbody>
                        <tbody></tbody>
                    </table>
                    <span class="iwebSQLSELECT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT * FROM cliente WHERE id = @id") %></span>
                        <%-- <span class="sqlParameter">@parametro = idElemento_azione[_nomecampo]</span> --%>
                        <span class="iwebPARAMETRO">@id = tabellaClienti_selectedValue_cliente.id</span>
                    </span>
                </div>
                <div class="r">
                    <div class="btn btn-default r" onclick="iwebApriPopupModificaiwebDETTAGLIO('dettaglioAnagrafica', 'popupModificaAnagraficaCliente');">Modifica</div>

                    <div id="popupModificaAnagraficaCliente" class="popup popupType2 iwebBINDRIGASELEZIONATA__tabellaClienti iwebBIND__dettaglioAnagrafica" style="display: none">
                        <div>
                            <div class="popupHeader">
                                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()"></div>
                                <div class="popupTitolo l">Modifica anagrafica cliente</div>
                                <div class="b"></div>
                            </div>
                            <div class="popupCorpo">
                                <table>
                                    <tr>
                                        <td>id</td>
                                        <td><span class="iwebCAMPO_id"></span></td>
                                    </tr>
                                    <tr>
                                        <td>Nominativo *</td>
                                        <td>
                                            <input type="text" class="iwebCAMPO_nominativo iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                    </tr>
                                    <tr>
                                        <td>Indirizzo</td>
                                        <td>
                                            <input type="text" class="iwebCAMPO_indirizzo iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <tr>
                                        <td>Citta</td>
                                        <td>
                                            <input type="text" class="iwebCAMPO_citta iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <tr>
                                        <td>Provincia</td>
                                        <td>
                                            <input type="text" class="iwebCAMPO_provincia iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <tr>
                                        <td>Email</td>
                                        <td>
                                            <input type="text" class="iwebCAMPO_email iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <tr>
                                        <td>Telefono</td>
                                        <td>
                                            <input type="text" class="iwebCAMPO_telefono iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <tr>
                                        <td>cf</td>
                                        <td>
                                            <input type="text" class="iwebCAMPO_cf iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <tr>
                                        <td>piva</td>
                                        <td>
                                            <input type="text" class="iwebCAMPO_piva iwebTIPOCAMPO_varchar" /></td>
                                    </tr>
                                    <%-- basta aggiungere nomi di campi esistenti e funziona --%>
                                    <%--<tr>
                                        <td></td>
                                        <td><input type="button" value="Aggiorna" onclick="iwebBindPopupModificaiwebDETTAGLIO()" /></td>
                                    </tr>--%>
                                </table>
                            </div>
                            <div class="popupFooter">
                                <%--<input type="button" value="Aggiorna" onclick="iwebBindPopupModificaiwebDETTAGLIO()" />--%>
                                <div class="btn btn-warning" onclick="chiudiPopupType2()">Annulla</div>
                                <div class="btn btn-success" onclick="iwebBindPopupModificaiwebDETTAGLIO()">Aggiorna</div>
                            </div>
                        </div>
                    </div>
                    <div class="iwebSQLUPDATE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE cliente SET nominativo = @nominativo, indirizzo = @indirizzo, citta = @citta, provincia = @provincia, email = @email, telefono = @telefono, cf = @cf, piva = @piva WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@nominativo = popupModificaAnagraficaCliente_findValue_nominativo</span>
                        <span class="iwebPARAMETRO">@indirizzo = popupModificaAnagraficaCliente_findValue_indirizzo</span>
                        <span class="iwebPARAMETRO">@citta = popupModificaAnagraficaCliente_findValue_citta</span>
                        <span class="iwebPARAMETRO">@provincia = popupModificaAnagraficaCliente_findValue_provincia</span>
                        <span class="iwebPARAMETRO">@telefono = popupModificaAnagraficaCliente_findValue_telefono</span>
                        <span class="iwebPARAMETRO">@email = popupModificaAnagraficaCliente_findValue_email</span>
                        <span class="iwebPARAMETRO">@cf = popupModificaAnagraficaCliente_findValue_cf</span>
                        <span class="iwebPARAMETRO">@piva = popupModificaAnagraficaCliente_findValue_piva</span>
                        <span class="iwebPARAMETRO">@id = popupModificaAnagraficaCliente_findValue_id</span>
                    </div>
                </div>
                <div class="b"></div>
