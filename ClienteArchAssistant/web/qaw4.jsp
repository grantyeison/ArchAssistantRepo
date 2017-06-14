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

        <div class="col-lg-12 col-md-12 col-md-12">
            
            <form name="qaw-4" action="QAW4">
                
                <h2 class="page-header">Identificación de los drivers arquitecturales:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <p class="parrafo">
                            En este paso, los facilitadores dan a los presentes un tiempo de descanso durante el cual consolidan las notas tomadas en los pasos 2 y 3, revisando las restricciones, atributos de calidad, drivers, y todo lo demás identificado por cada uno, luego, hacen una presentación de esta información a los stakeholders, pidiendo correcciones, adiciones o que se elimine lo que no sea necesario, con la finalidad de tener una lista de atributos directores en los cuales basarse para pasos posteriores, además, con el propósito de que todos en el taller tengan un conocimiento común sobre los drivers que se manejarán más adelante.
                        </p>
                    </div>
                    <div class="col-lg-3 col-md-2"></div>
                </div>
                <h2 class="bienvenida">Atributos de Calidad del proyecto:</h2>
                <%

                     p = new ArchAssistantBean();
                     ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw4");
                    List<Atributocalidad> listaAtributos = p.ListarAtr();
                    List<Atributocalidad> atrEscogidos = p.ObtenerAtributosEscogidos(ratq);
                    out.println("<table border=\"0\" class=\"tblCentContent\">");
                    out.println("<tbody>");
                    Atributocalidad atr;
                    for (int i = 0; i <= listaAtributos.size(); i += 3) {
                        if (listaAtributos.size() > i) {
                            atr = listaAtributos.get(i);
                            out.println("<tr>");
                            out.println("<td class=\"alIzq\">");
                            out.println("<input type=\"checkbox\" name=\"chk" + atr.getAcID() + "\" ");
                            for (Atributocalidad atrEsc : atrEscogidos) {
                                if (atr.getAcID() == atrEsc.getAcID()) {
                                    out.println("checked");
                                }
                            }
                            out.println(">\t" + atr.getAcNombre());
                            out.println("<input readonly hidden='true' value ='" + atr.getAcDescripcion() + "' id=atrDesc'" + atr.getAcID() + "'/>");
                            out.println("</td>");
                        }

                        if (listaAtributos.size() > i + 1) {
                            atr = listaAtributos.get(i + 1);
                            out.println("<td class=\"alIzq\">");
                            out.println("<input type=\"checkbox\" name=\"chk" + atr.getAcID() + "\" ");
                            for (Atributocalidad atrEsc : atrEscogidos) {
                                if (atr.getAcID() == atrEsc.getAcID()) {
                                    out.println("checked");
                                }
                            }
                            out.println(">\t" + atr.getAcNombre());
                            out.println("<input readonly hidden='true' value ='" + atr.getAcDescripcion() + "' id=atrDesc'" + atr.getAcID() + "'/>");
                            out.println("</td>");
                        }

                        if (listaAtributos.size() > i + 2) {
                            atr = listaAtributos.get(i + 2);
                            out.println("<td class=\"alIzq\">");
                            out.println("<input type=\"checkbox\" class=\"margenS\" name=\"chk" + atr.getAcID() + "\" ");
                            for (Atributocalidad atrEsc : atrEscogidos) {
                                if (atr.getAcID() == atrEsc.getAcID()) {
                                    out.println("checked");
                                }
                            }
                            out.println(">\t" + atr.getAcNombre());
                            out.println("<input readonly hidden='true' value ='" + atr.getAcDescripcion() + "' id=atrDesc'" + atr.getAcID() + "'/>");
                            out.println("</td>");
                        }
                        out.println("</tr>");

                    }

                    out.println("</div>");
                    out.println("</tbody>");
                    out.println("</table>");
                %>
                <table width="100" border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td><input type="submit" name="btnqaw4GuardarSelec" value="Guardar Seleccionados" class="btn btn-primary"</td>
                            <td><input type="reset" value="Cancelar" class="btn btn-danger"/></td>
                        </tr>
                        <tr>
                            <td>Nombre:</td>
                            <td><input type="text" name="TxtAtribNombreNueAtri" class="form-control"/></td>
                        </tr>
                        <tr>
                            <td>Descripción:</td>
                            <td> <input type="text" name="TxtAtribDescripNueAtrib" class="form-control"/></td>
                        </tr>
                        <tr>
                            <td><input type="submit" name="BtnQaw4GuardarNuevoAtributo" value="Guardar" class="btn btn-primary"/></td>
                            <td><input type="reset" value="Cancelar" class="btn btn-danger"/></td>
                        </tr>
                    </tbody>
                </table> 
                <table border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td class="alDer"><input type="submit" value="Regresar" name="btnQaw4anterior" class="btn btn-primary btn-lg previous"/></td>
                            <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnQawInicio" class="btn btn-primary btn-lg"/></td>
                            <td class="alCen"><input id="btnCont" type="button" value="Continuar" name="btnQaw4Continuar" class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>    

        <script>
            $("#btnCont").click(function ()
            {
                $("#mostrarmodal").modal("show");
            });
        </script>
        <!-- Modal -->
        <div class="modal fade" id="mostrarmodal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3>Justifica tus decisiones</h3>
                    </div>
                    <div class="modal-body">
                       <form name="qaw4" action="QAW4"> 
                        <h4>Razonamiento: </h4>
                        <textarea rows="5" cols="120" name="ratqaw4" class="form-control parrafo"><%
                            String paso = "qaw4";
                            ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw4");
                            if (ratq != null) {
                                int indiceAtribs = 0;
                                String ratio = ratq.getRatQawDescripcion();
                                System.out.println("ratio: "+ratq.getRatQawDescripcion());
                                if (ratio != null || ratio != "") {
                                    indiceAtribs = ratio.indexOf("~|~|") + 4;
                                }
                                out.print(ratio.substring(indiceAtribs));
                            }
                            %></textarea>
                        <table class="tblCentfull" border="0" >
                            <tr><td class="alDer"><input type="submit" value="Guardar" name="btnQaw4Guardar" class="btn btn-primary"/></td></tr>
                        </table>

                    </form>
                    </div>

                        <div>
                            <h2>Archivos:</h2>
                            <form name="qaw-4" action="QAW4" method="post"  enctype="multipart/form-data">
                                <table width="400" border="0" class="tblCent">
                                    <tr><td><input type="file" name="archivo" id="myfile" class="filestyle"/></td>
                                        <td><input type="submit" value="subir archivo" name="btnQawsubir" class="btn btn-primary"/></td></tr>
                                </table>
                            </form>
                        </div>
                        <div class="divScroll tblCentfullP">
                            <form name="qaw-4" action="QAW4"> 

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
                <div class="modal-footer">
                    <form name="popupRatio" action="popupRationale"> 

                        <a href="<%
                            int este = Integer.parseInt("" + paso.charAt(3));
                            String siguiente = paso.substring(0, 3) + String.valueOf(este + 1);
                            out.print(siguiente + ".jsp");
                           %>" class="btn btn-primary">Siguiente Paso</a>
                        <a href="#" data-dismiss="modal" class="btn btn-danger">Cerrar</a>
                    </form>
                </div>
            </div>

        </div>
    </div>
</body>
</html>
