<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Alta.aspx.cs" Inherits="TiendaOnline.Alta" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Alta de productos</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Alta de productos</h2>
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
                        <asp:RequiredFieldValidator ID="rfvCategoria" runat="server" ControlToValidate="ddlCategoria"
                            InitialValue="" ErrorMessage="Seleccione una categoría." Display="Dynamic" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar" OnClick="btnConfirmar_Click" />
                    </td>
                </tr>
            </table>
            <p>
                <asp:Label ID="lblMensaje" runat="server" />
            </p>
            <p>
                <asp:HyperLink ID="lnkInicio" runat="server" NavigateUrl="~/Default.aspx" Text="Volver a la página principal" />
            </p>
        </div>

        <asp:SqlDataSource ID="dsCategorias" runat="server"
            ConnectionString="<%$ ConnectionStrings:TiendaOnline %>"
            SelectCommand="SELECT idCategoria, [descripción] FROM [categorías] ORDER BY [descripción]" />

        <asp:SqlDataSource ID="dsAlta" runat="server"
            ConnectionString="<%$ ConnectionStrings:TiendaOnline %>"
            InsertCommand="INSERT INTO productos (nombre, precio, [categoría]) VALUES (@nombre, @precio, @categoria)"
            OnInserting="dsAlta_Inserting">
            <InsertParameters>
                <asp:Parameter Name="nombre" Type="String" />
                <asp:Parameter Name="precio" Type="Decimal" />
                <asp:Parameter Name="categoria" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
