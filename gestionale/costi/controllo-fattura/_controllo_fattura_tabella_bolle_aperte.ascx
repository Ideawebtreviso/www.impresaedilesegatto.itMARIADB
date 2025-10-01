<%@ Control Language="C#" ClassName="_controllo_fattura_tabella_bolle_aperte" %>

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
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM bollafattura WHERE bollafattura.id=@bollafattura.id") %></span>
            </span>
        </div>
        <table id="tabellaBolleAperte" class="iwebTABELLA iwebCHIAVE__bollafattura.id iwebBIND__elementoConITab">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <th>
                        <div class="l">Numero</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_bollafattura.numero_DESC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>
                    </th>
                    <th>Data</th>
                    <th>Chiusa</th>
                    <th>Controllato</th>
                    <th>Righe aperte</th>
                    <th>Scansione</th>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%>
                    </th>
                    <th class="iwebNascosto"></th>
                    <th>
                        <%-- filtro di testo sul campo numero --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_bollafattura.numero">
                            <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                        </div>
                    </th>
                    <th>
                        <%--maggiore uguale di--%>
                        <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_bollafattura.databollafattura">
                            <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" 
                                onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <%--minore di--%>
                        <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_bollafattura.databollafattura">
                            <%--<input type="text" placeholder="A" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>--%>
                            <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" 
                                onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <div class="glyphicon glyphicon-filter iwebCliccabile" title="Filtra" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                        </div>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo stato --%>
                        <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_bollafattura.chiusa">
                            <%-- potrei aggiungere il codice per fare in alternativa: --%>
                            <select id="ddlFiltroBolleStato" class="iwebDDL largStato"
                                onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option class="iwebAGGIUNTO" value="">tutte</option> <%-- stringa vuota ignora il filtro --%>
                                <option class="iwebAGGIUNTO" value="1">Chiusa</option>
                                <option class="iwebAGGIUNTO" value="0" selected>Aperta</option>
                            </select>

                            <br /><br />

                            <input type="checkbox" id="tabellaBolleAperteFiltroCostiSoloFattura" onchange="
                                iwebCaricaElemento('tabellaBolleAperte');
                            " /> Solo bolle fattura in testata
                        </div>
                    </th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td>
                        <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaClientiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');"></div>--%>
                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolleAperte');"></div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_bollafattura.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.numero iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.databollafattura iwebData"></span>
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_bollafattura.chiusa iwebCheckbox" disabled />
                    </td>
                    <td>
                        <span class="iwebCAMPO_importocontrollato iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_numeroRigheVerificate"></span> /
                        <span class="iwebCAMPO_numeroRighe"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.scansione"></span>
                    </td>
                </tr>
            </tbody>
            <tbody>
                <%-- il codice viene generato automaticamente qui --%>
            </tbody>
            <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                <%-- eventualmente va messo display:none --%>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><b class="r">Totale</b></td>
                    <td>
                        <span id="Span1" class="iwebTOTALE iwebQuantita"></span>
                        <span class="iwebSQLTOTAL">(righeverificate.quantita * righeverificate.prezzo * (1-righeverificate.sconto1/100) * (1-righeverificate.sconto2/100))</span>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="Select2" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT bollafattura.id as 'bollafattura.id', "
              + "       bollafattura.numero as 'bollafattura.numero', "
              + "       bollafattura.chiusa as 'bollafattura.chiusa',  "       
              + "       bollafattura.databollafattura as 'bollafattura.databollafattura', "
              + "       fornitore.id as 'fornitore.id', "
              + "       COUNT(costo.id) as 'numeroRighe', "
              + "       COUNT(righeverificate.id) as 'numeroRigheVerificate', "
              + "       SUM(righeverificate.quantita * righeverificate.prezzo * (1-righeverificate.sconto1/100) * (1-righeverificate.sconto2/100)) as 'importocontrollato' "
              + "FROM bollafattura INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
              + "                   LEFT JOIN costo ON bollafattura.id = costo.idbollafattura "
              + "                   LEFT JOIN costo as righeverificate ON righeverificate.idcostobollariferita = costo.id "
              + "                   LEFT JOIN bollafattura as fatturaverificata ON righeverificate.idbollafattura = fatturaverificata.id "
              + "WHERE bollafattura.idfornitore = @idfornitore AND bollafattura.isddt = true AND bollafattura.isfattura = false and "
              + "      (fatturaverificata.id = @idfatturaincontrollo OR @tabellaBolleAperteFiltroCostiSoloFattura = false) "
              + "GROUP BY bollafattura.id" 
            ) %></span>
            <span class="iwebPARAMETRO">@idfornitore = tabellaFatture_findFirstValue_fornitore.id</span>
            <span class="iwebPARAMETRO">@idfatturaincontrollo = tabellaFatture_findFirstValue_bollafattura.id</span>
            <span class="iwebPARAMETRO">@tabellaBolleAperteFiltroCostiSoloFattura = tabellaBolleAperteFiltroCostiSoloFattura_value</span>
            
        </span>
    </div>
