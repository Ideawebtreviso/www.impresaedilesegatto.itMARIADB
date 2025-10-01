<%@ Control Language="C#" ClassName="_gestione_computo_dettaglio_voci" %>

    <div>
        <div class="btn btn-default" onclick="
            iwebApriPopupModificaiwebDETTAGLIO('dettaglioAnagrafica', 'popupModificaAnagraficaVoce');
            ">Modifica</div>
        <%--<div class="btn btn-default r" onclick="
            iwebDDL_aggiornaSelezionati('popupTabellaVociModificaDDLSuddivisioni', [10]);
            iwebApriPopupModificaiwebDETTAGLIO('dettaglioAnagrafica', 'popupModificaAnagraficaVoce');
            iwebCaricaElemento('popupTabellaVociModificaDDLSuddivisioni');">Modifica</div>--%>

        <div id="popupModificaAnagraficaVoce" class="popup popupType2 iwebBINDRIGASELEZIONATA__tabellaVoci iwebBIND__dettaglioAnagrafica" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Modifica voce</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <div class="iwebTABELLA_ContenitoreParametri"></div>
                    <table>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td>
                                <span class="iwebCAMPO_voce.id"></span>
                                <span class="iwebCAMPO_idcomputo"></span>
                                <span class="iwebCAMPO_voce.idvoceorigine"></span>
                                <span class="iwebCAMPO_voce.posizione"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Codice *</td>
                            <td><input type="text" 
                                class="iwebCAMPO_codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Titolo *</td>
                            <td><input type="text" 
                                class="iwebCAMPO_titolo iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td>
                                <textarea class="iwebCAMPO_voce.descrizione iwebTIPOCAMPO_memo"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>Suddivisione</td>
                            <td>
                                <select id="popupTabellaVociModificaDDLSuddivisioni" class="iwebDDL iwebCAMPO_idsuddivisione iwebTIPOCAMPO_varchar">
                                    <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                </select>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT descrizione as NOME, id as VALORE FROM suddivisione WHERE idcomputo = @idcomputo") %></span>
	                                <span class="iwebPARAMETRO">@idcomputo = IDCOMPUTO_value</span>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>Nuova suddivisione</td>
                            <td><input type="text" class="iwebCAMPO_suddivisione.descrizione iwebTIPOCAMPO_varchar"/></td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" 
                        onclick="gestioneComputo_popupTabellaVociModifica_confermaModifica('popupModificaAnagraficaVoce', 'dettaglioAnagrafica');
                                    // questo è definito allìinterno della funziona qua sopra  iwebBind('tabellaVoci');">Aggiorna</div>
                </div>
            </div>
        </div>
        <%--<div class="iwebSQLUPDATE">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE voce SET nominativo = @nominativo, tel = @tel, mail = @mail WHERE id = @id") %></span>
	        <span class="iwebPARAMETRO">@nominativo = popupModificaAnagraficaVoce_findValue_codice</span>
	        <span class="iwebPARAMETRO">@tel = popupModificaAnagraficaVoce_findValue_titolo</span>
	        <span class="iwebPARAMETRO">@mail = popupModificaAnagraficaVoce_findValue_descrizione</span>
	        <span class="iwebPARAMETRO">@id = popupModificaAnagraficaVoce_findValue_id</span>
        </div>--%>
    </div>
    <div class="b"></div>
<br />

    <div>
        <table id="dettaglioAnagrafica" class="iwebDETTAGLIO">
            <%--ajaxDettaglioBindFrom_tabellaClienti">--%>
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
                <%-- aggiungi qui tr specifici (vengono letti solo se non esiste il div qua sopra) --%>
                <tr class="iwebNascosto">
                    <td>dati</td>
                    <td><span class="iwebCAMPO_idsuddivisione"></span>
                        <span class="iwebCAMPO_voce.id"></span>
                        <span class="iwebCAMPO_voce.posizione"></span>
                        <span class="iwebCAMPO_voce.idvoceorigine"></span>
                    </td>
                </tr>
                <tr>
                    <td>codice</td>
                    <td><span class="iwebCAMPO_codice iwebCodice"></span></td>
                </tr>
                <tr>
                    <td>titolo</td>
                    <td><span class="iwebCAMPO_titolo"></span></td>
                </tr>
                <tr>
                    <td>descrizione voce</td>
                    <td><span class="iwebCAMPO_voce.descrizione iwebDescrizione iwebTroncaCrtsAt_1000"></span></td>
                </tr>
                <tr>
                    <td>descrizione suddivisione</td>
                    <td><span class="iwebCAMPO_suddivisionedescrizione iwebDescrizione iwebTroncaCrtsAt_50"></span></td>
                </tr>
            </tbody>
            <tbody></tbody>
        </table>
        <%-- SELECT codice, titolo, descrizione, idsuddivisione FROM voce WHERE id = @id --%>
        <span class="iwebSQLSELECT">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
            "SELECT codice, " + 
            "       titolo, " +
            "       voce.id as 'voce.id', " +
            "       voce.descrizione as 'voce.descrizione', " +
            "       voce.posizione as 'voce.posizione', " +
            "       voce.idvoceorigine as 'voce.idvoceorigine', " +
            "       idsuddivisione, " +
            "       suddivisione.descrizione as 'suddivisionedescrizione' " +
            "FROM voce LEFT JOIN suddivisione ON voce.idsuddivisione = suddivisione.id "+
            "WHERE voce.id = @idvoce") %></span>
            <span class="iwebPARAMETRO">@idvoce = tabellaVoci_selectedValue_voce.id</span>
        </span>
    </div>
    <div class="b"></div>
