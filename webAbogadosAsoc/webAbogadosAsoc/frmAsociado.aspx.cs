using System;
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
        private void Limpiar()
        {
            Mensaje(string.Empty);
            this.txtCodigo.Text = string.Empty;
            this.ddlTipoDoc.SelectedIndex = 0;
            this.txtNombre.Text = string.Empty;
            this.chkActivo.Checked = true;
        }
        private void llenarComboTipoDoc()
        {
            try
            {
                Clases.clsTipoDoc objXX = new Clases.clsTipoDoc(strApp);
                if (!objXX.llenarCombo(this.ddlTipoDoc))
                {
                    Mensaje(objXX.Error);
                    objXX = null;
                    return;
                }
            }
            catch (Exception ex) { Mensaje(ex.Message); }
        }
        private void llenarGridAsoc()
        {
            try
            {
                Clases.clsAsociado objXX = new Clases.clsAsociado(strApp);
                if (!objXX.llenarGrid(this.grvDatos))
                {
                    Mensaje(objXX.Error);
                    objXX = null;
                    return;
                }
            }
            catch (Exception ex) { Mensaje(ex.Message); }
        }
        private void Buscar()
        {
            Clases.clsAsociado objXX = new Clases.clsAsociado(strApp);
            if (!objXX.buscar(strNroDoc))
            {
                Limpiar();
                Mensaje(objXX.Error);
                objXX = null;
                return;
            }
            this.txtCodigo.Text = objXX.nroDoc;
            this.ddlTipoDoc.SelectedValue = objXX.tipoDoc;
            this.txtNombre.Text = objXX.Nombre;
            this.chkActivo.Checked = objXX.Activo;
            objXX = null;
        }
        private void Grabar()
        {
            try
            {
                if (intOpcion != 1 && intOpcion != 2)
                {
                    Mensaje("Opcion no valida");
                    return;
                }
                strNroDoc = this.txtCodigo.Text.Trim().ToUpper();
                strTipoDoc = this.ddlTipoDoc.SelectedValue;
                strNombre = this.txtNombre.Text.Trim();
                blnActivo = this.chkActivo.Checked;
                Clases.clsAsociado objXX = new Clases.clsAsociado(strApp, strTipoDoc, strTipoDoc, strNombre, blnActivo);
                if (intOpcion == 1)
                {
                    if (!objXX.grabarMaestro())
                    {
                        Mensaje(objXX.Error);
                        objXX = null;
                        return;
                    }
                    else //intOpcion == 2
                        if (!objXX.modificarMaestro())
                    {
                        Mensaje(objXX.Error);
                        objXX = null;
                        return;
                    }
                }
                strNroDoc = objXX.nroDoc;
                objXX = null;
                if (strNroDoc == "-1")
                {
                    Mensaje("Ya existe un registro con dichos valores");
                    return;
                }
                else if (strNroDoc == "0")
                {
                    Mensaje("Error al procesar registro, consultar el Admon del sistema");
                    return;
                }
                Mensaje("Registro grabado con exito");
                llenarGridAsoc();
            }
            catch (Exception ex)
            {
                Mensaje(ex.Message);
            }
        }
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
                    intOpcion = 1;//Agregar - INSERT 
                    this.txtCodigo.ReadOnly = false;
                    Limpiar();
                    this.txtCodigo.Focus();
                    break;
                case "opcmodifcar":
                    intOpcion = 2;//Modificar - UPDATE
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
               // Buscar();
            }
            catch (Exception ex) 
            {
                Mensaje(ex.Message); 
            }
        }
        protected void grvDatos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string opcion = e.CommandName.ToLower();
            int nroFila = Convert.ToInt32(e.CommandArgument);
            if (nroFila >= 0)
            {
                strNroDoc = grvDatos.Rows[nroFila].Cells[1].Text;
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