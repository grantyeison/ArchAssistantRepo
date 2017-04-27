<%-- 
    Document   : qaw4
    Created on : 25/01/2017, 08:33:34 AM
    Author     : Prometheus
--%>

<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="java.util.List"%>
<%@page import="servicios.Atributocalidad"%>
<%@page import="servicios.Rationaleqaw"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - QAW</title>
    </head>
    <body>
        <form name="qaw-4" action="QAW4">
            <h1 align="center">ArchAssistant</h1>
            <h2 align="center">QAW</h2>
            <h2 align="center"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
            <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
            <table width="100%" border="0" align="center">
            <tbody>
              <tr>
                <td><a href="QAW1.html"><h3>Paso 1</h3></a></td>
                <td><a href="QAW2.html"><h3>Paso 2</h3></a></td>
                <td><a href="QAW3.html"><h3>Paso 3</h3></a></td>
                <td><h1>Paso 4</h1></td>
                <td><h3>Paso 5</h3></td>
                <td><h3>Paso 6</h3></td>
                <td><h3>Paso 7</h3></td>
                <td><h3>Paso 8</h3></td>
              </tr>
            </tbody>
            </table>
            <h2>Identificación de los drivers arquitecturales:</h2>
            <p align="justify">
                En este paso, los facilitadores dan a los presentes un tiempo de descanso durante el cual consolidan las notas tomadas en los pasos 2 y 3, revisando las restricciones, atributos de calidad, drivers, y todo lo demás identificado por cada uno, luego, hacen una presentación de esta información a los stakeholders, pidiendo correcciones, adiciones o que se elimine lo que no sea necesario, con la finalidad de tener una lista de atributos directores en los cuales basarse para pasos posteriores, además, con el propósito de que todos en el taller tengan un conocimiento común sobre los drivers que se manejarán más adelante.
            </p>

            <h2>Controladores proyecto:</h2>
                <%
                    
                    ArchAssistantBean p = new ArchAssistantBean();
                    Rationaleqaw ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw4");
                    List<Atributocalidad> listaAtributos = p.ListarAtr();
                    List<Atributocalidad> atrEscogidos = p.ObtenerAtributosEscogidos(ratq);
                    if (atrEscogidos != null)
                    {
                        for (Atributocalidad atr2 : atrEscogidos)
                        {
                            System.out.println("¨¨¨¨¨¨¨¨¨"+atr2.getAcID());
                        }
                    }
                    out.println("<table border=\"0\">");
                    out.println("<tbody>");
                    
                    for (Atributocalidad atr : listaAtributos)
                    {
                        out.println("<tr>");
                        out.println("<td>");
                        out.println("<input type=\"checkbox\" name=\"chk"+atr.getAcID()+"\" ");
                        for (Atributocalidad atrEsc : atrEscogidos)
                        {
                            if (atr.getAcID() == atrEsc.getAcID())
                            {
                                out.println("checked");
                            }
                        }
                        
                        out.println(">" + atr.getAcNombre()+": ");
                        
                        out.println("</td>");
                        out.println("<td>");
                        out.println(atr.getAcDescripcion());
                        out.println("</td>");
                        out.println("</tr>");
                    } 
                    out.println("</tbody>");
                    out.println("</table>");
                %>
            <table width="100" border="0">
              <tbody>
                <tr>
                    <td><input type="submit" name="btnqaw4GuardarSelec" value="Guardar Seleccionados"</td>
                    <td><input type="reset" value="Cancelar"/></td>
                </tr>
                <tr>
                  <td>Nombre:</td>
                  <td><input type="text" name="TxtAtribNombreNueAtri"/></td>
                </tr>
                <tr>
                  <td>Descripción:</td>
                  <td> <input type="text" name="TxtAtribDescripNueAtrib"/></td>
                </tr>
                <tr>
                  <td><input type="submit" name="BtnQaw4GuardarNuevoAtributo" value="Guardar"/></td>
                  <td><input type="reset" value="Cancelar"/></td>
                </tr>
              </tbody>
            </table>
              
            <h2>Rationale:</h2>
            <textarea rows="5" cols="120" name="ratqaw4"><%
                    ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw4");
                    if (ratq != null)
                    {
                        int indiceAtribs = 0;
                        String ratio = ratq.getRatQawDescripcion();
                        if (ratio != null || ratio != "")
                        {
                            indiceAtribs = ratio.indexOf("~|~|")+4;
                        }
                        out.print(ratio.substring(indiceAtribs));
                    }
                %></textarea>
                <br/>
                <input type="submit" value="Guardar" name="btnQaw4Guardar"/>
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
                            System.out.println("listados");
                            out.print("<tr>");
                            out.print("<td>"+archivo.getName()+"</td>");
                            out.print("<td>"+"<input type=\"submit\" value=\"Eliminar\" name=\"btnQaw4Eliminar"+archivo.getName()+"\"/>"+"</td>");
                            out.print("<td>"+"<input type=\"submit\" value=\"Descargar\" name=\"btnQaw4Bajar"+archivo.getName()+"\"/>"+"</td>");
                            out.print("</tr>");
                        }
                    }
                 %>
              </tbody>
            </table>
        </form>
              
        <form name="qaw-4" action="QAW4" method="post" enctype="multipart/form-data">
            <input type="file" name="archivo" id="myfile"/>
            <input type="submit" value="subir archivo" name="btnQaw4subir"/>
        </form>
              
        <form name="qaw-4" action="QAW4">    
            <table width="100" border="0">
              <tbody>
                <tr>
                    <td><input type="submit" value="Regresar" name="btnQaw4anterior"/></td>
                    <td><input type="submit" value="Continuar" name="btnQaw4Continuar"/></td>
                </tr>
              </tbody>
            </table>
        </form>
    </body>
</html>
