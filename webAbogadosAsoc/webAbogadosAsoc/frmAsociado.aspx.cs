using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace webAbogadosAsoc
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        #region "Variables globales"
        private static int intOpcion; //1:Agregar, 2: Modificar, 0: Otra Oppcion
        private static string strApp;
        private bool blnActivo;
        private string strNroDoc, strTipoDoc, strNombre;
        #endregion

        #region "Metodos personalisados"
        private void Mensaje(string Texto)
        { this.lblMsj.Text = Texto.Trim(); }
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)//Cuando se carga por primera vez
            {
                intOpcion = 0;
                strApp = System.Reflection.Assembly.GetExecutingAssembly().GetName().Name;//Capturar el nombre de la aplicacion
                llenarComboTipoDoc();
                this.ddlTipoDoc.SelectedIndex = 0;
                llenarGridAsoc();
            }
        }
        protected void mnuOpciones_MenuItemClick(object sender, MenuEventArgs e)
        {
            Mensaje(string.Empty);
            this.ibtnBuscar.Visible = false;
            this.txtCodigo.ReadOnly = true;
            intOpcion = 0;
            //mnuOpciones_MenuItemClick
            Mensaje(string.Empty);
            this.ibtnBuscar.Visible = false;
            this.txtCodigo.ReadOnly = true;
            intOpcion = 0;
            switch (this.mnuOpciones.SelectedValue.ToLower())
            {
                case "opcbuscar":
                    this.txtCodigo.ReadOnly = false;
                    Limpiar();
                    this.txtCodigo.Focus();
                    break;
                case "opcagregar":
                    intOpcion = 1;
                    this.txtCodigo.ReadOnly = false;
                    Limpiar();
                    this.txtCodigo.Focus();
                    break;
                case "opcmodifcar":
                    intOpcion = 2;
                    this.txtNombre.Focus();
                    break;
                case "opcgrabar":
                    Grabar();
                    break;
                case "opccancelar":
                    if (intOpcion == 1 || intOpcion == 2)
                        Limpiar();
                    break;
                case "opcimprimir":
                    break;
            }
            // ibtnBuscar_Clik
            try
            {
                Mensaje(string.Empty);
                strNroDoc = this.txtCodigo.Text.Trim();
                if (string.IsNullOrEmpty(strNroDoc))
                {
                    Mensaje("Numero de documento no valido");
                    return;
                }
                this.ibtnBuscar.Visible = false;
                Buscar();
            }
            catch (Exception ex) { Mensaje(ex.Message); }
            // grvDatos_RowCommand
            string opcion = e.CommandName.ToLower();
            int index = Convert.ToInt32(e.CommandArgument);
            if (index >= 0)
            {
                strNroDoc = grvDatos.Row[index].Cells[1].Text;
                switch (opcion)
                {
                    case "select":
                        Buscar();
                        break;
                }
            }
        }
    }
}