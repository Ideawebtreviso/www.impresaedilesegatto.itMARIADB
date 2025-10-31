<%@ Control Language="C#" %>
    <%-- width915 l --%>
    <div class="iwebTABELLAWrapper">
        <table id="tabellaCostiFattureCollegate" class="iwebTABELLA iwebCHIAVE__costo.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="iwebNascosto">idcosto idcostoriferito</th>

                    <th>Num. fattura</th>
                    <th>Data fattura</th>

                    <th>Qta bolla</th>
                    <th>Prezzo bolla</th>
                    <th>Sc.1 bolla</th>
                    <th>Sc.2 bolla</th>

                    <th>Qta fattura</th>
                    <th>Prezzo fattura</th>
                    <th>Sc.1 fattura</th>
                    <th>Sc.2 fattura</th>
                </tr>
                <tr class="iwebNascosto">
                    <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                    <th class="iwebNascosto"></th>

                    <th></th>
                    <th></th>

                    <th></th>
                    <th></th>
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
                        <span class="iwebCAMPO_costo.id"></span>
                        <span class="iwebCAMPO_costoriferito.id"></span>
                    </td>

                    <td>
                        <span class="iwebCAMPO_fattura.numero"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_fattura.databollafattura iwebData"></span>
                    </td>

                    <td>
                        <span class="iwebCAMPO_quantitabolla iwebQuantita"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_prezzobolla iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_sconto1bolla"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_sconto2bolla"></span>
                    </td>

                    <td>
                        <span class="iwebCAMPO_quantitafattura iwebQuantita"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_prezzofattura iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_sconto1fattura"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_sconto2fattura"></span>
                    </td>
                </tr>
            </tbody>
            <tbody><%-- il codice viene generato automaticamente qui --%></tbody>
            <tfoot><%-- iwebPAGENUMBER, iwebTOTPAGINE, iwebPAGESIZE,iwebTOTRECORD sono di riferimento al js --%>
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
                    <td></td>
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="Select189PYJTHRG" onchange="iwebTABELLA_FooterCambiaPageSize()" style="width:120px"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT costo.id as 'costo.id', "
              + "       costoriferito.id as 'costoriferito.id', "
              
              + "       costo.quantita as 'quantitabolla', "
              + "       costo.prezzo as 'prezzobolla', "
              + "       costo.sconto1 as 'sconto1bolla', "
              + "       costo.sconto2 as 'sconto2bolla', "

              + "       costoriferito.quantita as 'quantitafattura', "
              + "       costoriferito.prezzo as 'prezzofattura', "
              + "       costoriferito.sconto1 as 'sconto1fattura', "
              + "       costoriferito.sconto2 as 'sconto2fattura', "
              
              + "       fattura.numero as 'fattura.numero', "
              + "       fattura.databollafattura as 'fattura.databollafattura', "
              + "       fornitore.ragionesociale as 'fornitore.ragionesociale' "

              + "FROM costo LEFT JOIN costo as costoriferito ON costo.id = costoriferito.idcostobollariferita "
              + "           LEFT JOIN bollafattura as fattura ON costoriferito.idbollafattura = fattura.id "
              + "           LEFT JOIN fornitore ON fattura.idfornitore = fornitore.id"
              + "WHERE costo.idbollafattura = @idbollafattura AND costoriferito.id IS NOT NULL"
            ) %></span>
            <span class="iwebPARAMETRO">@idbollafattura = tabellaBolle_selectedValue_bollafattura.id</span>
        </span>

    </div>
