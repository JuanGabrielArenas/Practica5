<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmAsociado.aspx.cs" Inherits="webAbogadosAsoc.WebForm2" %>

<asp:Content ID="Content4" ContentPlaceHolderID="Cuerpo" runat="server">

    <table align="center" class="auto-style8">
        <tr>
            <td class="auto-style9"><strong>Maestro de Asociados</strong></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <table align="center" class="auto-style5">
                    <tr>
                        <td class="auto-style10" style="width: 35%">Nro. Doc.:&nbsp;&nbsp; </td>
                        <td class="auto-style11">&nbsp;&nbsp;
                            <asp:TextBox ID="txtCodigo" runat="server" Width="60%"></asp:TextBox>
                        &nbsp;
                            <asp:ImageButton ID="ibtnBuscar" runat="server" ImageUrl="~/Imagenes/Buscar.jpg" Visible="False" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style12">Tipo Doc.:&nbsp;&nbsp; </td>
                        <td class="auto-style13">
                            <asp:DropDownList ID="ddlTipoDoc" runat="server" AutoPostBack="True" Width="60%">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style10">Nombre:&nbsp;&nbsp;</td>
                        <td class="auto-style11">&nbsp;&nbsp;
                            <asp:TextBox ID="txtNombre" runat="server" Width="60%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style10">Activo:&nbsp;&nbsp;</td>
                        <td class="auto-style11">
                            <asp:CheckBox ID="chkActivo" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="Panel1" runat="server">
                    <asp:Menu ID="mnuOpciones" runat="server" BackColor="#99CCFF" BorderColor="#0066FF" BorderStyle="Solid" BorderWidth="2px" DynamicHorizontalOffset="2" Font-Bold="True" Font-Size="Small" ForeColor="#000099" ItemWrap="True" Orientation="Horizontal" RenderingMode="Table" Width="100%" OnMenuItemClick="mnuOpciones_MenuItemClick">
                        <Items>
                            <asp:MenuItem Text="Agregar" Value="opcAgregar"></asp:MenuItem>
                            <asp:MenuItem Text="Modificar" Value="opcModificar"></asp:MenuItem>
                            <asp:MenuItem Text="Buscar" Value="opcBuscar"></asp:MenuItem>
                            <asp:MenuItem Text="Grabar" Value="opcGrabar"></asp:MenuItem>
                            <asp:MenuItem Text="Cancelar" Value="opcCancelar"></asp:MenuItem>
                            <asp:MenuItem Text="Imprimir" Value="opcImprimir"></asp:MenuItem>
                        </Items>
                        <StaticHoverStyle BackColor="#99FFCC" BorderColor="#66FFCC" BorderStyle="Solid" BorderWidth="2px" />
                        <StaticMenuStyle HorizontalPadding="20px" />
                    </asp:Menu>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvDatos" runat="server" Width="95%" OnRowCommand="grvDatos_RowCommand">
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Imagenes/Buscar.jpg" ShowSelectButton="True">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:CommandField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblMsj" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

</asp:Content>
<asp:Content ID="Content5" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
            border: 3px solid #0033CC;
        }
        .auto-style9 {
            font-size: x-large;
            color: #0066FF;
        }
        .auto-style10 {
            text-align: right;
        }
        .auto-style11 {
            text-align: left;
        }
        .auto-style12 {
            text-align: right;
            height: 29px;
        }
        .auto-style13 {
            text-align: left;
            height: 29px;
        }
    </style>
</asp:Content>

