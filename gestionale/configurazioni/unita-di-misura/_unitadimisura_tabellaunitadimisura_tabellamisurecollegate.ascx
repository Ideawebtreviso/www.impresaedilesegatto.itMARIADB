<%@ Control Language="C#" %>

    <div class="iwebTABELLAWrapper width915 l">
        <table id="tabellaMisureCollegate" class="iwebTABELLA iwebCHIAVE__misura.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="iwebNascosto">ID</th>
                    <th>Cod. computo</th>
                    <th>Computo</th>
                    <th>Cod. voce</th>
                    <th>Voce</th>
                    <th>Misura</th>
                    <th>Descr. misura</th>
                    <th>Totale misura</th>
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
                </tr>
            </thead>
            <tbody class="iwebNascosto">
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                    <td class="iwebNascosto">
                        <span class="iwebCAMPO_voce.id"></span>
                        <span class="iwebCAMPO_misura.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_computo.codice iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_computo.titolo iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_voce.codice iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_voce.titolo iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_misura.sottocodice iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_misura.descrizione iwebDescrizione"></span>
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
                    <td class="iwebNascosto"></td>
                    <td class="iwebNascosto"></td>
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
                    <div class="iwebPAGESIZE"><select id="Select16RKXCDF" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT misura.id as 'misura.id', "
              + "       voce.id as 'voce.id', "
              + "       computo.id as 'computo.id', "
              
              + "       computo.codice as 'computo.codice', "
              + "       computo.titolo as 'computo.titolo', "
              + "       voce.codice as 'voce.codice', "
              + "       voce.titolo as 'voce.titolo', "
              + "       misura.sottocodice as 'misura.sottocodice', "
              + "       misura.descrizione as 'misura.descrizione', "
              + "       misura.totaleimporto as 'misura.totaleimporto' "
              
              + "FROM misura LEFT JOIN voce ON misura.idvoce = voce.id "
              + "            LEFT JOIN computo ON voce.idcomputo = computo.id "
              
              + "WHERE misura.idunitamisura = @idunitadimisura "
              + "ORDER BY computo.id, voce.posizione, misura.posizione"
            ) %></span>
            <span class="iwebPARAMETRO">@idunitadimisura = tabellaUnitadimisura_selectedValue_unitadimisura.id</span>
        </span>
    </div>
