<%@ Control Language="C#" ClassName="_stampa_computo_stampe_precedenti" %>

    <div class="iwebTABELLAWrapper width1560">
        <table id="tabellaStampe" class="iwebTABELLA iwebCHIAVE__computopdf.id">
            <thead>
                <tr>
                    <%-- il primo è il checkbox di selezione --%>
                    <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                    <th class="iwebNascosto">ID</th>
                    <th>Data nel pdf</th>
                    <th>Stampa intestazione</th>
                    <th>Stampa prezzi</th>
                    <th>Stampa copertina</th>
                    <th>Stampa riepilogo</th>
                    <th>Stampa misure</th>
                    <th>Stampa totale suddivisioni</th>
                    <th>Stampa totale finale</th>
                    <th>Stampa numero pagina</th>
                    <th>Titolo di stampa</th>
                    <th>Iva %</th>
                    <th></th> 
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
                        <span class="iwebCAMPO_idcomputopdf"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_dataora iwebData"></span>
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_stampalogo iwebCheckbox" disabled />
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_stampaprezzi iwebCheckbox" disabled />
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_stampacopertina iwebCheckbox" disabled />
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_stampasuddivisioni iwebCheckbox" disabled />
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_stampamisure iwebCheckbox" disabled />
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_stampatotalenellesuddivisioni iwebCheckbox" disabled />
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_stampatotalefinale iwebCheckbox" disabled />
                    </td>
                    <td>
                        <input type="checkbox" class="iwebCAMPO_stampanumeropagina iwebCheckbox" disabled />
                    </td>
                    <td>
                        <span class="iwebCAMPO_titolocomputo"></span>
                    </td>
                    <td>
                        <span class="iwebCAMPO_iva r"></span>
                    </td>
                    <td>
                        <div class="iwebCAMPO_LINKIDCANTIERE btn btn-default iwebCliccabile" onclick="
                            iwebTABELLA_SelezionaRigaComeUnica();
                            ristampaComputoPrecedentementeGenerato();
                        ">
                            RIPRENDI
                        </div>
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
                </tr>
                <tr><td><div class="iwebTABELLAFooterPaginazione">
                    <div>Pagina</div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                    <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                    <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                    <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                    <div class="iwebPAGESIZE"><select id="SelectTabellaStampe1gretg345h4hrhrshrt54t" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                    <div class="iwebTOTRECORD">Trovate 0 righe</div>
                </div></td></tr>
            </tfoot>
        </table>
        <span class="iwebSQLSELECT">
	        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                SELECT computopdf.id as 'idcomputopdf', 
                       computopdf.idcomputo as 'idcomputo', 
                       computopdf.datacreazione as 'datacreazione', 
                       computopdf.dataora as 'dataora', 
                       computopdf.stampaprezzi as 'stampaprezzi', 
                       computopdf.stampacopertina as 'stampacopertina', 
                       computopdf.stampasuddivisioni as 'stampasuddivisioni', 
                       computopdf.stampamisure as 'stampamisure', 
                       computopdf.stampatotalenellesuddivisioni as 'stampatotalenellesuddivisioni', 
                       computopdf.stampatotalefinale as 'stampatotalefinale', 
                       computopdf.titolocomputo as 'titolocomputo', 
                       computopdf.stampalogo as 'stampalogo', 
                       computopdf.stampanumeropagina as 'stampanumeropagina', 
                       computopdf.iva as 'iva'
                FROM computopdf 
                WHERE computopdf.idcomputo = @idcomputo 
                ORDER BY computopdf.id DESC"
            ) %></span>
                <%--"SELECT id, " +
                "       dataora, " +
                "       stampalogo, " +
                "       stampaprezzi, " +
                "       stampacopertina, " +
                "       stampasuddivisioni, " +
                "       stampamisure, " +
                "       stampatotalefinale, " +
                "       stampatotalenellesuddivisioni, " +
                "       stampanumeropagina, " +
                "       titolocomputo " +
                "       iva " +
                "FROM computopdf WHERE computopdf.idcomputo = @idcomputo ORDER BY computopdf.id DESC "--%>
	        <span class="iwebPARAMETRO">@idcomputo = IDCOMPUTO_value</span>
        </span>
    </div><%-- fine tabella in alto --%>
