<%@ Control Language="C#" %>

    <%-- width915 l --%>
    <div class="iwebTABELLAWrapper width610">
        <table id="tabellaMisureCollegate" class="iwebTABELLA iwebCHIAVE__misura.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="iwebNascosto">ID</th>
                    <th>Sottocodice</th>
                    <th>Descrizione</th>
                    <th>Prezzo unitario</th>
                    <th>Totale misura</th>
                    <th>Totale importo</th>
                </tr>
                <tr class="iwebNascosto">
                    <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                    <th class="iwebNascosto"></th>
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
                        <span class="iwebCAMPO_misura.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_misura.sottocodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_misura.descrizione iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_misura.prezzounitario iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_misura.totalemisura iwebValuta"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_misura.totaleimporto iwebValuta"></span>
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
                    <div class="iwebPAGESIZE"><select id="Select1WLYYTRS" onchange="iwebTABELLA_FooterCambiaPageSize()" style="width:120px"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT misura.id as 'misura.id', "
              + "       misura.sottocodice as 'misura.sottocodice', "
              + "       misura.descrizione as 'misura.descrizione', "
              + "       misura.prezzounitario as 'misura.prezzounitario', "
              + "       misura.totalemisura as 'misura.totalemisura', "
              + "       misura.totaleimporto as 'misura.totaleimporto' "
              + "FROM misura "
              + "WHERE misura.idvoce = @idvoce "
              + "ORDER BY misura.posizione"
            ) %></span>
            <span class="iwebPARAMETRO">@idvoce = tabellaVoci_selectedValue_voce.id</span>
        </span>
    </div>
