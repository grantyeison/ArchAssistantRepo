<%-- 
    Document   : qaw6
    Created on : 25/01/2017, 08:34:02 AM
    Author     : Prometheus
--%>

<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="java.util.LinkedList"%>
<%@page import="servicios.Atributocalidad"%>
<%@page import="servicios.Escenario"%>
<%@page import="java.util.List"%>
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
                <td><a href="QAW4.html"><h3>Paso 4</h3></a></td>
                <td><a href="QAW5.html"><h3>Paso 5</h3></a></td>
                <td><h1>Paso 6</h1></td>
                <td><h3>Paso 7</h3></td>
                <td><h3>Paso 8</h3></td>
              </tr>
            </tbody>
        </table>
        <form name="qaw-6" action="QAW6">
            <h2>Consolidación de escenarios:</h2>
            <p align="justify">
                Teniendo una lista de varios escenarios generados durante la lluvia de ideas, se hace una consolidación de los mismos buscando escenarios que sean muy similares o que se puedan mezclar en uno solo, para esto, se hace una votación por parte de los stakeholders siendo cuidadosos de no perder funcionalidades al hacer la fusión, para evitar que no se pierda el trabajo hecho en el paso anterior.
            </p>

            <h2>Escenarios:</h2>

            <h3>Lista de escenarios:</h3>
            <table width="100%" border="3">
              <tbody>
                <tr>
                  <th scope="col">Código</th>
                  <th scope="col">Nombre</th>
                  <th scope="col">Estímulo</th>
                  <th scope="col">ambiente</th>
                  <th scope="col">Respuesta</th>
                </tr>
                <%
                    List<Integer> atributosEscogidos = new LinkedList<Integer>();
                    int id = 0;
                    int index = -1;
                    int bandera = Integer.parseInt(session.getAttribute("sigAtr").toString());
                    List<Atributocalidad> listaAtributos;
                    ArchAssistantBean p = new ArchAssistantBean();
                    listaAtributos = p.ListarAtr();
                    Rationaleqaw ratq4 = p.RationaleQAW(proyectoActual.getProID(), "qaw4");
                    Atributocalidad atrActual = (Atributocalidad)session.getAttribute("AtributoActual");
                    String ratio;
                    String[] listAc = null;
                    int indiceAtribs = 0;
                    if (ratq4 != null)
                    {
                        ratio = ratq4.getRatQawDescripcion();
                        indiceAtribs = ratio.indexOf(",~|~|");
                        if (indiceAtribs != 0)
                        {
                            String ac = ratio.substring(0, indiceAtribs);
                            listAc = ac.split(",");
                        }
                    }
                    for (String i : listAc)
                    {
                        atributosEscogidos.add(Integer.parseInt(i));
                    }
                    atrActual = (Atributocalidad) session.getAttribute("AtributoActual");
                    System.out.println("atractual: "+atrActual+" bandera "+ session.getAttribute("sigAtr"));
                    if (atrActual != null)
                    {
                        index = atributosEscogidos.indexOf(atrActual.getAcID());
                    }
                    if (atributosEscogidos.size()> index+1)
                    {
                        if (bandera == 1)
                        {
                            id = atributosEscogidos.get(index+1);
                        }
                        else 
                        {
                            if (index == -1)
                            {
                                index = 0;
                            }
                            id = atributosEscogidos.get(index);
                        }
                    }
                    else
                    {
                        id = atributosEscogidos.get(index);
                    }
                    atrActual = p.buscarAtr(id);
                    
                    session.setAttribute("AtributoActual", atrActual);
                                        
                    out.println("<h2> Escenarios de Atributo "+atrActual.getAcNombre()+"</h2>");

                    ArchAssistantBean archB = new ArchAssistantBean();
                    List<Escenario> listaEsc = archB.ListEscenarios(proyectoActual);
                    for (Escenario esce : listaEsc)
                    {
                        if (esce.getTblAtributoCalidadacID().getAcID() == id)
                        {
                              out.println("<tr>");
                              out.println("<td>");
                              out.println(esce.getEscID());
                              out.println("</td>");
                              out.println("<td>");
                              out.println(esce.getEscNombre());
                              out.println("</td>");
                              out.println("<td>");
                              out.println(esce.getEscEstimulo());
                              out.println("</td>");
                              out.println("<td>");
                              out.println(esce.getEscAmbiente());
                              out.println("</td>");
                              out.println("<td>");
                              out.println(esce.getEscRespuesta());
                              out.println("</td>");
                              out.println("</tr>");
                        }
                    }
              %>
              </tbody>
            </table>



            <table width="100" border="0">
              <tbody>
                <tr>
                    <td>Código del Escenario: </td>
                    <td><input type="text" name="txtQaw6CodigoSeleccionar"/></td>
                </tr>
                <tr>
                    <td><input type="submit" value="Seleccionar o crear" name="btnQaw6SeleccionarEscenario"/></td>
                    <td><input type="submit" value="Eliminar" name="btnQaw6EliminarEscenario"/></td>
                </tr>
              </tbody>
            </table>
            
            <input type="submit" value="Siguiente" name="btnQaw6SiguienteAtributo"/>  
              
            <h2>Rationale:</h2>
            <textarea rows="5" cols="120" name="ratqaw6"><%
                    //ArchAssistantBean p = new ArchAssistantBean();
                    Rationaleqaw ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw6");
                    if (ratq != null)
                    {
                        out.print(ratq.getRatQawDescripcion());
                    }
                %></textarea>
                <br/>
                <input type="submit" value="Guardar" name="btnQaw6Guardar"/>
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

            <form name="qaw-6" action="QAW6" method="post" enctype="multipart/form-data">
                <input type="file" name="archivo" id="myfile"/>
                <input type="submit" value="subir archivo" name="btnQawsubir"/>
            </form>

            <form name="qaw-6" action="QAW6">    
                <table width="100" border="0">
                  <tbody>
                    <tr>
                        <td><input type="submit" value="Regresar" name="btnQaw6anterior"/></td>
                      <td><input type="submit" value="Continuar" name="btnQaw6Continuar" /></td>
                    </tr>
                  </tbody>
                </table>
            </form>
    </body>
</html>
