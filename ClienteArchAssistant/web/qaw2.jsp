<%-- 
    Document   : qaw2
    Created on : 23/01/2017, 09:21:23 PM
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
        <link rel="stylesheet" href="./css/bootstrap.min.css" />
        <link rel="stylesheet" href="./css/estilos.css" />
        <script src="./js/jquery-3.2.1.js"></script>
        <script src="./js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="col-lg-12 col-md-12 col-md-12">
            <form name="qaw-2" action="QAW2">
                <h2 class="subtitle">QAW</h2>
                <h2 class="bienvenida"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
                <table border="0" class="tblCentfull">
                  <tbody>
                    <tr>
                      <td><a href="QAW1.html"><h3 class="bienvenida">Paso 1</h3></a></td>
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
                <h2 class="page-header">Presentación del negocio o misión del sistema a desarrollar:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-2"></div>
                    <p class="parrafo col-lg-6 col-md-8 col-sm-12">
                        Luego de la presentación inicial, uno de los representantes de los stakeholders, generalmente alguien con un cargo administrativo, explica el negocio o la misión, dejando claro cuál es el propósito de la organización, es posible que en este paso se invierta alrededor de una hora además el o los moderadores en este paso deben analizar muy bien la información presentada sacando la mayor cantidad de atributos de calidad que se puedan identificar para pasos posteriores.
                    </p>
                    <div class="col-lg-3 col-md-2"></div>
                </div>
                <div class="col-lg-7 col-md-6 col-sm-12">
                    <h2 class="page-header">Rationale:</h2>
                    <textarea rows="5" cols="120" name="ratqaw2" class="form-control parrafo"><%

                            ArchAssistantBean p = new ArchAssistantBean();
                            Rationaleqaw ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw2");
                            if (ratq != null)
                            {
                                out.print(ratq.getRatQawDescripcion());
                            }

                    %></textarea>
                    <br/>
                    <input type="submit" value="Guardar" name="btnQaw2Guardar" class="btn btn-primary"/>
                </div>
            </form>

            <form name="qaw-2" action="QAW2" method="post" enctype="multipart/form-data">
                 <div class="col-lg-5 col-md-6 col-sm-12"> 
                    <h2 class="page-header">Archivos:</h2>
                    
                    <table width="400" border="0" class="tblCent">
                        <tr><td><input type="file" name="archivo" id="myfile"/></td>
                        <td><input type="submit" value="subir archivo" name="btnQawsubir" class="btn btn-primary"/></td></tr>
                    </table>
                    
                    <table width="400" border="0" class="tblCentfull">
                      <tbody>
                        <%
                            GuardarArchivo arch = new GuardarArchivo();
                            List<File> archivos = null;
                            if (ratq != null)
                            {
                                archivos = arch.listarArchivos(ratq.getRatQawArchivo());
                            }
                            if (archivos != null)
                            {
                                for(File archivo : archivos)
                                {
                                    out.print("<tr>");
                                    out.print("<td>"+archivo.getName()+"</td>");
                                    out.print("<td class='alDer'>"+"<button type=\"submit\"  name=\"btnQawEliminar"+archivo.getName()+"\" class=\"btn btn-primary \">  <span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span></button>        ");
                                    out.print("<button type=\"submit\" value=\"Descargar\" name=\"btnQawBajar"+archivo.getName()+"\" class=\"btn btn-primary\"/>  <span class=\"glyphicon glyphicon-download-alt\" aria-hidden=\"true\"></span></button>"+"</td>");
                                    out.print("</tr>");
                                }
                            }
                         %>
                      </tbody>
                    </table>
                 </div>
            </form>

            <form name="qaw-2" action="QAW2">    
                <table border="0" class="tblCentfull">
                  <tbody>
                    <tr>
                        <td class="alIzq"><input type="submit" value="Regresar" name="btnQaw2anterior" class="btn btn-primary btn-lg"/></td>
                        <td class="alDer"><input type="submit" value="Continuar" name="btnQaw2Continuar" class="btn btn-primary btn-lg"/></td>
                    </tr>
                  </tbody>
                </table>

            </form>
        </div>
    </body>
</html>
