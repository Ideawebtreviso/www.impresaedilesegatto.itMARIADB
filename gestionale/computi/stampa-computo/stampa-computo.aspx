<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="stampa-computo.aspx.cs" Inherits="gestionale_computi_stampa_computo_stampa_computo" %>

<%@ Register TagPrefix="stampaComputo" TagName="tabellaComputi" Src="_stampa_computo_tabella_computo.ascx" %>
<%@ Register TagPrefix="stampaComputo" TagName="opzioniStampaSuddivisioni" Src="_stampa_computo_opzioni_stampa_suddivisioni.ascx" %>
<%@ Register TagPrefix="stampaComputo" TagName="opzioniStampa" Src="_stampa_computo_opzioni_stampa.ascx" %>
<%@ Register TagPrefix="stampaComputo" TagName="stampePrecedenti" Src="_stampa_computo_stampe_precedenti.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="stampa-computo-03.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDCOMPUTO" class="iwebNascosto"><asp:Literal ID="LiteralIDCOMPUTO" runat="server"></asp:Literal></span>
    <div class="TitoloPagina">
        Stampa computo
    </div>
    <stampaComputo:tabellaComputi runat="server" ID="stampaComputo_tabellaComputi" />

    <div class="TitoloPagina">
        Opzioni di stampa
    </div>
    <stampaComputo:opzioniStampaSuddivisioni runat="server" ID="stampaComputo_opzioniStampaSuddivisioni" />
    <stampaComputo:opzioniStampa runat="server" ID="stampaComputo_opzioniStampa" />

    <div class="TitoloPagina">
        Stampe precedenti
    </div>
    <stampaComputo:stampePrecedenti runat="server" ID="stampaComputo_stampePrecedenti" />


    <script>
        function pageload() {

            // carico la tabella computi e imposto il Titolo di stampa
            iwebCaricaElemento("tabellaComputi", false, function () {
                // NEL CASO NON FUNZIONI QUESTA FUNZIONE, CANCELLARE TUTTO E MOSTRARE SOLO LA RIGA QUA SOTTO COMMENTATA
                //document.getElementById("titoloComputo").value = document.getElementById("tabellaComputi").getElementsByTagName("tbody")[1].getElementsByTagName("tr")[0].getElementsByClassName("iwebCAMPO_titolo")[0].innerHTML;

                var el = document.getElementById("tabellaComputi").getElementsByTagName("tbody")[1].getElementsByTagName("tr")[0].getElementsByClassName("iwebCAMPO_titolo")[0];
                if (el.title != "")
                    if (el.title.length >= 100)
                        document.getElementById("titoloComputo").value = el.title.substr(0, 99);
                    else
                        document.getElementById("titoloComputo").value = el.title;
                else
                    if (el.innerHTML.length >= 100)
                        document.getElementById("titoloComputo").value = el.innerHTML.substr(0, 99);
                    else
                        document.getElementById("titoloComputo").value = el.innerHTML;

                // Condizioni ultima pagina offerta
                document.getElementById("condizioniUltimaPagina").value = iwebValutaParametroAjax("tabellaComputi_findFirstValue_condizioniultimapagina");

            });

            // carico la tabella con l'elenco delle stampe, poi imposto la data e i checkbox
            iwebCaricaElemento("tabellaStampe", false, function () {

                // devo prendere la prima riga della tabella e ottenere iwebCAMPO_dataora
                var dataora = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_dataora");
                if (dataora != "" && dataora.length == 10) {
                    // propongo la data inserita nell'ultima stampa come data di stampa
                    document.getElementById("dataDiStampa").value = convertiData_AMG_in_GMA(dataora);
                } else {
                    // propongo la data di oggi come data di stampa
                    document.getElementById("dataDiStampa").value = ottieniDataDiOggi();
                }

                var iva = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_iva");
                document.getElementById("stampaIva").value = iva;

                // ottengo i checkbox
                if (iwebValutaParametroAjax("tabellaStampe_findfirstvalue_id") != "'0'") {
                    // se ho trovato almeno un record valido
                    var testo_dataora = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_dataora");
                    var cb_stampalogo = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_stampalogo");
                    var cb_stampaprezzi = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_stampaprezzi");
                    var cb_stampacopertina = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_stampacopertina");
                    var cb_stampasuddivisioni = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_stampasuddivisioni");
                    var cb_stampamisure = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_stampamisure");
                    var cb_stampatotalenellesuddivisioni = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_stampatotalenellesuddivisioni");
                    var cb_stampatotalefinale = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_stampatotalefinale");
                    var cb_stampanumeropagina = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_stampanumeropagina");
                    var testo_titolocomputo = iwebValutaParametroAjax("tabellaStampe_findfirstvalue_titolocomputo");

                    document.getElementById("dataDiStampa").value = convertiData_AMG_in_GMA(testo_dataora);
                    document.getElementById("stampaLogo").checked = cb_stampalogo;
                    document.getElementById("stampaPrezzi").checked = cb_stampaprezzi;
                    document.getElementById("stampaCopertina").checked = cb_stampacopertina;
                    document.getElementById("stampaSuddivisioni").checked = cb_stampasuddivisioni;
                    document.getElementById("stampaMisure").checked = cb_stampamisure;
                    document.getElementById("stampaTotaleNelleSuddivisioni").checked = cb_stampatotalenellesuddivisioni;
                    document.getElementById("stampaTotaleFinale").checked = cb_stampatotalefinale;
                    document.getElementById("stampaNumeroPagina").checked = cb_stampanumeropagina;
                    document.getElementById("titoloComputo").value = testo_titolocomputo;
                }

                // adesso che ho in mano l'id del primo elemento della tabella con l'elenco delle stampe, posso caricare la tabella delle suddivisioni
                iwebCaricaElemento("tabellaSuddivisioni");

            });
        }


        // convertiData_AMG_in_GMA("2016-07-21")
        function convertiData_AMG_in_GMA(dataora) {
            if (isNaN(dataora[4])) {
                // trasformo ad esempio 2016-07-21 in 21-07-2016
                var anno = dataora.substr(0, 4);
                var mese = dataora.substr(5, 2);
                var giorno = dataora.substr(8, 2);
                return giorno + "-" + mese + "-" + anno;
            }
            return dataora;
        }
    </script>
</asp:Content>

