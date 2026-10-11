<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Baja.aspx.cs" Inherits="TiendaOnline.Baja" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Baja de productos</title>
    <script type="text/javascript">
        function confirmarBaja() {
            var checks = document.querySelectorAll("input[type='checkbox']");
            var hay = false;
            for (var i = 0; i < checks.length; i++) {
                if (checks[i].checked) {
                    hay = true;
                    break;
                }
            }
            if (!hay) {
                alert("Seleccione al menos un producto.");
                return false;
            }
            return confirm("¿Confirma que desea eliminar los productos seleccionados?");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Baja de productos</h2>
            <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False"
                DataKeyNames="idProducto" DataSourceID="dsBaja" EmptyDataText="No hay productos.">
                <Columns>
                    <asp:TemplateField HeaderText="Seleccionar">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkSeleccionar" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="idProducto" HeaderText="idProducto" />
                    <asp:BoundField DataField="nombre" HeaderText="nombre" />
                    <asp:BoundField DataField="precio" HeaderText="precio" DataFormatString="{0:N2}" />
                </Columns>
            </asp:GridView>
            <p>
                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" OnClick="btnEliminar_Click"
                    OnClientClick="return confirmarBaja();" />
            </p>
            <p>
                <asp:Label ID="lblMensaje" runat="server" />
            </p>
            <p>
                <asp:HyperLink ID="lnkInicio" runat="server" NavigateUrl="~/Default.aspx" Text="Volver a la página principal" />
            </p>
        </div>

        <asp:SqlDataSource ID="dsBaja" runat="server"
            ConnectionString="<%$ ConnectionStrings:TiendaOnline %>"
            SelectCommand="SELECT idProducto, nombre, precio FROM productos ORDER BY idProducto"
            DeleteCommand="DELETE FROM productos WHERE idProducto = @idProducto">
            <DeleteParameters>
                <asp:Parameter Name="idProducto" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
