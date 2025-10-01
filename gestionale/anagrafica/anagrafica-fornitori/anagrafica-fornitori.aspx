<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="anagrafica-fornitori.aspx.cs" Inherits="gestionale_anagrafica_anagrafica_fornitori_anagrafica_fornitori" %>

<%@ Register TagPrefix="anagraficaFornitori" TagName="tabellaFornitori" Src="_anagrafica-fornitori-tabella-fornitori.ascx" %>
<%@ Register TagPrefix="anagraficaFornitori" TagName="dettaglioFornitori" Src="_anagrafica-fornitori-dettaglio-fornitori.ascx" %>
<%@ Register TagPrefix="anagraficaFornitori" TagName="tabellaProdotti" Src="_anagrafica-fornitori-tabella-prodotti.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Anagrafica fornitori
    </div>

    <anagraficaFornitori:tabellaFornitori runat="server" ID="anagraficaClienti_tabellaFornitori" />

    <%-- elemento con i tab a destra --%>
    <div id="elementoConITab" class="iwebTABPADRE width610 r">
        <div class="headerTab"></div>
        <div class="corpoTab">
            <%-- tab 1 --%>
            <div class="iwebTABFIGLIO Tab_1 selectedTab iwebBIND__dettaglioAnagrafica iwebTABNOMEHEAD_Fornitore">
                <anagraficaFornitori:dettaglioFornitori runat="server" ID="anagraficaClienti_dettaglioFornitori" />
            </div>

            <div class="iwebTABFIGLIO Tab_2 iwebBIND__tabellaProdotti iwebTABNOMEHEAD_Prodotti">
                <anagraficaFornitori:tabellaProdotti runat="server" ID="anagraficaFornitori_tabellaProdotti" />
            </div>

        </div><%-- fine corpotab --%>
    </div><%-- fine elemento con i tab --%>

    <script>

        function pageload() {
            iwebCaricaElemento("tabellaFornitori");
            iwebCaricaElemento("elementoConITab");
        }
    </script>
</asp:Content>

