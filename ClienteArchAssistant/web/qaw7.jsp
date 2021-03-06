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

        <div class="col-lg-12 col-md-12 col-md-12">
            
            <form name="qaw-7" action="QAW7">
                
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
                            archB = new ArchAssistantBean();
                            listaEsc = archB.ListEscenarios(proyectoActual);
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
                        session.setAttribute("pasoActual", "qaw7");
                         p = new ArchAssistantBean();
                         ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw7");
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
                                     arch = new GuardarArchivo();
                                    archivos = null;
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
                            <td class="alCen"><input id="btnCont" value="Continuar" name="btnQaw7Continuar"  class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
            <%//@include file='popupRationale.jsp'%>      
            <script>
                 $("#btnCont").click(function()
                 {
                     $("#mostrarmodal").modal("show");
                 });
             </script>
        </div>
    </body>
</html>
