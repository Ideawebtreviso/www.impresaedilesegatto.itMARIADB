<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="gerarchia-computo.aspx.cs" Inherits="gestionale_computi_gerarchia_computo_gerarchia_computo" %>

<%--<%@ Register TagPrefix="gerarchiaComputo" TagName="gerarchiaComputo" Src="_gerarchia-computo-gerarchia-computo.ascx" %>--%>
<%@ Register TagPrefix="gerarchiaComputo" TagName="tabellaVoci" Src="_gerarchia_computo_tabella_voci.ascx" %>
<%@ Register TagPrefix="gerarchiaComputo" TagName="modificaSuddivisione" Src="_gerarchia_computo_tabella_suddivisioni.ascx" %>
<%@ Register TagPrefix="gerarchiaComputo" TagName="eliminaSuddivisione" Src="_gerarchia_computo_elimina_suddivisione.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="gerarchia-computo2.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDCOMPUTO" class="iwebNascosto"><asp:Literal ID="LiteralIDCOMPUTO" runat="server"></asp:Literal></span>
    <div class="TitoloPagina">
        Gerarchia computo
    </div>

    <%-- qui verrà generato il div gerarchia --%>
    <div id="rootDivGerarchia"></div>

    <%-- link per tornare indietro --%>
    <a class='glyphicon glyphicon-arrow-left' style='text-decoration:none' href='../elenco-computi/elenco-computi.aspx'></a> Vai a elenco-computi <br /><br />

    <%-- popup: modifica suddivisione --%>
    <gerarchiaComputo:modificaSuddivisione runat="server" ID="gerarchiaComputo_modificaSuddivisione" />

    <%-- popup: elimina suddivisione --%>
    <gerarchiaComputo:eliminaSuddivisione runat="server" ID="gerarchiaComputo_eliminaSuddivisione" />

    <%-- popup: voci associate --%>
    <gerarchiaComputo:tabellaVoci runat="server" ID="gerarchiaComputo_gerarchiaComputo" />

    <script>
        function pageload() {
            var idComputo = document.getElementById("IDCOMPUTO").innerHTML;

            if (idComputo > 0)
                // genera il codice
                generaGerarchiaComputo(idComputo);
            else {
                document.getElementById("rootDivGerarchia").style.padding = "10px 15px"
                document.getElementById("rootDivGerarchia").innerHTML = "Computo non trovato";
            }
        }
    </script>
</asp:Content>
