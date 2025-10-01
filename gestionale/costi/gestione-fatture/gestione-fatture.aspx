<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="gestione-fatture.aspx.cs" Inherits="gestionale_costi_gestione_fatture_gestione_fatture" %>

<%@ Register TagPrefix="gestioneFatture" TagName="tabellaFatture" Src="_gestione_fatture_tabella_fatture.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="gestione-fatture2.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Elenco fatture
    </div>

    <gestioneFatture:tabellaFatture runat="server" ID="gestioneFatture_tabellaFatture" />

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaFatture");
        }

    </script>
</asp:Content>

