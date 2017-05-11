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
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <script src="./js/jquery-3.2.1.js"></script>
        <!--<script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/bootstrap.min.js"></script>
    </head>
    <body>
        <form name="qaw-2" action="QAW2">
            <h1 align="center">ArchAssistant</h1>
            <h2 align="center">QAW</h2>
            <h2 align="center"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
            <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
            <table width="100%" border="0" align="center">
              <tbody>
                <tr>
                  <td><a href="QAW1.html"><h3>Paso 1</h3></a></td>
                  <td><h1>Paso 2</h1></td>
                  <td><h3>Paso 3</h3></td>
                  <td><h3>Paso 4</h3></td>
                  <td><h3>Paso 5</h3></td>
                  <td><h3>Paso 6</h3></td>
                  <td><h3>Paso 7</h3></td>
                  <td><h3>Paso 8</h3></td>
                </tr>
              </tbody>
            </table>
            <h2>Presentación del negocio o misión del sistema a desarrollar:</h2>
            <p align="justify">
                luego de la presentación inicial, uno de los representantes de los stakeholders, generalmente alguien con un cargo administrativo, explica el negocio o la misión, dejando claro cuál es el propósito de la organización, es posible que en este paso se invierta alrededor de una hora además el o los moderadores en este paso deben analizar muy bien la información presentada sacando la mayor cantidad de atributos de calidad que se puedan identificar para pasos posteriores.
            </p>
            <h2>Rationale:</h2>
            <textarea rows="5" cols="120" name="ratqaw2"><%
                
                    ArchAssistantBean p = new ArchAssistantBean();
                    Rationaleqaw ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw2");
                    if (ratq != null)
                    {
                        out.print(ratq.getRatQawDescripcion());
                    }
                
            %></textarea>
            <br/>
            <input type="submit" value="Guardar" name="btnQaw2Guardar"/>
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
                            out.print("<td>"+"<input type=\"submit\" value=\"Eliminar\" name=\"btnQawEliminar"+archivo.getName()+"\"/>"+"</td>");
                            out.print("<td>"+"<input type=\"submit\" value=\"Descargar\" name=\"btnQawBajar"+archivo.getName()+"\"/>"+"</td>");
                            out.print("</tr>");
                        }
                    }
                 %>
              </tbody>
            </table>
        </form>
              
        <form name="qaw-2" action="QAW2" method="post" enctype="multipart/form-data">
            <input type="file" name="archivo" id="myfile"/>
            <input type="submit" value="subir archivo" name="btnQawsubir"/>
        </form>
              
        <form name="qaw-2" action="QAW2">    
            <table width="100" border="0">
              <tbody>
                <tr>
                  <td><input type="submit" value="Regresar" name="btnQaw2anterior"/></td>
                  <td><input type="submit" value="Continuar" name="btnQaw2Continuar"/></td>
                </tr>
              </tbody>
            </table>

        </form>
    </body>
</html>
