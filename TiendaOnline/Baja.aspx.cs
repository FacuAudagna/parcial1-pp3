using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TiendaOnline
{
    public partial class Baja : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            int eliminados = 0;

            foreach (GridViewRow fila in gvProductos.Rows)
            {
                CheckBox chk = (CheckBox)fila.FindControl("chkSeleccionar");
                if (chk == null || !chk.Checked)
                    continue;

                dsBaja.DeleteParameters["idProducto"].DefaultValue = gvProductos.DataKeys[fila.RowIndex].Value.ToString();
                eliminados += dsBaja.Delete();
            }

            if (eliminados == 0)
            {
                lblMensaje.Text = "Seleccione al menos un producto.";
                return;
            }

            lblMensaje.Text = "Se eliminaron " + eliminados + " producto(s).";
            gvProductos.DataBind();
        }
    }
}
