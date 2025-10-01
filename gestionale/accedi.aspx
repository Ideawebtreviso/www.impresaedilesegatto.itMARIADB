<%@ Page Title="" Language="C#" MasterPageFile="~/gestionale/MasterPage.master" AutoEventWireup="true" CodeFile="accedi.aspx.cs" Inherits="gestionale_accedi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <h3>Accedi all'Area Riservata</h3>
    <table>
        <tr>
            <td>E-mail:</td>
            <td>
                <asp:TextBox ID="UserEmail" runat="server" /></td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                    ControlToValidate="UserEmail"
                    Display="Dynamic"
                    ErrorMessage="Inserire la propria email."
                    runat="server" />
            </td>
        </tr>
        <tr>
            <td>Password:</td>
            <td>
                <asp:TextBox ID="UserPass" TextMode="Password" Text=""
                    runat="server" />
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                    ControlToValidate="UserPass"
                    ErrorMessage="Inserire la password."
                    runat="server" />
            </td>
        </tr>
        <tr>
            <td>Ricordami su questo computer</td>
            <td>
                <asp:CheckBox ID="Persist" runat="server" /></td>
        </tr>
    </table>
    <asp:Button ID="Submit1" OnClick="Logon_Click" Text="Accedi" runat="server" />
    <p>
        <asp:Label ID="Msg" ForeColor="red" runat="server" />
    </p>
</asp:Content>

