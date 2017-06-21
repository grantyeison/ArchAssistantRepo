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
<%@page import="servicios.Proyecto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


        <div class="col-lg-12 col-md-12 col-md-12">
            
            <form name="qaw-2" action="QAW2">
                
                
                <h2 class="page-header">Presentación del negocio o misión del sistema a desarrollar:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        
                        Luego de la presentación inicial, uno de los representantes de los stakeholders, 
                        <div  id="descqaw2" class="collapse">
                            generalmente alguien con un cargo administrativo, explica el negocio o la misión, dejando claro cuál es el propósito de la organización, es posible que en este paso se invierta alrededor de una hora además el o los moderadores en este paso deben analizar muy bien la información presentada sacando la mayor cantidad de atributos de calidad que se puedan identificar para pasos posteriores.
                        </div>
                        <input readonly="true" style="border-width:0; color:blue; text-decoration: underline;" data-toggle="collapse" data-target="#descqaw2" id="verDescPaso" value="ver más...">
                    </div>
                    <div class="col-lg-3 col-md-2"></div>
                </div>
                <div class="col-lg-7 col-md-6 col-sm-12">
                    <h2 class="page-header">Rationale:</h2>
                    <textarea rows="5" cols="120" name="ratqaw2" class="form-control parrafo"><%
                            session.setAttribute("pasoActual", "qaw2");
                    //        Proyecto proyectoActual = (Proyecto) session.getAttribute("proyectoActual");
                    proyectoActual = (Proyecto) session.getAttribute("proyectoActual");
                    //        ArchAssistantBean p = new ArchAssistantBean();
                    p = new ArchAssistantBean();
                    //        Rationaleqaw ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw2");
                    ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw2");
                            if (ratq != null)
                            {
                                out.print(ratq.getRatQawDescripcion());
                            }

                    %></textarea>
                    <br/>
                    <input type="submit" value="Guardar" name="btnQaw2Guardar" class="btn btn-primary"/>
                </div>
            </form>

            <div class="col-lg-5 col-md-6 col-sm-12">
                <div>
                    <h2 class="page-header">Archivos:</h2>
                    <form name="qaw-2" action="QAW2" method="post" enctype="multipart/form-data">
                        <table width="400" border="0" class="tblCent">
                            <tr><td><input type="file" name="archivo" id="myfile"/></td>
                            <td><input type="submit" value="subir archivo" name="btnQawsubir" class="btn btn-primary"/></td></tr>
                        </table>
                    </form>
                </div>
                <div class="divScroll">
                    <form name="qaw-2" action="QAW2"> 

                    <table width="400" border="0" class="tblCentfull">
                      <tbody>
                        <%
                            //GuardarArchivo arch = new GuardarArchivo();
                            arch = new GuardarArchivo();
                            //List<File> archivos = null;
                            archivos = null;
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
                  </form>
                </div>
            </div>
                      <!--
            <form name="qaw-2" action="QAW2">    
                <table border="0" class="tblCent">
                  <tbody>
                    <tr>
                        <td class="alDer"><input type="submit" value="Regresar" name="btnQaw2anterior" class="btn btn-primary btn-lg"/></td>
                        <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnQawInicio" class="btn btn-primary btn-lg"/></td>
                        <td class="alCen"><input id="btnCont" type="button" value="Continuar" name="btnQaw2Continuar" class="btn btn-primary btn-lg"/></td>
                    </tr>
                  </tbody>
                </table>

            </form>-->
        </div>
                      
