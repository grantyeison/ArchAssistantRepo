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
         
        <form name="qaw-3" action="QAW3">
            <h1 align="center">ArchAssistant</h1>
            <h2 align="center">QAW</h2>
            <h2 align="center"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
            <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
            <table width="100%" border="0" align="center">
                <tbody>
                  <tr>
                    <td><a href="qaw1.jsp"><h3>Paso 1</h3></a></td>
                    <td><a href="qaw2.jsp"><h3>Paso 2</h3></a></td>
                    <td><h1>Paso 3</h1></td>
                    <td><h3>Paso 4</h3></td>
                    <td><h3>Paso 5</h3></td>
                    <td><h3>Paso 6</h3></td>
                    <td><h3>Paso 7</h3></td>
                    <td><h3>Paso 8</h3></td>
                  </tr>
                </tbody>
            </table>
            <h2>Presentación del plan arquitectural:</h2>
            <p align="justify">
                Si bien a estas alturas del taller no se conoce aún la arquitectura del sistema, se pueden tener algunos gráficos generales técnicos que aclaren a los participantes un poco cual es la finalidad del proceso en curso, en este paso se puede mostrar la siguiente información:
            </p>
            <ul>
                <li>planes para satisfacer los requerimientos del negocio/misión.</li>
                <li>Información técnica como especificaciones físicas de los equipos, sistemas operativos, estándares.</li>
                <li>Diagramas de contexto, diagramas de alto nivel del sistema y otras descripciones.</li>
            </ul>

            <h2>Rationale:</h2>
            <textarea rows="5" cols="120" name="ratqaw3"><%
                
                    ArchAssistantBean p = new ArchAssistantBean();
                    Rationaleqaw ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw3");
                    if (ratq != null)
                    {
                        out.print(ratq.getRatQawDescripcion());
                    }
                
            %></textarea>
            <br/>
            <input type="submit" value="Guardar" name="btnQaw3Guardar"/>
            <table width="400" border="0">
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
                            out.print("<td>"+"<input type=\"submit\" value=\"Eliminar\" name=\"btnQaw3Eliminar"+archivo.getName()+"\"/>"+"</td>");
                            out.print("<td>"+"<input type=\"submit\" value=\"Descargar\" name=\"btnQaw3Bajar"+archivo.getName()+"\"/>"+"</td>");
                            out.print("</tr>");
                        }
                    }
                 %>
              </tbody>
            </table>
        </form>
              
        <form name="qaw-3" action="QAW3" method="post" enctype="multipart/form-data">
            <input type="file" name="archivo" id="myfile"/>
            <input type="submit" value="subir archivo" name="btnQaw3subir"/>
        </form>
              
        <form name="qaw-3" action="QAW3">    
            <table width="100" border="0">
              <tbody>
                <tr>
                    <td><input type="submit" value="Regresar" name="btnQaw3anterior"/></td>
                    <td><input type="submit" value="Continuar" name="btnQaw3Continuar"/></td>
                </tr>
              </tbody>
            </table>
        </form>
        
    </body>
</html>
