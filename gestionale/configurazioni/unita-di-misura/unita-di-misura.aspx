<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="unita-di-misura.aspx.cs" Inherits="gestionale_configurazioni_unita_di_misura_unita_di_misura" %>

<%@ Register TagPrefix="unitaDiMisura" TagName="tabellaUnitadimisura" Src="_unita_di_misura_tabella_unita_di_misura.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="unita-di-misura.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Anagrafica unita' di misura
    </div>

    <unitaDiMisura:tabellaUnitadimisura runat="server" ID="unitaDiMisura_tabellaUnitadimisura" />

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaUnitadimisura");
        }
    </script>
</asp:Content>


