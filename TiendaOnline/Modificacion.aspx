<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Modificacion.aspx.cs" Inherits="TiendaOnline.Modificacion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Modificación de productos</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Modificación de productos</h2>
            <p>
                Producto
                <asp:DropDownList ID="ddlProducto" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" />
            </p>
            <table>
                <tr>
                    <td>Nombre</td>
                    <td>
                        <asp:TextBox ID="txtNombre" runat="server" MaxLength="100" />
                        <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                            ErrorMessage="Ingrese el nombre." Display="Dynamic" />
                    </td>
                </tr>
                <tr>
                    <td>Precio</td>
                    <td>
                        <asp:TextBox ID="txtPrecio" runat="server" MaxLength="12" />
                        <asp:RequiredFieldValidator ID="rfvPrecio" runat="server" ControlToValidate="txtPrecio"
                            ErrorMessage="Ingrese el precio." Display="Dynamic" />
                        <asp:CompareValidator ID="cvPrecio" runat="server" ControlToValidate="txtPrecio"
                            Operator="GreaterThan" ValueToCompare="0" Type="Double"
                            ErrorMessage="El precio tiene que ser mayor a cero." Display="Dynamic" />
                    </td>
                </tr>
                <tr>
                    <td>Categoría</td>
                    <td>
                        <asp:DropDownList ID="ddlCategoria" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" />
                    </td>
                </tr>
            </table>
            <p>
                <asp:Label ID="lblMensaje" runat="server" />
            </p>
            <p>
                <asp:HyperLink ID="lnkInicio" runat="server" NavigateUrl="~/Default.aspx" Text="Volver a la página principal" />
            </p>

            <asp:HiddenField ID="hfNombre" runat="server" />
            <asp:HiddenField ID="hfPrecio" runat="server" />
            <asp:HiddenField ID="hfCategoria" runat="server" />
        </div>

        <asp:SqlDataSource ID="dsProductos" runat="server"
            ConnectionString="<%$ ConnectionStrings:TiendaOnline %>"
            SelectCommand="SELECT idProducto, CAST(idProducto AS varchar(10)) + ' - ' + nombre AS texto
                           FROM productos
                           ORDER BY idProducto" />

        <asp:SqlDataSource ID="dsCategorias" runat="server"
            ConnectionString="<%$ ConnectionStrings:TiendaOnline %>"
            SelectCommand="SELECT idCategoria, [descripción] FROM [categorías] ORDER BY [descripción]" />

        <asp:SqlDataSource ID="dsDetalle" runat="server"
            ConnectionString="<%$ ConnectionStrings:TiendaOnline %>"
            SelectCommand="SELECT nombre, precio, [categoría] FROM productos WHERE idProducto = @idProducto"
            UpdateCommand="UPDATE productos
                           SET nombre = @nombre, precio = @precio, [categoría] = @categoria
                           WHERE idProducto = @idProducto"
            OnUpdating="dsDetalle_Updating">
            <SelectParameters>
                <asp:Parameter Name="idProducto" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombre" Type="String" />
                <asp:Parameter Name="precio" Type="Decimal" />
                <asp:Parameter Name="categoria" Type="Int32" />
                <asp:Parameter Name="idProducto" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
