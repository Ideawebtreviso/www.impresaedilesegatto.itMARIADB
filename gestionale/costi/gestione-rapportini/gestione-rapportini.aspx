<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="gestione-rapportini.aspx.cs" Inherits="gestionale_costi_gestione_rapportini_gestione_rapportini" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="gestione-rapportino.js"></script>
<%--    <style>
        .contenitorePaginaAspx_GestioneRapportini .iwebQuadroHeaderRiga {
            color:red;
            text-align:center;
            min-width:100px;
        }
        .contenitorePaginaAspx_GestioneRapportini .iwebQuadroHeaderColonna {
            text-align:right;
            color:blue;
        }
        .contenitorePaginaAspx_GestioneRapportini .iwebQuadroHeaderCella {
            color:green;
            text-align:center;
        }
    </style>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div class="TitoloPagina">
        Gestione rapportini
    </div><br />

    <div>
        <table class="tabellaDaA">
            <tr>
                <td>
                    Da:
                    <asp:TextBox ID="TextBoxDataDa" runat="server" ClientIDMode="Static" 
                        onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                        placeholder="dataDa" class="iwebTIPOCAMPO_date" 
                        onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" 
                    ></asp:TextBox>
                </td>
                <td>
                    A:
                    <asp:TextBox ID="TextBoxDataA" runat="server" ClientIDMode="Static" 
                        onkeydown="if (event.keyCode == 9) scwHide(this, event)"
                        placeholder="dataA" class="iwebTIPOCAMPO_date" 
                        onfocus="scwLanguage='it';scwShow(this, event);" onclick="scwLanguage = 'it'; scwShow(this, event);" maxlength="10" 
                    ></asp:TextBox>
                </td>
                <td>
                    <asp:Button runat="server" ID="ButtonFiltra" Text="Filtra" CssClass="btn btn-default iwebCliccabile" 
                        OnCommand="ButtonFiltra_Command" />
                    <%--(tabella ajax)<div class="btn btn-default iwebCliccabile" onclick="iwebQuadro_Carica('quadroRapportini');">filtra</div>--%>
                </td>
            </tr>
        </table>
    </div>

    <br />

        <table style="border-collapse:collapse;" class="iwebTABELLA">
            <tr>
                <%-- la PRIMA CELLA in alto a sinistra deve restare vuota --%>
                <th></th>
                <%-- TESTATA: CICLA SU TUTTI I GIORNI--%>
                <asp:Repeater ID="RepeaterGiorniHeader" runat="server" OnPreRender="RepeaterGiorniHeader_PreRender">
                    <ItemTemplate>
                        <th class="repeaterCellaPrimaRiga">
                            <%-- PRIMA RIGA: mostra la DATA --%>
                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "giorno", "{0:ddd dd MMM}")%>'
                                ForeColor='<%# MostraSoloSePrimaRiga() %>' Font-Bold="true" />
                        </th>
                    </ItemTemplate>
                </asp:Repeater>
            </tr>

            <%-- CORPO: CICLA SU TUTTE LE PIZZERIE--%>
            <asp:Repeater ID="Repeater1" runat="server" OnPreRender="Repeater1_PreRender" >
                <ItemTemplate>
                    <tr>
                        <td class="repeaterCellaPrimaColonna">
                            <asp:Label ID="LabelIDProdotto" runat="server" Text='<%# Eval("id") %>' Visible="false" />
                            <asp:Label ID="LabelCodice" runat="server" Text='<%# Eval("descrizione") %>' Visible="true" />

                            <asp:LinkButton ID="LinkButton1" runat="server" 
                                PostBackUrl='<%# "~/gestionale/costi/carica-rapportino/carica-rapportino.aspx?IDMANODOPERA=" + Eval("id") %>'>
                                <div class="btn btn-default iwebCliccabile bottoneCarica">
                                        Carica
                                </div>
                            </asp:LinkButton>

                            <%-- label nascosta da passare al repeater interno --%>
                            <%--<asp:Label ID="LabelIDPizzeria" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                            <asp:Label ID="mostraDa_Repeater2" runat="server" Text='<%# Eval("mostraDa_Repeater1") %>' Visible="false"></asp:Label>
                            <asp:Label ID="mostraA_Repeater2" runat="server" Text='<%# Eval("mostraA_Repeater1") %>' Visible="false"></asp:Label>--%>
                        </td>
                        <%-- CORPO: CICLA SU TUTTI I GIORNI--%>
                        <asp:Repeater ID="Repeater2" runat="server" OnPreRender="Repeater2_PreRender">
                            <ItemTemplate>
                                <td class="repeaterCella">
                                    <asp:Label ID="LabelIDProdotto" CssClass="iwebNascosto" runat="server" OnPreRender="LabelIDProdotto_PreRender" />
                                    <asp:Label ID="LabelGiorno" runat="server" Text='<%# Eval("giorno") %>' Visible="false" />

                                    <%-- mostro i dati nella cella --%>
                                    <asp:Repeater ID="Repeater3" runat="server" OnPreRender="Repeater3_PreRender">
                                        <ItemTemplate>

                                            <asp:Label ID="LabelCodiceCantiere" runat="server" Text='<%# Eval("cantierecodice") %>'
                                                ToolTip='<%# Eval("cantieredescrizione") %>'></asp:Label>:

                                            <asp:Label ID="LabelQuantitaOre" runat="server" Text='<%# Convert.ToDouble(Eval("quantita")) %>'
                                                ToolTip='<%# "costo: " + Eval("prezzo") + " €" %>'
                                                OnPreRender="LabelQuantitaOre_PreRender"></asp:Label>

                                            <asp:Label ID="LabelUnitaDiMisura" runat="server" Text='<%# Eval("unitadimisuracodice") %>'></asp:Label>
                                            <br />

                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <%-- calcolato dal Repeater3_PreRender --%>
                                    <asp:Panel runat="server" class="repeaterCellaPanelTotOre" id="repeaterCellaPanelTotOre" Visible="false">
                                        Totale: <asp:Label ID="LabelTotOre" runat="server"></asp:Label>

                                        <%-- solo queta label è calcolata nel suo prerender --%>
                                        <asp:Label ID="LabelUnitaDiMisuraTotale" runat="server" 
                                            OnPreRender="LabelUnitaDiMisuraTotale_PreRender"></asp:Label>

                                    </asp:Panel>
                                </td>
                            </ItemTemplate>
                        </asp:Repeater>

                    </tr>
                </ItemTemplate>
            </asp:Repeater>

        </table>

    <br/>

    <div class="contenitoreQuadro iwebNascosto">
        <%-- altro.. --%>
        <%-- posso usare iwebTABELLA solo per il css --%>
        <table id="quadroRapportini" class="iwebQUADRO">
            <thead class="iwebNascosto">
                <%-- esempio di riga --%>
                <tr>
                    <td class="iwebQuadroHeaderRiga">@valore
                    </td>
                </tr>

                <%-- esempio di colonna --%>
                <tr>
                    <td class="iwebQuadroHeaderColonna">
                        @valore
                        <div class="btn btn-default iwebCliccabile bottoneCarica">carica</div>
                    </td>
                </tr>

                <%-- esempio di cella generica --%>
                <tr>
                    <td class="iwebQuadroHeaderCella">@valore</td>
                </tr>

                <%-- serve ai calcoli interni del javascript --%>
                <tr>
                    <td>
                        <span><%--listaRighe--%></span>
                        <span><%--listaColonne--%></span>
                    </td>
                </tr>
            </thead>
            <tbody>
                <%-- generato automaticamente --%>
            </tbody>
        </table>
        <span class="iwebSQLQuadroRiga iwebNascosto">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("NON MI SERVE") %></span>
        </span>
        <span class="iwebSQLQuadroColonna iwebNascosto">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("SELECT * FROM prodotto WHERE idfornitore = @idfornitore") %></span>
            <span class="iwebPARAMETRO">@idfornitore = IDFORNITORESEGATTOMANODOPERA_value</span>
        </span>
        <span class="iwebSQLQuadroCella iwebNascosto">
            <span class="iwebSQL"><%= IwebCrypter.iwebcsCriptaSQL("NON MI SERVE") %></span>
        </span>
    </div>

    <script>
        function pageload() {
            //iwebQuadro_Carica("quadroRapportini");
        }
    </script>
</asp:Content>

