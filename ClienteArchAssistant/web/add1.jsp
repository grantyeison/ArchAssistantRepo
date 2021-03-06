<%-- 
    Document   : add1
    Created on : 25/01/2017, 12:10:18 PM
    Author     : Prometheus
--%>
<%@page import="servicios.Proyecto"%>
<%@page import="Servlets.Utilidad"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="servicios.Escenario"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="servicios.Rationaleadd"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - ADD</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <link rel="stylesheet" href="./css/editor.css" />
        <link rel="stylesheet" href="./css/font-awesome.min.css" />
        <!--
        <script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/jquery-3.2.1.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/editor.js"></script>
        <script src="./js/funciones.js"></script>

    </head>
    <body>
        <form name="add-1" action="ADD1" method="get" >
            <div class="col-lg-12 col-md-12 col-md-12">            
                <h2 class="subtitle">ADD</h2>
                <h2 class="bienvenida">
                    <% if (session.getAttribute("validUsuario") == null) {
                            response.sendRedirect("InicioUsuario.jsp");
                            //redirijo al login
                        }%>
                    <jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>             

                <table width="100%" border="0" class="tblCentfull">
                    <tbody>
                        <tr>
                            <td><h1 class="bienvenida">Paso 1</h1></td>
                            <td><h3 class="bienvenida">Paso 2</h3></td>
                            <td><h3 class="bienvenida">Paso 3</h3></td>
                            <td><h3 class="bienvenida">Paso 4</h3></td>
                            <td><h3 class="bienvenida">Paso 5</h3></td>
                            <td><h3 class="bienvenida">Paso 6</h3></td>
                            <td><h3 class="bienvenida">Paso 7</h3></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>

                        </tr>
                    </tbody>
                </table>
                <h2 class="page-header">Confirmar que hay suficiente información de los requerimientos:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-2"></div>
                    <p class="parrafo col-lg-6 col-md-8 col-sm-12">
                        Para iniciar el proceso de ejecutar el método ADD se requiere la lista de requerimientos 
                        priorizada por los Stakeholders (interesados), en caso de no estar organizada, ésta se devolverá
                        para que se haga el proceso pertinente.
                    </p>
                    <div class="col-lg-3 col-md-2"></div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1"></div>
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <h2 class="page-header">Escenarios priorizados:</h2>
                        <table width="100%" border="3" class="table table-responsive">
                            <tbody>
                                <tr>
                                    <!--<th scope="col">Código</th>-->
                                    <th scope="col">Nombre Atributo</th>
                                    <th scope="col">Nombre Escenario</th>
                                    <th scope="col">Estímulo</th>
                                    <th scope="col">Fuente</th>
                                    <th scope="col">Ambiente</th>
                                    <th scope="col">Artefacto</th>
                                    <th scope="col">Respuesta</th>
                                    <th scope="col">Medida</th>
                                    <th scope="col">Prioridad</th>
                                    <th scope="col">Acción</th>
                                </tr>
                                <%
                                    session.setAttribute("pasoActual", "add1");
                                    ArchAssistantBean archB = new ArchAssistantBean();
                                    List<Escenario> listaEsc = archB.ListEscenarios(proyectoActual);
                                    Collections.sort(listaEsc, new Utilidad(false));
                                    for (Escenario esce : listaEsc) {
                                        String estado = esce.getEscEstado();
                                        if (esce.getEscPrioridad() != null && esce.getEscPrioridad() > 0 && estado != null) {
                                            if (estado.equals("refinado")) {
                                                /*
                                            out.println("<tr>");
                                            out.println("<td>");
                                            out.println(esce.getEscID());
                                            out.println("</td>");
                                                 */
                                                out.println("<td>");
                                                out.println(esce.getTblAtributoCalidadacID().getAcNombre());
                                                out.println("</td>");
                                                out.println("<td>");
                                                out.println(esce.getEscNombre());
                                                out.println("</td>");
                                                out.println("<td>");
                                                out.println(esce.getEscEstimulo());
                                                out.println("</td>");
                                                if (esce.getEscFuente() != null) {
                                                    out.println("<td>");
                                                    out.println(esce.getEscFuente());
                                                    out.println("</td>");
                                                } else {
                                                    out.println("<td>&nbsp;</td>");
                                                }
                                                out.println("<td>" + esce.getEscAmbiente());
                                                out.println("</td>");
                                                if (esce.getEscArtefacto() != null) {
                                                    out.println("<td>");
                                                    out.println(esce.getEscArtefacto());
                                                    out.println("</td>");
                                                } else {
                                                    out.println("<td>&nbsp;</td>");
                                                }
                                                out.println("<td>" + esce.getEscRespuesta());
                                                out.println("</td>");
                                                if (esce.getEscMedidaRespuesta() != null) {
                                                    out.println("<td>");
                                                    out.println(esce.getEscMedidaRespuesta());
                                                    out.println("</td>");
                                                } else {
                                                    out.println("<td>&nbsp;</td>");
                                                }
                                                out.println("<td>");
                                                if (esce.getEscPrioridad() != null) {
                                                    out.println(esce.getEscPrioridad());
                                                } else {
                                                    out.println(0);
                                                }
                                                out.println("</td>");
                                                out.println("<td><button type=\"submit\" value=\"votar\" name=\"btnQaw8Refinar" + esce.getEscID() + "\" class=\"btn btn-primary\" >  <span class=\"glyphicon glyphicon-cog\" aria-hidden=\"true\"></span></button></td>");
                                                out.println("</tr>");
                                            }

                                        } else {

                                        }
                                    }
                                %>                       
                            </tbody>
                        </table>
                    </div>
                    <div class="col-lg-1"></div>
                </div>
            </div>
            <%@include file='rationale.jsp'%>
        </form>
        <form name="add-1" action="ADD1" method="get">
            <table width="100" border="0" class="tblCent">
                <tbody>
                    <tr>
                        <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnAddInicio" class="btn btn-primary btn-lg"/></td>
                        <td class="alCen"><input type="submit" value="Continuar" name="btnAddContinuar" class="btn btn-primary btn-lg"/></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>
