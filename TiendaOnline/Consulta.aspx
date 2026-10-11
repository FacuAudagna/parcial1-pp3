<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Consulta.aspx.cs" Inherits="TiendaOnline.Consulta" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Consulta de productos</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Consulta de productos</h2>
            <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" DataSourceID="dsConsulta" DataKeyNames="idProducto">
                <Columns>
                    <asp:BoundField DataField="idProducto" HeaderText="idProducto" />
                    <asp:BoundField DataField="nombre" HeaderText="nombre" />
                    <asp:BoundField DataField="precio" HeaderText="precio" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="descripción" HeaderText="descripción" />
                </Columns>
            </asp:GridView>
            <p>
                <asp:HyperLink ID="lnkInicio" runat="server" NavigateUrl="~/Default.aspx" Text="Volver a la página principal" />
            </p>
        </div>

        <asp:SqlDataSource ID="dsConsulta" runat="server"
            ConnectionString="<%$ ConnectionStrings:TiendaOnline %>"
            SelectCommand="SELECT p.idProducto, p.nombre, p.precio, c.[descripción]
                           FROM productos p
                           INNER JOIN [categorías] c ON p.[categoría] = c.idCategoria
                           ORDER BY p.idProducto" />
    </form>
</body>
</html>
