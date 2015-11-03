<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="InstaPhotos.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>Instagram Authentication App</h1>
        <asp:Button ID="btnLogin" runat="server" Text="Login With Instagram" OnClick="btnLogin_Click" />
    </div>
    </form>
</body>
</html>
