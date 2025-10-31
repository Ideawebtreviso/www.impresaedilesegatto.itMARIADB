<%@ Control Language="C#" ClassName="_report_cantiere_tabella_cantiere" %>


    <table id="tabellaCantiere" class="iwebTABELLA iwebCHIAVE__cantiere.id">
        <thead>
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                <th class="commandHead iwebNascosto">
                </th>
                <th class="iwebNascosto">ID</th>
                <th>Codice</th>
                <th>Cliente</th>
                <th>Descrizione</th>
            </tr>
            <%-- filtri --%>
            <tr class="iwebNascosto">
                <th class="iwebNascosto">ID</th>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </thead>
        <tbody class="iwebNascosto">
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE iwebNascosto" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                <td class="iwebNascosto">
                    <span class="iwebCAMPO_cantiere.id"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_cliente.nominativo"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_cantiere.descrizione iwebDescrizione"></span>
                </td>
            </tr>
        </tbody>
        <tbody>
            <%-- il codice viene generato automaticamente qui --%>
        </tbody>
        <tfoot class="iwebNascosto">
            <tr class="iwebNascosto"></tr>
            <tr><td><div class="iwebTABELLAFooterPaginazione">
                <div>Pagina</div>
                <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                <div class="iwebPAGESIZE"><select id="Select1ASC328HF" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                <div class="iwebTOTRECORD">Trovate 0 righe</div>
            </div></td></tr>
        </tfoot>
    </table>
    <span class="iwebSQLSELECT">
	    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
            "SELECT cantiere.id as 'cantiere.id', "
          + "       cantiere.codice as 'cantiere.codice', "
          + "       cantiere.descrizione as 'cantiere.descrizione', "
          + "       cliente.nominativo as 'cliente.nominativo' "
          + "FROM cantiere INNER JOIN cliente ON cantiere.idcliente = cliente.id "
          + "WHERE cantiere.id = @idcantiere") %></span>
	    <span class="iwebPARAMETRO">@idcantiere = IDCANTIERE_value</span>
    </span>
