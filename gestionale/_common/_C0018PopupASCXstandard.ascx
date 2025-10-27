<%@ Control Language="C#" %>
<%--<script runat="server">
    Boolean isagente;
    protected void Page_Load(object sender, EventArgs e) { isagente = Utility.isagente(((FormsIdentity)Context.User.Identity).Ticket); }
    protected void NascondiSeAgente(object sender, EventArgs e) { ((HtmlControl)sender).Visible = !isagente; }
</script>--%>

<%-- INPUT --%>
<span class="iwebNascosto" id="C0018datiDaImportare">
    <span id="C0018ImportaidRigaDocumento"></span>
</span>
<%-- OUTPUT --%>
<span class="iwebNascosto" id="C0018datiDaEsportare">
    <span id="C0018EsportaSerieDocumento"></span>
    <span id="C0018EsportaNumeroDocumento"></span>
</span>

<script>
    function C0018PopupASCX_apri(livelloPopup) {
        // in base al livello del popup viene modificato lo stile specifico
        let elPopup = document.getElementById("C0018PopupASCX");
        setLivelloNuovoPopup(elPopup, livelloPopup);

        // codice qui..

        iwebMostraCaricamentoAjax();
        iwebCaricaElemento("C0018TabellaInformazioniRigaCorrente", false, function () {

            // e codice qui..

            // apro il popup
            apriPopupType2("C0018PopupASCX");

            iwebNascondiCaricamentoAjax();
        });
    }
</script>
<div id="C0018PopupASCX" class="popup popupType2" style="display:none">
    <div>
        <div class="popupHeader">
            <div class="glyphicon glyphicon-remove iwebCliccabile r xDelPopup" onclick="chiudiPopupType2(this)"></div>
            <div class="popupTitolo l">Dettaglio</div>
            <div class="b"></div>
        </div>
        <div class="popupCorpo">

            <div>
                <div class="testoConPaddingBottom">Riepilogo riga selezionata</div>

                <table id="C0018TabellaInformazioniRigaCorrente" class="iwebTABELLA iwebCHIAVE__documentoriga.id">
                    <thead>
                        <tr>
                            <%-- il primo è il checkbox di selezione --%>
                            <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                            <th class="commandHead iwebNascosto"></th>
                            <th class="iwebNascosto">ID</th>
                            <th>Serie / Numero") %></th>
                            <th>Tipo doc.") %></th>
                            <th>Data") %></th>
                            <th>Nome") %></th>
                            <th>Descrizione") %></th>
                            <th>Prezzo") %></th>
                        </tr>
                        <tr class="iwebNascosto">
                            <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                            <th class="iwebNascosto"><%-- AZIONI --%></th>
                            <th class="iwebNascosto"></th>
                            <th></th>
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
                            <td class="iwebNascosto">
                            </td>
                            <td class="iwebNascosto">
                                <span class="iwebCAMPO_documentoriga.id"></span>
                                <span class="iwebCAMPO_documentotestata.id"></span>
                            </td>
                            <td>
                                <div class="colonnaInDueParti">
                                    <div class="colonnaInDueParti_destra">
                                        <span class="iwebCAMPO_documentotestata.serie iwebCodice"></span>
                                    </div>
                                    <div class="colonnaInDueParti_sinistra">
                                        <span class="iwebCAMPO_documentotestata.numerodocumento iwebCodice"></span>
                                    </div>
                                    <div class="colonnaInDueParti_clearboth"></div>
                                </div>
                            </td>
                            <td>
                                <span class="iwebCAMPO_tipodocumento.nome"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_documentotestata.datadocumento iwebData"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_documentoriga.nome iwebTroncaCrtsAt_30"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_documentoriga.descrizione iwebTroncaCrtsAt_30"></span>
                            </td>
                            <td>
                                <span class="iwebCAMPO_documentoriga.quantita iwebQuantita"></span>
                            </td>
                        </tr>
                    </tbody>
                    <tbody><%-- il codice viene generato automaticamente qui --%></tbody>
                    <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE e iwebTOTRECORD sono di riferimento al js --%>
                        <tr class="iwebTABELLAFooterTotali iwebNascosto">
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                          <tr class="iwebTABELLAFooterNavigazione">
                              <td colspan="99">
                                  <div class="iwebTABELLAFootNav stickyFooterLeft2024">
                                      <!-- <div>  qui esportazione csv e future funzioni  </div> -->
                                      <div class="iwebTABELLAFootNav_limite">
                                          <select class="iwebTABELLA_FooterQtaPerPag" onchange="iwebTABELLA_FooterCambiaLimit(this)"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select><span>righe</span><span>|</span>
                                      </div>
                                      <div class="iwebTABELLAFootNav_offset iwebTABELLAFooterDivNascosto">
                                          <span>Pagina</span>
                                          <span class="material-icons-outlined" onclick="iwebTABELLA_FooterPagPrec(this)">navigate_before</span>
                                          <span><input type="text" class="iwebTABELLA_FooterPagNumero" onchange="iwebTABELLA_FooterPagCambia(this)" /></span>
                                          <span class="material-icons-outlined" onclick="iwebTABELLA_FooterPagSucc(this)">navigate_next</span>
                                          <span>di</span><span class="iwebTABELLA_FooterPagQuante"></span>
                                          <span>|</span><span class="iwebTABELLA_FooterRecordTot"></span><span>record</span>
                                      </div>
                                      <div class="iwebTABELLAFootNav_totale iwebTABELLAFooterDivNascosto"><span class="iwebTABELLA_FooterTotRecord"></span></div>
                                      <div class="iwebTABELLAFootNav_mostra"><div class="btn" onclick="iwebTABELLAFootNavPulsanteMostra(this)">Mostra totali</div><input type="checkbox" class="iwebTABELLAFooterMostraNascondiTotali" style="display:none" /></div>
                                      <%--<div class="iwebTABELLAFootNav_altro"><div style="margin-left:auto"></div></div>--%>
                                      <%--<script>iwebTABELLAFootNavMostra("C0018TabellaInformazioniRigaCorrente")</script>--%>
                                  </div>
                              </td>
                          </tr>
                    </tfoot>
                </table>
                <span class="iwebSQLSELECT">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
SELECT documentoriga.id as 'documentoriga.id', 

    documentotestata.numerodocumento as 'documentotestata.numerodocumento', 
    documentotestata.serie as 'documentotestata.serie', 
    documentotestata.datadocumento as 'documentotestata.datadocumento', 

    documentoriga.nome as 'documentotestata.nome', 
    documentoriga.descrizione as 'documentotestata.descrizione', 
    documentoriga.quantita as 'documentotestata.quantita', 

    tradtipodocumento.traduzione as 'tipodocumento.nome'

FROM documentoriga INNER JOIN documentotestata ON documentoriga.idtestata = documentotestata.id 

                INNER JOIN tipodocumento ON documentotestata.idtipodocumento = tipodocumento.id 
                " + (Traduzione.getIdLingua() == 1 ? @"
                        INNER JOIN traduzione as tradtipodocumento ON tipodocumento.nome = tradtipodocumento.chiave AND tradtipodocumento.tipo = 1
                    " : @"
                        INNER JOIN traduzione as traddefaulttipodocumento ON tipodocumento.nome = traddefaulttipodocumento.chiave AND traddefaulttipodocumento.tipo = 1
                        INNER JOIN traduzionelingua as tradtipodocumento ON traddefaulttipodocumento.id = tradtipodocumento.idtraduzione AND tradtipodocumento.idlingua = " + Traduzione.getIdLingua() + @"
                ") + @"

WHERE documentoriga.id = @C0018ImportaidRigaDocumento
                    ")%></span>
	                <span class="iwebPARAMETRO">@C0018ImportaidRigaDocumento = C0018ImportaidRigaDocumento_value</span>
                </span>
            </div>

        </div>

        <div class="popupFooter">
            <div class="btn btn-warning nonAbilitatoInSolaLettura" onclick="chiudiPopupType2(this)" ><%= Traduzione.traduci("Annulla") %></div>
            <div class="btn btn-success" onclick="C0018PulsanteChiudiPopup(this)">Porta serie e numero in pagina</div>
        </div>
    </div>
</div>

<script>
    function C0018PulsanteChiudiPopup(el) {
        // preparo i parametri da esportare
        let seriedocumento = iwebValutaParametroAjax("C0018TabellaInformazioniRigaCorrente_findFirstValue_documentotestata.seriedocumento");
        let numerodocumento = iwebValutaParametroAjax("C0018TabellaInformazioniRigaCorrente_findFirstValue_documentotestata.numerodocumento");

        iwebElaboraCampo("C0018EsportaSerieDocumento", seriedocumento);
        iwebElaboraCampo("C0018EsportaNumeroDocumento", numerodocumento);

        C0018PopupASCX_chiudi();

        let elPopupGenitore = cercaPopupPadreRicors(el);
        chiudiPopupType2B(elPopupGenitore);
    }
</script>
