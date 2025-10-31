<%@ Control Language="C#" %>

    <%-- width915 l --%>
    <div class="iwebTABELLAWrapper width915">
        <table id="tabellaCostiCollegati" class="iwebTABELLA iwebCHIAVE__costo.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="iwebNascosto">ID</th>
                    <th>N° bolla</th>
                    <th>Fatt. acc.</th>
                    <th>N° fattura</th>

                    <th>Codice cantiere</th>
                    <th>Cantiere</th>

                    <th>quantita</th>
                    <th>prezzo</th>
                    <th>Sc. 1</th>
                    <th>Sc. 2</th>
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
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_costo.id"></span>
                        <span class="iwebCAMPO_prodotto.id"></span>
                        <span class="iwebCAMPO_bollafattura.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_numerobolla"></span>
                    </td>
                    <td>
                        <input type="checkbox" disabled class="iwebCAMPO_bollafattura.isfattura iwebCheckbox" />
                    </td>
                    <td>
                        <span class="iwebCAMPO_numerofattura"></span>
                    </td>

                    <td>
                        <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.descrizione iwebDescrizione"></span>
                    </td>

                    <td>
                        <span class="iwebCAMPO_costo.quantita iwebQuantita"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_costo.sconto1 iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_costo.sconto2 iwebValuta"></span>
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
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="Select1ASDASDSADS" onchange="iwebTABELLA_FooterCambiaPageSize()" style="width:120px"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT costo.id as 'costo.id', "
              + "       prodotto.id as 'prodotto.id', "
              + "       bollafattura.id as 'bollafattura.id', "
              
              + "       cantiere.codice as 'cantiere.codice', "
              + "       cantiere.descrizione as 'cantiere.descrizione', "
              
              + "       costo.quantita as 'costo.quantita', "
              + "       costo.prezzo as 'costo.prezzo', "
              + "       costo.sconto1 as 'costo.sconto1', "
              + "       costo.sconto2 as 'costo.sconto2', "

              + "       IF(bollafattura.isfattura && bollafattura.isddt = false, bolla.numero, bollafattura.numero) as 'numerobolla', "
              + "       IF(bollafattura.isfattura && bollafattura.isddt = false, bollafattura.numero, '') as 'numerofattura', "
              + "       (bollafattura.isfattura && bollafattura.isddt) as 'bollafattura.isfattura' "

              + "FROM costo LEFT JOIN prodotto ON costo.idprodotto = prodotto.id "
              + "           LEFT JOIN cantiere ON costo.idcantiere = cantiere.id "
              + "           LEFT JOIN bollafattura ON costo.idbollafattura = bollafattura.id "
              + "           LEFT JOIN costo as costofatturariferita ON costo.id = costofatturariferita.idcostobollariferita " /* ottengo la riga costo fattura */

              + "           LEFT JOIN costo as rigacostobolla ON costo.idcostobollariferita = rigacostobolla.id " /* mi serve come tabella intermedia per ottenere il numero bolla */
              + "           LEFT JOIN bollafattura as bolla ON rigacostobolla.idbollafattura = bolla.id " /* da qui ottengo il numero bolla */

              + "WHERE costo.idprodotto = @idprodotto AND costofatturariferita.id is NULL"
            ) %></span>
            <span class="iwebPARAMETRO">@idprodotto = tabellaProdotti_selectedValue_prodotto.id</span>
        </span>
    </div>
