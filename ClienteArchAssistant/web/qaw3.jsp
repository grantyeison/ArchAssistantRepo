<%-- 
    Document   : qaw3
    Created on : 24/01/2017, 11:25:57 AM
    Author     : Prometheus
--%>

<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="servicios.Rationaleqaw"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - QAW</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <script src="./js/jquery-3.2.1.js"></script>
        <!--<script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="col-lg-12 col-md-12 col-md-12">
            <form name="qaw-3" action="QAW3">
                <h2 class="subtitle">QAW</h2>
                <h2 class="bienvenida"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
                <table border="0" class="tblCentfull">
                    <tbody>
                        <tr>
                            <td><a href="qaw1.jsp"><h3 class="bienvenida">Paso 1</h3></a></td>
                            <td><a href="qaw2.jsp"><h3 class="bienvenida">Paso 2</h3></a></td>
                            <td><h1 class="bienvenida">Paso 3</h1></td>
                            <td><h3 class="bienvenida">Paso 4</h3></td>
                            <td><h3 class="bienvenida">Paso 5</h3></td>
                            <td><h3 class="bienvenida">Paso 6</h3></td>
                            <td><h3 class="bienvenida">Paso 7</h3></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                        </tr>
                    </tbody>
                </table>
                <h2 class="page-header">Presentación del plan arquitectural:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <p class="parrafo">
                            Si bien a estas alturas del taller no se conoce aún la arquitectura del sistema, se pueden tener algunos gráficos generales técnicos que aclaren a los participantes un poco cual es la finalidad del proceso en curso, en este paso se puede mostrar la siguiente información:
                        </p>
                        <ul>
                            <li>planes para satisfacer los requerimientos del negocio/misión.</li>
                            <li>Información técnica como especificaciones físicas de los equipos, sistemas operativos, estándares.</li>
                            <li>Diagramas de contexto, diagramas de alto nivel del sistema y otras descripciones.</li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-md-2"></div>
                </div>
                <div class="col-lg-7 col-md-6 col-sm-12">
                    <h2 class="page-header">Rationale:</h2>
                    <textarea rows="5" cols="120" name="ratqaw3" class="form-control parrafo"><%

                        ArchAssistantBean p = new ArchAssistantBean();
                        Rationaleqaw ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw3");
                        if (ratq != null) {
                            out.print(ratq.getRatQawDescripcion());
                        }

                        %></textarea>
                    <br/>
                    <input type="submit" value="Guardar" name="btnQaw3Guardar" class="btn btn-primary"/>
                </div>
            </form>

            <div class="col-lg-5 col-md-6 col-sm-12">
                <div>
                    <h2 class="page-header">Archivos:</h2>
                    <form name="qaw-3" action="QAW3" method="post" enctype="multipart/form-data">
                        <table width="400" border="0" class="tblCent">
                            <tr><td><input type="file" name="archivo" id="myfile"/></td>
                                <td><input type="submit" value="subir archivo" name="btnQaw3subir" class="btn btn-primary"/></td></tr>
                        </table>
                    </form>
                </div>
                <div class="divScroll">
                    <form name="qaw-3" action="QAW3"> 

                        <table width="400" border="0" class="tblCentfull">
                            <tbody>
                                <%  GuardarArchivo arch = new GuardarArchivo();
                                    List<File> archivos = null;
                                    if (ratq != null) {
                                        archivos = arch.listarArchivos(ratq.getRatQawArchivo());
                                    }
                                    if (archivos != null) {
                                        for (File archivo : archivos) {
                                            out.print("<tr>");
                                            out.print("<td>" + archivo.getName() + "</td>");
                                            out.print("<td class='alDer'>"+"<button type=\"submit\"  name=\"btnQawEliminar"+archivo.getName()+"\" class=\"btn btn-primary \">  <span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span></button>        ");
                                            out.print("<button type=\"submit\" value=\"Descargar\" name=\"btnQawBajar"+archivo.getName()+"\" class=\"btn btn-primary\"/>  <span class=\"glyphicon glyphicon-download-alt\" aria-hidden=\"true\"></span></button>"+"</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
            <form name="qaw-3" action="QAW3">    
                <table border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td class="alDer"><input type="submit" value="Regresar" name="btnQaw3anterior" class="btn btn-primary btn-lg"/></td>
                            <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnQawInicio" class="btn btn-primary btn-lg"/></td>
                            <td class="alIzq"><input type="submit" value="Continuar" name="btnQaw3Continuar" class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </body>
</html>
