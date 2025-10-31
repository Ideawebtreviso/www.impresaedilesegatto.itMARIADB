<%@ Control Language="C#" ClassName="_report_cantiere_tabella_report_cantiere" %>

<style>
    @media print {
        #tabellaReportCantiere {
            font-size: 120%;
        }

        #tabellaReportCantiere .iwebDescrizione {
            font-size: inherit;
        }
    }
</style>

    <table id="tabellaReportCantiere" class="iwebTABELLA iwebCHIAVE__costo.id">
        <thead>
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <th class="iwebNascosto"><input type="checkbox" onclick="iwebTABELLA_CheckboxTuttiNessuno(); iwebTABELLA_AggiornaConteggioSelezionati()"/></th>
                <th class="commandHead iwebNascosto">
                </th>
                <th class="iwebNascosto">ID</th>
                <th><div class="l">Data costo</div>
                    <div>
                        <span class="iwebFILTROOrdinamento iwebSORT_datacostoodatabolla_DESC glyphicon glyphicon-sort-by-alphabet r" 
                        onclick="iwebTABELLA_CambiaOrdinamento()"></span>
                    </div>
                    <div class="b"></div>
                </th>
                <th>Tipo fornitore</th>
                <th>Fornitore</th>
                <th>Articolo</th>
                <th>Descrizione</th>
                <th>Prezzo</th>
                <th>Sc.1</th>
                <th>Sc.2</th>
                <th>U.M.</th>
                <th>Qta</th>
                <th>Importo</th>
                <th>Qta/M</th>
                <th>Importo/M</th>
                <th>N° bolla</th>
                <th>Fatt. acc.</th>
                <th>N° fattura</th>
                <%--<th>Prot. bolla</th>--%>
                <th>Prot.<%-- fatt.--%></th>
            </tr>
            <%-- filtri --%>
            <tr>
                <td>
                    <%--maggiore uguale di--%>
                    <%--<div class="iwebFILTRO iwebFILTROMaggioreUgualeDi iwebFILTROTIPOCAMPO_data iwebCAMPO_costo.datacosto">
                        <input type="text" placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                    </div>--%>
                    <div class="iwebFILTROTIPOCAMPO_data">
                        <input type="text"  id="datacostoodatabollaDA" class="iwebTIPOCAMPO_date" 
                            onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                            placeholder="Da" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                    </div>

                    <%--minore di--%>
<%--                    <div class="iwebFILTRO iwebFILTROMinoreDi iwebFILTROTIPOCAMPO_data iwebCAMPO_costo.datacosto">
                        <input type="text" placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                    </div>--%>
                    <div class="iwebFILTROTIPOCAMPO_data">
                        <input type="text" id="datacostoodatabollaA" class="iwebTIPOCAMPO_date"
                            onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                            placeholder="A" onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
                    </div>

                    <div class="glyphicon glyphicon-filter iwebCliccabile" title="Filtra" onclick="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                    </div>
                </td>
                <td>
                    <div class="iwebFILTRO iwebFILTROUgualaA iwebCAMPO_fornitore.tipofornitore">
                        <select id="peroranonservelidqui"
                            onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)">
                            <option value="">Tutti</option>
                            <option value="Materiale">Materiale</option>
                            <option value="Servizio">Servizio generico</option>
                            <option value="Professionista">Professionista</option>
                            <option value="Lavorazione">Lavorazione</option>
                            <option value="Manodopera">Manodopera</option>
                        </select>
                    </div>
                </td>
                <td>
                    <%-- filtro di testo sul fornitore.ragionesociale --%>
                    <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_fornitore.ragionesociale">
                        <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                    </div>
                </td>
                <td>
                    <%-- filtro di testo sul campo prodotto.descrizione --%>
                    <div class="iwebFILTRO iwebFILTROTestoSemplice iwebCAMPO_prodotto.descrizione">
                        <input type="text" onkeyup="iwebTABELLA_VerificaAutocompletamento(this)"/>
                    </div>
                </td>
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
                <td></td>
                <td></td>
                <%-- protocollobolla in visualizzazione, ma come filtro lo applico a bolla.protocollo --%>
                <%--<th>
                    <div class="iwebFILTRO iwebFILTROTestoSemplice iwebFILTROUgualaA iwebCAMPO_bolla.protocollo">
                        <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                    </div>
                </th>--%>
                <th>
                    <%-- protocollofattura in visualizzazione, ma come filtro lo applico a bollafattura.protocollo --%>
                    <div class="iwebFILTRO iwebFILTROTestoSemplice iwebFILTROUgualaA iwebCAMPO_bollafattura.protocollo">
                        <input type="text" onchange="iwebTABELLA_Carica(cercaTablePadreRicors().id, 0, true)"/>
                    </div>
                </th>
            </tr>
        </thead>
        <tbody class="iwebNascosto">
            <tr>
                <%-- il primo è il checkbox di selezione --%>
                <td class="iwebNascosto"><input type="checkbox" class="iwebCBSELEZIONABILE iwebNascosto" onchange="iwebTABELLA_AggiornaConteggioSelezionati()"/></td>
                <td class="iwebNascosto">
                    <span class="iwebCAMPO_costo.id"></span>
                    <span class="iwebCAMPO_prodotto.id"></span>
                    <span class="iwebCAMPO_fornitore.id"></span>
                    <span class="iwebCAMPO_bollafattura.id"></span>
                    <span class="iwebCAMPO_bollafattura.isddt"></span>
                    <span class="iwebCAMPO_bolla.id"></span>
                    <span class="iwebCAMPO_bolla.isddt"></span>
                    <span class="iwebCAMPO_costo.idcostobollariferita"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_datacostoodatabolla iwebData"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_fornitore.tipofornitore iwebDescrizione iwebTroncaCrtsAt_30"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_fornitore.ragionesociale iwebDescrizione"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_prodotto.descrizione"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.descrizione"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.prezzo iwebValuta"></span>
                </td>
                <td>
                    <%-- sovrascrivo la larghezza intervenendo sulla colonna che di default è più larga --%>
                    <span class="iwebCAMPO_costo.sconto1 iwebQuantita" style="width:30px;"></span>
                </td>
                <td>
                    <%-- sovrascrivo la larghezza intervenendo sulla colonna che di default è più larga --%>
                    <span class="iwebCAMPO_costo.sconto2 iwebQuantita" style="width:30px;"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_unitadimisura.codice iwebCodice"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.quantita iwebQuantita"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.importo iwebQuantita"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costo.qtaoremastrino iwebQuantita"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_costoimportoqtaoremastrino iwebQuantita"></span>
                </td>
                <td>
                    <span class="iwebCAMPO_bollafattura.numero iwebNascosto"></span>
                    <span class="iwebCAMPO_numerobolla"></span>
                </td>
                <td>
                    <input type="checkbox" disabled class="iwebCAMPO_bollafattura.isfattura iwebCheckbox" />
                </td>
                <td>
                    <span class="iwebCAMPO_numerofattura"></span>
                </td>
                <%--<td>
                    <span class="iwebCAMPO_protocollobolla"></span>
                </td>--%>
                <td>
                    <span class="iwebCAMPO_protocollofattura"></span>
                </td>
            </tr>
        </tbody>
        <tbody><%-- il codice viene generato automaticamente qui --%></tbody>
        <tfoot>
            <tr>
                <td colspan="9" style="text-align:right"><b>Totale:</b></td>
                <td>
                    <!-- uso i filtri della tabella, ma eseguo una query diversa -->
                    <span id="Span1" class="iwebTOTALE iwebUSAFILTRI iwebQuantita"></span>
                    <span class="iwebSQLSELECT iwebNascosto">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                             SELECT SUM(costo.quantita) as 'TOTALE'
                             FROM costo
                                INNER JOIN cantiere ON (cantiere.id = costo.idcantiere AND cantiere.id = @idcantiere)
                                LEFT JOIN costo as costofatturariferita ON (costo.id = costofatturariferita.idcostobollariferita)
                                INNER JOIN prodotto ON costo.idprodotto = prodotto.id
                                LEFT JOIN bollafattura ON costo.idbollafattura = bollafattura.id
                                INNER JOIN fornitore ON ((bollafattura.id is null AND prodotto.idfornitore = fornitore.id) OR bollafattura.idfornitore = fornitore.id)

                                LEFT JOIN costo as rigacostobolla ON costo.idcostobollariferita = rigacostobolla.id /* mi serve come tabella intermedia per ottenere il numero bolla */
                                LEFT JOIN bollafattura as bolla ON rigacostobolla.idbollafattura = bolla.id /* da qui ottengo il numero bolla */

                             WHERE costofatturariferita.id is NULL AND
                                   (@dataDa = '' OR ((bolla.databollafattura is null AND costo.datacosto >= @dataDa) OR (bolla.databollafattura is not null AND bolla.databollafattura >= @dataDa))) AND
                                   (@dataA = '' OR ((bolla.databollafattura is null AND costo.datacosto <= @dataA) OR (bolla.databollafattura is not null AND bolla.databollafattura <= @dataA)))
                        ")%></span>
	                    <span class="iwebPARAMETRO">@idcantiere = IDCANTIERE_value</span>
                        <span class="iwebPARAMETRO">@dataDa = datacostoodatabollaDA_value</span>
                        <span class="iwebPARAMETRO">@dataA = datacostoodatabollaA_value</span>
                    </span>
                </td>
                <td>
                    <!-- uso i filtri della tabella, ma eseguo una query diversa -->
                    <span id="Span2" class="iwebTOTALE iwebUSAFILTRI iwebQuantita"></span>
                    <span class="iwebSQLSELECT iwebNascosto">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                            SELECT SUM(costo.quantita * (costo.prezzo * (100-costo.sconto1) * (100-costo.sconto2) / 10000)) as 'TOTALE'
                            FROM costo
                                INNER JOIN cantiere ON (cantiere.id = costo.idcantiere AND cantiere.id = @idcantiere)
                                LEFT JOIN costo as costofatturariferita ON (costo.id = costofatturariferita.idcostobollariferita)
                                INNER JOIN prodotto ON costo.idprodotto = prodotto.id
                                LEFT JOIN bollafattura ON costo.idbollafattura = bollafattura.id
                                INNER JOIN fornitore ON ((bollafattura.id is null AND prodotto.idfornitore = fornitore.id) OR bollafattura.idfornitore = fornitore.id)
                                LEFT JOIN costo as rigacostobolla ON costo.idcostobollariferita = rigacostobolla.id /* mi serve come tabella intermedia per ottenere il numero bolla */
                                LEFT JOIN bollafattura as bolla ON rigacostobolla.idbollafattura = bolla.id /* da qui ottengo il numero bolla */

                            WHERE costofatturariferita.id is NULL AND
                                  (@dataDa = '' OR ((bolla.databollafattura is null AND costo.datacosto >= @dataDa) OR (bolla.databollafattura is not null AND bolla.databollafattura >= @dataDa))) AND
                                  (@dataA = '' OR ((bolla.databollafattura is null AND costo.datacosto <= @dataA) OR (bolla.databollafattura is not null AND bolla.databollafattura <= @dataA)))
                        ") %></span>
	                    <span class="iwebPARAMETRO">@idcantiere = IDCANTIERE_value</span>
                        <span class="iwebPARAMETRO">@dataDa = datacostoodatabollaDA_value</span>
                        <span class="iwebPARAMETRO">@dataA = datacostoodatabollaA_value</span>
                    </span>
                </td>

                <td>
                    <!-- uso i filtri della tabella, ma eseguo una query diversa -->
                    <span id="Span3" class="iwebTOTALE iwebUSAFILTRI iwebQuantita"></span>
                    <span class="iwebSQLSELECT iwebNascosto">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                             SELECT SUM(costo.quantita) as 'TOTALE'
                             FROM costo
                                INNER JOIN cantiere ON (cantiere.id = costo.idcantiere AND cantiere.id = @idcantiere)
                                LEFT JOIN costo as costofatturariferita ON (costo.id = costofatturariferita.idcostobollariferita)
                                INNER JOIN prodotto ON costo.idprodotto = prodotto.id
                                LEFT JOIN bollafattura ON costo.idbollafattura = bollafattura.id
                                INNER JOIN fornitore ON ((bollafattura.id is null AND prodotto.idfornitore = fornitore.id) OR bollafattura.idfornitore = fornitore.id)

                                LEFT JOIN costo as rigacostobolla ON costo.idcostobollariferita = rigacostobolla.id /* mi serve come tabella intermedia per ottenere il numero bolla */
                                LEFT JOIN bollafattura as bolla ON rigacostobolla.idbollafattura = bolla.id /* da qui ottengo il numero bolla */

                             WHERE costofatturariferita.id is NULL AND
                                   (@dataDa = '' OR ((bolla.databollafattura is null AND costo.datacosto >= @dataDa) OR (bolla.databollafattura is not null AND bolla.databollafattura >= @dataDa))) AND
                                   (@dataA = '' OR ((bolla.databollafattura is null AND costo.datacosto <= @dataA) OR (bolla.databollafattura is not null AND bolla.databollafattura <= @dataA)))
                        ")%></span>
	                    <span class="iwebPARAMETRO">@idcantiere = IDCANTIERE_value</span>
                        <span class="iwebPARAMETRO">@dataDa = datacostoodatabollaDA_value</span>
                        <span class="iwebPARAMETRO">@dataA = datacostoodatabollaA_value</span>
                    </span>
                </td>
                <td>
                    <!-- uso i filtri della tabella, ma eseguo una query diversa -->
                    <span id="Span4" class="iwebTOTALE iwebUSAFILTRI iwebQuantita"></span>
                    <span class="iwebSQLSELECT iwebNascosto">
	                    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                            SELECT SUM(costo.quantita * (costo.prezzo * (100-costo.sconto1) * (100-costo.sconto2) / 10000)) as 'TOTALE'
                            FROM costo
                                INNER JOIN cantiere ON (cantiere.id = costo.idcantiere AND cantiere.id = @idcantiere)
                                LEFT JOIN costo as costofatturariferita ON (costo.id = costofatturariferita.idcostobollariferita)
                                INNER JOIN prodotto ON costo.idprodotto = prodotto.id
                                LEFT JOIN bollafattura ON costo.idbollafattura = bollafattura.id
                                INNER JOIN fornitore ON ((bollafattura.id is null AND prodotto.idfornitore = fornitore.id) OR bollafattura.idfornitore = fornitore.id)
                                LEFT JOIN costo as rigacostobolla ON costo.idcostobollariferita = rigacostobolla.id /* mi serve come tabella intermedia per ottenere il numero bolla */
                                LEFT JOIN bollafattura as bolla ON rigacostobolla.idbollafattura = bolla.id /* da qui ottengo il numero bolla */

                            WHERE costofatturariferita.id is NULL AND
                                  (@dataDa = '' OR ((bolla.databollafattura is null AND costo.datacosto >= @dataDa) OR (bolla.databollafattura is not null AND bolla.databollafattura >= @dataDa))) AND
                                  (@dataA = '' OR ((bolla.databollafattura is null AND costo.datacosto <= @dataA) OR (bolla.databollafattura is not null AND bolla.databollafattura <= @dataA)))
                        ") %></span>
	                    <span class="iwebPARAMETRO">@idcantiere = IDCANTIERE_value</span>
                        <span class="iwebPARAMETRO">@dataDa = datacostoodatabollaDA_value</span>
                        <span class="iwebPARAMETRO">@dataA = datacostoodatabollaA_value</span>
                    </span>
                </td>
                <td colspan="4"></td>
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
	    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
             SELECT costo.id as 'costo.id', 
                    costo.idcostobollariferita as 'costo.idcostobollariferita', 
                    costofatturariferita.id as 'idcostofatturachechiude', 
                    /* unitadimisura.id as 'unitadimisura.id',  */
                    unitadimisura.codice as 'unitadimisura.codice', 
                    costo.prezzo as 'costo.prezzo', 
                    costo.sconto1 as 'costo.sconto1', 
                    costo.sconto2 as 'costo.sconto2', 
                    IF (bolla.isddt = true, bolla.databollafattura, costo.datacosto) as 'datacostoodatabolla', 
            
                    costo.quantita as 'costo.quantita', 
                    (costo.quantita * (costo.prezzo * (100-costo.sconto1) * (100-costo.sconto2) / 10000)) as 'costo.importo', 
            
                    costo.qtaoremastrino as 'costo.qtaoremastrino', 
                    (costo.qtaoremastrino * (costo.prezzo * (100-costo.sconto1) * (100-costo.sconto2) / 10000)) as 'costoimportoqtaoremastrino', 

                    IF (bollafattura.isfattura && bollafattura.isddt = false, rigacostobolla.descrizione, costo.descrizione) as 'costo.descrizione', 

                    prodotto.id as 'prodotto.id', 
                    prodotto.descrizione as 'prodotto.descrizione', 
                    prodotto.listino as 'prodotto.listino', 
            
                    fornitore.ragionesociale as 'fornitore.ragionesociale', 
                    fornitore.tipofornitore as 'fornitore.tipofornitore', 
            
                    bolla.isddt as 'bolla.isddt', 
                    bollafattura.isddt as 'bollafattura.isddt', 
                    bolla.id as 'bolla.id', 
                    bollafattura.id as 'bollafattura.id', 
                    bollafattura.numero as 'bollafattura.numero', 
                    IF (bollafattura.isfattura && bollafattura.isddt = false, bolla.numero, bollafattura.numero) as 'numerobolla', 
                    IF (bollafattura.isfattura && bollafattura.isddt = false, bollafattura.numero, '') as 'numerofattura', 
            
                    IF (bollafattura.isfattura && bollafattura.isddt = false, bolla.protocollo, bollafattura.protocollo) as 'protocollobolla', 
                    IF (bollafattura.isfattura && bollafattura.isddt = false, bollafattura.protocollo, '') as 'protocollofattura', 
            
                    (bollafattura.isfattura && bollafattura.isddt) as 'bollafattura.isfattura' 


             FROM costo INNER JOIN cantiere ON (cantiere.id = costo.idcantiere AND cantiere.id = @idcantiere) 
                        LEFT JOIN costo as costofatturariferita ON (costo.id = costofatturariferita.idcostobollariferita)
                        INNER JOIN prodotto ON costo.idprodotto = prodotto.id 
                        LEFT JOIN bollafattura ON costo.idbollafattura = bollafattura.id 
                        INNER JOIN fornitore ON ((bollafattura.id is null AND prodotto.idfornitore = fornitore.id) OR bollafattura.idfornitore = fornitore.id) 
            
                        LEFT JOIN costo as rigacostobolla ON costo.idcostobollariferita = rigacostobolla.id  /* mi serve come tabella intermedia per ottenere il numero bolla */
                        LEFT JOIN bollafattura as bolla ON rigacostobolla.idbollafattura = bolla.id  /* da qui ottengo il numero bolla */
                        LEFT JOIN unitadimisura ON prodotto.idunitadimisura = unitadimisura.id
            
             WHERE costofatturariferita.id is NULL AND 
                        (@dataDa = '' OR ((bolla.databollafattura is null AND costo.datacosto >= @dataDa) OR (bolla.databollafattura is not null AND bolla.databollafattura >= @dataDa))) AND 
                        (@dataA = '' OR ((bolla.databollafattura is null AND costo.datacosto <= @dataA) OR (bolla.databollafattura is not null AND bolla.databollafattura <= @dataA))) 
        ") %></span>

        <%-- La data costo deve essere sempre la data della bolla se si riferisce a una bolla e la data fattura se si riferisce alla fattura. --%>
        <%-- Il difficile di questa query è che deve scartare i record di bolla che sono stati chiusi da una fattura. 
            Per farlo, si mette in LEFT JOIN costi con se stessa  [LEFT JOIN costo as costofatturariferita ON (costo.id = costofatturariferita.idcostobollariferita)].
            A questo punto i record di BOLLE che sono CHIUSE sono agganciati ad altri dati: nella clausola WHERE tengo solo i dati non aggianciati, da cui la clausola [costo.idcostobollariferita is NULL].
            Da notare che questa clausola WHERE non può essere spostata dentro la JOIN. 
            
            FORNITORE: se il COSTO è riferito ad una bollafattura, allora il fornitore è quello della bollafattura.
             Altrimenti il fornitore è quello del prodotto (ad esempio per i costi di manodopera).
            Da cui la seguente condizione [INNER JOIN fornitore ON  ((bollafattura.id is null AND prodotto.idfornitore = fornitore.id) OR bollafattura.idfornitore = fornitore.id) ]
            
                         --%>
	    <span class="iwebPARAMETRO">@idcantiere = IDCANTIERE_value</span>
        <span class="iwebPARAMETRO">@dataDa = datacostoodatabollaDA_value</span>
        <span class="iwebPARAMETRO">@dataA = datacostoodatabollaA_value</span>
    </span>
