<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="elenco-cantieri.aspx.cs" Inherits="gestionale_costi_elenco_cantieri_elenco_cantieri" %>

<%@ Register TagPrefix="elencoCantieri" TagName="tabellaCantieri" Src="_elenco_cantieri_tabella_cantieri.ascx" %>
<%@ Register TagPrefix="elencoCantieri" TagName="dettaglioCantieri" Src="_elenco_cantieri_dettaglio_cantieri.ascx" %>
<%@ Register TagPrefix="elencoCantieri" TagName="tabellaBolle" Src="_elenco_cantieri_tabella_bolle.ascx" %>
<%@ Register TagPrefix="elencoCantieri" TagName="tabellaFatture" Src="_elenco_cantieri_tabella_fatture.ascx" %>
<%@ Register TagPrefix="elencoCantieri" TagName="tabellaCosti" Src="_elenco_cantieri_tabella_costi.ascx" %>
<%@ Register TagPrefix="elencoCantieri" TagName="tabellaCostiServizi" Src="_elenco_cantieri_tabella_costi_servizi.ascx" %>
<%@ Register TagPrefix="elencoCantieri" TagName="tabellaCostiLavorazioni" Src="_elenco_cantieri_tabella_costi_lavorazioni.ascx" %>
<%@ Register TagPrefix="elencoCantieri" TagName="tabellaRapportini" Src="_elenco_cantieri_tabella_rapportini.ascx" %>
<%@ Register TagPrefix="elencoCantieri" TagName="tabellaBolleAperte" Src="_elenco_cantieri_tabella_bolle_aperte.ascx" %>
<%@ Register TagPrefix="elencoCantieri" TagName="tabellaProfessionisti" Src="_elenco_cantieri_tabella_professionisti.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="elenco-cantieri.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDFORNITORESEGATTOMANODOPERA" class="iwebNascosto"><asp:Literal ID="LabelIDFORNITORESEGATTOMANODOPERA" runat="server"></asp:Literal></span>
    <span id="IDFORNITORECOSTIGENERICI" class="iwebNascosto"><asp:Literal ID="LabelIDFORNITORECOSTIGENERICI" runat="server"></asp:Literal></span>

    <div class="TitoloPagina">
        Elenco cantieri
    </div>

    <div class="iwebTABELLAWrapper l" style="width:975px">
        <elencoCantieri:tabellaCantieri runat="server" ID="controlloFattura_tabellaCantieri" />
    </div>

    <%-- elemento con i tab a destra --%>
    <div id="elementoConITab" class="iwebTABPADRE r" style="width:560px">
        <div class="headerTab"></div>
        <div class="corpoTab">
            <%-- tab 1 --%>
            <div class="iwebTABFIGLIO Tab_1 selectedTab iwebBIND__dettaglioAnagrafica iwebTABNOMEHEAD_Cantiere">
                <elencoCantieri:dettaglioCantieri runat="server" ID="elencoCantieri_dettaglioCantieri" />
            </div>

            <%-- tab 2 --%>
            <div class="iwebTABFIGLIO Tab_2 iwebTABNOMEHEAD_Fatture_dirette iwebBIND__tabellaBolle">
                <elencoCantieri:tabellaBolle runat="server" ID="elencoCantieri_tabellaBolle" />
            </div>

            <%-- tab 3 --%>
            <div class="iwebTABFIGLIO Tab_3 iwebTABNOMEHEAD_Bolle_aperte iwebBIND__tabellaBolleAperte">
                <elencoCantieri:tabellaBolleAperte runat="server" ID="elencoCantieri_tabellaBolleAperte" />
            </div>

            <%-- tab 4 --%>
            <div class="iwebTABFIGLIO Tab_4 iwebTABNOMEHEAD_Fatture_controllo iwebBIND__tabellaFatture">
                <elencoCantieri:tabellaFatture runat="server" ID="elencoCantieri_tabellaFatture" />
            </div>

            <%-- tab 5 --%>
            <div class="iwebTABFIGLIO Tab_5 iwebTABNOMEHEAD_Costi_materiali iwebBIND__tabellaCosti">
                <elencoCantieri:tabellaCosti runat="server" ID="elencoCantieri_tabellaCosti" />
            </div>

            <%-- tab 6 --%>
            <div class="iwebTABFIGLIO Tab_6 iwebTABNOMEHEAD_Costi_generali iwebBIND__tabellaCostiServizi">
                <elencoCantieri:tabellaCostiServizi runat="server" ID="elencoCantieri_tabellaCostiServizi" />
            </div>

            <%-- tab 7 --%>
            <div class="iwebTABFIGLIO Tab_7 iwebTABNOMEHEAD_Costi_professionisti iwebBIND__tabellaProfessionisti">
                <elencoCantieri:tabellaProfessionisti runat="server" ID="elencoCantieri_tabellaProfessionisti" />
            </div>

            <%-- tab 8 --%>
            <div class="iwebTABFIGLIO Tab_8 iwebTABNOMEHEAD_Costi_lavorazioni iwebBIND__tabellaCostiLavorazioni">
                <elencoCantieri:tabellaCostiLavorazioni runat="server" ID="elencoCantieri_tabellaCostiLavorazioni" />
            </div>

            <%-- tab 9 --%>
            <div class="iwebTABFIGLIO Tab_9 iwebTABNOMEHEAD_Rapportini iwebBIND__tabellaRapportini">
                <elencoCantieri:tabellaRapportini runat="server" ID="elencoCantieri_tabellaRapportini" />
            </div>

        </div>
    </div>
    <script>
        function pageload() {
            iwebCaricaElemento("tabellaCantieri");
            iwebCaricaElemento("elementoConITab");
        }
    </script>
</asp:Content>

