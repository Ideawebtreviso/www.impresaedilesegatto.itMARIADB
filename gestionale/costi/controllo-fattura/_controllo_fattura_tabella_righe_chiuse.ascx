<%@ Control Language="C#" ClassName="_controllo_fattura_tabella_righe_chiuse" %>


    <table id="tabellaRigheChiuse" class="iwebTABELLA iwebCHIAVE__costo.id">
        <thead>
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                <th class="commandHead">
                </th>
                <th class="iwebNascosto">ID</th>
                <th>Cantiere</th>
                <th>Cliente</th>
                <th>Prodotto</th>
                <th>Qta bolla</th>
                <th>Prezzo bolla</th>
                <th>Sc.1 bolla</th>
                <th>Sc.2 bolla</th>
                <th>Qta fattura</th>
                <th>Prezzo fattura</th>
                <th>Sc.1 fattura</th>
                <th>Sc.2 fattura</th>
                <th>Tot</th>
                <th></th>
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
                <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                <td>
                    <div class="iwebCliccabile glyphicon glyphicon-pencil" title="Modifica" onclick="iwebTABELLA_ModificaRigaInPopup('popupTabellaRigheChiuseModifica'); iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaRigheChiuse');"></div>
                    <%--<div class="glyphicon glyphicon-hand-right iwebCliccabile" title="Seleziona" onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaRigheAperte');"></div>--%>
                </td>
                <td class="iwebNascosto">
                    <span class="iwebCAMPO_costo.id"></span>
                    <span class="iwebCAMPO_costo.idbollafattura"></span>
                    <span class="iwebCAMPO_costoinfattura.id"></span>
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
                    <span class="iwebCAMPO_costoinfattura.quantita iwebQuantita"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costoinfattura.prezzo iwebValuta"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costoinfattura.sconto1 iwebValuta"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costoinfattura.sconto2 iwebValuta"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_importocontrollato iwebValuta"></span>
                </td>
                <td>
                    <div class="iwebCliccabile glyphicon glyphicon-trash" title="Elimina"
                            onclick="iwebTABELLA_SelezionaRigaComeUnica(); iwebBind('tabellaRigheChiuse');
                                    iwebTABELLA_EliminaRigaInPopup('popupTabellaRigheChiuseElimina')"></div>
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
                <div class="iwebPAGESIZE"><select id="Select4" onchange="iwebTABELLA_FooterCambiaPageSize()"><option value="10">10</option><option value="20">20</option><option value="50">50</option><option value="100">100</option><option value="10000">Tutti</option></select></div><div>righe</div><div>|</div>
                <div class="iwebTOTRECORD">Trovate 0 righe</div>
            </div></td></tr>
        </tfoot>
    </table>
    <span class="iwebSQLSELECT">
        <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(
            "SELECT costo.id as 'costo.id', costo.idbollafattura as 'costo.idbollafattura', costo.idprodotto as 'costo.idprodotto', costo.idcantiere as 'costo.idcantiere', "
            + "       costoinfattura.id as 'costoinfattura.id', "
            + "       costo.quantita as 'costo.quantita', costo.prezzo as 'costo.prezzo', costo.sconto1 as 'costo.sconto1', costo.sconto2 as 'costo.sconto2', "
            + "       cantiere.codice as 'cantiere.codice', cliente.nominativo as 'cliente.nominativo', "
            + "       prodotto.descrizione as 'prodotto.descrizione', "
            + "       costoinfattura.quantita as 'costoinfattura.quantita', costoinfattura.prezzo as 'costoinfattura.prezzo', costoinfattura.sconto1 as 'costoinfattura.sconto1', costoinfattura.sconto2 as 'costoinfattura.sconto2', "
            + "       (costoinfattura.quantita * costoinfattura.prezzo * (1-costoinfattura.sconto1/100) * (1-costoinfattura.sconto2/100)) as 'importocontrollato' "
            + ""
            + "FROM (((costo INNER JOIN cantiere ON costo.idcantiere = cantiere.id) "
            + "              INNER JOIN cliente ON cantiere.idcliente = cliente.id) "
            + "              INNER JOIN prodotto ON costo.idprodotto = prodotto.id) "
            + "              LEFT JOIN costo as costoinfattura ON costoinfattura.idcostobollariferita = costo.id "
            + ""
            + "WHERE costo.idbollafattura = @idbollafattura AND "
            + "      costoinfattura.id is not null "
        ) %></span>
        <span class="iwebPARAMETRO">@idbollafattura = tabellaBolleAperte_selectedValue_bollafattura.id</span>
    </span>


    <%-- modifica --%>
    <div id="popupTabellaRigheChiuseModifica" class="popup popupType2" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Modifica riga chiusa</div>
                <div class="b"></div>
            </div>
            <div class="popupCorpo">
                <div class="iwebTABELLA_ContenitoreParametri"></div>
                <table>
                    <tr class="iwebNascosto">
                        <td>id</td>
                        <td><span class="iwebCAMPO_costoinfattura.id"></span></td>
                    </tr>
                    <tr>
                        <td>Cantiere</td>
                        <td>
                            <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Cliente</td>
                        <td>
                            <span class="iwebCAMPO_cliente.nominativo"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Prodotto</td>
                        <td>
                            <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Qta bolla</td>
                        <td>
                            <span class="iwebCAMPO_costo.quantita iwebQuantita"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Prezzo bolla</td>
                        <td>
                            <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Sconto 1 bolla</td>
                        <td>
                            <span class="iwebCAMPO_costo.sconto1 iwebValuta"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Sconto 2 bolla</td>
                        <td>
                            <span class="iwebCAMPO_costo.sconto2 iwebValuta"></span>
                        </td>
                    </tr>

                    <tr>
                        <td>Quantita fattura *</td>
                        <td><input type="text" class="iwebCAMPO_costoinfattura.quantita iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                            onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                    </tr>
                    <tr>
                        <td>Prezzo fattura *</td>
                        <td><input type="text" class="iwebCAMPO_costoinfattura.prezzo iwebTIPOCAMPO_varchar iwebCAMPOOBBLIGATORIO" 
                            onchange="iwebTABELLA_VerificaCampiObbligatori(this.parentElement)" /></td>
                    </tr>
                    <tr>
                        <td>Sconto 1 fattura</td>
                        <td><input type="text" class="iwebCAMPO_costoinfattura.sconto1 iwebTIPOCAMPO_varchar"/></td>
                    </tr>
                    <tr>
                        <td>Sconto 2 fattura</td>
                        <td><input type="text" class="iwebCAMPO_costoinfattura.sconto2 iwebTIPOCAMPO_varchar"/></td>
                    </tr>
                </table>
            </div>
            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-success" onclick="iwebTABELLA_ConfermaModificaRigaInPopup('popupTabellaRigheChiuseModifica', 'tabellaRigheChiuse', 'costoinfattura.quantita,costoinfattura.prezzo,costoinfattura.sconto1,costoinfattura.sconto2', 'costoinfattura.id', true);">Aggiorna</div>
                <span class="iwebSQLUPDATE">
	                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("UPDATE costo SET quantita = @quantita, prezzo = @prezzo, sconto1 = @sconto1, sconto2 = @sconto2 WHERE id = @id") %></span>
	                <span class="iwebPARAMETRO">@quantita = popupTabellaRigheChiuseModifica_findValue_costoinfattura.quantita</span>
	                <span class="iwebPARAMETRO">@prezzo = popupTabellaRigheChiuseModifica_findValue_costoinfattura.prezzo</span>
	                <span class="iwebPARAMETRO">@sconto1 = popupTabellaRigheChiuseModifica_findValue_costoinfattura.sconto1</span>
	                <span class="iwebPARAMETRO">@sconto2 = popupTabellaRigheChiuseModifica_findValue_costoinfattura.sconto2</span>
	                <span class="iwebPARAMETRO">@id = popupTabellaRigheChiuseModifica_findValue_costoinfattura.id</span>
                </span>
            </div>
        </div>
    </div>


    <%-- elimina --%>
    <div id="popupTabellaRigheChiuseElimina" class="popup popupType2" style="display:none">
        <div>
            <div class="popupHeader">
                <div class="glyphicon glyphicon-remove iwebCliccabile r" onclick="chiudiPopupType2()" ></div>
                <div class="popupTitolo l">Elimina associazione fattura/bolla, la riga ritornerà aperta</div>
                <div class="b"></div>
            </div>
            <div class="iwebTABELLA_ContenitoreParametri"></div>
            <div class="popupCorpo">
                <table>
                    <%-- in eliminazione deve comparire il/i campo/i chiave, eventualmente come span iwebNascosto. 
                            in questo modo dovrebbero essere eseguiti meno controlli rispetto alla ricerca dell'id sulla riga --%>
                    <tr class="iwebNascosto">
                        <td>id</td>
                        <td><span class="iwebCAMPO_costoinfattura.id"></span></td>
                    </tr>
                    <tr>
                        <td>Cantiere</td>
                        <td>
                            <span class="iwebCAMPO_cantiere.codice iwebCodice"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Cliente</td>
                        <td>
                            <span class="iwebCAMPO_cliente.nominativo"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Prodotto</td>
                        <td>
                            <span class="iwebCAMPO_prodotto.descrizione iwebDescrizione"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Qta bolla</td>
                        <td>
                            <span class="iwebCAMPO_costo.quantita iwebQuantita"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Prezzo bolla</td>
                        <td>
                            <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Sconto 1 bolla</td>
                        <td>
                            <span class="iwebCAMPO_costo.sconto1 iwebValuta"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Sconto 2 bolla</td>
                        <td>
                            <span class="iwebCAMPO_costo.sconto2 iwebValuta"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Qta fattura</td>
                        <td>
                            <span class="iwebCAMPO_costoinfattura.quantita iwebQuantita"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Prezzo fattura</td>
                        <td>
                            <span class="iwebCAMPO_costoinfattura.prezzo iwebValuta"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Sconto 1 fattura</td>
                        <td>
                            <span class="iwebCAMPO_costoinfattura.sconto1 iwebValuta"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Sconto 2 fattura</td>
                        <td>
                            <span class="iwebCAMPO_costoinfattura.sconto2 iwebValuta"></span>
                        </td>
                    </tr>
                    <%-- se voglio aggiungere un campo ho necessità di averlo in tabella --%>
                </table>
            </div>
            <div class="popupFooter">
                <div class="btn btn-warning" onclick="chiudiPopupType2()" >Annulla</div>
                <div class="btn btn-danger" onclick="
                    iwebTABELLA_ConfermaEliminaRigaInPopup('popupTabellaRigheChiuseElimina', 'tabellaRigheChiuse', true, function(){
                        controlloFattura_togliSpuntaDaBollaChiusa(function(){
                            iwebCaricaElemento('elementoConITab');
                            iwebCaricaElemento('tabellaBolleAperte');
                        });
                    });">Elimina</div>
                <span class="iwebSQLDELETE">
                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("DELETE FROM costo WHERE id = @id") %></span>
	                <span class="iwebPARAMETRO">@id = popupTabellaRigheChiuseElimina_findValue_costoinfattura.id</span>
                </span>
            </div>
        </div>
    </div>
