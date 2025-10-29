<%@ Control Language="C#" ClassName="_elenco_cantieri_dettaglio_cantieri" %>

<div class="b"></div>
        <div class="l">
            <div class="btn btn-default r" 
                onclick="iwebApriPopupModificaiwebDETTAGLIO('dettaglioAnagrafica', 'popupModificaAnagraficaCantiere');
                document.getElementById('popupTabellaCantieriModificaSpanCodiceErrato').style.display = 'none';">Modifica</div>

            <div id="popupModificaAnagraficaCantiere" class="popup popupType2 iwebBINDRIGASELEZIONATA__tabellaCantieri iwebBIND__dettaglioAnagrafica" style="display:none">
                <div>
                    <div class="popupHeader">
                        <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                        <div class="popupTitolo l">Modifica anagrafica cantiere</div>
                        <div class="b"></div>
                    </div>
                    <div class="popupCorpo">
                        <table>
                            <tr class="iwebNascosto">
                                <td>id</td>
                                <td><span class="iwebCAMPO_cantiere.id"></span></td>
                            </tr>
                            <tr>
                                <td>Nominativo *</td>
                                <td>
                                    <div class="iwebCAMPO_cliente.nominativo">
                                        <select id="popupModificaAnagraficaCantiereDDLCliente" class="iwebDDL iwebCAMPO_cliente.id iwebCAMPOOBBLIGATORIO iwebTIPOCAMPO_varchar" 
                                            onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                            <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                        </select>
                                        <span class="iwebSQLSELECT">
                                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"SELECT nominativo as NOME, id as VALORE FROM cliente ORDER BY nominativo") %></span>
                                        </span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Codice *</td>
                                <td><input type="text" 
                                        class="iwebCAMPO_cantiere.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                <td><span id="popupTabellaCantieriModificaSpanCodiceErrato" style="display:none">Il codice esiste già.</span></td>
                            </tr>
                            <tr>
                                <td>Indirizzo</td>
                                <td><input type="text" class="iwebCAMPO_cantiere.indirizzo iwebTIPOCAMPO_varchar" /></td>
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
                                <td>Data inizio</td>
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
                                <td><input type="text" class="iwebCAMPO_cantiere.descrizione iwebTIPOCAMPO_varchar" /></td>
                            </tr>
                            <tr>
                                <td>Stato</td>
                                <td>
                                    <select id="popupModificaAnagraficaCantiereStato" class="iwebCAMPO_cantiere.stato iwebTIPOCAMPO_varchar">
                                        <option value="Aperto">Aperto</option>
                                        <option value="Da firmare">Da firmare</option>
                                        <option value="Chiuso">Chiuso</option>
                                    </select>
                                </td>
                            </tr>
                            <%-- basta aggiungere nomi di campi esistenti e funziona --%>
                            <%--<tr>
                                <td></td>
                                <td><input type="button" value="Aggiorna" onclick="iwebBindPopupModificaiwebDETTAGLIO()" /></td>
                            </tr>--%>
                        </table>
                    </div>
                    <div class="popupFooter">
                        <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                        <div class="btn btn-success" onclick="popupModificaAnagraficaCantiere_conferma()">Aggiorna</div>
                        <%--<div class="btn btn-success" onclick="elencoCantieri_iwebBindPopupModificaiwebDETTAGLIO('popupModificaAnagraficaCantiere')">Aggiorna</div>--%>
                    </div>
                    <%--<div class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                            UPDATE cantiere
                            SET
                                idcliente = @idcliente,
                                codice = @codice,
                                indirizzo = @indirizzo,
                                descrizione = @descrizione,
                                stato = @stato
                            WHERE id = @id
                        ") %></span>
	                    <span class="iwebPARAMETRO">@idcliente = popupModificaAnagraficaCantiere_findValue_cliente.id</span>
	                    <span class="iwebPARAMETRO">@codice = popupModificaAnagraficaCantiere_findValue_cantiere.codice</span>
	                    <span class="iwebPARAMETRO">@indirizzo = popupModificaAnagraficaCantiere_findValue_cantiere.indirizzo</span>
	                    <span class="iwebPARAMETRO">@descrizione = popupModificaAnagraficaCantiere_findValue_cantiere.descrizione</span>
	                    <span class="iwebPARAMETRO">@stato = popupModificaAnagraficaCantiere_findValue_cantiere.stato</span>
	                    <span class="iwebPARAMETRO">@id = popupModificaAnagraficaCantiere_findValue_cantiere.id</span>
                    </div>--%>
                    <script>
                        function popupModificaAnagraficaCantiere_conferma() {
                            let idcliente = iwebValutaParametroAjax("popupModificaAnagraficaCantiere_findValue_cliente.id");
                            let codice = iwebValutaParametroAjax("popupModificaAnagraficaCantiere_findValue_cantiere.codice");
                            let indirizzo = iwebValutaParametroAjax("popupModificaAnagraficaCantiere_findvalue_cantiere.indirizzo");
                            let cantdatainizio = iwebValutaParametroAjax("popupModificaAnagraficaCantiere_findvalue_cantiere.cantdatainizio", null, "DateTime?");
                            let cantdatafine = iwebValutaParametroAjax("popupModificaAnagraficaCantiere_findvalue_cantiere.cantdatafine", null, "DateTime?");
                            let descrizione = iwebValutaParametroAjax("popupModificaAnagraficaCantiere_findvalue_cantiere.descrizione");
                            let stato = iwebValutaParametroAjax("popupModificaAnagraficaCantiere_findValue_cantiere.stato");
                            let idcantiere = iwebValutaParametroAjax("popupModificaAnagraficaCantiere_findValue_cantiere.id", null, "int?");

                            let parametri = {
                                idcliente: idcliente,
                                codice: codice,
                                indirizzo: indirizzo,
                                cantdatainizio: cantdatainizio,
                                cantdatafine: cantdatafine,
                                descrizione: descrizione,
                                stato: stato,
                                idcantiere: idcantiere
                            };
                            iwebMostraCaricamentoAjax();
                            ajax2024("/WebServiceComputi.asmx/popupModificaAnagraficaCantiere_conferma", parametri, function () {

                                iwebCaricaElemento("tabellaCantieri");
                                chiudiPopupType2B("popupModificaAnagraficaCantiere");

                                iwebNascondiCaricamentoAjax();
                            });
                        }
                    </script>
                </div>
            </div>
        </div>

        <div class="b"></div><br />

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
                    <tr class="iwebNascosto">
                        <td>ID</td>
                        <td>
                            <span class="iwebCAMPO_cantiere.id"></span>
                            <span class="iwebCAMPO_cliente.id"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Cliente</td>
                        <td><span class="iwebCAMPO_cliente.nominativo iwebDescrizione"></span></td>
                    </tr>
                    <tr>
                        <td>Codice</td>
                        <td><span class="iwebCAMPO_cantiere.codice"></span></td>
                    </tr>
                    <tr>
                        <td>Indirizzo</td>
                        <td><span class="iwebCAMPO_cantiere.indirizzo iwebDescrizione iwebTroncaCrtsAt_1000"></span></td>
                    </tr>
                    <tr>
                        <td>Data inizio</td>
                        <td><span class="iwebCAMPO_cantiere.cantdatainizio iwebData"></span></td>
                    </tr>
                    <tr>
                        <td>Data fine</td>
                        <td><span class="iwebCAMPO_cantiere.cantdatafine iwebData"></span></td>
                    </tr>
                    <tr>
                        <td>Descrizione</td>
                        <td><span class="iwebCAMPO_cantiere.descrizione iwebDescrizione iwebTroncaCrtsAt_1000"></span></td>
                    </tr>
                    <tr>
                        <td>Chiuso</td>
                        <td><span class="iwebCAMPO_cantiere.stato iwebCodice"></span></td>
                    </tr>
                </tbody>
                <tbody></tbody>
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
                        cantiere.stato as 'cantiere.stato'
                    FROM cantiere LEFT JOIN cliente ON cantiere.idcliente = cliente.id
                    WHERE cantiere.id = @id
                ") %></span>
                <span class="iwebPARAMETRO">@id = tabellaCantieri_selectedValue_cantiere.id</span>
            </span>
        </div>
        <div class="b"></div>
