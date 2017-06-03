<%-- 
    Document   : add7
    Created on : 25/01/2017, 12:30:55 PM
    Author     : Prometheus
--%>

<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="servicios.Modulo"%>
<%@page import="java.util.List"%>
<%@page import="servicios.Usuario"%>
<%@page import="servicios.Rationaleadd"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <script src="./js/jquery-3.2.1.js"></script>
        <!--<script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/funciones.js"></script>

        <title>ArchAssistant - ADD</title>
    </head>
    <body>
        <div class="col-lg-12 col-md-12 col-md-12">
            <form name="add-7" action="ADD7">
                <h2 class="subtitle">ADD</h2>
                <%Usuario u = (Usuario) session.getAttribute("validUsuario");
                    if (u == null) {
                        response.sendRedirect("InicioUsuario.jsp");
                    }%>
                <h2 class="bienvenida"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
                <table width="100%" border="0" align="center">
                    <tbody>
                        <tr>
                            <td><a href="add1.jsp"><h3 class="bienvenida">Paso 1</h3></a></td>
                            <td><a href="add2.jsp"><h3 class="bienvenida">Paso 2</h3></a></td>
                            <td><a href="add3.jsp"><h3 class="bienvenida">Paso 3</h3></a></td>
                            <td><a href="add4.jsp"><h3 class="bienvenida">Paso 4</h3></a></td>
                            <td><a href="add5.jsp"><h3 class="bienvenida">Paso 5</h3></a></td>
                            <td><a href="add6.jsp"><h3 class="bienvenida">Paso 6</h3></a></td>
                            <td><h1 class="bienvenida">Paso 7</h1></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                        </tr>
                    </tbody>
                </table><h2 class="page-header">Verificar y refinar los requerimientos haciéndolos restricciones para los elementos instanciados:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12"> 
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <p class="parrafo">
                            Verificar que la descomposición de elementos cumple hasta ahora con los requerimientos funcionales, atributos de calidad y restricciones de diseño, y se preparan los elementos hijos para su tratamiento en pasos posteriores.
                        </p>
                    </div>
                    <div class="col-lg-3 col-md-2"></div>                        
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1"> </div>
                    <div class="col-lg-10 col-md-6 col-sm-12" name="listaModulos" id="listaModulos">                        
                        <h2 class="page-header">Submódulos del sistema:</h2>
                        <table width="100%" border="3" class="tblCentfull">
                            <tbody>
                                <tr>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Descripción</th>
                                    <th scope="col">Tipo</th>

                                </tr>
                                <%
                                    ArchAssistantBean archB = new ArchAssistantBean();
                                    List<Modulo> listaMod = archB.ListarModulos(proyectoActual);
                                    Modulo padreActual = (Modulo) session.getAttribute("padreActual");
                                    if (padreActual == null) {
                                        padreActual = archB.buscarModDescomposicion(proyectoActual);
                                    }
                                    for (Modulo m : listaMod) {
                                        Modulo padreM = m.getTblModuloModId();
                                        if (padreM != null) {
                                            if (padreM.getModId() == padreActual.getModId() && m.getModFinal().equals("SubModulo")) {
                                                out.println("<tr>");
                                                out.println("<td>");
                                                out.println(m.getModNombre());
                                                out.println("</td>");
                                                out.println("<td>");
                                                out.println(m.getModDescripcion());
                                                out.println("</td>");
                                                out.println("<td>");
                                                out.println("<select name='selModulo' id='selModulo_'"+m.getModId()+"  class='form-control'>");
                                                out.println("<option value='Modulo'>Modulo</option>");
                                                out.println("<option value='Submodulo'>SubModulo</option>");
                                                out.println("</select>");
                                                //out.println(m.getModFinal());
                                                out.println("</td>");
                                                out.println("</tr>");
                                            }
                                        }
                                    }%>
                            </tbody>
                        </table>
                        <p class="parrafo"> En este punto, los Submódulos pasan a convertirse en módulos para su posterior descomposición.</p>
                    </div>
                    <div class="col-lg-1"></div>
                </div>
            </form>
            <!-- las responsabilidades que luego se convierten en restricciones vienen dadas por los escenarios asociados a cada módulo -->


            <div class="col-lg-12 col-md-8 col-sm-12">
                <div class="col-lg-1 " ></div>
                <div class="col-lg-5 col-md-6 col-sm-12">
                    <form id="add-7" name="add-7" action="ADD7">
                        <table width="100" border="0" class="tblCentfull">
                            <tbody>
                                <tr>
                                    <td>
                                        <h2 class="page-header">Rationale:</h2>
                                        <textarea rows="9" cols="120" name="ratadd7" class="form-control"><%
                                            Modulo descMod = (Modulo) request.getSession().getAttribute("padreActual");
                                            if (descMod == null) {
                                                descMod = archB.buscarModDescomposicion(proyectoActual);
                                                request.getSession().setAttribute("padreActual", descMod);
                                            }
                                            Rationaleadd rata = archB.RationaleADD(proyectoActual.getProID(), "add7_" + descMod.getModId());
                                            if (rata != null) {
                                                out.print(rata.getRatAddDescripcion());
                                            }
                                            %></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="alIzq"><input type="submit" value="Guardar" name="btnAdd7Guardar" class="btn btn-primary"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
                <div class="col-lg-5 col-md-6 col-sm-12">
                    <div>
                        <h2 class="page-header">Archivos:</h2>
                        <form name="add-7" action="ADD7" method="post" enctype="multipart/form-data">
                            <table width="400" border="0" class="tblCent">
                                <tr><td><input type="file" name="archivo" id="myfile" /></td>
                                    <td><input type="submit" value="subir archivo" name="btnAddsubir" class="btn btn-primary"/></td></tr>
                            </table>
                        </form>
                    </div>
                    <div class="divScroll">
                        <form name="add-7" action="ADD7">
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
            <form name="add-7" action="ADD7">    
                <table border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td class="alDer"><input type="submit" value="Regresar" name="btnAdd7anterior" class="btn btn-primary btn-lg"/></td>
                            <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnInicio" class="btn btn-primary btn-lg"/></td>
                            <td class="alIzq"><input type="submit" value="Continuar" name="btnContinuar" class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </body>
</html>
