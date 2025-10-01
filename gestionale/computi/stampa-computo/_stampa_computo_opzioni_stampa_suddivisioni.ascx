<%@ Control Language="C#" ClassName="_stampa_computo_opzioni_stampa_suddivisioni" %>


    <div class="iwebTABELLAWrapper width400">
        <table id="tabellaSuddivisioni" class="iwebTABELLA iwebCHIAVE__id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="iwebNascosto">ID</th>
                    <th>Suddivisione</th>
                    <th>Stampa</th>
                    <%--<th></th> --%>
                </tr>
                <tr class="iwebNascosto">
                    <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%></th>
                    <th></th>
                    <th></th>
                    <%--<th></th> --%>
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_descrizione iwebDescrizione"></span>
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_truefalse iwebCheckbox" />
                    </td>
                </tr>
            </tbody>
            <tbody>
                <%-- il codice viene generato automaticamente qui --%>
            </tbody>
            <tfoot class="iwebNascosto"><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
                <tr>
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
                    <div class="iwebPAGESIZE"><select id="SelectTabellaStampe1" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000" selected>Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
            <%-- COMPUTOPDF.ID IS NULL   OR   SUDDIVISIONEPDF.ID IS NOT NULL   as truefalse
                ha questo senso:
                Al pageload prima carico la tabella delle stampe precedenti.
                Quando è caricata posso ottenere l'id dell'ultima stampa effettuata.
                SE NON HO effettuato ancora alcuna stampa: COMPUTOPDF.ID IS NULL vale true, mettendo quindi tutti i flag spuntati.
                SE HO già effettuato almeno una stampa, @idcomputopdf = tabellaStampe_findfirstvalue_id andrà a prendere i dati dell'ultima generata.
                    Avendo in mano l'ultima, vado a mettere a true i flag che hanno: SUDDIVISIONEPDF.ID IS NOT NULL (gli altri andranno a false) --%>
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                SELECT suddivisione.id as 'id', 
                       suddivisione.descrizione as 'descrizione', 
                       computopdf.id is null OR suddivisionepdf.id is not null as truefalse 

                FROM suddivisione LEFT JOIN computopdf ON computopdf.id = @idcomputopdf
                                  LEFT JOIN suddivisionepdf ON computopdf.id = suddivisionepdf.idcomputopdf AND suddivisione.id = suddivisionepdf.idsuddivisione

                WHERE suddivisione.idcomputo = @idcomputo AND 
                      suddivisione.idpadre is null 

                ORDER BY suddivisione.posizione
            ") %></span>
	        <span class="iwebPARAMETRO">@idcomputo = IDCOMPUTO_value!!!</span>
            <span class="iwebPARAMETRO">@idcomputopdf = tabellaStampe_findfirstvalue_id!!!</span>
        </span>
    </div>
