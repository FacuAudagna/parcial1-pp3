using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TiendaOnline
{
    public partial class Alta : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarCategorias();
        }

        private void CargarCategorias()
        {
            ddlCategoria.Items.Clear();
            ddlCategoria.Items.Add(new ListItem("Seleccione", ""));

            DataView datos = (DataView)dsCategorias.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView fila in datos)
            {
                ddlCategoria.Items.Add(new ListItem(
                    fila["descripción"].ToString(),
                    fila["idCategoria"].ToString()));
            }
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            decimal precio = decimal.Parse(txtPrecio.Text.Trim(), NumberStyles.Number, CultureInfo.CurrentCulture);

            dsAlta.InsertParameters["nombre"].DefaultValue = txtNombre.Text.Trim();
            dsAlta.InsertParameters["precio"].DefaultValue = precio.ToString(CultureInfo.CurrentCulture);
            dsAlta.InsertParameters["categoria"].DefaultValue = ddlCategoria.SelectedValue;
            dsAlta.Insert();

            txtNombre.Text = "";
            txtPrecio.Text = "";
            ddlCategoria.SelectedIndex = 0;
            lblMensaje.Text = "El producto se guardó.";
        }

        protected void dsAlta_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            decimal precio = decimal.Parse(txtPrecio.Text.Trim(), NumberStyles.Number, CultureInfo.CurrentCulture);
            e.Command.Parameters["@nombre"].Value = txtNombre.Text.Trim();
            e.Command.Parameters["@precio"].Value = precio;
            e.Command.Parameters["@categoria"].Value = int.Parse(ddlCategoria.SelectedValue);
        }
    }
}
