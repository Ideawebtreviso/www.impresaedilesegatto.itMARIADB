<%@ Control Language="C#" ClassName="_controllo_fattura_tabella_righe_aperte" %>

    <div class="btn btn-default" onclick="controlloFattura_inserisciCosto()" tabindex="1" id="salvaRigheAperte">Salva</div><br /><br />
    <%-- inserimento di una riga nella tabella costo (=inserisco una riga chiusa) --%>
    <%-- idbollafattura -> qui vado ad inserire l'id della fattura che sto controllando --%>
    <%-- idcostobollariferita -> qui vado ad inserire l'id della bolla aperta selezionata --%>
    <span id="iwebSQLINSERISCICOSTO" class="iwebNascosto"><%= IwebCrypter.iwebcsCriptaSQL(
        "INSERT INTO costo (idbollafattura, idprodotto, idcantiere, idcostobollariferita, quantita, prezzo, sconto1, sconto2, datacosto)"
        + "       VALUES (@idbollafattura, @idprodotto, @idcantiere, @idcostobollariferita, @quantita, @prezzo, @sconto1, @sconto2, @datacosto)"
    ) %></span>
    <span id="iwebSQLAGGIORNADATOPRODOTTO" class="iwebNascosto"><%= IwebCrypter.iwebcsCriptaSQL(
        "UPDATE prodotto SET listino = @prezzo, sconto1 = @sconto1, sconto2 = @sconto2 WHERE id = @idprodotto"
    ) %></span>

    <table id="tabellaRigheAperte" class="iwebTABELLA iwebCHIAVE__costo.id">
        <thead>
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <th><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati(); righeAperteCheckboxModificaRighe()"/>(*)</th>
                <th class="commandHead iwebNascosto"></th>
                <th class="iwebNascosto">ID</th>
                <th>Cantiere</th>
                <th>Cliente</th>
                <th>Prodotto</th>
                <th>Qta bolla</th>
                <th>Prezzo bolla</th>
                <th>Sc. 1 bolla</th>
                <th>Sc.2 bolla</th>
                <th>Qta fattura</th>
                <th>Prezzo fattura</th>
                <th>Sc.1 fattura</th>
                <th>Sc.2 fattura</th>
                <th>Aggiorna dato prodotto</th>
                <th>Tot</th>
            </tr>
            <tr class="iwebNascosto">
                <th></th><%-- CHECKBOX --%>
                <th><%-- AZIONI --%>
                </th>
                <th class="iwebNascosto"></th>
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
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody class="iwebNascosto">
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <td><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati(); righeAperteCheckboxModificaRiga(this)" tabindex="-1"/></td>
                <td class="iwebNascosto">
                    <%--<div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaClientiModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaClienti');"></div>
                    <div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaRigheAperte');"></div>--%>
                </td>
                <td class="iwebNascosto">
                    <span class="iwebCAMPO_costo.id"></span>
                    <span class="iwebCAMPO_costo.idbollafattura iwebNascosto"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                    <span class="iwebCAMPO_costo.idcantiere iwebNascosto"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_cliente.nominativo iwebDescrizione iwebTroncaCrtsAt_30"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione iwebTroncaCrtsAt_30"></span>
                    <span class="iwebCAMPO_costo.idprodotto iwebNascosto"></span>
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
                <td>
                    <input type="text" class="iwebCAMPO_costoinfattura.quantita" placeholder="quantita" tabindex="1"/>
                </td>
                <td>
                    <input type="text" class="iwebCAMPO_costoinfattura.prezzo" placeholder="prezzo" tabindex="1" />
                </td>
                <td>
                    <input type="text" class="iwebCAMPO_costoinfattura.sconto1" placeholder="sconto1" tabindex="1" />
                </td>
                <td>
                    <input type="text" class="iwebCAMPO_costoinfattura.sconto2" placeholder="sconto2" tabindex="1" />
                </td>
                <td>
                    <input type="checkbox" class="iwebCheckbox cbAggiornaDatoProdotto" tabindex="1" />
                </td>
                <td>
                    <span class="iwebCAMPO_importodacontrollare iwebValuta"></span>
                </td>
            </tr>
        </tbody>
        <tbody>
            <%-- il codice viene generato automaticamente qui --%>
        </tbody>
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
                <td></td>
            </tr>
            <tr><td><div class="iwebTABELLAFooterPaginazione">
                <div>Pagina</div>
                <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaPrec();"><span class="glyphicon glyphicon-chevron-left"></span></div>
                <div class="iwebPAGENUMBER"><input type="text" value="1" onchange="iwebTABELLA_FooterVaiPaginaSpec()" /></div>
                <div class="iwebCliccabile" onclick="iwebTABELLA_FooterVaiPaginaSucc()"><span class="glyphicon glyphicon-chevron-right"></span></div><div>di</div>
                <div class="iwebTOTPAGINE">1</div><div>|</div><div>Vedi</div>
                <div class="iwebPAGESIZE"><select id="Select3" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                <div class="iwebTOTRECORD">Trovate 0 righe</div>
            </div></td></tr>
        </tfoot>
    </table>
    <span class="iwebSQLSELECT">
        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
            "SELECT costo.id as 'costo.id', costo.idbollafattura as 'costo.idbollafattura', costo.idprodotto as 'costo.idprodotto', costo.idcantiere as 'costo.idcantiere', "
            + "       costo.quantita as 'costo.quantita', costo.prezzo as 'costo.prezzo', costo.sconto1 as 'costo.sconto1', costo.sconto2 as 'costo.sconto2', "
            + "       cantiere.codice as 'cantiere.codice', cliente.nominativo as 'cliente.nominativo', "
            + "       prodotto.descrizione as 'prodotto.descrizione', "
            + "       (costo.quantita * costo.prezzo * (1-costo.sconto1/100) * (1-costo.sconto2/100)) as 'importodacontrollare' "
            + ""
            + "FROM (((costo INNER JOIN cantiere ON costo.idcantiere = cantiere.id) "
            + "              INNER JOIN cliente ON cantiere.idcliente = cliente.id) "
            + "              INNER JOIN prodotto ON (costo.idprodotto = prodotto.id)) "
            + "              LEFT JOIN costo as costoinfattura ON costoinfattura.idcostobollariferita = costo.id "
            + "WHERE costo.idbollafattura = @idbollafattura AND costo.idbollafattura <> 0 AND "
            + "      costoinfattura.id is null "
        ) %></span>
        <span class="iwebPARAMETRO">@idbollafattura = tabellaBolleAperte_selectedValue_bollafattura.id</span>
    </span>

<%--    <input type="text" id="elementoPerFarFunzionareIlTabIndex" tabindex="1"
onkeydown="
if (event.which == 9 || event.keyCode == 9) document.getElementById('salvaRigheAperte').focus();
"/>--%>

(* Spuntare le righe che risultano corrette dai dati di bolla).
