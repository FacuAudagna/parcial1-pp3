<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TiendaOnline.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Tienda Online</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Tienda Online</h2>
            <p>Indumentaria deportiva</p>
            <p>
                <asp:HyperLink ID="lnkAlta" runat="server" NavigateUrl="~/Alta.aspx" Text="Alta de productos" />
            </p>
            <p>
                <asp:HyperLink ID="lnkBaja" runat="server" NavigateUrl="~/Baja.aspx" Text="Baja de productos" />
            </p>
            <p>
                <asp:HyperLink ID="lnkModificacion" runat="server" NavigateUrl="~/Modificacion.aspx" Text="Modificación de productos" />
            </p>
            <p>
                <asp:HyperLink ID="lnkConsulta" runat="server" NavigateUrl="~/Consulta.aspx" Text="Consulta de productos" />
            </p>
        </div>
    </form>
</body>
</html>
