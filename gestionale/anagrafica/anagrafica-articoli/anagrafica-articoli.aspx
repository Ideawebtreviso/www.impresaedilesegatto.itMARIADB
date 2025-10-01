<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="anagrafica-articoli.aspx.cs" Inherits="gestionale_anagrafica_anagrafica_articoli_anagrafica_articoli" %>

<%@ Register TagPrefix="anagraficaArticoli" TagName="tabellaProdotti" Src="_anagrafica_articoli_tabella-prodotti.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Anagrafica articoli
    </div>

    <anagraficaArticoli:tabellaProdotti runat="server" ID="anagraficaClienti_tabellaClienti" />

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaProdotti");
            iwebCaricaElemento("ddlFiltroTabellaProdottiUnitaDiMisura");
        }
    </script>
</asp:Content>

