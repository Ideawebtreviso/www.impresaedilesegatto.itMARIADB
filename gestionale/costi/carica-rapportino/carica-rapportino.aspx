<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="carica-rapportino.aspx.cs" Inherits="gestionale_costi_carica_rapportino_carica_rapportino" %>

<%@ Register TagPrefix="caricaRapportino" TagName="tabellainserimento" Src="_carica_rapportino_tabella_inserimento.ascx" %>
<%@ Register TagPrefix="caricaRapportino" TagName="tabellaCosti" Src="_carica_rapportino_tabella_costi.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="carica-rapportino.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDMANODOPERA" class="iwebNascosto"><asp:Literal ID="LiteralIDMANODOPERA" runat="server"></asp:Literal></span>

    <div class="TitoloPagina">
        Carica rapportino:
        <span class="iwebLABEL" id="labelRagioneSociale">
            <span><%-- il risultato va qui --%></span>
            <span class="iwebSQLSELECT">
                <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL(@"
                    SELECT IF (codice is null OR codice = '', 
                        CONCAT(descrizione),
                        CONCAT(descrizione, ' (', codice, ') ')
                        ) as VALORE 
                    FROM prodotto 
                    WHERE id = @idmanodopera
                ") %></span>
                <span class="iwebPARAMETRO">@idmanodopera = IDMANODOPERA_value</span>
            </span>
        </span>
    </div>

    <caricaRapportino:tabellainserimento runat="server" ID="caricaRapportino_tabellainserimento" />

    <div class="iwebNascosto">
        <table class="tabellaDaA">
            <tr>
                <td>
                    Da:
                    <asp:TextBox ID="TextBoxDataDa" runat="server" ClientIDMode="Static" 
                        placeholder="dataDa" class="iwebTIPOCAMPO_date" 
                        onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" 
                    ></asp:TextBox>
                </td>
                <td>
                    A:
                    <asp:TextBox ID="TextBoxDataA" runat="server" ClientIDMode="Static" 
                        placeholder="dataA" class="iwebTIPOCAMPO_date" 
                        onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" 
                    ></asp:TextBox>
                </td>
                <td> <%--<asp:Button runat="server" ID="ButtonFiltra" Text="Filtra" CssClass="btn btn-default iwebCliccabile" OnCommand="ButtonFiltra_Command" />--%>
                    <%--(tabella ajax)<div class="btn btn-default iwebCliccabile" onclick="iwebQuadro_Carica('quadroRapportini');">filtra</div>--%>
                </td>
            </tr>
        </table>
    </div>

    <caricaRapportino:tabellaCosti runat="server" ID="caricaRapportino_tabellaCosti" />

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaCosti");
            iwebCaricaElemento("labelRagioneSociale");
            iwebCaricaElemento("labelPrezzo");

            // IL CODICE QUA SOTTO FA SI CHE PREMENDO TAB ALL'INTERNO DI INSERISCI NUOVA VOCE, GLI ELEMENTI SI ALTERNINO DAL PRIMO ALL'ULTIMO E SUBITO DOPO DI NUOVO IL PRIMO A ROTAZIONE
            // funzione che mi ritorna tutti gli elementi con tabIndex == 1
            var allElements = document.getElementsByTagName("*");
            var iwebTABINDEX_gruppo1 = Array.prototype.slice.call(allElements, 0);
            iwebTABINDEX_gruppo1 = iwebTABINDEX_gruppo1.map(function (o) {
                return o.tabIndex === 1 ? o : null;
            }).filter(function (o) {
                return o != null
            });

            // funzione che: al tab dell'ultimo elemento con tabindex = 1, mi riporta al secondo elemento con tabindex = 1
            addEvent(iwebTABINDEX_gruppo1[iwebTABINDEX_gruppo1.length - 1],
                'keydown',
                function (event) { if (event.which == 9 || event.keyCode == 9) iwebTABINDEX_gruppo1[0].focus() }
            );

        }

        // esempio: addEvent( document.getElementById('myElement'), 'click', function () { alert('hi!'); } );
        function addEvent(element, evnt, funct) {
            if (element.attachEvent)
                return element.attachEvent('on' + evnt, funct);
            else
                return element.addEventListener(evnt, funct, false);
        }

    </script>

</asp:Content>

