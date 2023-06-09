﻿using System;
using System.Web.UI.WebControls;
using libLlenarCombos;
using libLlenarGrids;
using libLlenarRBList;
using libLlenarCBList;

namespace webAbogadosAsoc.Clases
{
    public class clsGenerales
    {
        #region "Atributos/Propiedades"
        private string strApp;
        public string Error { get; private set; }
        #endregion
        #region "Metodos Publicos"
        public bool llenarGrid(string App, GridView Grid, string SQL)
        {
            try
            {
                strApp = App;
                if (string.IsNullOrEmpty(strApp))
                {
                    Error = "Falta el nombre de la aplicacion";
                    return false;
                }
                if (Grid == null)
                {
                    Error = "sin Grid a llenar";
                    return false;
                }
                clsLlenarGrids objXX = new clsLlenarGrids(strApp);
                objXX.SQL = SQL;
                if (!objXX.llenarGridWeb(Grid))
                {
                    Error = objXX.Error;
                    objXX = null;
                    return false;
                }
                objXX = null;
                //formato al llenar grid
                Grid.GridLines = GridLines.Both;
                Grid.CellPadding = 1;
                Grid.ForeColor = System.Drawing.Color.Black;
                Grid.BackColor = System.Drawing.Color.Beige;
                Grid.AlternatingRowStyle.BackColor = System.Drawing.Color.Gainsboro;
                Grid.HeaderStyle.BackColor = System.Drawing.Color.Aqua;
                return true;
            }
            catch (Exception ex)
            {
                Error = ex.Message;
                return false;
            }
        }
        public bool llenarCombo(string App, DropDownList Combo, string SQL, 
            string nombrePK, string nombreTexto)
        {
            try
            {
                strApp = App;
                if (string.IsNullOrEmpty(strApp))
                {
                    Error = "Falta el nombre de la aplicacion";
                    return false;
                }
                if (Combo == null)
                {
                    Error = "sin Combo a llenar";
                    return false;
                }
                clsLlenarCombos objXX = new clsLlenarCombos(strApp);
                objXX.SQL = SQL;
                objXX.campoID = nombrePK;
                objXX.campoTexto = nombreTexto;
                if (!objXX.llenarComboWeb(Combo))
                {
                    Error = objXX.Error;
                    objXX = null;
                    return false;
                }
                objXX = null;
                return true;
            }
            catch (Exception ex)
            {
                Error = ex.Message;
                return false;
            }
        }
        public bool llenarRadioBL(string App, RadioButtonList RadioBL, string SQL, 
            string nombrePK, string nombreTexto)
        {
            try
            {
                strApp = App;
                if (string.IsNullOrEmpty(strApp))
                {
                    Error = "Falta el nombre de la aplicacion";
                    return false;
                }
                if (RadioBL == null)
                {
                    Error = "sin Radio a llenar";
                    return false;
                }
                clsLlenarRBList objXX = new clsLlenarRBList(strApp);
                objXX.SQL = SQL;
                objXX.campoID = nombrePK;
                objXX.campoTexto = nombreTexto;
                if (!objXX.llenarRadioBLWeb(RadioBL))
                {
                    Error = objXX.Error;
                    objXX = null;
                    return false;
                }
                objXX = null;
                return true;
            }
            catch (Exception ex)
            {
                Error = ex.Message;
                return false;
            }
        }
        public bool llenarCheckBL(string App, CheckBoxList CheckBL, string SQL, 
            string nombrePK, string nombreTexto)
        {
            try
            {
                strApp = App;
                if (string.IsNullOrEmpty(strApp))
                {
                    Error = "Falta el nombre de la aplicacion";
                    return false;
                }
                if (CheckBL == null)
                {
                    Error = "sin Check a llenar";
                    return false;
                }
                clsLlenarCBList objXX = new clsLlenarCBList(strApp);
                objXX.SQL = SQL;
                objXX.campoID = nombrePK;
                objXX.campoTexto = nombreTexto;
                if (!objXX.llenarCheckBLWeb(CheckBL))
                {
                    Error = objXX.Error;
                    objXX = null;
                    return false;
                }
                objXX = null;
                return true;
            }
            catch (Exception ex)
            {
                Error = ex.Message;
                return false;
            }
        }
        #endregion
    }
}