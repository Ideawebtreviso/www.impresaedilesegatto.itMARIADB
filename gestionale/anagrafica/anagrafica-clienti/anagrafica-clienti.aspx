<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="anagrafica-clienti.aspx.cs" Inherits="gestionale_anagrafica_anagrafica_clienti_anagrafica_clienti" %>

<%@ Register TagPrefix="anagraficaClienti" TagName="tabellaClienti" Src="_anagrafica-clienti-tabella-clienti.ascx" %>
<%@ Register TagPrefix="anagraficaClienti" TagName="dettaglioCliente" Src="_anagrafica-clienti-dettaglio-cliente.ascx" %>
<%@ Register TagPrefix="anagraficaClienti" TagName="tabellaComputi" Src="_anagrafica-clienti-tabella-computi.ascx" %>
<%@ Register TagPrefix="anagraficaClienti" TagName="tabellaCantieri" Src="_anagrafica-clienti-tabella-cantieri.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="anagrafica-clienti.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Anagrafica clienti
    </div>

    <anagraficaClienti:tabellaClienti runat="server" ID="anagraficaClienti_tabellaClienti" />


    <div id="elementoConITab" class="iwebTABPADRE width610 r">
        <div class="headerTab"></div>
        <div class="corpoTab">
            <%-- tab 1 --%>
            <div class="iwebTABFIGLIO Tab_1 selectedTab iwebBIND__dettaglioAnagrafica iwebTABNOMEHEAD_Cliente">
                <anagraficaClienti:dettaglioCliente runat="server" ID="anagraficaClienti_elementoConITab" />
            </div>

            <%-- tab 2 --%>
            <div class="iwebTABFIGLIO Tab_2 iwebTABNOMEHEAD_Computi iwebBIND__tabellaComputi">
                <anagraficaClienti:tabellaComputi runat="server" ID="anagraficaClienti_tabellaComputi" />
            </div>

            <%-- tab 3 --%>
            <div class="iwebTABFIGLIO Tab_3 iwebTABNOMEHEAD_Cantieri iwebBIND__tabellaCantieri">
                <anagraficaClienti:tabellaCantieri runat="server" ID="TabellaComputi1" />
            </div>
        </div>
    </div>

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaClienti");
            iwebBind("tabellaClienti");

            iwebCaricaElemento("ddlFiltroClientiCitta");
            iwebCaricaElemento("ddlFiltroClientiProvincia");
        }
    </script>
</asp:Content>

