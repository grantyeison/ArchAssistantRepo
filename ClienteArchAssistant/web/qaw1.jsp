<%-- 
    Document   : qaw1
    Created on : 20/01/2017, 04:16:32 PM
    Author     : Prometheus
--%>

<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page import="servicios.Rationaleqaw"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <div class="col-lg-12 col-md-12 col-sm-12">
            
            <form name="qaw-1" action="QAW1">
               
                    <ul class="tim"></ul>
               <!-- <table width="100%" border="0" class="tblCentfull">
                    <tbody>
                        <tr>
                            <td><%/*
                                    String paso = proyectoActual.getProAvance();
                                    int avan = Integer.parseInt(paso.substring(3));
                                    System.out.println("avance actual: "+avan);
                                    if (avan == 0 || avan == 1)
                                    {
                                        out.print("<a href=\"qaw1.jsp\">");
                                    }*/
                                %><h1 class="bienvenida">Paso 1</h1></td>
                            <td><h3 class="bienvenida">Paso 2</h3></td>
                            <td><h3 class="bienvenida">Paso 3</h3></td>
                            <td><h3 class="bienvenida">Paso 4</h3></td>
                            <td><h3 class="bienvenida">Paso 5</h3></td>
                            <td><h3 class="bienvenida">Paso 6</h3></td>
                            <td><h3 class="bienvenida">Paso 7</h3></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                            
                            <!-- 
                            <td><a href="qaw1.jsp"><h3 class="bienvenida">Paso 1</h3></a></td>
                            <td><a href="qaw2.jsp"><h3 class="bienvenida">Paso 2</h3></a></td>
                            <td><a href="qaw3.jsp"><h3 class="bienvenida">Paso 3</h3></a></td>
                            <td><a href="qaw4.jsp"><h3 class="bienvenida">Paso 4</h3></a></td>
                            <td><a href="qaw5.jsp"><h3 class="bienvenida">Paso 5</h3></a></td>
                            <td><a href="qaw6.jsp"><h3 class="bienvenida">Paso 6</h3></a></td>
                            <td><a href="qaw7.jsp"><h3 class="bienvenida">Paso 7</h3></a></td>
                            <td><h1 class="bienvenida">Paso 8</h1></td> 
                            
                        </tr>
                    </tbody>
                </table>-->
                <h2 class="page-header">Presentación de QAW e introducciones:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">

                            En este paso, se explica detalladamente el propósito y funcionalidad de QAW
                        <div  id="descqaw1" class="collapse">
                                dando a conocer cada uno de los pasos de manera clara a los involucrados, además 
                                cada uno de ellos se presentará a sí mismo indicando su rol en la organización y su 
                                relación con el sistema a desarrollar.
                            
                        </div>
                            <u><input readonly="true" class="textColl" style="border-width:0; color:blue; text-decoration: underline;" data-toggle="collapse" data-target="#descqaw1" id="verDescPaso" value="ver más..."></u>
                    </div>
                    <div class="col-lg-3 col-md-2"></div>
                </div>
                <div class="col-lg-7 col-md-6 col-sm-12">
                    <h2 class="page-header">Rationale:</h2>
                    <textarea rows="5" cols="120" name="ratqaw1" class="form-control parrafo"><%
                        session.setAttribute("pasoActual", "qaw1");
                        ArchAssistantBean p = new ArchAssistantBean();
                        Rationaleqaw ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw1");
                        if (ratq != null) {
                            out.print(ratq.getRatQawDescripcion());
                        }
                        %></textarea>
                    <br/>
                    <input type="submit" value="Guardar" name="btnQaw1Guardar" class="btn btn-primary"/>
                </div>
            </form>

            <div class="col-lg-5 col-md-6 col-sm-12">
                <div>
                    <form name="qaw-1" action="QAW1" method="post"  enctype="multipart/form-data">
                        <h2 class="page-header">Archivos:</h2>
                        <table width="400" border="0" class="tblCent">
                            <tr><td><input type="file" name="archivo" id="myfile" class="filestyle"/></td>
                                <td><input type="submit" value="subir archivo" name="btnQawsubir" class="btn btn-primary"/></td></tr>
                        </table>
                    </form>
                </div>
                <div class="divScroll">
                    <form name="qaw-1" action="QAW1"> 

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
                                            out.print("<td class='alDer'>" + "<button type=\"submit\" value=\"Eliminar\" name=\"btnQawEliminar"
                                                    + archivo.getName() + "\" class=\"btn btn-primary\"/>  "
                                                    + "<span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span></button>        ");
                                            out.print("<button type=\"submit\" value=\"Descargar\" name=\"btnQawBajar"
                                                    + archivo.getName() + "\" class=\"btn btn-primary\"/>  "
                                                    + "<span class=\"glyphicon glyphicon-download-alt\" aria-hidden=\"true\">"
                                                    + "</span></button>" + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
                            <!--
            <form name="qaw-1" action="QAW1">
                <table width="100" border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnQawInicio" class="btn btn-primary btn-lg"/></td>
                            <td class="alCen"><input id="btnCont" type="button" value="Continuar" name="btnQaw1Continuar" class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>-->
        </div>
              
    