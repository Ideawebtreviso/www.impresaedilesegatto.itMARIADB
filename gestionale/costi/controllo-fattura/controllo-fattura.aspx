<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="controllo-fattura.aspx.cs" Inherits="gestionale_costi_controllo_fattura_controllo_fattura" %>

<%@ Register TagPrefix="controlloFattura" TagName="tabellaFatture" Src="_controllo_fattura_tabella_fatture.ascx" %>
<%@ Register TagPrefix="controlloFattura" TagName="tabellaBolleAperte" Src="_controllo_fattura_tabella_bolle_aperte.ascx" %>
<%@ Register TagPrefix="controlloFattura" TagName="tabellaRigheAperte" Src="_controllo_fattura_tabella_righe_aperte.ascx" %>
<%@ Register TagPrefix="controlloFattura" TagName="tabellaRigheChiuse" Src="_controllo_fattura_tabella_righe_chiuse.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="controllo-fattura.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <span id="IDFATTURA" class="iwebNascosto"><asp:Literal ID="LiteralIDFATTURA" runat="server"></asp:Literal></span>

    <div class="TitoloPagina">
        Controllo fattura
    </div><br />

    <controlloFattura:tabellaFatture runat="server" ID="controlloFattura_tabellaFatture" />

    <div class="TitoloPagina">
        Bolle
    </div>

    <controlloFattura:tabellaBolleAperte runat="server" ID="controlloFattura_tabellaBolleAperte" />

    <%-- elemento con i tab a destra --%>
    <div class="width610 r">
        <div id="elementoConITab" class="iwebTABPADRE">
            <div class="headerTab"></div>
            <div class="corpoTab">
                <%-- tab 1 --%>
                <div class="iwebTABFIGLIO Tab_1 selectedTab iwebBIND__tabellaRigheAperte iwebTABNOMEHEAD_Righe_aperte">
                    <controlloFattura:tabellaRigheAperte runat="server" ID="controlloFattura_tabellaRigheAperte" />
                </div>

                <%-- tab 2 --%>
                <div class="iwebTABFIGLIO Tab_2 iwebBIND__tabellaRigheChiuse iwebTABNOMEHEAD_Righe_chiuse">
                    <controlloFattura:tabellaRigheChiuse runat="server" ID="controlloFattura_tabellaRigheChiuse" />
                </div>
            </div>
        </div>
    </div>
    <script>
        function pageload() {
            //iwebCaricaElemento("tabellaFatture");
            //iwebCaricaElemento("tabellaBolleAperte");
            controlloFattura_iwebTABELLA_Carica("tabellaFatture", 0, true);

            iwebCaricaElemento("elementoConITab");
            // IL CODICE QUA SOTTO FA SI CHE GLI ELEMENTI CON TABINDEX=1 SI ALTERNINO DAL PRIMO ALL'ULTIMO E SUBITO DOPO DI NUOVO IL PRIMO A ROTAZIONE
            // funzione che mi ritorna tutti gli elementi con tabIndex == 1
            var allElements = document.getElementsByTagName("*");
            var iwebTABINDEX_gruppo1 = Array.prototype.slice.call(allElements, 0);
            iwebTABINDEX_gruppo1 = iwebTABINDEX_gruppo1.map(function (o) {
                if (o.tabIndex == 0) o.tabIndex = -1;
            })

            // funzione che: al tab dell'ultimo elemento con tabindex = 1, mi riporta al primo elemento con tabindex = 1
           /* addEvent(iwebTABINDEX_gruppo1[iwebTABINDEX_gruppo1.length - 1],
                'keydown',
                function (event) { if (event.which == 9 || event.keyCode == 9) setTimeout(function () { iwebTABINDEX_gruppo1[0].focus() }, 10) }
            );*/
        }
        /*
        
        // esempio: addEvent( document.getElementById('myElement'), 'click', function () { alert('hi!'); } );
        function addEvent(element, evnt, funct) {
            if (element.attachEvent)
                return element.attachEvent('on' + evnt, funct);
            else
                return element.addEventListener(evnt, funct, false);
        }*/

    </script>
</asp:Content>

