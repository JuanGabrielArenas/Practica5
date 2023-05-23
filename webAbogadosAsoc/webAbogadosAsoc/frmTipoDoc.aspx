<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmTipoDoc.aspx.cs" Inherits="webAbogadosAsoc.WebForm5" %>

<asp:Content ID="Content4" ContentPlaceHolderID="Cuerpo" runat="server">

    <table class="auto-style5">
        <tr>
            <td class="auto-style8"><strong>Maestro de Tipo de Documento</strong></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <table class="auto-style5">
                    <tr>
                        <td class="auto-style11">Codigo:&nbsp;&nbsp; </td>
                        <td class="auto-style12">
                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            <asp:ImageButton ID="ibtnBuscar" runat="server" ImageUrl="~/Imagenes/Buscar.jpg" Visible="False" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style11">Descripcion:&nbsp;&nbsp; </td>
                        <td class="auto-style12">
                            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="auto-style9"></td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="Panel1" runat="server">
                    <asp:Menu ID="mnuOpciones" runat="server" BackColor="#99CCFF" BorderColor="#0066FF" BorderStyle="Solid" BorderWidth="2px" DynamicHorizontalOffset="2" Font-Bold="True" Font-Size="Small" ForeColor="#000099" ItemWrap="True" Orientation="Horizontal" RenderingMode="Table" Width="100%" >
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
                </asp:Panel></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server">
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style13">
                <asp:Label ID="lblMsj" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

</asp:Content>
<asp:Content ID="Content5" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style8 {
            font-size: large;
            color: #0033CC;
        }
        .auto-style9 {
            height: 27px;
        }
        .auto-style11 {
            width: 249px;
            text-align: right;
        }
        .auto-style12 {
            text-align: left;
        }
        .auto-style13 {
            text-align: right;
        }
    </style>
</asp:Content>

