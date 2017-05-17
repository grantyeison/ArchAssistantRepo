<%-- 
    Document   : qaw7
    Created on : 25/01/2017, 08:34:12 AM
    Author     : Prometheus
--%>

<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
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
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <script src="./js/jquery-3.2.1.js"></script>
        <!--<script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/bootstrap.min.js"></script>

    </head>
    <body>
        <div class="col-lg-12 col-md-12 col-md-12">
            <form name="qaw-7" action="QAW7">
                <h2 class="subtitle">QAW</h2>
                <h2 class="bienvenida"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
                <table border="0" class="tblCentfull">
                    <tbody>
                        <tr>
                            <td><a href="QAW1.html"><h3 class="bienvenida">Paso 1</h3></a></td>
                            <td><a href="QAW2.html"><h3 class="bienvenida">Paso 2</h3></a></td>
                            <td><a href="QAW3.html"><h3 class="bienvenida">Paso 3</h3></a></td>
                            <td><a href="QAW4.html"><h3 class="bienvenida">Paso 4</h3></a></td>
                            <td><a href="QAW5.html"><h3 class="bienvenida">Paso 5</h3></a></td>
                            <td><a href="QAW6.html"><h3 class="bienvenida">Paso 6</h3></a></td>
                            <td><h1 class="bienvenida">Paso 7</h1></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                        </tr>
                    </tbody>
                </table>
                <h2 class="page-header">Priorización de los escenarios:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-2"></div>
                    <p class="parrafo col-lg-6 col-md-8 col-sm-12">
                        Una vez estén los escenarios definitivos a usar en el sistema, los stakeholders realizarán una votación para organizarlos por su nivel de importancia; se asigna una cantidad de votos a cada participante igual a un tercio de la cantidad de escenarios que haya y se redondea al número par superior o igual, de este modo se podrá hacer dos rondas de votaciones de modo que cada participante indique en la ronda inicial con la mitad de sus votos los escenarios más importantes y luego nuevamente en la segunda ronda, una persona puede votar en ambas rondas por los mismos escenarios.
                    </p>
                    <div class="col-lg-3 col-md-2"></div>
                </div>

                <h2 class="page-header">Escenarios de calidad:</h2>

                <table width="100%" border="3" class="tblCentContent">
                    <tbody>
                        <tr>
                            <th scope="col" class="alCen">Nombre</th>
                            <th scope="col" class="alCen">Estímulo</th>
                            <th scope="col" class="alCen">ambiente</th>
                            <th scope="col" class="alCen">Respuesta</th>
                            <th scope="col" class="alCen">Votos</th>
                        </tr>
                        <%
                            ArchAssistantBean archB = new ArchAssistantBean();
                            List<Escenario> listaEsc = archB.ListEscenarios(proyectoActual);
                            for (Escenario esce : listaEsc) {
                                out.println("<tr>");
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
                                out.println("<td>");
                                if (esce.getEscPrioridad() != null) {
                                    out.println(esce.getEscPrioridad());
                                } else {
                                    out.println(0);
                                }
                                out.println("<button type=\"submit\" value=\"votar\" name=\"btnQaw7Prioridad" + esce.getEscID() + "\" class=\"btn btn-primary\" >  <span class=\"glyphicon glyphicon-thumbs-up\" aria-hidden=\"true\"></span></button></td>");
                                out.println("</tr>");
                            }
                        %>
                    </tbody>
                </table>

                <div class="col-lg-7 col-md-6 col-sm-12">
                    <h2 class="page-header">Rationale:</h2>
                    <textarea rows="5" cols="120" name="ratqaw7" class="form-control parrafo"><%
                        ArchAssistantBean p = new ArchAssistantBean();
                        Rationaleqaw ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw7");
                        if (ratq != null) {
                            out.print(ratq.getRatQawDescripcion());
                        }
                        %></textarea>
                    <br/>
                    <input type="submit" value="Guardar" name="btnQaw7Guardar" class="btn btn-primary"/>
                </div>
            </form>

            <div class="col-lg-5 col-md-6 col-sm-12">
                <div>
                    <h2 class="page-header">Archivos:</h2>
                    <form name="qaw-7" action="QAW7" method="post" enctype="multipart/form-data">
                        <table width="400" border="0" class="tblCent">
                            <tr><td><input type="file" name="archivo" id="myfile"/></td>
                                <td><input type="submit" value="subir archivo" name="btnQawsubir" class="btn btn-primary"/></td></tr>
                        </table>
                    </form>
                </div>
                <div class="divScroll">
                    <form name="qaw-7" action="QAW7"> 

                        <table width="400" border="0" class="tblCentfull">
                            <tbody>
                                <%
                                    GuardarArchivo arch = new GuardarArchivo();
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
            <form name="qaw-7" action="QAW7">    
                <table border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td class="alDer"><input type="submit" value="Regresar" name="btnQaw7anterior"  class="btn btn-primary btn-lg"/></td>
                            <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnQawInicio" class="btn btn-primary btn-lg"/></td>
                            <td class="alIzq"><input type="submit" value="Continuar" name="btnQaw7Continuar"  class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>

            </form>
        </div>
    </body>
</html>
