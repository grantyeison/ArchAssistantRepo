<%-- 
    Document   : add8
    Created on : 25/01/2017, 12:31:04 PM
    Author     : Prometheus
--%>

<%@page import="servicios.Modulo"%>
<%@page import="servicios.Usuario"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
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
        <div class="col-lg-12 col-md-12 col-md-12">
            <form name="add-8" action="ADD8">
                <h2 class="subtitle">ADD</h2>
                <%
                    session.setAttribute("pasoActual", "add8");
                    Usuario u = (Usuario) session.getAttribute("validUsuario");
                    if (u == null) {
                        response.sendRedirect("InicioUsuario.jsp");
                    }
                    ArchAssistantBean archB = new ArchAssistantBean();
                %>
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
                            <td><a href="add7.jsp"><h3 class="bienvenida">Paso 7</h3></a></td>
                            <td><h1 class="bienvenida">Paso 8</h1></td>
                        </tr>
                    </tbody>
                </table><h2 class="page-header">Repetir los pasos 2 al 7 para el siguiente elemento a descomponer:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12"> 
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <p class="parrafo">
                            A esta altura, se tiene un elemento padre descompuesto en hijos, y cada uno de estos tiene asignado una descripción de interfaces, atributos de calidad, requerimientos funcionales y restricciones de diseño; por lo tanto, cada hijo está preparado para ser descompuesto como un elemento padre siguiendo los pasos anteriormente descritos.
                        </p>
                    </div>
                    <div class="col-lg-3 col-md-2"></div>                        
                </div>
            </form>
                <%@include file='rationale.jsp'%>
                <!--
            <div class="col-lg-12 col-md-8 col-sm-12">
                <div class="col-lg-1 " ></div>
                <div class="col-lg-5 col-md-6 col-sm-12">
                    <form id="add-8" name="add-8" action="ADD8">
                        <table width="100" border="0" class="tblCentfull">
                            <tbody>
                                <tr>
                                    <td>
                                        <h2 class="page-header">Rationale:</h2>
                                        <textarea rows="9" cols="120" name="ratadd8" class="form-control"><%
                                            /*
                                            ArchAssistantBean archB = new ArchAssistantBean();
                                            Modulo descMod = (Modulo) request.getSession().getAttribute("padreActual");
                                            if (descMod == null) {
                                                descMod = archB.buscarModDescomposicion(proyectoActual);
                                                request.getSession().setAttribute("padreActual", descMod);
                                            }
                                            Rationaleadd rata = archB.RationaleADD(proyectoActual.getProID(), "add8_" + descMod.getModId());
                                            if (rata != null) {
                                                out.print(rata.getRatAddDescripcion());
                                            }*/
                                            %></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="alIzq"><input type="submit" value="Guardar" name="btnAdd8Guardar" class="btn btn-primary"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
                <div class="col-lg-5 col-md-6 col-sm-12">
                    <div>
                        <h2 class="page-header">Archivos:</h2>
                        <form name="add-8" action="ADD8" method="post" enctype="multipart/form-data">
                            <table width="400" border="0" class="tblCent">
                                <tr><td><input type="file" name="archivo" id="myfile" /></td>
                                    <td><input type="submit" value="subir archivo" name="btnAddsubir" class="btn btn-primary"/></td></tr>
                            </table>
                        </form>
                    </div>
                    <div class="divScroll">
                        <form name="add-8" action="ADD8">
                            <table width="400" border="0" class="tblCentfull">
                                <tbody>
                                    <%
                                        /*
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
                                        }*/
                                    %>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>
                -->
                <div class="col-lg-1"></div>
                
            </div>

            <form name="add-8" action="ADD8">    
                <table border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td class="alDer"><input type="submit" value="Regresar" name="btnAdd8anterior" class="btn btn-primary btn-lg"/></td>
                            <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnInicio" class="btn btn-primary btn-lg"/></td>
                            <td class="alIzq"><input type="submit" value="Continuar" name="btnContinuar" class="btn btn-primary btn-lg"/></td>
                            <td class="alIzq"><input type="submit" value="Finalizar" name="btnFinalizar" class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
    </body>
</html>
