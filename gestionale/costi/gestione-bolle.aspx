<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="gestione-bolle.aspx.cs" Inherits="gestionale_costi_gestione_bolle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="gestione-bolle.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Gestione bolle
    </div>

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
                    <th class="iwebNascosto">ID</th>
                    <th>Fattura acc.</th>
                    <th>Numero</th>
                    <th>Data</th>
                    <th><div class="l">Fornitore</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_fornitore.ragionesociale_ASC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>
                    </th>
                    <th>Chiusa</th>
                    <th>Importo</th>
                    <th>Righe controllate</th>
                    <th>Scansione</th>
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
                        <%--maggiore uguale di--%>
                        <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_bollafattura.databollafattura">
                            <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <%--minore di--%>
                        <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_bollafattura.databollafattura">
                            <%--<input type="text" placeholder="A" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>--%>
                            <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                        </div>
                        <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                        </div>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo telefono --%>
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
                                <option class="iwebAGGIUNTO" value="0">Chiusa</option>
                                <option class="iwebAGGIUNTO" value="1">Aperta</option>
                            </select>
                        </div>
                    </th>
                    <th></th>
                    <th></th>
                    <th></th>
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
                    <td>
                        <span class="iwebCAMPO_bollafattura.pathfilescansione iwebDescrizione iwebTroncaCrtsAt_30"></span>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaBolleElimina')"></div>
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
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="Select1QTBL67SS" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                 "SELECT bollafattura.id as 'bollafattura.id', "
               + "       bollafattura.id as 'LinkPerScarico', "
               + "       bollafattura.numero as 'bollafattura.numero', "
               + "       bollafattura.databollafattura as 'bollafattura.databollafattura', "
               + "       bollafattura.isfattura as 'bollafattura.isfattura', "
               + "       bollafattura.importo as 'bollafattura.importo', "
               + "       bollafattura.pathfilescansione as 'bollafattura.pathfilescansione', "
               + "       bollafattura.chiusa as 'bollafattura.chiusa', "
               + "       fornitore.id as 'fornitore.id', "
               + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "
               + "       COUNT(costo.id) as 'numeroRighe', "
               + "   IF (bollafattura.isfattura, COUNT(costo.id), COUNT(righeverificate.id)) as 'numeroRigheVerificate' " 
               + "FROM bollafattura LEFT JOIN fornitore ON (bollafattura.idfornitore = fornitore.id) "
               + "LEFT JOIN costo ON bollafattura.id = costo.idbollafattura "
               + "LEFT JOIN costo as righeverificate ON righeverificate.idcostobollariferita = costo.id "
               + "WHERE bollafattura.isddt = true"
               + "GROUP BY bollafattura.id" 
               
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
                            <td>Data *</td>
                            <td>
                                <input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_date iwebCAMPOOBBLIGATORIO" 
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
                                Accompagnatoria
                            </td>
                            <td>
                                <input type="checkbox"  class="iwebCAMPO_bollafattura.isfattura iwebTIPOCAMPO_date"/>
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
                                <div id="popupTabellaBolleInserimentoPDFFileUpload" class="iwebFileUpload iwebCAMPO_bollafattura.pathfilescansione">
                                    <input type="file" onchange="iwebPREPARAUPLOAD(event)" />
                                    <img class="iwebNascosto" src="/extra-sito/imageNotFound.gif" alt="preview" />
                                    <span class="iwebNascosto"></span> <%-- contenuto file selezionato --%>
                                    <span class="iwebNascosto"></span> <%-- nome file selezionato --%>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <%-- IdPopupAssociato, nomeQuery, parametriQuery, attesaRispostaServer --%>
                    <div class="btn btn-success" onclick="iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaBolleInserimento', 'tabellaBolle', '', true)">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "INSERT INTO bollafattura (idfornitore, numero, databollafattura, isddt, isfattura, importo, chiusa, pathfilescansione) "
                                             + "VALUES(@idfornitore, @numero, @databollafattura, true, @isfattura, @importo, false, @pathfilescansione)" ) %></span>
                        <span class="iwebPARAMETRO">@idfornitore = popupTabellaBolleInserimento_findValue_fornitore.id</span>
                        <span class="iwebPARAMETRO">@numero = popupTabellaBolleInserimento_findValue_bollafattura.numero</span>
                        <span class="iwebPARAMETRO">@databollafattura = popupTabellaBolleInserimento_findValue_bollafattura.databollafattura</span>
                        <span class="iwebPARAMETRO">@isfattura = popupTabellaBolleInserimento_findValue_bollafattura.isfattura</span>
                        <span class="iwebPARAMETRO">@importo = popupTabellaBolleInserimento_findValue_bollafattura.importo</span>
                        <span class="iwebPARAMETRO">@pathfilescansione = popupTabellaBolleInserimento_findValue_bollafattura.pathfilescansione</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <div id="popupTabellaBolleElimina" class="popup popupType2" style="display:none">
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
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-danger" onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaBolleElimina', 'tabellaBolle', true);">Elimina</div>
                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM bollafattura WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = tabellaBolle_selectedValue_bollafattura.id</span>
                    </span>
                </div>
            </div>
        </div>
    </div><%-- fine tabellaSinistra --%>


    <%-- elemento con i tab a destra --%>
    <div id="elementoConITab" class="iwebTABPADRE width610 r">
        <div class="headerTab"></div>
        <div class="corpoTab">
            <div class="iwebTABFIGLIO Tab_1 selectedTab iwebBIND__dettaglioAnagrafica iwebTABNOMEHEAD_Bolla">
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
                                <td>Bolla Accompagnatoria</td>
                                <td><input type="checkbox" class="iwebCAMPO_bollafattura.isfattura" disabled /></td>
                            </tr>
                            <tr>
                                <td>Scansione</td>
                                <td><span class="iwebCAMPO_bollafattura.pathfilescansione"></span></td>
                            </tr>
                        </tbody>
                        <tbody></tbody>
                    </table>
                    <span class="iwebSQLSELECT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "SELECT bollafattura.id as 'bollafattura.id', bollafattura.numero as 'bollafattura.numero', bollafattura.isfattura as 'bollafattura.isfattura', "
                            + "       bollafattura.databollafattura as 'bollafattura.databollafattura', bollafattura.chiusa as 'bollafattura.chiusa', " 
                            + "       bollafattura.importo as 'bollafattura.importo', bollafattura.pathfilescansione as 'bollafattura.pathfilescansione', "
                            + "       fornitore.id as 'fornitore.id', fornitore.ragionesociale as 'fornitore.ragionesociale' "
                            + "FROM bollafattura LEFT JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
                            + "WHERE bollafattura.id = @id AND bollafattura.isddt = true") %></span>
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
                                        <td>Data</td>
                                        <td><%--<input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_varchar"/>--%>
                                            <input type="text" class="iwebCAMPO_bollafattura.databollafattura iwebTIPOCAMPO_date" 
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
                                        <td>Accompagnatoria</td>
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
                                        <td></td>
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
                                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                                <div class="btn btn-success" onclick="iwebBindPopupModificaiwebDETTAGLIO()">Aggiorna</div>
                            </div>
                        </div>
                    </div>
                    <div class="iwebSQLUPDATE">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                            "UPDATE bollafattura SET numero = @numero, databollafattura = @databollafattura, "
                                          + "       idfornitore = @idfornitore, isfattura = @isfattura, chiusa = @chiusa, importo = @importo "
                                          + "WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@numero = popupModificaAnagraficaBolle_findValue_bollafattura.numero</span>
                        <span class="iwebPARAMETRO">@databollafattura = popupModificaAnagraficaBolle_findValue_bollafattura.databollafattura</span>
                        <span class="iwebPARAMETRO">@idfornitore = popupModificaAnagraficaBolle_findValue_fornitore.id</span>
                        <span class="iwebPARAMETRO">@isfattura = popupModificaAnagraficaBolle_findValue_bollafattura.isfattura</span>
                        <span class="iwebPARAMETRO">@chiusa = popupModificaAnagraficaBolle_findValue_bollafattura.chiusa</span>
                        <span class="iwebPARAMETRO">@importo = popupModificaAnagraficaBolle_findValue_bollafattura.importo</span>
                        <span class="iwebPARAMETRO">@id = popupModificaAnagraficaBolle_findValue_bollafattura.id</span>
                    </div>
                </div>
                <div class="b"></div>
            </div><%-- fine tab 1 --%>


            <div class="iwebTABFIGLIO Tab_2 iwebBIND__tabellaCosti iwebTABNOMEHEAD_Righe_bolla">
                <table id="tabellaCosti" class="iwebTABELLA iwebCHIAVE__costo.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="iwebNascosto commandHead">
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                                    onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaCostiInserimento');"></div>
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th><div class="l">Prodotto</div>
                                <div>
                                    <span class="iwebFILTROOrdinamento iwebSORT_prodotto.descrizione_ASC glyphicon glyphicon-sort-by-alphabet r" 
                                    onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                                </div>
                                <div class="b"></div>
                            </th>
                            <th>Qta cons</th>
                            <th>Prezzo cons</th>
                            <th>Num fatt</th>
                            <th>Data fatt</th>
                            <th>Qta fatt</th>
                            <th>Prezzo fatt</th>
                            <th></th><%-- ALTRO --%>
                        </tr>
                        <tr>
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th class="iwebNascosto"><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
                            <th>
                                <%-- filtro di testo sul campo prodotto.descrizione --%>
                                <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.descrizione">
                                    <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                                </div>
                            </th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th>
                                <%--maggiore uguale di--%>
                                <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_fatturacontrollata.databollafattura">
                                    <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                </div>
                                <%--minore di--%>
                                <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_data_creazione">
                                    <%--<input type="text" placeholder="A" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>--%>
                                    <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                </div>
                                <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                </div>
                            </th>
                            <th></th>
                            <th></th>
                            <th></th><%-- ALTRO --%>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td class="iwebNascosto">
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaCostiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');"></div>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');"></div>--%>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_costo.id"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.quantita iwebValuta"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_fatturacontrollata.numero iwebCodice"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_fatturacontrollata.databollafattura iwebData"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costobollafatturariferita.quantita iwebCodice"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costobollafatturariferita.prezzo iwebValuta"></span>
                            </td>
                            <td>
                                <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                     onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');
                                              iwebTABELLA_EliminaRigaInPopup('popupTabellaCostiElimina')"></div>
                                <%--<input type="button" value="Elimina" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCosti');
                                                                                iwebTABELLA_EliminaRigaInPopup('popupTabellaCostiElimina')" />--%>
                            </td><%-- ALTRO --%>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                        <%-- eventualmente va messo display:none --%>
                        <tr>
                            <td class="iwebNascosto"></td>
                            <td class="iwebNascosto"></td>
                            <td></td>
                            <td>Tot</td>
                            <td class="iwebValuta_tdPadre">
                                <span id="SpanTotalePrezzoCons" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">costo.prezzo</span>
	                            <span class="iwebPARAMETRO iwebNascosto">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
                            </td>
                            <td></td>
                            <td></td>
                            <td>
                                <span id="SpanTotaleQtaFatt" class="iwebTOTALE"></span>
                                <span class="iwebSQLTOTAL">costobollafatturariferita.quantita</span>
	                            <span class="iwebPARAMETRO iwebNascosto">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
                            </td>
                            <td class="iwebValuta_tdPadre">
                                <span id="Span1" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">costobollafatturariferita.prezzo</span>
	                            <span class="iwebPARAMETRO iwebNascosto">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
                            </td>
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
                <%--<span class="iwebSQLSELECT">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT * FROM costo") %></span>
                </span>--%>
                <span class="iwebSQLSELECT">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                        "SELECT costo.id as 'costo.id', "
                      + "       prodotto.descrizione as 'prodotto.descrizione', "
                      + "       costo.quantita as 'costo.quantita', "
                      + "       costo.prezzo as 'costo.prezzo', "
                      + "       fatturacontrollata.numero as 'fatturacontrollata.numero', "
                      + "       fatturacontrollata.databollafattura as 'fatturacontrollata.databollafattura', "
                      + "       costobollafatturariferita.quantita as 'costobollafatturariferita.quantita', "
                      + "       costobollafatturariferita.prezzo as 'costobollafatturariferita.prezzo' "
                      + "FROM ((costo LEFT JOIN costo as costobollafatturariferita ON costobollafatturariferita.idcostobollariferita = costo.id) "
                      + "             LEFT JOIN prodotto ON costo.idprodotto = prodotto.id) "
                      + "             LEFT JOIN bollafattura as fatturacontrollata ON costobollafatturariferita.idbollafattura = fatturacontrollata.id "
                      + "WHERE costo.idbollafattura = @idbollafattura") %></span>
                    <span class="iwebPARAMETRO">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
                </span>

                <%-- elimina --%>
                <div id="popupTabellaCostiElimina" class="popup popupType2" style="display:none">
                    <div>
                        <div class="popupHeader">
                            <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                            <div class="popupTitolo l">Eliminazione costo bolla, ricontrolla i dati</div>
                            <div class="b"></div>
                        </div>
                        <div class="iwebTABELLA_ContenitoreParametri"></div>
                        <div class="popupCorpo">
                            <table>
                                <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                     in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                                <tr class="iwebNascosto">
                                    <td>id</td>
                                    <td><span class="iwebCAMPO_costo.id"></span></td>
                                </tr>
                                <tr>
                                    <td>Prodotto</td>
                                    <td>
                                        <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Qta consegna</td>
                                    <td>
                                        <span class="iwebCAMPO_costo.quantita iwebValuta"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Prezzo consegna</td>
                                    <td>
                                        <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Num fattura</td>
                                    <td>
                                        <span class="iwebCAMPO_fatturacontrollata.numero iwebCodice"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Data fattura</td>
                                    <td>
                                        <span class="iwebCAMPO_fatturacontrollata.databollafattura iwebData"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Qta fattura</td>
                                    <td>
                                        <span class="iwebCAMPO_costobollafatturariferita.quantita iwebCodice"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Prezzo fattura</td>
                                    <td>
                                        <span class="iwebCAMPO_costobollafatturariferita.prezzo iwebValuta"></span>
                                    </td>
                                </tr>
                                <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                            </table>
                        </div>
                        <div class="popupFooter">
                            <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                            <div class="btn btn-danger" onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaCostiElimina', 'tabellaCosti', true);">Elimina</div>
                            <span class="iwebSQLDELETE">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM costo WHERE id = @id") %></span>
	                            <span class="iwebPARAMETRO">@id = popupTabellaCostiElimina_findValue_costo.id</span>
                            </span>
                        </div>
                    </div>
                </div>

            </div><%-- fine tab 4 --%>


            <div class="iwebTABFIGLIO Tab_3 iwebBIND__tabellaCantieri iwebTABNOMEHEAD_Cantieri">

                <table id="tabellaCantieri" class="iwebTABELLA iwebCHIAVE__cantiere.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="iwebNascosto commandHead">
                                <%--<input type="button" value="Aggiungi" onclick="apriPopupType2('popupTabellaCantieriInserimento');" />--%>
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                                    onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaCantieriInserimento');"></div>
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th>Cliente</th>
                            <th>Codice</th>
                            <th>Descrizione</th>
                        </tr>
                        <tr class="iwebNascosto">
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th class="iwebNascosto"><%-- AZIONI --%>
                            </th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td class="iwebNascosto">
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaCantieriModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');"></div>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');"></div>--%>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_cantiere.id"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cliente.nominativo"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_cantiere.descrizione iwebDescrizione"></span>
                            </td>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                        <%-- eventualmente va messo display:none --%>
                        <tr class="iwebNascosto">
                            <td class="iwebNascosto"></td>
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
                            <div class="iwebPAGESIZE"><select id="Select3" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                            <div class="iwebTOTRECORD">Trovate 0 righe</div>
                        </div></td></tr>
                    </tfoot>
                </table>
                <%--<span class="iwebSQLSELECT">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT * FROM cantiere") %></span>
                </span>--%>
                <span class="iwebSQLSELECT">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                        "SELECT cantiere.id as 'cantiere.id', "
                      + "cantiere.codice as 'cantiere.codice', "
                      + "cantiere.descrizione as 'cantiere.descrizione', "
                      + "cliente.nominativo as 'cliente.nominativo' "
                      + "FROM costo LEFT JOIN cantiere ON costo.idcantiere = cantiere.id "
                      + "           LEFT JOIN cliente ON cantiere.idcliente = cliente.id "
                      + "WHERE idbollafattura = @idbollafattura "
                      + "GROUP BY cantiere.id") %></span>
                    <span class="iwebPARAMETRO">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
                </span>

            </div><%-- fine tab 5 --%>
        </div>
    </div><%-- fine elemento con i tab --%>


    <script>
        function pageload() {
            iwebCaricaElemento("tabellaBolle");
            iwebCaricaElemento("elementoConITab");

        }
    </script>
</asp:Content>

