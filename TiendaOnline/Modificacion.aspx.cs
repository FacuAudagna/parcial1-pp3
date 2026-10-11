using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TiendaOnline
{
    public partial class Modificacion : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarListas();
                CargarProducto();
            }
        }

        private void CargarListas()
        {
            ddlCategoria.DataSource = dsCategorias.Select(DataSourceSelectArguments.Empty);
            ddlCategoria.DataTextField = "descripción";
            ddlCategoria.DataValueField = "idCategoria";
            ddlCategoria.DataBind();

            ddlProducto.DataSource = dsProductos.Select(DataSourceSelectArguments.Empty);
            ddlProducto.DataTextField = "texto";
            ddlProducto.DataValueField = "idProducto";
            ddlProducto.DataBind();
        }

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMensaje.Text = "";
            CargarProducto();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            if (ddlProducto.Items.Count == 0)
            {
                lblMensaje.Text = "No hay productos para modificar.";
                return;
            }

            string nombre = txtNombre.Text.Trim();
            decimal precio;
            if (!decimal.TryParse(txtPrecio.Text.Trim(), NumberStyles.Number, CultureInfo.CurrentCulture, out precio) || precio <= 0)
            {
                lblMensaje.Text = "El precio no es válido.";
                return;
            }

            string categoria = ddlCategoria.SelectedValue;
            decimal precioOriginal = decimal.Parse(hfPrecio.Value, CultureInfo.InvariantCulture);

            bool cambioNombre = nombre != hfNombre.Value;
            bool cambioPrecio = precio != precioOriginal;
            bool cambioCategoria = categoria != hfCategoria.Value;

            if (!cambioNombre && !cambioPrecio && !cambioCategoria)
            {
                lblMensaje.Text = "Modifique al menos un campo antes de guardar.";
                return;
            }

            dsDetalle.UpdateParameters["nombre"].DefaultValue = nombre;
            dsDetalle.UpdateParameters["precio"].DefaultValue = precio.ToString(CultureInfo.CurrentCulture);
            dsDetalle.UpdateParameters["categoria"].DefaultValue = categoria;
            dsDetalle.UpdateParameters["idProducto"].DefaultValue = ddlProducto.SelectedValue;

            if (dsDetalle.Update() == 0)
            {
                lblMensaje.Text = "No se pudo guardar el producto.";
                return;
            }

            string id = ddlProducto.SelectedValue;
            ddlProducto.DataSource = dsProductos.Select(DataSourceSelectArguments.Empty);
            ddlProducto.DataTextField = "texto";
            ddlProducto.DataValueField = "idProducto";
            ddlProducto.DataBind();
            ddlProducto.SelectedValue = id;

            hfNombre.Value = nombre;
            hfPrecio.Value = precio.ToString(CultureInfo.InvariantCulture);
            hfCategoria.Value = categoria;
            txtPrecio.Text = precio.ToString("0.00");
            lblMensaje.Text = "Los cambios se guardaron.";
        }

        protected void dsDetalle_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            decimal precio = decimal.Parse(txtPrecio.Text.Trim(), NumberStyles.Number, CultureInfo.CurrentCulture);
            e.Command.Parameters["@nombre"].Value = txtNombre.Text.Trim();
            e.Command.Parameters["@precio"].Value = precio;
            e.Command.Parameters["@categoria"].Value = int.Parse(ddlCategoria.SelectedValue);
        }

        private void CargarProducto()
        {
            if (ddlProducto.Items.Count == 0)
            {
                txtNombre.Enabled = false;
                txtPrecio.Enabled = false;
                ddlCategoria.Enabled = false;
                btnGuardar.Enabled = false;
                lblMensaje.Text = "No hay productos para modificar.";
                return;
            }

            dsDetalle.SelectParameters["idProducto"].DefaultValue = ddlProducto.SelectedValue;
            DataView datos = (DataView)dsDetalle.Select(DataSourceSelectArguments.Empty);
            if (datos.Count == 0)
                return;

            DataRowView fila = datos[0];
            decimal precio = Convert.ToDecimal(fila["precio"]);
            string categoria = fila["categoría"].ToString();

            txtNombre.Text = fila["nombre"].ToString();
            txtPrecio.Text = precio.ToString("0.00");
            ddlCategoria.SelectedValue = categoria;

            hfNombre.Value = txtNombre.Text;
            hfPrecio.Value = precio.ToString(CultureInfo.InvariantCulture);
            hfCategoria.Value = categoria;

            txtNombre.Enabled = true;
            txtPrecio.Enabled = true;
            ddlCategoria.Enabled = true;
            btnGuardar.Enabled = true;
        }
    }
}
