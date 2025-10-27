<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="gestione-computo.aspx.cs" Inherits="gestionale_computi_gestione_computo_gestione_computo" %>

<%@ Register TagPrefix="_C0001PopupTemplateVoce" TagName="_C0001PopupTemplateVoce" Src="~/gestionale/_common/_C0001PopupTemplateVoce.ascx" %>

<%@ Register TagPrefix="gestioneComputo" TagName="tabellaComputi" Src="_gestione_computo_tabella_computi.ascx" %>
<%@ Register TagPrefix="gestioneComputo" TagName="tabellaVoci" Src="_gestione_computo_tabella_voci.ascx" %>
<%@ Register TagPrefix="gestioneComputo" TagName="dettaglioVoci" Src="_gestione_computo_dettaglio_voci.ascx" %>
<%@ Register TagPrefix="gestioneComputo" TagName="tabellaMisure" Src="_gestione_computo_tabella_misure.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="gestione-computo7.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDCOMPUTO" class="iwebNascosto"><asp:Literal ID="LiteralIDCOMPUTO" runat="server"></asp:Literal></span>
    <%--<span id="IDCLIENTE"><asp:Literal ID="LiteralIDCLIENTE" runat="server"></asp:Literal></span>--%>

    <%-- _C0001PopupTemplateVoce --%>
    <_C0001PopupTemplateVoce:_C0001PopupTemplateVoce runat="server" />

    <gestioneComputo:tabellaComputi runat="server" ID="gestioneComputo_tabellaComputi" />

    <div class="TitoloPagina">
        <br /> <br /> <br /> Voci e Misure
    </div>

    <gestioneComputo:tabellaVoci runat="server" ID="gestioneComputo_tabellaVoci" />
    
    <%-- elemento con i tab a destra --%>
    <div id="elementoConITab" class="width730 iwebTABPADRE r">
        <div class="headerTab"></div>
        <div class="corpoTab">
            <%-- tab 1 --%>
            <div class="iwebTABFIGLIO Tab_1 selectedTab iwebBIND__dettaglioAnagrafica iwebTABNOMEHEAD_Voce">
                <gestioneComputo:dettaglioVoci runat="server" ID="gestioneComputo_dettaglioVoci" />
            </div>

            <%-- tab 2 --%>
            <div class="iwebTABFIGLIO Tab_2 iwebBIND__tabellaMisure iwebTABNOMEHEAD_Misura">
                <gestioneComputo:tabellaMisure runat="server" ID="gestioneComputo_tabellaMisure" />
            </div><%-- fine tab 2 --%>

            <%--<div class="iwebTABFIGLIO Tab_3 iwebBIND__tabellaMisure iwebTABNOMEHEAD_Misura">
            </div><%-- fine tab 3 --%>

        </div>
    </div>

    <script>
        function pageload() {
            iwebCaricaElemento("tabellaComputi");
            iwebCaricaElemento("tabellaVoci");

            iwebCaricaElemento("ddlFiltroGenericoSuddivisioni");

            iwebCaricaElemento("elementoConITab");

            //iwebDDLSelezionaValore("tabellaVociDDLSuddivisioni", "Tutti");
            // carico il filtro ddl suddivisioni della tabella voci
            iwebCaricaElemento("tabellaVociDDLSuddivisioni");

            // IL CODICE QUA SOTTO FA SI CHE PREMENDO TAB ALL'INTERNO DI INSERISCI NUOVA VOCE, GLI ELEMENTI SI ALTERNINO DAL PRIMO ALL'ULTIMO E SUBITO DOPO DI NUOVO IL PRIMO A ROTAZIONE
            // funzione che mi ritorna tutti gli elementi con tabIndex == 1
            var allElements = document.getElementsByTagName("*");
            var iwebTABINDEX_gruppo1 = Array.prototype.slice.call(allElements, 0);
            iwebTABINDEX_gruppo1 = iwebTABINDEX_gruppo1.map(function (o) {
                    return o.tabIndex === 1 ? o : null;
                }).filter(function (o) {
                    return o != null
                });

            // funzione che: al tab dell'ultimo elemento con tabindex = 1, mi riporta al secondo elemento con tabindex = 1
            addEvent(iwebTABINDEX_gruppo1[iwebTABINDEX_gruppo1.length - 1],
                'keydown',
                function (event) { if (event.which == 9 || event.keyCode == 9) iwebTABINDEX_gruppo1[0].focus() }
            );

            // IL CODICE QUA SOTTO FA SI CHE PREMENDO TAB ALL'INTERNO DI INSERISCI NUOVA MISURA, GLI ELEMENTI SI ALTERNINO DAL PRIMO ALL'ULTIMO E SUBITO DOPO DI NUOVO IL PRIMO A ROTAZIONE
            // funzione che mi ritorna tutti gli elementi con tabIndex == 1
            //var allElements = document.getElementsByTagName("*");
            var iwebTABINDEX_gruppo2 = Array.prototype.slice.call(allElements, 0);
            iwebTABINDEX_gruppo2 = iwebTABINDEX_gruppo2.map(function (o) {
                return o.tabIndex === 2 ? o : null;
            }).filter(function (o) {
                return o != null
            });

            // funzione che: al tab dell'ultimo elemento con tabindex = 1, mi riporta al secondo elemento con tabindex = 1
            addEvent(iwebTABINDEX_gruppo2[iwebTABINDEX_gruppo2.length - 1],
                'keydown',
                function (event) { if (event.which == 9 || event.keyCode == 9) iwebTABINDEX_gruppo2[0].focus() }
            );
        }

        // esempio: addEvent( document.getElementById('myElement'), 'click', function () { alert('hi!'); } );
        function addEvent(element, evnt, funct) {
            if (element.attachEvent)
                return element.attachEvent('on' + evnt, funct);
            else
                return element.addEventListener(evnt, funct, false);
        }

    </script>
</asp:Content>
