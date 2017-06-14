<%-- 
    Document   : qaw8
    Created on : 25/01/2017, 08:34:51 AM
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
            
            <form name="qaw-8" action="QAW8">
                
                <h2 class="page-header">Refinamiento de los escenarios:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-2"></div>
                    <p class="parrafo col-lg-6 col-md-8 col-sm-12">
                        con el tiempo restante asignado al taller, se procederá a refinar los primeros 4 o 5 escenarios que serán los más importantes del sistema; para este proceso se debe especificar:
                    </p>
                    <div class="col-lg-3 col-md-2"></div>
                </div>

                <div class="col-lg-1"></div>
                <div class="col-lg-10 col-md-12 col-sm-12">


                    <h2 class="page-header">Escenarios de calidad:</h2>

                    <table width="100%" border="3" class="tblCentfull">
                        <tbody>
                            <tr>
                                <th scope="col">Código</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Estímulo</th>
                                <th scope="col">Fuente</th>
                                <th scope="col">Ambiente</th>
                                <th scope="col">Artefacto</th>
                                <th scope="col">Respuesta</th>
                                <th scope="col">Medida</th>
                                <th scope="col">Prioridad</th>
                                <th scope="col">Acción</th>
                            </tr>
                            <%
                                archB = new ArchAssistantBean();
                                listaEsc = archB.ListEscenarios(proyectoActual);
                                for (Escenario esce : listaEsc) {
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
                                    if (esce.getEscFuente() != null) {
                                        out.println("<td>");
                                        out.println(esce.getEscFuente());
                                        out.println("</td>");
                                    } else {
                                        out.println("<td>&nbsp;</td>");
                                    }
                                    out.println("<td>" + esce.getEscAmbiente());
                                    out.println("</td>");
                                    if (esce.getEscArtefacto() != null) {
                                        out.println("<td>");
                                        out.println(esce.getEscArtefacto());
                                        out.println("</td>");
                                    } else {
                                        out.println("<td>&nbsp;</td>");
                                    }
                                    out.println("<td>" + esce.getEscRespuesta());
                                    out.println("</td>");
                                    if (esce.getEscMedidaRespuesta() != null) {
                                        out.println("<td>");
                                        out.println(esce.getEscMedidaRespuesta());
                                        out.println("</td>");
                                    } else {
                                        out.println("<td>&nbsp;</td>");
                                    }
                                    out.println("<td>");
                                    if (esce.getEscPrioridad() != null) {
                                        out.println(esce.getEscPrioridad());
                                    } else {
                                        out.println(0);
                                    }
                                    out.println("</td>");
                                    out.println("<td><button type=\"submit\" value=\"votar\" name=\"btnQaw8Refinar" + esce.getEscID() + "\" class=\"btn btn-primary\" >  <span class=\"glyphicon glyphicon-cog\" aria-hidden=\"true\"></span></button></td>");
                                    out.println("</tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="col-lg-1"></div>

                <div class="col-lg-7 col-md-6 col-sm-12">
                    <h2 class="page-header">Rationale:</h2>
                    <textarea rows="5" cols="120" name="ratqaw8" class="form-control parrafo"><%
                        session.setAttribute("pasoActual", "qaw8");
                         p = new ArchAssistantBean();
                         ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw8");
                        if (ratq != null) {
                            out.print(ratq.getRatQawDescripcion());
                        }
                        %></textarea>
                    <br/>
                    <input type="submit" value="Guardar" name="btnQaw8Guardar"  class="btn btn-primary"/>
                </div>
            </form>

            <div class="col-lg-5 col-md-6 col-sm-12">
                <div>
                    <h2 class="page-header">Archivos:</h2>
                    <form name="qaw-8" action="QAW8" method="post" enctype="multipart/form-data">
                        <table width="400" border="0" class="tblCent">
                            <tr><td><input type="file" name="archivo" id="myfile"/></td>
                                <td><input type="submit" value="subir archivo" name="btnQawsubir" class="btn btn-primary"/></td></tr>
                        </table>
                    </form>
                </div>
                <div class="divScroll">
                    <form name="qaw-8" action="QAW8"> 

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
                                            out.print("<td class='alDer'>" + "<button type=\"submit\"  name=\"btnQawEliminar" + archivo.getName() + "\" class=\"btn btn-primary \">  <span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span></button>        ");
                                            out.print("<button type=\"submit\" value=\"Descargar\" name=\"btnQawBajar" + archivo.getName() + "\" class=\"btn btn-primary\"/>  <span class=\"glyphicon glyphicon-download-alt\" aria-hidden=\"true\"></span></button>" + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
            <form name="qaw-8" action="QAW8">   
                <table border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td class="alDer"><input type="submit" value="Regresar" name="btnQaw8anterior" class="btn btn-primary btn-lg"/></td>                            
                            <td class="alCen"><input id="btnCont" value="Inicio" name="btnQaw8Inicio" class="btn btn-primary btn-lg"/></td>
                            <td class="alDer"><input type="submit" value="Continuar" name="btnQaw8continuar" class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <%//@include file='popupRationale.jsp'%>      
        <script>
             $("#btnCont").click(function()
             {
                 $("#mostrarmodal").modal("show");
             });
         </script>