<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="gestione-bolle.aspx.cs" Inherits="gestionale_costi_gestione_bolle_gestione_bolle" %>

<%@ Register TagPrefix="gestioneBolle" TagName="tabellaBolle" Src="_gestione_bolle_tabella_bolle.ascx" %>
<%@ Register TagPrefix="gestioneBolle" TagName="dettaglioBolle" Src="_gestione_bolle_dettaglio_bolle.ascx" %>
<%@ Register TagPrefix="gestioneBolle" TagName="tabellaCosti" Src="_gestione_bolle_tabella_costi.ascx" %>
<%@ Register TagPrefix="gestioneBolle" TagName="tabellaCantieri" Src="_gestione_bolle_tabella_cantieri.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="gestione-bolle2.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Gestione bolle
    </div>

    <gestioneBolle:tabellaBolle runat="server" ID="gestioneBolle_tabellaBolle" />

    <%-- elemento con i tab a destra --%>
    <div id="elementoConITab" class="iwebTABPADRE width610 r">
        <div class="headerTab"></div>
        <div class="corpoTab">
            <%-- tab 1 --%>
            <div class="iwebTABFIGLIO Tab_1 selectedTab iwebBIND__dettaglioAnagrafica iwebTABNOMEHEAD_Bolla">
                <gestioneBolle:dettaglioBolle runat="server" ID="gestioneBolle_dettaglioBolle" />
            </div>

            <%-- tab 2 --%>
            <div class="iwebTABFIGLIO Tab_2 iwebBIND__tabellaCosti iwebTABNOMEHEAD_Righe_bolla">
                <gestioneBolle:tabellaCosti runat="server" ID="gestioneBolle_tabellaCosti" />
            </div>

            <%-- tab 3 --%>
            <div class="iwebTABFIGLIO Tab_3 iwebBIND__tabellaCantieri iwebTABNOMEHEAD_Cantieri">
                <gestioneBolle:tabellaCantieri runat="server" ID="gestioneBolle_tabellaCantieri" />
            </div>
        </div>
    </div><%-- fine elemento con i tab --%>


    <script>
        function pageload() {
            iwebCaricaElemento("tabellaBolle");
            iwebCaricaElemento("elementoConITab");
        }
    </script>
</asp:Content>

