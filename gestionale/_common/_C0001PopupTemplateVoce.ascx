<%@ Control Language="C#" %>
<%--<script runat="server">
    Boolean isagente;
    protected void Page_Load(object sender, EventArgs e) { isagente = Utility.isagente(((FormsIdentity)Context.User.Identity).Ticket); }
    protected void NascondiSeAgente(object sender, EventArgs e) { ((HtmlControl)sender).Visible = !isagente; }
</script>--%>

<%-- INPUT --%>
<span class="iwebNascosto">
    <span id="C0001ImportaAAAAAAAAA"></span>
</span>
<%-- OUTPUT --%>
<span class="iwebNascosto">
    <span id="C0001EsportaIdvocetemplate"></span>
    <span id="C0001EsportaCodice"></span>
    <span id="C0001EsportaNome"></span>
</span>

<script>
    function C0001PopupASCX_apri(livelloPopup) {
        // in base al livello del popup viene modificato lo stile specifico
        let elPopup = document.getElementById("C0001popupPickingVoceTemplate");
        setLivelloNuovoPopup(elPopup, livelloPopup);

        // codice qui..
        iwebMostraCaricamentoAjax();
        iwebCaricaElemento("C0001tabellaVoceTemplate", false, function () {
            apriPopupType2("C0001popupPickingVoceTemplate");
            iwebNascondiCaricamentoAjax();
        });
    }
</script>


        <%-- C0001popupPickingVoceTemplate --%>
        <div id="C0001popupPickingVoceTemplate" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Template voci</div>
                    <div class="b"></div>
                </div>
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <div class="popupCorpo">

                    <table id="C0001tabellaVoceTemplate" class="iwebTABELLA iwebCHIAVE__vocetemplate.id">
                        <thead>
                            <tr>
                                <%-- il primo è il checkbox di selezione --%>
                                <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                                <th class="iwebNascosto">ID</th>
                                <th>
                                    <div class="glyphicon glyphicon-plus iwebCliccabile" title="Aggiungi" tabindex="1"
                                        onclick="
                                        let livelloPopup = getLivelloNuovoPopup('C0001popupPickingVoceTemplate');
                                        setLivelloNuovoPopup('C0001popupInserimentoVoceTemplate', livelloPopup);
                                        apriPopupType2('C0001popupInserimentoVoceTemplate');
                                        "></div>
                                </th>
                                <th>Codice</th>
                                <th>Testo</th>
                                <th></th>
                            </tr>
                            <tr class="iwebNascosto">
                                <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                                <th class="iwebNascosto"></th>
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
                                    <span class="iwebCAMPO_vocetemplate.id"></span>
                                </td>
                                <td>
                                    <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona"
                                        onclick="iwebTABELLA_SelezionaRigaComeUnica(this); C0001popupPickingVoceTemplate_conferma()"></div>

                                    <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica"
                                        onclick="
                                            iwebTABELLA_SelezionaRigaComeUnica(this);
                                            let livelloPopup = getLivelloNuovoPopup('C0001popupPickingVoceTemplate');
                                            setLivelloNuovoPopup('C0001popupModificaVoceTemplate', livelloPopup);
                                            iwebTABELLA_ModificaRigaInPopup('C0001popupModificaVoceTemplate');
                                        "></div>

                                </td>
                                <td>
                                    <span class="iwebCAMPO_vocetemplate.codice iwebCodice"></span>
                                </td>
                                <td>
                                    <span class="iwebCAMPO_vocetemplate.nome iwebCodice"></span>
                                </td>
                                <td>
                                    <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                                        onclick="
                                            iwebTABELLA_SelezionaRigaComeUnica(this);
                                            let livelloPopup = getLivelloNuovoPopup('C0001popupPickingVoceTemplate');
                                            setLivelloNuovoPopup('C0001popupEliminaVoceTemplate', livelloPopup);
                                            iwebTABELLA_EliminaRigaInPopup('C0001popupEliminaVoceTemplate');
                                        "></div>
                                </td>
                            </tr>
                        </tbody>
                        <tbody><%-- il codice viene generato automaticamente qui --%></tbody>
                        <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                            <%-- eventualmente va messo display:none --%>
                            <tr class="iwebNascosto">
                                <td class="iwebNascosto"></td>
                                <td class="iwebNascosto"></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr><td><div class="iwebTABELLAFooterPaginazione">
                                <div>Pagina</div>
                                <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                                <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                                <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                                <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                                <div class="iwebPAGESIZE"><select id="C0001Select1" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                                <div class="iwebTOTRECORD">Trovate 0 righe</div>
                            </div></td></tr>
                        </tfoot>
                    </table>
                    <span class="iwebSQLSELECT">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                            SELECT
                                vocetemplate.id as 'vocetemplate.id',
                                vocetemplate.codice as 'vocetemplate.codice',
                                vocetemplate.nome as 'vocetemplate.nome'
                            FROM vocetemplate
                        ") %></span>
                        <%--WHERE vocetemplate.id = @idvocetemplate
                            <span class="iwebPARAMETRO">@idvocetemplate = tabellaUnitadimisura_selectedValue_vocetemplate.id</span>--%>
                    </span>

                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2(this)" >Annulla</div>
                </div>
            </div>
        </div>


        <%-- C0001popupInserimentoVoceTemplate -> INSERIMENTO --%>
        <div id="C0001popupInserimentoVoceTemplate" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Inserimento template voce</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <table>
                        <tr>
                            <td>Codice</td>
                            <td><input type="text" class="iwebCAMPO_vocetemplate.codice iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Testo</td>
                            <td><textarea class="iwebCAMPO_vocetemplate.nome iwebTIPOCAMPO_memo"></textarea></td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2(this)" >Annulla</div>
                    <div class="btn btn-success" onclick="C0001popupInserimentoVoceTemplate_salva();">Inserisci</div>
                </div>
            </div>
        </div>
        <script>
            function C0001popupInserimentoVoceTemplate_salva() {

                let codice = iwebValutaParametroAjax("C0001popupInserimentoVoceTemplate_findValue_vocetemplate.codice");
                let nome = iwebValutaParametroAjax("C0001popupInserimentoVoceTemplate_findValue_vocetemplate.nome");

                if (codice == "" && nome == "") { alert("Compilare almeno un campo"); return; }

                let parametri = {
                    codice: codice,
                    nome: nome
                };
                iwebMostraCaricamentoAjax();
                ajax2024("/WebServiceComputi.asmx/C0001popupInserimentoVoceTemplate_salva", parametri, function () {

                    iwebCaricaElemento("C0001tabellaVoceTemplate");
                    chiudiPopupType2B("C0001popupInserimentoVoceTemplate");

                    iwebNascondiCaricamentoAjax();
                });
            }
        </script>



        <%-- C0001popupModificaVoceTemplate -> MODIFICA --%>
        <div id="C0001popupModificaVoceTemplate" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Modifica template voce</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <table>
                        <tr style="display:none">
                            <td>id</td>
                            <td>
                                <span class="iwebTABELLA_ContenitoreParametri"></span>
                                <span class="iwebCAMPO_vocetemplate.id"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Codice</td>
                            <td><input type="text" class="iwebCAMPO_vocetemplate.codice iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Testo</td>
                            <td><textarea class="iwebCAMPO_vocetemplate.nome iwebTIPOCAMPO_memo"></textarea></td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2(this)" >Annulla</div>
                    <div class="btn btn-success" onclick="C0001popupModificaVoceTemplate_salva();">Salva</div>
                </div>
            </div>
        </div>
        <script>
            function C0001popupModificaVoceTemplate_salva() {

                let idvocetemplate = iwebValutaParametroAjax("C0001popupModificaVoceTemplate_findValue_vocetemplate.id", null, "int?");
                let codice = iwebValutaParametroAjax("C0001popupModificaVoceTemplate_findValue_vocetemplate.codice");
                let nome = iwebValutaParametroAjax("C0001popupModificaVoceTemplate_findValue_vocetemplate.nome");

                if (codice == "" && nome == "") { alert("Compilare almeno un campo"); return; }

                let parametri = {
                    idvocetemplate: idvocetemplate,
                    codice: codice,
                    nome: nome
                };
                iwebMostraCaricamentoAjax();
                ajax2024("/WebServiceComputi.asmx/C0001popupModificaVoceTemplate_salva", parametri, function () {

                    iwebCaricaElemento("C0001tabellaVoceTemplate");
                    chiudiPopupType2B("C0001popupModificaVoceTemplate");

                    iwebNascondiCaricamentoAjax();
                });
            }
        </script>




        <%-- C0001popupEliminaVoceTemplate -> ELIMINA --%>
        <div id="C0001popupEliminaVoceTemplate" class="popup popupType2" style="display:none">
            <div>
                <div class="popupHeader">
                    <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                    <div class="popupTitolo l">Eliminazione template voce, ricontrolla i dati</div>
                    <div class="b"></div>
                </div>
                <div class="popupCorpo">
                    <table>
                        <tr style="display:none">
                            <td>id</td>
                            <td>
                                <span class="iwebTABELLA_ContenitoreParametri"></span>
                                <span class="iwebCAMPO_vocetemplate.id"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Codice</td>
                            <td><input type="text" class="iwebCAMPO_vocetemplate.codice iwebTIPOCAMPO_varchar" /></td>
                        </tr>
                        <tr>
                            <td>Testo</td>
                            <td><textarea class="iwebCAMPO_vocetemplate.nome iwebTIPOCAMPO_memo"></textarea></td>
                        </tr>
                    </table>
                </div>
                <div class="popupFooter">
                    <div class="btn btn-warning" onclick="chiudiPopupType2(this)" >Annulla</div>
                    <div class="btn btn-danger" onclick="C0001popupEliminaVoceTemplate_conferma();">Elimina</div>
                </div>
            </div>
        </div>
        <script>
            function C0001popupEliminaVoceTemplate_conferma() {

                let idvocetemplate = iwebValutaParametroAjax("C0001popupEliminaVoceTemplate_findValue_vocetemplate.id", null, "int?");

                let parametri = {
                    idvocetemplate: idvocetemplate
                };
                iwebMostraCaricamentoAjax();
                ajax2024("/WebServiceComputi.asmx/C0001popupEliminaVoceTemplate_conferma", parametri, function () {

                    iwebCaricaElemento("C0001tabellaVoceTemplate");
                    chiudiPopupType2B("C0001popupEliminaVoceTemplate");

                    iwebNascondiCaricamentoAjax();
                });
            }
        </script>



<script>
    function C0001popupPickingVoceTemplate_conferma() {
        // preparo i parametri da esportare
        let idvocetemplate = iwebValutaParametroAjax("C0001tabellaVoceTemplate_selectedValue_vocetemplate.id", null, "int?");
        let codice = iwebValutaParametroAjax("C0001tabellaVoceTemplate_selectedValue_vocetemplate.codice");
        let nome = iwebValutaParametroAjax("C0001tabellaVoceTemplate_selectedValue_vocetemplate.nome");

        // esporto i parametri che potrebbero servirmi più tardi
        iwebElaboraCampo("C0001EsportaIdvocetemplate", idvocetemplate);
        iwebElaboraCampo("C0001EsportaCodice", codice);
        iwebElaboraCampo("C0001EsportaNome", nome);

        C0001PopupASCX_chiudi(idvocetemplate, codice, nome); // restituisco il risultato chiamando la funzione preparata
        chiudiPopupType2B("C0001popupPickingVoceTemplate"); // Questo controllo è un popup. Lo chiudo.
    }
</script>
