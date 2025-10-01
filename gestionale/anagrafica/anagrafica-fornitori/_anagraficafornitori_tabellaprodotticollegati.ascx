<%@ Control Language="C#" %>

    <div class="iwebTABELLAWrapper width915 l">
        <table id="tabellaProdottiCollegati" class="iwebTABELLA iwebCHIAVE__prodotto.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="iwebNascosto">ID</th>
                    <th>Ragione sociale</th>
                    <th>Codice prodotto</th>
                    <th>Prodotto</th>
                    <th>Listino</th>
                </tr>
                <tr class="iwebNascosto">
                    <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                    <th class="iwebNascosto"></th>
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
                        <span class="iwebCAMPO_prodotto.id"></span>
                        <span class="iwebCAMPO_fornitore.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fornitore.ragionesociale"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_prodotto.codice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_prodotto.descrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_prodotto.listino"></span>
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
                "SELECT prodotto.id as 'prodotto.id', "
              + "       fornitore.id as 'fornitore.id', "

              + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "
              + "       prodotto.codice as 'prodotto.codice', "
              + "       prodotto.descrizione as 'prodotto.descrizione', "
              + "       prodotto.listino as 'prodotto.listino' "

              + "FROM prodotto LEFT JOIN fornitore ON prodotto.idfornitore = fornitore.id "
              + "WHERE prodotto.idfornitore = @idfornitore"
            ) %></span>
            <span class="iwebPARAMETRO">@idfornitore = tabellaFornitori_selectedValue_fornitore.id</span>
        </span>
    </div>
