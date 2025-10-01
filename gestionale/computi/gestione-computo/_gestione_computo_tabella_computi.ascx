<%@ Control Language="C#" ClassName="_gestione_computo_tabella_computi" %>

    <div class="TitoloPagina">
        Gestione computo
    </div>
    <div class="iwebTABELLAWrapper width1560 l">
        <table id="tabellaComputi" class="iwebTABELLA iwebCHIAVE__computo.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="iwebNascosto">ID</th>
                    <th>Cliente</th>
                    <th>Codice computo</th>
                    <th>Titolo</th>
                    <th>Descrizione</th>
                    <th>Stato</th>
                    <th>Tipo</th>
                    <th>Data consegna</th>
                    <th>Computi associati</th>
                    <%--<th></th> --%>
                </tr>
                <tr class="iwebNascosto">
                    <th class="iwebNascosto"></th><%-- CHECKBOX --%>
                    <th><%-- AZIONI --%></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
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
                        <span class="iwebCAMPO_computo.id"></span>
                        <span class="iwebCAMPO_cliente.id"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_nominativo"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_codice iwebCodice"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_titolo iwebTitolo"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_descrizione iwebDescrizione"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_stato"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_tipo"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_datadiconsegna iwebData"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_condizioniprimapagina"></span>
                        <span class="iwebCAMPO_condizioniultimapagina"></span>
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
                    <div class="iwebPAGESIZE"><select id="Select1" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
                "SELECT cliente.id as 'cliente.id', " +
                "       cliente.nominativo, " +
                "       computo.id as 'computo.id', " +
                "       computo.codice, " +
                "       computo.titolo, " +
                "       computo.descrizione, " +
                "       computo.stato, " +
                "       computo.tipo, " +
                "       computo.datadiconsegna, " +
                "       computo.condizioniprimapagina, " +
                "       computo.condizioniultimapagina " +
                "FROM computo INNER JOIN cliente ON cliente.id = computo.idcliente " +
                "WHERE computo.id = @idcomputo"
            ) %></span>
	        <span class="iwebPARAMETRO">@idcomputo = IDCOMPUTO_value</span>
        </span>
    </div><%-- fine tabella in alto --%>
