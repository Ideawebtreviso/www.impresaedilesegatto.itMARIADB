<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="report-cantiere.aspx.cs" Inherits="gestionale_costi_report_cantiere_report_cantiere" %>

<%@ Register TagPrefix="reportCantiere" TagName="tabellaCantiere" Src="_report_cantiere_tabella_cantiere.ascx" %>
<%@ Register TagPrefix="reportCantiere" TagName="tabellaReportCantiere" Src="_report_cantiere_tabella_report_cantiere.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDCANTIERE" class="iwebNascosto"><asp:Literal ID="LiteralIDCANTIERE" runat="server"></asp:Literal></span>
    <div class="TitoloPagina">
        Cantiere
    </div><br />

    <reportCantiere:tabellaCantiere runat="server" ID="reportCantiere_tabellaCantieri" />

    <div class="TitoloPagina">
        Report cantiere
    </div><br />

    <div class="width1560">
        <reportCantiere:tabellaReportCantiere runat="server" ID="reportCantiere_tabellaReportCantiere" />
    </div>

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaReportCantiere");
            iwebCaricaElemento("tabellaCantiere");
        }
    </script>
</asp:Content>

