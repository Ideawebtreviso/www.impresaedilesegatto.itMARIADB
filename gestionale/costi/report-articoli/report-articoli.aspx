<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" %>

<%--<%@ Register TagPrefix="reportArticoli" TagName="tabellaCantiere" Src="_report_articoli_tabella_cantiere.ascx" %>--%>
<%@ Register TagPrefix="reportArticoli" TagName="tabellaReportArticoli" Src="_report_articoli_tabella_report_cantiere.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">

    <div class="TitoloPagina">
        Report articoli
    </div><br />

    <div class="width1560">
        <reportArticoli:tabellaReportArticoli runat="server" ID="reportArticoli_tabellaReportArticoli" />
    </div>

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaReportArticoli");
        }
    </script>
</asp:Content>

