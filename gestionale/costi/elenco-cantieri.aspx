<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="elenco-cantieri.aspx.cs" Inherits="gestionale_costi_elenco_cantieri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="elenco-cantieri.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDFORNITORESEGATTOMANODOPERA" class="iwebNascosto"><asp:Literal ID="LabelIDFORNITORESEGATTOMANODOPERA" runat="server"></asp:Literal></span>
    <span id="IDFORNITORECOSTIGENERICI" class="iwebNascosto"><asp:Literal ID="LabelIDFORNITORECOSTIGENERICI" runat="server"></asp:Literal></span>

    <div class="TitoloPagina">
        Elenco cantieri
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
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM cantiere WHERE cantiere.id=@cantiere.id") %></span>
            </span>
        </div>
        <table id="tabellaCantieri" class="iwebTABELLA iwebCHIAVE__cantiere.id iwebBIND__elementoConITab">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                            onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaCantieriInserimento');
                            document.getElementById('popupTabellaCantieriInserimentoSpanCodiceErrato').style.display = 'none';"></div>
                    </th>
                    <th class="iwebNascosto">ID</th>
                    <th><div class="l">Codice</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_cantiere.codice_ASC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>
                    </th>
                    <th>Cliente</th>
                    <th>Descrizione</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%>
                    </th>
                    <th class="iwebNascosto"></th>
                    <th>
                        <%-- filtro di testo sul campo codice --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_cantiere.codice">
                            <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                        </div>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo nominativo --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_cliente.nominativo">
                            <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                        </div>
                    </th>
                    <th>
                        <%-- filtro di testo sul campo descrizione --%>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_cantiere.descrizione">
                            <input type="text" onkeypress="iwebTABELLA_VerificaAutocompletamento()"/>
                        </div>
                    </th>
                    <th></th><%-- ALTRO --%>
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td>
                        <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaCantieriModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');"></div>--%>
                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');"></div>
                    </td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_cantiere.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cliente.nominativo iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.descrizione iwebDescrizione"></span>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaCantieriElimina')"></div>
                        <%--<input type="button" value="Elimina" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaCantieri');
                                                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaCantieriElimina')" />--%>
                    </td><%-- ALTRO --%>
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
                "SELECT cliente.nominativo as 'cliente.nominativo', cliente.id as 'cliente.id', cantiere.id as 'cantiere.id', cantiere.codice as 'cantiere.codice', cantiere.descrizione as 'cantiere.descrizione' "
              + "FROM cantiere LEFT JOIN cliente ON cantiere.idcliente = cliente.id"
            ) %></span>
        </span>

        <%-- inserimento --%>
        <div id="popupTabellaCantieriInserimento" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Inserisci nuovo record</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <table>
                        <tr>
                            <td>Nominativo *</td>
                            <%--<td><input type="text" class="iwebCAMPO_fornitore.id iwebTIPOCAMPO_varchar" /></td>--%>
                            <td>
                                <div class="iwebCAMPO_cliente.nominativo">
                                    <select id="popupTabellaCantieriInserimentoDDLCliente" class="iwebDDL iwebCAMPO_cliente.id iwebCAMPOOBBLIGATORIO" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                        <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                    </select>
                                    <span class="iwebSQLSELECT">
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT nominativo as NOME, id as VALORE FROM cliente ORDER BY nominativo") %></span>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Codice *</td>
                            <td><input id="popupTabellaCantieriInserimentoCodice" type="text" 
                                    class="iwebCAMPO_cantiere.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                            <td><span id="popupTabellaCantieriInserimentoSpanCodiceErrato" style="display:none">Il codice esiste già.</span></td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><input id="popupTabellaCantieriInserimentoDescrizione" type="text" class="iwebCAMPO_cantiere.descrizione iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                    </table>
                </div>

                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-success" onclick="elencoCantieri_iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaCantieriInserimento', 'tabellaCantieri', '', true)">Inserisci</div>
                    <span class="iwebSQLINSERT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("INSERT INTO cantiere (idcliente, codice, descrizione) VALUES(@idcliente, @codice, @descrizione)") %></span>
                        <span class="iwebPARAMETRO">@idcliente = popupTabellaCantieriInserimento_findvalue_cliente.id</span>
                        <span class="iwebPARAMETRO">@codice = popupTabellaCantieriInserimento_findvalue_cantiere.codice</span>
                        <span class="iwebPARAMETRO">@descrizione = popupTabellaCantieriInserimento_findvalue_cantiere.descrizione</span>
                    </span>
                </div>
            </div>
        </div>

        <%-- elimina --%>
        <div id="popupTabellaCantieriElimina" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione cantiere, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">
                    <table>
                        <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                        <tr>
                            <td>id</td>
                            <td><span class="iwebCAMPO_cantiere.id"></span></td>
                        </tr>
                        <tr>
                            <td>Codice</td>
                            <td><span class="iwebCAMPO_cantiere.codice"></span></td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><span class="iwebCAMPO_cantiere.descrizione"></span></td>
                        </tr>
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-danger" onclick="iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaCantieriElimina', 'tabellaCantieri', true);">Elimina</div>
                    <span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM cantiere WHERE id = @id") %></span>
                        <span class="iwebPARAMETRO">@id = tabellaCantieri_selectedValue_cantiere.id</span>
                    </span>
                </div>
            </div>
        </div>
    </div><%-- fine tabellaSinistra --%>


    <%-- elemento con i tab a destra --%>
    <div id="elementoConITab" class="iwebTABPADRE width610 r">
        <div class="headerTab"></div>
        <div class="corpoTab">
            <div class="iwebTABFIGLIO Tab_1 selectedTab iwebBIND__dettaglioAnagrafica iwebTABNOMEHEAD_Cantiere">
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
                                <td>Codice</td>
                                <td><span class="iwebCAMPO_cantiere.codice iwebCodice"></span></td>
                            </tr>
                            <tr>
                                <td>Cliente</td>
                                <td><span class="iwebCAMPO_cliente.nominativo iwebDescrizione iwebTroncaCrtsAt_30"></span></td>
                            </tr>
                            <tr>
                                <td>Descrizione</td>
                                <td><span class="iwebCAMPO_cantiere.descrizione iwebDescrizione iwebTroncaCrtsAt_50"></span></td>
                            </tr>
                        </tbody>
                        <tbody></tbody>
                    </table>
                    <span class="iwebSQLSELECT">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                            "SELECT cliente.nominativo as 'cliente.nominativo', cliente.id as 'cliente.id', cantiere.id as 'cantiere.id', cantiere.codice as 'cantiere.codice', cantiere.descrizione as 'cantiere.descrizione' "
                          + "FROM cantiere LEFT JOIN cliente ON cantiere.idcliente = cliente.id WHERE cantiere.id = @id"
                        ) %></span>
                        <span class="iwebPARAMETRO">@id = tabellaCantieri_selectedValue_cantiere.id</span>
                    </span>
                </div>
                <div class="r">
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
                                        <%--<td><input type="text" class="iwebCAMPO_cliente.id iwebTIPOCAMPO_varchar" /></td>--%>
                                        <td>
                                            <div class="iwebCAMPO_cliente.nominativo">
                                                <select id="popupModificaAnagraficaCantiereDDLCliente" class="iwebDDL iwebCAMPO_cliente.id iwebCAMPOOBBLIGATORIO" 
                                                    onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                                    <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                                </select>
                                                <span class="iwebSQLSELECT">
                                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT nominativo as NOME, id as VALORE FROM cliente ORDER BY nominativo") %></span>
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Codice *</td>
                                        <td><input id="Text1" type="text" 
                                                class="iwebCAMPO_cantiere.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                        <td><span id="popupTabellaCantieriModificaSpanCodiceErrato" style="display:none">Il codice esiste già.</span></td>
                                    </tr>
                                    <tr>
                                        <td>Descrizione</td>
                                        <td><input id="Text2" type="text" class="iwebCAMPO_cantiere.descrizione iwebTIPOCAMPO_varchar" /></td>
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
                                <div class="btn btn-success" onclick="elencoCantieri_iwebBindPopupModificaiwebDETTAGLIO('popupModificaAnagraficaCantiere')">Aggiorna</div>
                            </div>
                            <div class="iwebSQLUPDATE">
	                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE cantiere SET idcliente = @idcliente, codice = @codice, descrizione = @descrizione WHERE id = @id") %></span>
	                            <span class="iwebPARAMETRO">@idcliente = popupModificaAnagraficaCantiere_findValue_cliente.id</span>
	                            <span class="iwebPARAMETRO">@codice = popupModificaAnagraficaCantiere_findValue_cantiere.codice</span>
	                            <span class="iwebPARAMETRO">@descrizione = popupModificaAnagraficaCantiere_findValue_cantiere.descrizione</span>
	                            <span class="iwebPARAMETRO">@id = popupModificaAnagraficaCantiere_findValue_cantiere.id</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="b"></div>
            </div><%-- fine tab 1 --%>

            <div class="iwebTABFIGLIO Tab_2 iwebTABNOMEHEAD_Bolle iwebBIND__tabellaBolle">

                <table id="tabellaBolle" class="iwebTABELLA iwebCHIAVE__bollafattura.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="commandHead iwebNascosto">
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
                            <th>Importo Testata</th>
                            <th>Importo Costi sul cantiere</th>
                        </tr>
                        <tr>
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
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
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td>
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaBolleModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');"></div>--%>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');"></div>
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
                                <input type="checkbox" class="iwebCAMPO_bollafattura.chiusa" disabled/>
                            </td>
                            <td>
                                <span class="iwebCAMPO_bollafattura.importo iwebValuta"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_sommaPrezziCantiere iwebValuta"></span>
                            </td>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE, iwebTOTRECORD sono di riferimento al js --%>
                        <%-- eventualmente va messo display:none --%>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><b class="r">Totale</b></td>
                            <td>
                                <span id="Span1" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">bollafattura.importo</span>
                                <%--<span class="iwebSQLSELECT iwebNascosto">
	                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                         "SELECT SUM(bollafattura.importo) as 'bollafattura.importo' "
                                       + "FROM (bollafattura LEFT JOIN fornitore ON bollafattura.idfornitore = fornitore.id) "
                                       + "                   LEFT JOIN costo ON bollafattura.id = costo.idbollafattura "
                                       + "WHERE bollafattura.isddt = true AND costo.idcantiere = 206 "
                                       + "GROUP BY bollafattura.numero" 
                                       
                                    )%></span>
                                </span>--%>
                                <%--<span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL( 
                                        "SELECT sum(risultato.importo) "
+ "FROM "
+ "(SELECT importo FROM `bollafattura` LEFT JOIN costo ON bollafattura.id = costo.idbollafattura WHERE numero like '%10%' AND costo.idcantiere = 184 group by bollafattura.numero) as risultato"
                                    ) %></span>
                                    <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span>
                                </span>--%>
                            </td>
                            <td>
                                <span id="Span2" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">costo.prezzo</span>
                            </td>
                        </tr>
                        <tr><td><div class="iwebTABELLAFooterPaginazione">
                            <div>Pagina</div>
                            <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                            <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                            <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                            <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                            <div class="iwebPAGESIZE"><select id="Select2ASDASDQWERRT34R34" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                            <div class="iwebTOTRECORD">Trovate 0 righe</div>
                        </div></td></tr>
                    </tfoot>
                </table>
                <span class="iwebSQLSELECT">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                         "SELECT bollafattura.id as 'bollafattura.id', "
                       + "       bollafattura.numero as 'bollafattura.numero', "
                       + "       bollafattura.databollafattura as 'bollafattura.databollafattura', "
                       + "       bollafattura.isfattura as 'bollafattura.isfattura', "
                       + "       bollafattura.chiusa as 'bollafattura.chiusa', "
                       + "       bollafattura.importo as 'bollafattura.importo', "
                       + "       fornitore.id as 'fornitore.id', "
                       + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "
                       + "       costo.id as 'costo.id', "
                       + "       SUM(costo.prezzo) as 'sommaPrezziCantiere' "
                       + "FROM (bollafattura LEFT JOIN fornitore ON bollafattura.idfornitore = fornitore.id) "
                       + "                   LEFT JOIN costo ON bollafattura.id = costo.idbollafattura "
                       + "WHERE bollafattura.isddt = true AND costo.idcantiere = @idcantiere "
                       + "GROUP BY bollafattura.numero" 
                       )%></span>
                                           <%--+ "       SUM(prodotto.listino) as 'importoTestata' "--%>

                       <%--+ "   IF (bollafattura.isfattura, COUNT(costo.id), COUNT(righeverificate.id)) as 'numeroRigheVerificate' "--%> 
                    <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span>
                </span>


            </div><%-- fine tab 2 --%>
            <div class="iwebTABFIGLIO Tab_3 iwebTABNOMEHEAD_Fatture iwebBIND__tabellaFatture">

                <table id="tabellaFatture" class="iwebTABELLA iwebCHIAVE__bollafattura.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="commandHead iwebNascosto">
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
                            <th>Importo Testata</th>
                            <th>Importo Costi sul cantiere</th>
                        </tr>
                        <tr>
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
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
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td>
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaBolleModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');"></div>--%>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');"></div>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_bollafattura.id"></span>
                            </td>
                            <td>
                                <input type="checkbox" class="iwebCAMPO_bollafattura.isddt iwebCheckbox" disabled />
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
                                <span class="iwebCAMPO_bollafattura.importo iwebValuta"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_sommaPrezziCantiere iwebValuta"></span>
                            </td>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE, iwebTOTRECORD sono di riferimento al js --%>
                        <%-- eventualmente va messo display:none --%>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><b class="r">Totale</b></td>
                            <td>
                                <span id="Span3" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">bollafattura.importo</span>
                                <%--<span class="iwebSQLSELECT iwebNascosto">
	                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                         "SELECT SUM(bollafattura.importo) as 'bollafattura.importo' "
                                       + "FROM (bollafattura LEFT JOIN fornitore ON bollafattura.idfornitore = fornitore.id) "
                                       + "                   LEFT JOIN costo ON bollafattura.id = costo.idbollafattura "
                                       + "WHERE bollafattura.isddt = true AND costo.idcantiere = 206 "
                                       + "GROUP BY bollafattura.numero" 
                                       
                                    )%></span>
                                </span>--%>
                                <%--<span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL( 
                                        "SELECT sum(risultato.importo) "
+ "FROM "
+ "(SELECT importo FROM `bollafattura` LEFT JOIN costo ON bollafattura.id = costo.idbollafattura WHERE numero like '%10%' AND costo.idcantiere = 184 group by bollafattura.numero) as risultato"
                                    ) %></span>
                                    <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span>
                                </span>--%>
                            </td>
                            <td>
                                <span id="Span4" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">costo.prezzo</span>
                            </td>
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
                <span class="iwebSQLSELECT">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                         "SELECT bollafattura.id as 'bollafattura.id', "
                       + "       bollafattura.numero as 'bollafattura.numero', "
                       + "       bollafattura.databollafattura as 'bollafattura.databollafattura', "
                       + "       bollafattura.isddt as 'bollafattura.isddt', "
                       + "       bollafattura.importo as 'bollafattura.importo', "
                       + "       fornitore.id as 'fornitore.id', "
                       + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "
                       + "       costo.id as 'costo.id', "
                       + "       SUM(costo.prezzo) as 'sommaPrezziCantiere' "
                       + "FROM (bollafattura LEFT JOIN fornitore ON bollafattura.idfornitore = fornitore.id) "
                       + "                   LEFT JOIN costo ON bollafattura.id = costo.idbollafattura "
                       + "WHERE bollafattura.isfattura = true AND costo.idcantiere = @idcantiere "
                       + "GROUP BY bollafattura.numero" 
                       )%></span>
                                           <%--+ "       SUM(prodotto.listino) as 'importoTestata' "--%>

                       <%--+ "   IF (bollafattura.isfattura, COUNT(costo.id), COUNT(righeverificate.id)) as 'numeroRigheVerificate' "--%> 
                    <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span>
                </span>


            </div><%-- fine tab 3 --%>

            <div class="iwebTABFIGLIO Tab_4 iwebTABNOMEHEAD_Costi iwebBIND__tabellaCosti">

                <table id="tabellaCosti" class="iwebTABELLA iwebCHIAVE__bollafattura.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="commandHead iwebNascosto">
                                <%--<input type="button" value="Aggiungi" onclick="apriPopupType2('popupTabellaBolleInserimento');" />--%>
                                <%--<div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                                    onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaBolleInserimento');"></div>--%>
                            </th>
                            <th></th>
                            <th class="iwebNascosto">ID</th>
                            <th>Numero</th>
                            <th>Data</th>
                            <th><div class="l">Fornitore</div>
                                <div>
                                    <span class="iwebFILTROOrdinamento iwebSORT_fornitore.ragionesociale_ASC glyphicon glyphicon-sort-by-alphabet r" 
                                    onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                                </div>
                                <div class="b"></div>
                            </th>
                            <th>Prodotto</th>
                            <th>Qta cons (Bolle)</th>
                            <th>Prezzo cons (Bolle)</th>
                            <th>Qta cons (Fatt)</th>
                            <th>Prezzo cons (Fatt)</th>
                        </tr>
                        <tr>
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
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
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td>
                                <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaBolleModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');"></div>--%>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaBolle');"></div>
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
                                <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione iwebTroncaCrtsAt_30"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.quantita iwebQuantita"></span> 
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costofatturato.quantita iwebQuantita"></span> 
                            </td>
                            <td>
                                <span class="iwebCAMPO_costofatturato.prezzo iwebValuta"></span>
                            </td>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE, iwebTOTRECORD sono di riferimento al js --%>
                        <%-- eventualmente va messo display:none --%>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><b class="r">Totale</b></td>
                            <td></td>
                            <td>
                                <%--<span id="Span6" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">costo.prezzo</span>--%>
                            </td>
                        </tr>
                        <tr><td><div class="iwebTABELLAFooterPaginazione">
                            <div>Pagina</div>
                            <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                            <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                            <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                            <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                            <div class="iwebPAGESIZE"><select id="Select4" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                            <div class="iwebTOTRECORD">Trovate 0 righe</div>
                        </div></td></tr>
                    </tfoot>
                </table>
                <span class="iwebSQLSELECT">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                         "SELECT bollafattura.id as 'bollafattura.id', "
                       + "       bollafattura.numero as 'bollafattura.numero', "
                       + "       bollafattura.databollafattura as 'bollafattura.databollafattura', "
                       + "       bollafattura.importo as 'bollafattura.importo', "

                       + "       fornitore.id as 'fornitore.id', "
                       + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "

                       + "       prodotto.id as 'prodotto.id', "
                       + "       prodotto.descrizione as 'prodotto.descrizione', "

                       + "       costo.id as 'costo.id', "
                       + "       costo.quantita as 'costo.quantita', "
                       + "       costo.prezzo as 'costo.prezzo', "

                       + "       /* faccio l'if per distinguere la fattura accompagnatoria dalla bolla (che ha come prezzo e quantita il proprio prezzo e quantità) */ "
                       + "       costofatturato.id as 'costofatturato.id', "
                       + "       IF (bollafattura.isfattura = true, costo.quantita, costofatturato.quantita) as 'costofatturato.quantita', "
                       + "       IF (bollafattura.isfattura = true, costo.prezzo, costofatturato.prezzo) as 'costofatturato.prezzo' "

                       + "FROM (((costo INNER JOIN bollafattura ON costo.idbollafattura = bollafattura.id) "
                       + "              INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id) "
                       + "              INNER JOIN prodotto ON costo.idprodotto = prodotto.id) "
                       + "              LEFT JOIN costo as costofatturato ON costo.idcostobollariferita = costofatturato.id "
                       + "WHERE bollafattura.isddt = true AND costo.idcantiere = @idcantiere "
                       )%></span>
                                           <%--+ "       SUM(prodotto.listino) as 'importoTestata' "--%>

                       <%--+ "   IF (bollafattura.isfattura, COUNT(costo.id), COUNT(righeverificate.id)) as 'numeroRigheVerificate' "--%> 
                    <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span>
                </span>

            </div><%-- fine tab 4 --%>

            <div class="iwebTABFIGLIO Tab_5 iwebTABNOMEHEAD_Altri_costi iwebBIND__tabellaAltriCosti">

                <table id="tabellaAltriCosti" class="iwebTABELLA iwebCHIAVE__costo.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="commandHead">
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                                    onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaAltriCostiInserimento');"></div>
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th class="iwebNascosto">Fornitore</th>
                            <th>Prodotto</th>
                            <th>Quantita</th>
                            <th>Prezzo</th>
                            <th>Data</th>
                        </tr>
                        <tr>
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
                            <th class="iwebNascosto"></th>
                            <th>
                                <%-- filtro di testo sul campo nominativo --%>
                                <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.descrizione">
                                    <input class="largNumero" type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                                </div>
                            </th>
                            <th></th>
                            <th></th>
                            <th>
                                <%--maggiore uguale di--%>
                                <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_costo.datacosto">
                                    <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                </div>
                                <%--minore di--%>
                                <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_costo.datacosto">
                                    <%--<input type="text" placeholder="A" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>--%>
                                    <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                </div>
                                <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody class="iwebNascosto">
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                            <td>
                                <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaAltriCostiModifica'); iwebTABELLA_SelezionaRigaComeUnica();"></div>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica();"></div>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_costo.id"></span>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_fornitore.id iwebNascosto"></span>
                                <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_prodotto.id iwebNascosto"></span>
                                <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                                <%--( <span class="iwebCAMPO_unitadimisura.codice iwebCodice"></span> ) --%>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.quantita iwebQuantita"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.datacosto iwebData"></span>
                            </td>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE, iwebTOTRECORD sono di riferimento al js --%>
                        <%-- eventualmente va messo display:none --%>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><b class="r">Totale</b></td>
                            <td>
                                <span id="Span5" class="iwebTOTALE iwebValuta"></span>
                                <span class="iwebSQLTOTAL">costo.prezzo</span>
                            </td>
                            <td></td>
                        </tr>
                        <tr><td><div class="iwebTABELLAFooterPaginazione">
                            <div>Pagina</div>
                            <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                            <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                            <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                            <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                            <div class="iwebPAGESIZE"><select id="Select5HHTHWESASDASD" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                            <div class="iwebTOTRECORD">Trovate 0 righe</div>
                        </div></td></tr>
                    </tfoot>
                </table>
                <span class="iwebSQLSELECT">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                         "SELECT costo.id as 'costo.id', "
                       + "       costo.quantita as 'costo.quantita', "
                       + "       costo.prezzo as 'costo.prezzo', "
                       + "       costo.datacosto as 'costo.datacosto', "

                       + "       prodotto.id as 'prodotto.id', "
                       + "       prodotto.codice as 'prodotto.codice', "
                       + "       prodotto.descrizione as 'prodotto.descrizione', "
                       + "       prodotto.listino as 'prodotto.listino', "

                       + "       unitadimisura.codice as 'unitadimisura.codice', "
                       + "       fornitore.id as 'fornitore.id', "
                       + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "

                       + "       categoriaprodotto.codice as 'categoriaprodotto.codice', "
                       + "       categoriaprodotto.descrizione as 'categoriaprodotto.descrizione' "

                       + "FROM costo LEFT JOIN prodotto ON costo.idprodotto = prodotto.id "
                       + "           LEFT JOIN unitadimisura ON prodotto.idunitadimisura = unitadimisura.id "
                       + "           LEFT JOIN fornitore ON prodotto.idfornitore = fornitore.id "
                       + "           LEFT JOIN categoriaprodotto ON prodotto.idcategoria = categoriaprodotto.id "

                       + "WHERE costo.idcantiere = @idcantiere AND idfornitore = @idfornitore "
                    )%></span>
                    <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span>
                    <span class="iwebPARAMETRO">@idfornitore = IDFORNITORECOSTIGENERICI_value</span>
                </span>


                <%-- inserimento --%>
                <div id="popupTabellaAltriCostiInserimento" class="popup popupType2" style="display:none">
                    <div>
                        <div class="popupHeader">
                            <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                            <div class="popupTitolo l">Inserisci nuovo record</div>
                            <div class="b"></div>
                        </div>
                        <div class="popupCorpo">
                            <table>
                                <%--<tr>
                                    <td>Fornitore *</td>
                                    <td>
                                        <div class="iwebCAMPO_fornitore.ragionesociale">
                                            <select id="popupTabellaAltriCostiInserimentoDDLfornitore" class="iwebDDL iwebCAMPO_fornitore.id iwebCAMPOOBBLIGATORIO" 
                                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                            </select>
                                            <span class="iwebSQLSELECT">
                                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT ragionesociale as NOME, id as VALORE FROM fornitore WHERE id = @id") %></span>
                                                <span class="iwebPARAMETRO">@id = IDFORNITORECOSTIGENERICI_value</span>
                                            </span>
                                        </div>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>Prodotto *</td>
                                    <td>
                                        <div class="iwebCAMPO_prodotto.descrizione">
                                            <select id="popupTabellaAltriCostiInserimentoDDLprodotto" class="iwebDDL iwebCAMPO_prodotto.id iwebCAMPOOBBLIGATORIO" 
                                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                            </select>
                                            <span class="iwebSQLSELECT">
                                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT descrizione as NOME, id as VALORE FROM prodotto WHERE idfornitore = @idfornitore GROUP BY descrizione") %></span>
                                                <span class="iwebPARAMETRO">@idfornitore = IDFORNITORECOSTIGENERICI_value</span>
                                            </span>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Quantita *</td>
                                    <td><input type="text" 
                                            class="iwebCAMPO_costo.quantita iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                            onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                </tr>
                                <tr>
                                    <td>Prezzo</td>
                                    <td><input type="text" class="iwebCAMPO_costo.prezzo iwebTIPOCAMPO_varchar" /></td>
                                </tr>
                                <tr>
                                <tr>
                                    <td>Data altro costo</td>
                                    <td>
                                        <input class="iwebCAMPO_costo.datacosto iwebTIPOCAMPO_date" placeholder="gg/mm/aaaa"
                                            type="text" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="popupFooter">
                            <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                            <div class="btn btn-success" onclick="iwebTABELLA_ConfermaAggiungiRecordInPopup('popupTabellaAltriCostiInserimento', 'tabellaAltriCosti', '', true)">Inserisci</div>
                            <span class="iwebSQLINSERT">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("INSERT INTO costo (idbollafattura, idprodotto, idcantiere, idcostobollariferita, quantita, prezzo, sconto1, sconto2, datacosto) VALUES (0, @idprodotto, @idcantiere, 0, @quantita, @prezzo, 0, 0, @datacosto)") %></span>
	                            <span class="iwebPARAMETRO">@idprodotto = popupTabellaAltriCostiInserimento_findvalue_prodotto.id</span>
                                <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span> <%-- ottengo il valore dall'elemento selezionato della tabella cantieri --%>
                                <span class="iwebPARAMETRO">@quantita = popupTabellaAltriCostiInserimento_findvalue_costo.quantita</span>
                                <span class="iwebPARAMETRO">@prezzo = popupTabellaAltriCostiInserimento_findvalue_costo.prezzo</span>
                                <span class="iwebPARAMETRO">@datacosto = popupTabellaAltriCostiInserimento_findvalue_costo.datacosto</span>
                            </span>
                        </div>
                    </div>
                </div>

                <%-- modifica --%>
                <div id="popupTabellaAltriCostiModifica" class="popup popupType2" style="display:none">
                    <div>
                        <div class="popupHeader">
                            <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                            <div class="popupTitolo l">Modifica anagrafica altro costo</div>
                            <div class="b"></div>
                        </div>
                        <div class="popupCorpo">
                            <div class="iwebTABELLA_ContenitoreParametri"></div>
                            <table>
                                <tr class="iwebNascosto">
                                    <td>id</td>
                                    <td><span class="iwebCAMPO_costo.id"></span></td>
                                </tr>
                                <tr>
                                    <td>Prodotto *</td>
                                    <td>
                                        <div class="iwebCAMPO_prodotto.descrizione">
                                            <select id="popupTabellaAltriCostiModificaDDLprodotto" class="iwebDDL iwebCAMPO_prodotto.id iwebCAMPOOBBLIGATORIO" 
                                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)">
                                            </select>
                                            <span class="iwebSQLSELECT">
                                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT descrizione as NOME, id as VALORE FROM prodotto WHERE idfornitore = @idfornitore GROUP BY descrizione") %></span>
                                                <span class="iwebPARAMETRO">@idfornitore = IDFORNITORECOSTIGENERICI_value</span>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Quantita *</td>
                                    <td><input type="text" 
                                            class="iwebCAMPO_costo.quantita iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                                            onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                                </tr>
                                <tr>
                                    <td>Prezzo</td>
                                    <td><input type="text" class="iwebCAMPO_costo.prezzo iwebTIPOCAMPO_varchar" /></td>
                                </tr>
                                <tr>
                                    <td>Data altro costo</td>
                                    <td>
                                        <input class="iwebCAMPO_costo.datacosto iwebTIPOCAMPO_date" placeholder="gg/mm/aaaa"
                                            type="text" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="popupFooter">
                            <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                            <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaAltriCostiModifica', 'tabellaAltriCosti', 'prodotto.id, costo.quantita, costo.prezzo, costo.datacosto', 'costo.id', true);">Aggiorna</div>
                            <span class="iwebSQLUPDATE">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL( 
                                    "UPDATE costo "
                                  + "SET idprodotto = @idprodotto, quantita = @quantita, prezzo = @prezzo, datacosto = @datacosto "
                                  + "WHERE id = @id"
                                ) %></span>
                                <span class="iwebPARAMETRO">@idprodotto = popupTabellaAltriCostiModifica_findValue_prodotto.id</span>
                                <span class="iwebPARAMETRO">@quantita = popupTabellaAltriCostiModifica_findValue_costo.quantita</span>
                                <span class="iwebPARAMETRO">@prezzo = popupTabellaAltriCostiModifica_findValue_costo.prezzo</span>
                                <span class="iwebPARAMETRO">@datacosto = popupTabellaAltriCostiModifica_findValue_costo.datacosto</span>
                                <span class="iwebPARAMETRO">@id = popupTabellaAltriCostiModifica_findValue_costo.id</span>
                            </span>

                        </div>
                    </div>
                </div>

            </div><%-- fine tab 5 --%>

            <div class="iwebTABFIGLIO Tab_6 iwebTABNOMEHEAD_Rapportini iwebBIND__tabellaRapportini">

                <table id="tabellaRapportini" class="iwebTABELLA iwebCHIAVE__costo.id iwebBIND__elementoConITab">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="commandHead">
                                <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                                    onclick="iwebTABELLA_AggiungiRigaInPopup('popupTabellaAltriCostiInserimento');"></div>
                            </th>
                            <th class="iwebNascosto">ID</th>
                            <th class="iwebNascosto">Fornitore</th>
                            <th>Data</th>
                            <th>Quantita ore?</th>
                            <th>descrizione?</th>
                        </tr>
                        <tr>
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th><%-- AZIONI --%>
                            </th>
                            <th class="iwebNascosto"></th>
                            <th class="iwebNascosto"></th>
                            <th>
                                <%--maggiore uguale di--%>
                                <div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_costo.datacosto">
                                    <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                </div>
                                <%--minore di--%>
                                <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_costo.datacosto">
                                    <%--<input type="text" placeholder="A" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>--%>
                                    <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                                </div>
                                <div class="glyphicon glyphicon-filter iwebCliccabile" title="Annulla" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
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
                            <td>
                                <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaAltriCostiModifica'); iwebTABELLA_SelezionaRigaComeUnica();"></div>
                                <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica();"></div>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_costo.id"></span>
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_fornitore.id iwebNascosto"></span>
                                <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.datacosto iwebData"></span>
                                <span class="iwebCAMPO_prodotto.id iwebNascosto"></span>
                                <%--( <span class="iwebCAMPO_unitadimisura.codice iwebCodice"></span> ) --%>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.quantita iwebQuantita"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                            </td>
                        </tr>
                    </tbody>
                    <tbody>
                        <%-- il codice viene generato automaticamente qui --%>
                    </tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE, iwebTOTRECORD sono di riferimento al js --%>
                        <%-- eventualmente va messo display:none --%>
                        <tr>
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
                            <div class="iwebPAGESIZE"><select id="Select6" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                            <div class="iwebTOTRECORD">Trovate 0 righe</div>
                        </div></td></tr>
                    </tfoot>
                </table>
                <span class="iwebSQLSELECT">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                         "SELECT costo.id as 'costo.id', "
                       + "       costo.quantita as 'costo.quantita', "
                       + "       costo.prezzo as 'costo.prezzo', "
                       + "       costo.datacosto as 'costo.datacosto', "

                       + "       prodotto.id as 'prodotto.id', "
                       + "       prodotto.codice as 'prodotto.codice', "
                       + "       prodotto.descrizione as 'prodotto.descrizione', "
                       + "       prodotto.listino as 'prodotto.listino', "

                       + "       unitadimisura.codice as 'unitadimisura.codice', "
                       + "       fornitore.id as 'fornitore.id', "
                       + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "

                       + "       categoriaprodotto.codice as 'categoriaprodotto.codice', "
                       + "       categoriaprodotto.descrizione as 'categoriaprodotto.descrizione' "

                       + "FROM costo LEFT JOIN prodotto ON costo.idprodotto = prodotto.id "
                       + "           LEFT JOIN unitadimisura ON prodotto.idunitadimisura = unitadimisura.id "
                       + "           LEFT JOIN fornitore ON prodotto.idfornitore = fornitore.id "
                       + "           LEFT JOIN categoriaprodotto ON prodotto.idcategoria = categoriaprodotto.id "

                       + "WHERE costo.idcantiere = @idcantiere AND idfornitore = @idfornitore "
                    )%></span>
                    <span class="iwebPARAMETRO">@idcantiere = tabellaCantieri_selectedValue_cantiere.id</span>
                    <span class="iwebPARAMETRO">@idfornitore = IDFORNITORESEGATTOMANODOPERA_value</span>
                </span>

            </div><%-- fine tab 6 --%>

        </div>
    </div>
    <script>
        function pageload() {
            iwebCaricaElemento("tabellaCantieri");
            iwebCaricaElemento("elementoConITab");
        }
    </script>
</asp:Content>

