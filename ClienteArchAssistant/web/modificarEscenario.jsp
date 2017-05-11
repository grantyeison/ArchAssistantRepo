<%-- 
    Document   : modificarEscenario
    Created on : 2/02/2017, 04:39:18 PM
    Author     : Prometheus
--%>

<%@page import="servicios.Escenario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Escenario</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <script src="./js/jquery-3.2.1.js"></script>
        <!--<script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/bootstrap.min.js"></script>
    </head>
    <body>
        <form name="modEsc" action="ActualizarEscenario">
            <table width="100" border="0">
             <tbody>
              <tr>
                <td>Nombre:</td>
                <td><input type="text" name="txtQawNombre"
                    <%
                        int ref = Integer.parseInt(session.getAttribute("refinar").toString());
                        Escenario esc = (Escenario)session.getAttribute("escenarioActual");
                        out.println("value = \""+esc.getEscNombre()+"\"");
                    %>
                    />
                </td>
              </tr>
              <tr>
                <td>Estímulo:</td>
                <td><input type="text" name="txtQawEstimulo"
                    <%
                        out.println("value = \""+esc.getEscEstimulo()+"\"");
                    %>
                    />
                </td>
              </tr>
                  <%
                      if (ref == 1)
                      {
                        out.println("<tr>");
                        out.println("<td>Fuente:</td>");
                        out.println("<td><input type=\"text\" name=\"txtQawFuente\"");
                        out.println("value = \""+esc.getEscFuente()+"\"/>");
                        out.println("</td>");
                        out.println("</tr>");
                        out.println("<tr>");
                        out.println("<td>Artefacto:</td>");
                        out.println("<td><input type=\"text\" name=\"txtQawArtefacto\"");
                        out.println("value = \""+esc.getEscArtefacto()+"\"/>");
                        out.println("</td>");
                        out.println("</tr>");
                      }
                  %>
              <tr>
                <td>Ambiente:</td>
                <td><input type="text" name="txtQawAmbiente"
                    <%
                        out.println("value = \""+esc.getEscAmbiente()+"\"");
                    %>
                    />
                </td>
              </tr>
              <tr>
                <td>Respuesta:</td>
                <td><input type="text" name="txtQawRespuesta"
                    <%
                        out.println("value = \""+esc.getEscRespuesta()+"\"");
                    %>
                </td>
              </tr>
              <%
                      if (ref == 1)
                      {
                        out.println("<tr>");
                        out.println("<td>Medida de la Respuesta:</td>");
                        out.println("<td><input type=\"text\" name=\"txtQawMedida\"");
                        out.println("value = \""+esc.getEscMedidaRespuesta()+"\"/>");
                        out.println("</td>");
                        out.println("</tr>");
                      }
                  %>
              <tr>
                  <td><input type="submit" value="guardar" name="btnQawGuardarEscenario"/></td>
                  <td><input type="reset" value="Cancelar"/></td>
              </tr>
            </tbody>
          </table>
        </form>
    </body>
</html>
