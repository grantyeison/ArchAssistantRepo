<%-- 
    Document   : add2
    Created on : 25/01/2017, 12:30:08 PM
    Author     : Prometheus
--%>

<%@page import="servicios.Modulo"%>
<%@page import="java.util.List"%>
<%@page import="servicios.Rationaleadd"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - ADD</title>
    </head>
    <body>
        <form name="add-2" action="ADD2">
            <h1 align="center">ArchAssistant</h1>
            <h2 align="center">ADD</h2>
            <h2 align="center"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
            <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
            <table width="100%" border="0" align="center">
                <tbody>
                    <tr>
                      <td><a href="ADD1.html"><h3>Paso 1</h3></a></td>
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
                <h2>Escoger un elemento del sistema para descomponerlo:</h2>
                <p align="justify">
                    Durante este paso, se escoge el elemento en el cual se enfocará el proceso, el primer elemento que se descompone es el sistema en sí, en caso de ya haber sido descompuesto, cada elemento debe tener asignados algunos de los requerimientos.</br>
                            Para escoger un elemento, hay que basarse en las siguientes áreas:
                </p>
                <ul>
                    <li>Conocimiento de la arquitectura.</li>
                    <li>Riesgo y dificultad.</li>
                    <li>Criterio de negocios.</li>
                    <li>Criterio organizacional.</li>
                </ul>


                    <h2>Módulos del sistema:</h2><!-- inicialmente será todo el sistema, además todos los escenarios estarán asociados a este único módulo
                posteriormente, se dividirá el sistema en módulos y a cada uno se le asignará un conjunto de escenarios -->
                <table width="100%" border="3">
                  <tbody>
                    <tr>
                      <th scope="col">Código</th>
                      <th scope="col">Nombre</th>
                      <th scope="col">Descripción</th>
                      <th scope="col">Módulo final</th>
                    </tr>
                    <%
                    ArchAssistantBean archB = new ArchAssistantBean();
                    List<Modulo> listaMod = archB.ListarModulos(proyectoActual);
                    
                    for (Modulo mod : listaMod)
                    {
                      out.println("<tr>");
                      out.println("<td>");
                      out.println(mod.getModId());
                      out.println("</td>");
                      out.println("<td>");
                      out.println(mod.getModDescripcion());
                      out.println("</td>");
                      out.println("<td>");
                      out.println(mod.getModFinal());
                      out.println("</td>");
                    }
                    
                    %>
                  </tbody>
                  </table>
                  <input type="button" value="Seleccionar Elemento"/>
      
            <h2>Rationale:</h2>
            <textarea rows="5" cols="120" name="ratadd2">
                <%
                    ArchAssistantBean p = new ArchAssistantBean();
                    Rationaleadd rata = p.RationaleADD(proyectoActual.getProID(),"add2");
                    if (rata != null)
                    {
                        out.print(rata.getRatAddDescripcion());
                    }
                %>
            </textarea>
            <table width="100" border="0">
              <tbody>
                <tr>
                    <td><input type="submit" value="Guardar" name="btnAdd2Guardar"/></td>
                </tr>
                <tr>
                    <td><input type="submit" value="Regresar" name="btnAdd2anterior"/></td>
                    <td><input type="submit" value="Continuar" name="btnAdd2Continuar"/></td>
                </tr>
              </tbody>
            </table>
        </form>
    </body>
</html>
