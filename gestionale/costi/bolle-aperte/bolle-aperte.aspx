<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="bolle-aperte.aspx.cs" Inherits="gestionale_costi_bolle_aperte_bolle_aperte" %>

<%@ Register TagPrefix="costi" TagName="bolleaperte" Src="_costi_bolle_aperte.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Bolle aperte
    </div>

    <costi:bolleaperte runat="server" ID="caricaRapportino_tabellainserimento" />

    <script>
        function pageload() {
            iwebImpostaCampi("tabellaBolleAperte")
            iwebCaricaElemento("tabellaBolleAperte");
        }
    </script>
</asp:Content>

<%-- SELECT costobolla.id as 'costobolla.id', 
       costobolla.idprodotto as 'costobolla.idprodotto', 
       costobolla.idcantiere as 'costobolla.idcantiere', 
       costobolla.datacosto as 'costobolla.datacosto', 
       costobolla.quantita as 'costobolla.quantita', 
       costobolla.prezzo as 'costobolla.prezzo', 
       costobolla.sconto1 as 'costobolla.sconto1', 
       costobolla.sconto2 as 'costobolla.sconto2', 

       fornitore.id as 'fornitore.id', 
       fornitore.ragionesociale as 'fornitore.ragionesociale', 

       bollafattura.databollafattura as 'bollafattura.databollafattura' , 
       bollafattura.numero as 'bollafattura.numero', 

       SUM(costobolla.quantita * (costobolla.prezzo * (100-costobolla.sconto1) * (100-costobolla.sconto2) / 10000)) as 'costobolla.importo' 

FROM bollafattura INNER JOIN fornitore ON bollafattura.idfornitore = fornitore.id
                  INNER JOIN costo as costobolla ON costobolla.idbollafattura = bollafattura.id
                  LEFT JOIN costo as costofattura ON costobolla.id = costofattura.idcostobollariferita
WHERE bollafattura.isfattura = false AND bollafattura.chiusa = 0 AND costofattura.id IS NULL
GROUP BY bollafattura.id
 --%>