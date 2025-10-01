<%@ Control Language="C#" ClassName="_stampa_computo_opzioni_stampa" %>

<table class="tabellaopzionistampa">
    <tr>
        <td>Stampa intestazione</td>
        <td><input type="checkbox" id="stampaLogo" checked /></td>
    </tr>
    <tr>
        <td>Stampa copertina</td>
        <td><input type="checkbox" id="stampaCopertina" checked /></td>
    </tr>
    <tr>
        <td>Stampa riepilogo</td>
        <td><input type="checkbox" id="stampaSuddivisioni" checked /></td>
    </tr>
    <tr>
        <td>Stampa misure</td>
        <td><input type="checkbox" id="stampaMisure" checked /></td>
    </tr>
    <tr>
        <td>Stampa prezzi</td>
        <td><input type="checkbox" id="stampaPrezzi" checked /></td>
    </tr>
    <tr>
        <td>Stampa totale nelle suddivisioni</td>
        <td><input type="checkbox" id="stampaTotaleNelleSuddivisioni" checked /></td>
    </tr>
    <tr>
        <td>Stampa totale finale</td>
        <td><input type="checkbox" id="stampaTotaleFinale" checked /></td>
    </tr>
    <tr>
        <td>Stampa numero pagina</td>
        <td><input type="checkbox" id="stampaNumeroPagina" checked /></td>
    </tr>
    <tr>
        <td>Titolo di stampa</td>
        <td><textarea id="titoloComputo" class="iwebTIPOCAMPO_memo" maxlength="100"></textarea></td>
    </tr>
    <tr>
        <td>Condizioni ultima pagina offerta</td>
        <td><textarea id="condizioniUltimaPagina" class="iwebTIPOCAMPO_memo"></textarea></td>
    </tr>
    <tr>
        <td>Data</td>
        <td>
            <input type="text" id="dataDiStampa" class="iwebCAMPO_dataora iwebTIPOCAMPO_date" placeholder="gg/mm/aaaa"
                onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" />
        </td>
    </tr>
    <tr>
        <td>Iva</td>
        <td><input type="text" id="stampaIva" onblur="this.style.border = '1px solid #e5e5e5'" /></td>
    </tr>
    <tr>
        <td></td>
        <td>
            <div class="btn btn-success iwebCliccabile" onclick="stampaComputo()">Stampa</div>
        </td>
    </tr>
</table>
<span class="iwebSQLINSERT">
    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
        INSERT INTO computopdf (idcomputo, datacreazione, dataora, 
            stampalogo, stampaprezzi, stampacopertina, stampasuddivisioni, stampamisure, 
            stampatotalenellesuddivisioni, stampatotalefinale, stampanumeropagina, titolocomputo,
            iva) 
        VALUES (@idcomputo, @datacreazione, @dataora, 
            @stampalogo, @stampaprezzi, @stampacopertina, @stampasuddivisioni, @stampamisure, 
            @stampatotalenellesuddivisioni, @stampatotalefinale, @stampanumeropagina, @titolocomputo,
            @iva)
    ") %></span>
    <span class="iwebPARAMETRO">@idcomputo = IDCOMPUTO_value</span>
	<span class="iwebPARAMETRO">@dataora = dataDiStampa_value</span>
	<span class="iwebPARAMETRO">@datacreazione = FUNZIONE_ottieniDataDiOggiPerDB()</span>
	<span class="iwebPARAMETRO">@stampaprezzi = stampaPrezzi_value</span>
	<span class="iwebPARAMETRO">@stampalogo = stampaLogo_value</span>
	<span class="iwebPARAMETRO">@stampacopertina = stampaCopertina_value</span>
	<span class="iwebPARAMETRO">@stampasuddivisioni = stampaSuddivisioni_value</span>
	<span class="iwebPARAMETRO">@stampamisure = stampaMisure_value</span>
    <span class="iwebPARAMETRO">@stampatotalenellesuddivisioni = stampaTotaleNelleSuddivisioni_value</span>
	<span class="iwebPARAMETRO">@stampatotalefinale = stampaTotaleFinale_value</span>
	<span class="iwebPARAMETRO">@stampanumeropagina = stampaNumeroPagina_value</span>
	<span class="iwebPARAMETRO">@titolocomputo = titoloComputo_value</span>
	<span class="iwebPARAMETRO">@iva = FUNZIONE_funzioneTabellaopzionistampaSqlInsertStampaIva()</span>
</span>
<script>
    function funzioneTabellaopzionistampaSqlInsertStampaIva() {
        var a = iwebValutaParametroAjax("stampaIva_value");
        if (a == "") a = "##INSERTDBNULL##";
        return a;
    }
</script>

<%--<span id="queryAggiornamentoComputo" class="iwebNascosto">
    <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
        UPDATE computo SET condizioniultimapagina = @condizioniultimapagina
    ") %></span>
    <span class="iwebPARAMETRO">@idcomputo = IDCOMPUTO_value</span>
    <span class="iwebPARAMETRO">@condizioniultimapagina = tabellaComputi_findFirstValue_condizioniultimapagina</span>
</span>--%>
