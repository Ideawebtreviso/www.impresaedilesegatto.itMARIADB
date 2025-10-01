<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="elenco-computi.aspx.cs" Inherits="gestionale_computi_elenco_computi_elenco_computi" %>

<%@ Register TagPrefix="elencoComputi" TagName="tabellaFornitori" Src="_elenco-computi-tabella-computi.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="elenco-computi2.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Elenco computi
    </div>

    <elencoComputi:tabellaFornitori runat="server" ID="elencoComputi_tabellaFornitori" />

    <script>
        function pageload() {
            iwebImpostaCampi("tabellaComputi")
            iwebCaricaElemento("tabellaComputi");
            iwebBind("tabellaComputi");

            //iwebCaricaElemento("ddlFiltroClientiCitta");
            //iwebCaricaElemento("ddlFiltroClientiProvincia");
        }
    </script>

</asp:Content>
