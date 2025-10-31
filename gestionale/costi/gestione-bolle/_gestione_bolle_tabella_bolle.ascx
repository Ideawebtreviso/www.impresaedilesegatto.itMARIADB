<%@ Control Language="C#" ClassName="_gestione_bolle_tabella_bolle" %>

<%@ Register TagPrefix="gestionebolle_tabellabolle" TagName="controllofatture" Src="_gestionebolle_tabellabolle_controllofatture.ascx" %>

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
        <table id="tabellaBolle" class="iwebTABELLA iwebCHIAVE__bollafattura.id iwebBIND__elementoConITab">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <%--<input type="button" value="Aggiungi" onclick="apriPopupType2('popupTabellaBolleInserimento');" />--%>
                        <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                            onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaBolleInserimento');"></div>
                    </th>
                    <th></th>
                    <th class="iwebNascosto">
                        <%--<div class="l">ID</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_bollafattura.id_DESC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>--%>
                    </th>
                    <th>Fattura acc.</th>
                    <th>Numero</th>
                    <th>Prot.</th>
                    <th>Data</th>
                    <th>Fornitore</th>
                    <th>Chiusa</th>
                    <th>Importo</th>
                    <th>Righe control.</th>
                    <%--<th>Scansione</th>--%>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%>
                    </th>
                    <th class="iwebNascosto"></th>
                    <th></th>
                    <th></th>
                    <th>
                        <%-- filtro di testo sul campo nominativo --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_bollafattura.numero">
                            <input class="largNumero" type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebFILTROUgualaA iwebCAMPO_bollafattura.protocollo">
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
                        <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_fornitore.ragionesociale">
                            <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
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
                                <option class="iwebAGGIUNTO" value="0">Aperta</option>
                            </select>
                        </div>
                    </th>
                    <th></th>
                    <th></th>
                    <%--<th></th>--%>
                    <th></th><%-- ALTRO --%>
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td>
                        <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaBolleModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');"></div>--%>
                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');"></div>
                    </td>
                    <td>
                        <div class="btn btn-default iwebCAMPO_LinkPerScarico" onclick="gestioneBolle_scaricaBolla(iwebCAMPO_LinkPerScarico)" >Scarica</div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_bollafattura.id"></span>
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_bollafattura.isfattura iwebCheckbox" disabled />
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.numero iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.protocollo"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.databollafattura iwebData"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione iwebTroncaCrtsAt_30"></span>
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_bollafattura.chiusa iwebCheckbox" disabled />
                    </td>
                    <td>
                        <span class="iwebCAMPO_bollafattura.importo iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_numeroRigheVerificate"></span> /
                        <span class="iwebCAMPO_numeroRighe"></span>
                    </td>
                    <%--<td>
                        <span class="iwebCAMPO_bollafattura.nomefilescansione iwebDescrizione iwebTroncaCrtsAt_30"></span>
                    </td>--%>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaBolleElimina');">
                        </div>
                    </td><%-- ALTRO --%>
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
                    <td></td>
                    <td></td>
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="Select1KNBRRE4" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
            <%-- La data costo deve essere sempre la data della bolla se si riferisce a una bolla e la data fattura se si riferisce alla fattura. --%>
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                 "SELECT bollafattura.id as 'bollafattura.id', "
               + "       bollafattura.id as 'LinkPerScarico', "
               + "       bollafattura.numero as 'bollafattura.numero', "
               + "       bollafattura.protocollo as 'bollafattura.protocollo', "
               + "       bollafattura.databollafattura as 'bollafattura.databollafattura', "
               + "       bollafattura.isfattura as 'bollafattura.isfattura', "
               + "       bollafattura.importo as 'bollafattura.importo', "
               + "       bollafattura.pathfilescansione as 'bollafattura.pathfilescansione', "
               + "       bollafattura.nomefilescansione as 'bollafattura.nomefilescansione', "
               + "       bollafattura.chiusa as 'bollafattura.chiusa', "
               + "       fornitore.id as 'fornitore.id', "
               + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "
               + "       COUNT(costo.id) as 'numeroRighe', "
               + "   IF (bollafattura.isfattura, COUNT(costo.id), COUNT(righeverificate.id)) as 'numeroRigheVerificate' " 
               + "FROM bollafattura LEFT JOIN fornitore ON (bollafattura.idfornitore = fornitore.id) "
               + "LEFT JOIN costo ON bollafattura.id = costo.idbollafattura "
               + "LEFT JOIN costo as righeverificate ON righeverificate.idcostobollariferita = costo.id "
               + "WHERE bollafattura.isddt = true "
               + "GROUP BY bollafattura.id " 
               + "ORDER BY bollafattura.id DESC"
               
               )%></span>
        </span>

        <%-- inserimento --%>
        <div id="popupTabellaBolleInserimento" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Inserisci nuova bolla</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <table>
                        <tr>
                            <td>Numero *</td>
                            <td><input id="popupTabellaBolleInserimentoNumero" type="text" 
                                    class="iwebCAMPO_bollafattura.numero iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Prot.</td>
                            <td>
                                <input type="text" class="iwebCAMPO_bollafattura.protocollo iwebTIPOCAMPO_varchar"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Data *</td>
                            <td>
                                <input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_date iwebCAMPOOBBLIGATORIO" 
                                    onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                                    placeholder="gg/mm/aaaa" onfocus="scwLanguage='it';scwShow(this, event);" 
                                    onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>Fornitore *</td>
                            <%--<td><input type="text" class="iwebCAMPO_fornitore.id iwebTIPOCAMPO_varchar" /></td>--%>
                            <td>
                                <div class="iwebCAMPO_fornitore.ragionesociale">
                                    <select id="popupTabellaBolleInserimentoDDLFornitore" class="iwebDDL iwebCAMPO_fornitore.id iwebCAMPOOBBLIGATORIO" 
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
                            <td>
                                E' fattura
                            </td>
                            <td>
                                <input type="checkbox"  class="iwebCAMPO_bollafattura.isfattura"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Importo</td>
                            <td>
                                <input type="text" class="iwebCAMPO_bollafattura.importo iwebTIPOCAMPO_varchar"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Scansione</td>
                            <td>
                                <div id="popupTabellaBolleInserimentoPDFFileUpload" class="iwebFileUpload">
                                    <input type="file" onchange="iwebPREPARAUPLOAD(event)" />
                                    <img class="iwebNascosto" src="//:0" alt="preview" />
                                    <span class="iwebNascosto"></span> <%-- contenuto file selezionato --%>
                                    <span class="iwebCAMPO_bollafattura.nomefilescansione"></span> <%-- nome file selezionato --%>
                                    <span class="iwebNascosto iwebCAMPO_bollafattura.pathfilescansione"></span> <%-- nome file uploadato --%>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <%-- IdPopupAssociato, nomeQuery, parametriQuery, attesaRispostaServer --%>
                    <div class="btn btn-success" onclick="
                        /* verifico se numero-giorno-mese-idfornitore esistono già a DB. Se esistono mostro un alert di errore. Procedo solo se non esistono. */
                        popupTabellaBolleInserimentoVerificaInserimentiDoppi(function() {
                            /* tento di uploadare il file, se ci riesco con esito positivo, confermo l'aggiunta del record */
                            iwebINVIADATI('popupTabellaBolleInserimentoPDFFileUpload',
                                function(){
                                    iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaBolleInserimento', 'tabellaBolle', '', true);
                                }
                            );
                        });
                    ">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "INSERT INTO bollafattura (idfornitore, numero, protocollo, databollafattura, isddt, isfattura, importo, chiusa, pathfilescansione, nomefilescansione) "
                          + "VALUES(@idfornitore, @numero, @protocollo, @databollafattura, true, @isfattura, @importo, @chiusa, @pathfilescansione, @nomefilescansione)"
                        ) %></span>
                        <span class="iwebPARAMETRO">@idfornitore = popupTabellaBolleInserimento_findValue_fornitore.id</span>
                        <span class="iwebPARAMETRO">@numero = popupTabellaBolleInserimento_findValue_bollafattura.numero</span>
                        <span class="iwebPARAMETRO">@protocollo = popupTabellaBolleInserimento_findValue_bollafattura.protocollo</span>
                        <span class="iwebPARAMETRO">@databollafattura = popupTabellaBolleInserimento_findValue_bollafattura.databollafattura</span>
                        <span class="iwebPARAMETRO">@isfattura = popupTabellaBolleInserimento_findValue_bollafattura.isfattura</span>
                        <span class="iwebPARAMETRO">@importo = popupTabellaBolleInserimento_findValue_bollafattura.importo</span>
                        <span class="iwebPARAMETRO">@pathfilescansione = popupTabellaBolleInserimento_findValue_bollafattura.pathfilescansione</span>
                        <span class="iwebPARAMETRO">@nomefilescansione = popupTabellaBolleInserimento_findValue_bollafattura.nomefilescansione</span>
                        <%-- una bolla che è anche fattura di default è chiusa --%>
                        <span class="iwebPARAMETRO">@chiusa = popupTabellaBolleInserimento_findValue_bollafattura.isfattura</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <script>
            function funzionePopupTabellaBolleElimina() {
                var bottoneElimina = document.getElementById("popupTabellaBolleElimina_BottoneElimina");
                bottoneElimina.setAttribute("disabled","disabled");

                // carico la tabella interna al popup
                iwebCaricaElemento('tabellaCostiFattureCollegate', false, function () {
                    // terminato il caricamento della tabella interna:
                    var n = document.getElementById('tabellaCostiFattureCollegate').getElementsByTagName('tbody')[1].getElementsByTagName('td').length;
                    if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                        document.getElementById('tabellaCostiFattureCollegate').style.display = 'none';
                        document.getElementById('messaggioErroreSeTabellaCostiFattureCollegateHaRighe').style.display = 'none';
                        bottoneElimina.removeAttribute("disabled");
                    } else {
                        document.getElementById('tabellaCostiFattureCollegate').style.display = 'initial';
                        document.getElementById('messaggioErroreSeTabellaCostiFattureCollegateHaRighe').style.display = 'initial';
                        // bottoneElimina.removeAttribute("disabled"); -> di default è già stato bloccato a inizio funzionePopupTabellaBolleElimina()
                    }
                })
            }
        </script>
        <div id="popupTabellaBolleElimina" class="popup popupType2 iwebfunzione_funzionePopupTabellaBolleElimina" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione bolla, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">
                    <table>
                        <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td><span class="iwebCAMPO_bollafattura.id"></span></td>
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
                            <td><span class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_date"></span></td>
                        </tr>
                        <tr>
                            <td>Fornitore</td>
                            <td><span class="iwebCAMPO_fornitore.ragionesociale"></span></td>
                        </tr>
                        <tr>
                            <td>Bolla accompagnatoria</td>
                            <td><input type="checkbox" class="iwebCAMPO_bollafattura.isfattura" disabled /></td>
                        </tr>
                        <tr>
                            <td>Chiusa</td>
                            <td><input type="checkbox" class="iwebCAMPO_bollafattura.chiusa" disabled/></td>
                        </tr>
                        <tr>
                            <td>Importo</td>
                            <td><span class="iwebCAMPO_bollafattura.importo"></span></td>
                        </tr>
                        <tr>
                            <td>Righe verificate</td>
                            <td>
                                <span class="iwebCAMPO_numeroRigheVerificate"></span> /
                                <span class="iwebCAMPO_numeroRighe"></span>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top">Costi fattura collegati:</td>
                            <td>
                                <gestionebolle_tabellabolle:controllofatture runat="server" />
                                <div id="messaggioErroreSeTabellaCostiFattureCollegateHaRighe">Cancellazione non possibile finchè ci sono costi collegati a una o più fatture.</div>
                            </td>
                        </tr>
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella  --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div id="popupTabellaBolleElimina_BottoneElimina" class="btn btn-danger" onclick="eliminaBolla();">Elimina</div>
                </div>
            </div>
        </div>
    </div>

