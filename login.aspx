<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

</head>
    <style type="text/css"> 
        body {
          font-family: Arial, Helvetica, sans-serif;
        }
    </style>
<body>
    <form id="form1" runat="server">
    <div style="padding:30px;">
    <h3>Accedi all'Area Riservata</h3>
    <table>
        <tr>
            <td>E-mail:</td>
            <td>
                <asp:TextBox ID="UserEmail" runat="server" Text="webmaster@impresaedilesegatto.it" /></td>
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
                <asp:TextBox ID="UserPass" TextMode="Password" Text="24680ABC"
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
            <td>Database</td>
            <td>
                <asp:CheckBox ID="CheckBox1" runat="server" /></td>
        </tr>
        <tr>
            <td>Ricordami su questo computer</td>
            <td>
                <asp:RadioButtonList>
                    <asp:ListItem Text="Durigon" Value="Durigon"></asp:ListItem>
                    <asp:ListItem Text="Segatto" Value="Segatto"></asp:ListItem>
                </asp:RadioButtonList>
        </tr>
    </table>
    <asp:Button ID="Submit1" OnClick="Logon_Click" Text="Accedi" runat="server" />
    <p>
        <asp:Label ID="Msg" ForeColor="red" runat="server" />
    </p>
        </div>
    </form>
</body>
</html>
