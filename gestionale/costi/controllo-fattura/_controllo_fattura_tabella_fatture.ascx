<%@ Control Language="C#" ClassName="_controllo_fattura_tabella_fatture" %>

    <table id="tabellaFatture" class="iwebTABELLA iwebCHIAVE__bollafattura.id">
        <thead>
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                <th class="commandHead iwebNascosto">
                </th>
                <th class="iwebNascosto">ID</th>
                <th>Numero</th>
                <th>Data</th>
                <th>Fornitore</th>
                <th>Importo</th>
                <th>Tipo</th>
            </tr>
            <%-- filtri --%>
            <tr class="iwebNascosto">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </thead>
        <tbody class="iwebNascosto">
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE iwebNascosto" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                <td>
                    <span class="iwebCAMPO_bollafattura.numero"></span>
                    <span class="iwebCAMPO_bollafattura.id iwebNascosto"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_bollafattura.databollafattura iwebData"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione iwebTroncaCrtsAt_30"></span>
                    <span class="iwebCAMPO_fornitore.id iwebNascosto"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_bollafattura.importo iwebValuta"></span>
                </td>
                <td>
                    <span>Fattura</span>
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
                <div class="iwebPAGESIZE"><select id="Select1" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                <div class="iwebTOTRECORD">Trovate 0 righe</div>
            </div></td></tr>
        </tfoot>
    </table>
    <span class="iwebSQLSELECT">
	    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
            "SELECT bollafattura.id as 'bollafattura.id', "
          + "       bollafattura.numero as 'bollafattura.numero', "
          + "       bollafattura.databollafattura as 'bollafattura.databollafattura', "
          + "       fornitore.ragionesociale as 'fornitore.ragionesociale', "
          + "       fornitore.id as 'fornitore.id', "
          + "       bollafattura.importo as 'bollafattura.importo' "
          + "FROM bollafattura INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id "
          + "WHERE bollafattura.id = @idfattura") %></span>
	    <span class="iwebPARAMETRO">@idfattura = IDFATTURA_value</span>
    </span>
