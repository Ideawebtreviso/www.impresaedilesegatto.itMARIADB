<%@ Control Language="C#" ClassName="_gestione_computo_tabella_voci" %>

<%@ Register TagPrefix="gestionecomputo" TagName="misurecollegate" Src="_gestionecomputo_tabellavoci_misurecollegate.ascx" %>

    <div class="iwebTABELLAWrapper width800 l">
        <div class="r iwebTABELLAAzioniPerSelezionati">
            <span></span>
            <select id="ddlFiltroGenericoSuddivisioni" class="iwebDDL">
                <option class="iwebAGGIUNTO" value="-1">Seleziona...</option>
            </select>
            <span class="iwebSQLSELECT">
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT id as VALORE, descrizione as NOME FROM suddivisione WHERE idcomputo = @idcomputo") %></span>
	            <span class="iwebPARAMETRO">@idcomputo = IDCOMPUTO_value</span>
            </span>
            <input type="button" class="btn btn-default" value="Rimappa suddivisioni" disabled onclick="gestioneComputo_iwebTABELLA_ConfermaAzionePerSelezionati()"/>
            <div class="b"></div>
        </div>
        <table id="tabellaVoci" class="iwebTABELLA iwebCHIAVE__voce.id iwebBIND__elementoConITab">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="commandHead">
                        <%--<input type="button" value="Aggiungi" onclick="apriPopupType2('popupTabellaClientiInserimento');" />--%>
                        <div id="primoElementoPlusTabellaVoci" class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" tabindex="1"
                            onclick="azzeraCampiInserimentoTabellaVoci();
                                     preCaricaCodiceVoce();
                                     preCaricaPosizioneVoce(null);
                                     apriPopupType2_bind('popupTabellaVociInserimento', true);
                                     document.getElementById('popupTabellaVociInserimento').getElementsByClassName('iwebCAMPO_voce.codice')[0].focus();"
                            onkeypress="if (event.which == 13 || event.keyCode == 13){
                                            azzeraCampiInserimentoTabellaVoci();
                                            preCaricaCodiceVoce();
                                            preCaricaPosizioneVoce(null);
                                            apriPopupType2_bind('popupTabellaVociInserimento', true);
                                            document.getElementById('popupTabellaVociInserimento').getElementsByClassName('iwebCAMPO_voce.codice')[0].focus();
                                        }"
                            ></div>
                    </th>
                    <th>ID</th>
                    <th>Codice</th>
                    <th>Titolo<%--<div class="l">Titolo</div>
                        <div>
                            <span class="iwebFILTROOrdinamento iwebSORT_voce.titolo_ASC glyphicon glyphicon-sort-by-alphabet r" 
                            onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                        </div>
                        <div class="b"></div>--%>
                    </th>
                    <th>Descrizione</th>
                    <th>Suddivisione</th>
                    <th>Totale</th>
                    <th></th><%-- ALTRO --%>
                </tr>
                <tr>
                    <th></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%></th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_voce.id">
                            <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_voce.codice">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_voce.titolo">
                            <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                        </div>
                    </th>
                    <th>
                        <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_voce.descrizione">
                            <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                        </div>
                    </th>
                    <th class="contenitoreSelectMultiple">
                        <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_voce.idsuddivisione">
                            <select id="tabellaVociDDLSuddivisioni" class="iwebDDL" multiple="multiple" 
                                        onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                                <option class="iwebAGGIUNTO" value="-1">tutti</option>
                            </select>
                            <span class="iwebSQLSELECT">
                                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT descrizione as NOME, id as VALORE FROM suddivisione WHERE idcomputo = @idcomputo") %></span>
	                            <span class="iwebPARAMETRO">@idcomputo = IDCOMPUTO_value</span>
                            </span>
                        </div>
                    </th>
                    <th></th>
                    <th></th><%-- ALTRO --%>
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td>
                        <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaVociModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaVoci');"></div>--%>
                        <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaVoci');"></div>

                        <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" 
                            onclick="preCaricaCodiceVoce();
                                     preCaricaPosizioneVoce(this);
                                     apriPopupType2_bind('popupTabellaVociInserimento', true);"></div>

                        <div class="glyphicon glyphicon-share iwebCliccabile" title="Duplica" onclick="
                            iwebTABELLA_SelezionaRigaComeUnica(); 
                            gestioneComputo_duplicaRigaERelativeMisureTabellaVoci(this)
                        "></div>
                        <div id="iwebSQLSELECTduplica" class="iwebNascosto">
                            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                                "SELECT titolo, descrizione, posizione, idsuddivisione " +
                                "FROM voce " +
                                "WHERE id = @idvoce "
                            ) %></span>
	                        <span class="iwebPARAMETRO">@idvoce = tabellaVoci_selectedValue_voce.id</span>
                        </div>

                    </td>
                    <td>
                        <span class="iwebCAMPO_voce.id"></span>
                        <span class="iwebCAMPO_computo.id iwebNascosto"></span>
                        <span class="iwebCAMPO_suddivisione.id iwebNascosto"></span>
                        <span class="iwebCAMPO_voce.posizione iwebNascosto"></span>
                    </td>
                    <td class="tbVociColonnaCodice">
                        <span class="iwebCAMPO_voce.codice iwebCodice"></span>
                    </td>
                    <td class="tbVociColonnatitolo">
                        <span class="iwebCAMPO_voce.titolo iwebTitolo" ></span>
                    </td>
                    <td class="tbVociColonnaDescrizione">
                        <span class="iwebCAMPO_voce.descrizione iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_suddivisione.descrizione iwebDescrizione iwebTroncaCrtsAt_15"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_misura.totaleimporto iwebValuta"></span>
                    </td>
                    <td>
                        <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaVoci');
                                        iwebTABELLA_EliminaRigaInPopup('popupTabellaVociElimina')"></div>
                    </td><%-- ALTRO --%>
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
                    <td></td>
                    <td></td>
                    <td><b class="r">Totale</b></td>
                    <td>
                        <span id="SpanTotaleTotaliMisure" class="iwebTOTALE iwebValuta"></span>
                        <span class="iwebSQLTOTAL">misura.totaleimporto</span>
	                    <span class="iwebPARAMETRO iwebNascosto">@idcomputo = IDCOMPUTO_value</span>
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
        <span class="iwebSQLSELECT">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                SELECT
                    voce.id as 'voce.id',
                    voce.codice as 'voce.codice',
                    voce.titolo as 'voce.titolo',
                    voce.descrizione as 'voce.descrizione',
                    voce.posizione as 'voce.posizione',
                    computo.id as 'computo.id',
                    suddivisione.id as 'suddivisione.id',
                    suddivisione.descrizione as 'suddivisione.descrizione',
                    SUM(misura.totaleimporto) as 'misura.totaleimporto'

                FROM voce
                    INNER JOIN computo ON voce.idcomputo = computo.id
                    LEFT JOIN suddivisione ON voce.idsuddivisione = suddivisione.id
                    LEFT JOIN misura ON misura.idvoce = voce.id
                    LEFT JOIN vocetemplate ON misura.idvocetemplate = vocetemplate.id

                WHERE computo.id = @idcomputo
                GROUP BY voce.id, voce.codice
                ORDER BY suddivisione.posizione, voce.posizione
            ") %></span>
	        <span class="iwebPARAMETRO">@idcomputo = IDCOMPUTO_value</span>
        </span>
        <%-- inserimento --%>
        <div id="popupTabellaVociInserimento" class="popup popupType2 iwebBIND__popupTabellaVociInserimentoDDLSuddivisioni" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Inserisci nuova voce</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <table>
                        <tr class="iwebNascosto">
                            <td>posizione</td>
                            <td>
                                <%-- questo campo viene modificato da js --%>
                                <span class="iwebCAMPO_voce.posizione">99999</span>
                            </td>
                        </tr>
                        <tr>
                            <td>Codice *</td>
                            <td><input type="text" class="iwebCAMPO_voce.codice iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" tabindex="1"
                                onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                        </tr>
                        <tr>
                            <td>Titolo *</td>
                            <td>
                                <div class="iwebAUTOCOMPLETAMENTO iwebCAMPO_voce.titolo" id="iwebAUTOCOMPLETAMENTOTitoloInserimento">
                                    <span class="iwebNascosto">-1</span> <%-- numero rigaSelezionata --%>

                                    <%-- Chiave dell'el selezionato --%>
                                    <span class="iwebNascosto"></span>

                                    <%-- Valore dell'el selezionato --%>
                                    <input type="text" autocomplete="off" class="iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" tabindex="1"
                                        onkeyup="gestioneComputo_iwebAUTOCOMPLETAMENTO_Ricerca(event, this)" 
                                        onkeydown="gestioneComputo_iwebAUTOCOMPLETAMENTO_ScorriRisultati(event, this);" 
                                        onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)"/>
                                    <%-- caso particolare in cui, non usando la chiave, non mi importa il suo valore --%>
                                        <%--onblur="iwebAUTOCOMPLETAMENTO_onblur(event, this)"--%>

                                    <%-- Query di ricerca --%>
                                    <span class="iwebSQLSELECT">
                                        <%-- in questo caso uso la chiave per prendere anche la descrizione --%>
                                        <%-- inoltre, per prendere solo voce.titolo faccio via js uno split su [[[ --%>
                                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                            SELECT voce.descrizione as chiave, CONCAT(voce.titolo, ' [[[', computo.codice, ']]]') as valore 
                                            FROM voce INNER JOIN computo ON voce.idcomputo = computo.id
                                            WHERE voce.titolo like @titolo 
                                            LIMIT 5") %></span>
                                        <%--<span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                                            SELECT voce.descrizione as chiave, voce.titolo as valore 
                                            FROM voce 
                                            WHERE voce.titolo like @titolo 
                                            GROUP BY voce.titolo
                                            LIMIT 5") %></span>--%>
                                        <span class="iwebPARAMETRO">@titolo = like_iwebAUTOCOMPLETAMENTOTitoloInserimento_getValore</span>
                                    </span>
                                    <div class="iwebAUTOCOMPLETAMENTO_risultatiRicerca"><%--RISULTATI RICERCA--%></div>
                                </div>
                            </td>
                            <td>
                                <div class="btn btn-warning" tabindex="1" onclick="popupTabellaVociInserimentoPickingVoceTemplate()">Picking</div>
                            </td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td>
                                <textarea class="iwebCAMPO_voce.descrizione iwebTIPOCAMPO_memo" tabindex="1"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <%--iwebBIND__popupTabellaVociInserimentoDDLSuddivisioni--%>
                            <td>Suddivisione</td>
                            <td>
                                <select id="popupTabellaVociInserimentoDDLSuddivisioni" class="iwebDDL iwebTIPOCAMPO_varchar" tabindex="1">
                                    <option class="iwebAGGIUNTO" value="-1">Seleziona</option>
                                </select>
                                <span class="iwebSQLSELECT">
                                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT descrizione as NOME, id as VALORE FROM suddivisione WHERE idcomputo = @idcomputo") %></span>
	                                <span class="iwebPARAMETRO">@idcomputo = IDCOMPUTO_value</span>
                                </span>
                            </td>
                        </tr>
                        <tr id="popupTabellaVociInserimento_trNuovaSuddivisione">
                            <td>Nuova suddivisione</td>
                            <td><input type="text" class="iwebCAMPO_suddivisione.descrizione iwebTIPOCAMPO_varchar" tabindex="1"/></td>
                        </tr>
                    </table>
                </div>

                <div class="popupFooter">
                    <div class="btn btn-warning" tabindex="1" 
                        onclick="chiudiPopupType2()"
                        onkeypress="if (event.which == 13 || event.keyCode == 13) chiudiPopupType2();" 
                        >Annulla</div>
                    <div class="btn btn-success" tabindex="1" 
                        onclick="gestioneComputo_popupTabellaVociInserimento_confermaInserimento('popupTabellaVociInserimento', 'tabellaVoci', false);"
                        onkeypress="
                             if (event.which == 13 || event.keyCode == 13){
                                 gestioneComputo_popupTabellaVociInserimento_confermaInserimento('popupTabellaVociInserimento', 'tabellaVoci', false);
                                 setTimeout(function(){ document.getElementById('primoElementoPlusTabellaVoci').focus() }, 100);
                             }"
                        >Inserisci</div>
                    <div class="btn btn-success" tabindex="1" 
                        onclick="gestioneComputo_popupTabellaVociInserimento_confermaInserimento('popupTabellaVociInserimento', 'tabellaVoci', true);"
                        onkeypress="
                             if (event.which == 13 || event.keyCode == 13){
                                 gestioneComputo_popupTabellaVociInserimento_confermaInserimento('popupTabellaVociInserimento', 'tabellaVoci', true);
                             }"
                        >Inserisci + Nuova misura</div>
                </div>
            </div>
        </div>
        <script>
            function popupTabellaVociInserimentoPickingVoceTemplate() {

                // parametri di input
                // iwebElaboraCampo("C0001inputAAA", aaa);

                // parametri di output
                C0001PopupASCX_chiudi = function (idvocetemplate, codice, nome) {
                    iwebAUTOCOMPLETAMENTO_SetChiaveSelezionato("iwebAUTOCOMPLETAMENTOTitoloInserimento", idvocetemplate);
                    iwebAUTOCOMPLETAMENTO_SetValoreSelezionato("iwebAUTOCOMPLETAMENTOTitoloInserimento", nome);
                }

                let livelloPopup = getLivelloNuovoPopup("popupTabellaVociInserimento");
                C0001PopupASCX_apri(livelloPopup);
            }
        </script>






        <%-- elimina --%>
        <script>
            function funzionePopupTabellaVociElimina() {
                iwebCaricaElemento("tabellaMisureCollegate", false, function () {
                    var elTabellaMisureCollegate = document.getElementById("tabellaMisureCollegate");
                    var n = elTabellaMisureCollegate.getElementsByTagName('tbody')[1].getElementsByTagName('td').length;

                    if (n == 1) { /* 1 esiste solo in caso di nessun elemento trovato */
                        elTabellaMisureCollegate.style.display = 'none';
                        document.getElementById('messaggioErroreSeTabellaMisureCollegateHaRighe').style.display = 'none';
                    } else {
                        elTabellaMisureCollegate.style.display = 'block';
                        document.getElementById('messaggioErroreSeTabellaMisureCollegateHaRighe').style.display = 'block';
                    }
                });
            }
        </script>
        <div id="popupTabellaVociElimina" class="popup popupType2 iwebfunzione_funzionePopupTabellaVociElimina" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione voce, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">
                    <table>
                        <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                                in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                        <tr class="iwebNascosto">
                            <td></td>
                            <td><span class="iwebCAMPO_suddivisione.id"></span></td>
                        </tr>
                        <tr class="iwebNascosto">
                            <td>id</td>
                            <td><span class="iwebCAMPO_voce.id"></span></td>
                        </tr>
                        <tr>
                            <td>Codice</td>
                            <td><span class="iwebCAMPO_voce.codice"></span></td>
                        </tr>
                        <tr>
                            <td>Titolo</td>
                            <td><span class="iwebCAMPO_voce.titolo"></span></td>
                        </tr>
                        <tr>
                            <td>Descrizione</td>
                            <td><span class="iwebCAMPO_voce.descrizione"></span></td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top">Misure collegate:</td>
                            <td>
                                <gestionecomputo:misurecollegate runat="server" />
                                <div class="b"></div>
                                <div id="messaggioErroreSeTabellaMisureCollegateHaRighe">Attenzione! L'eliminazione di una voce cancella anche tutte le misure collegate.</div>
                            </td>
                        </tr>
                        <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                    <div class="btn btn-danger" onclick="gestioneComputo_iwebTABELLA_ConfermaEliminaRigaInPopup_tabellaVoci('popupTabellaVociElimina', 'tabellaVoci', true);">Elimina</div>
                    <%--<span class="iwebSQLDELETE">
                        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM voce WHERE id = @id") %></span>
	                    <span class="iwebPARAMETRO">@id = popupTabellaVociElimina_findValue_voce.id</span>
                    </span>--%>
                </div>
            </div>
        </div>

    </div>
