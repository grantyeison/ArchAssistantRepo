<%-- 
    Document   : add2
    Created on : 25/01/2017, 12:30:08 PM
    Author     : Prometheus
--%>

<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="servicios.Modulo"%>
<%@page import="java.util.List"%>
<%@page import="servicios.Rationaleadd"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="./css/bootstrap.min.css" />
        <link rel="stylesheet" href="./css/estilos.css" />
        <script src="./js/jquery-3.2.1.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/funciones.js"></script>
        <title>ArchAssistant - ADD</title>
    </head>
    <body>
        <div class="col-lg-12 col-md-12 col-md-12">
            <form name="add-2" action="ADD2">
                <h2 class="subtitle">ADD</h2>
                <h2 class="bienvenida">                    
                    <% if (session.getAttribute("validUsuario") == null) {
                            response.sendRedirect("InicioUsuario.jsp");
                            //redirijo al login
                        }%>
                    <jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
                <table border="0" class="tblCentfull">
                    <tbody>
                        <tr>
                            <td><a href="add1.jsp"><h3 class="bienvenida">Paso 1</h3></a></td>
                            <td><h1 class="bienvenida">Paso 2</h1></td>
                            <td><h3 class="bienvenida">Paso 3</h3></td>
                            <td><h3 class="bienvenida">Paso 4</h3></td>
                            <td><h3 class="bienvenida">Paso 5</h3></td>
                            <td><h3 class="bienvenida">Paso 6</h3></td>
                            <td><h3 class="bienvenida">Paso 7</h3></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                        </tr>
                    </tbody>
                </table>
                <h2 class="page-header">Escoger un elemento del sistema para descomponerlo:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12"> 
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-8 col-md-6 col-sm-12">
                        <p class="parrafo">
                            Durante este paso, se escoge el elemento en el cual se enfocará el proceso, el primer elemento que se descompone es el sistema en sí, en caso de ya haber sido descompuesto, cada elemento debe tener asignados algunos de los requerimientos.
                            Para escoger un elemento, hay que basarse en las siguientes áreas:
                        </p>
                        <ul>
                            <li>Conocimiento de la arquitectura.</li>
                            <li>Riesgo y dificultad.</li>
                            <li>Criterio de negocios.</li>
                            <li>Criterio organizacional.</li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-md-2"></div>
                </div>
                <div class="col-lg-1"></div>
                <div class="col-lg-10 col-md-12 col-sm-12">
                    <h2 class="page-header"> Módulos del sistema:</h2>
                    <!-- inicialmente será todo el sistema, además todos los escenarios estarán asociados a este único módulo
    posteriormente, se dividirá el sistema en módulos y a cada uno se le asignará un conjunto de escenarios -->
                    <table width="100%" border="3" class="tblCentfull">
                        <tbody>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Descripción</th>
                                <th scope="col">Módulo final</th>
                            </tr><%ArchAssistantBean archB = new ArchAssistantBean();
                                List<Modulo> listaMod = archB.ListarModulos(proyectoActual);

                                for (Modulo mod : listaMod) {
                                    out.println("<tr>");
                                    out.println("<td>");
                                    String estado = mod.getModFinal();
                                    if (estado.equals("Descomposicion")) {
                                        out.println("<input  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "' checked />");
                                    } else {
                                        if (estado.equals("Procesado")) {
                                            out.println("<input disabled  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "'/>");
                                        } else {
                                            out.println("<input  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "'/>");
                                        }
                                    }
                                    //out.println(mod.getModId());
                                    out.println("</td>");
                                    out.println("<td>");
                                    out.println(mod.getModNombre());
                                    out.println("</td>");
                                    out.println("<td>");
                                    out.println(mod.getModDescripcion());
                                    out.println("</td>");
                                    out.println("<td>");
                                    out.println(mod.getModFinal());
                                    out.println("</td>");
                                    out.println("</tr>");
                                }%>
                        </tbody>
                    </table>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1"></div>
                    <input type="hidden" name="modPadre" value=""/>
                    <div class="col-lg-5 col-md-6 col-sm-12">
                        <h2 class="page-header">Rationale:</h2>
                        <textarea rows="5" cols="120" name="ratadd2" class="form-control parrafo"><%
                            ArchAssistantBean p = new ArchAssistantBean();
                            Modulo descMod = (Modulo) request.getSession().getAttribute("padreActual");
                            if (descMod == null) {
                                descMod = archB.buscarModDescomposicion(proyectoActual);
                                request.getSession().setAttribute("padreActual", descMod);
                            }
                            Rationaleadd rata = p.RationaleADD(proyectoActual.getProID(), "add2_" + descMod.getModId());
                            if (rata != null) {
                                out.print(rata.getRatAddDescripcion());
                            }
                            %></textarea>
                        <br/>
                        <input type="submit" value="Guardar" name="btnAdd2Guardar" class="btn btn-primary"/>
                    </div>
            </form>
            <div class="col-lg-5 col-md-6 col-sm-12">
                <div>
                    <h2 class="page-header">Archivos:</h2>
                    <form name="add-2" action="ADD2" method="post" enctype="multipart/form-data">
                        <table width="400" border="0" class="tblCent">
                            <tr><td><input type="file" name="archivo" id="myfile"/></td>
                                <td><input type="submit" value="subir archivo" name="btnAddsubir" class="btn btn-primary"/></td></tr>
                        </table>
                    </form>
                </div>
                <div class="divScroll">
                    <form name="add-2" action="ADD2"> 

                        <table width="400" border="0" class="tblCentfull">
                            <tbody>
                                <%
                                    GuardarArchivo arch = new GuardarArchivo();
                                    List<File> archivos = null;
                                    if (rata != null) {
                                        archivos = arch.listarArchivos(rata.getRatAddArchivo());
                                    }
                                    if (archivos != null) {
                                        for (File archivo : archivos) {
                                            out.print("<tr>");
                                            out.print("<td>" + archivo.getName() + "</td>");
                                            out.print("<td class='alDer'>" + "<button type=\"submit\"  name=\"btnAddEliminar" + archivo.getName() + "\" class=\"btn btn-primary \">  <span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span></button>        ");
                                            out.print("<button type=\"submit\" value=\"Descargar\" name=\"btnAddBajar" + archivo.getName() + "\" class=\"btn btn-primary\"/>  <span class=\"glyphicon glyphicon-download-alt\" aria-hidden=\"true\"></span></button>" + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
            <div class="col-lg-1"></div> 
        </div>
        <form name="add-2" action="ADD2">    
            <table border="0" class="tblCent">
                <tbody>
                    <tr>
                        <td class="alDer"><input type="submit" value="Regresar" name="btnAdd2anterior" class="btn btn-primary btn-lg"/></td>
                        <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnInicio" class="btn btn-primary btn-lg"/></td>
                        <td class="alIzq"><input type="submit" value="Continuar" name="btnContinuar" class="btn btn-primary btn-lg"/></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
</body>
</html>
