<%@ Control Language="C#" %>

    <%-- width915 l --%>
    <div class="iwebTABELLAWrapper width610">
        <table id="tabellaCantieriCollegati" class="iwebTABELLA iwebCHIAVE__fornitore.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="iwebNascosto">ID</th>
                    <th>Cliente</th>
                    <th>Cod. cantiere</th>
                    <th>Cantiere</th>
                    <th>Stato cantiere</th>
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
                        <span class="iwebCAMPO_cantiere.id"></span>
                        <span class="iwebCAMPO_cliente.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cliente.nominativo"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.codice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.descrizione iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_cantiere.stato"></span>
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
                    <div class="iwebPAGESIZE"><select id="Select1" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT cantiere.id as 'cantiere.id', "
              + "       cliente.id as 'cliente.id', "
              
              + "       cliente.nominativo as 'cliente.nominativo', "
              + "       cantiere.codice as 'cantiere.codice', "
              + "       cantiere.descrizione as 'cantiere.descrizione', "
              + "       cantiere.stato as 'cantiere.stato' "

              + "FROM cantiere LEFT JOIN cliente ON cantiere.idcliente = cliente.id "
              + "WHERE cantiere.idcliente = @idcliente"
            ) %></span>
            <span class="iwebPARAMETRO">@idcliente = tabellaClienti_selectedValue_cliente.id</span>
        </span>
    </div>
