<%-- 
    Document   : popupRationale
    Created on : 23/05/2017, 04:27:16 PM
    Author     : Prometheus
--%>

<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="servicios.Proyecto"%>
<%@page import="servicios.Rationaleqaw"%>
<%@page import="Beans.ArchAssistantBean"%>
<!--
<script type="text/javascript">
   /* $(document).ready(function() {
        $('#btnSubirA').click(function(event){
            $.processRequest('popupRationale',{},function(responseText) {
                alert(responseText);
                $('#tblArchivos').html(responseText);
            });
        });
    });
/**/
</script>
-->
<div class="modal fade" id="mostrarmodal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3>Justifica tus decisiones</h3>
            </div>
            <div class="modal-body">
                <form name="popupRatio" action="popupRationale" method="post"  enctype="multipart/form-data">
                    <h4>Archivos:</h4>
                    <table width="400" border="0" class="tblCent">
                        <tr><td><input type="file" name="archivo" id="myfile" class="filestyle"/></td>
                            <td><input id="btnSubirA" type="submit" value="subir archivo" name="btnSubir" class="btn btn-primary"/></td></tr>
                    </table>
                </form>
            </div>
            <form name="popupRatio" action="popupRationale">
                <div class="modal-body">
                    <div class="divScroll tblCentfullP" id="tblArchivos">

                        <table width="400" border="0" class="tblCentfull" >
                            <tbody>
                                <%
                                    Proyecto proyecto = (Proyecto) session.getAttribute("proyectoActual");
                                    ArchAssistantBean p = new ArchAssistantBean();
                                    String paso = (String) session.getAttribute("pasoActual");
                                    Rationaleqaw ratq = p.RationaleQAW(proyecto.getProID(), paso);

                                    GuardarArchivo arch = new GuardarArchivo();
                                    List<File> archivos = null;
                                    if (ratq != null) {
                                        archivos = arch.listarArchivos(ratq.getRatQawArchivo());
                                    }
                                    if (archivos != null) {
                                        for (File archivo : archivos) {
                                            out.print("<tr>");
                                            out.print("<td>" + archivo.getName() + "</td>");
                                            out.print("<td class='alIzq'>" + "<button type=\"submit\" value=\"Eliminar\" name=\"btnQawEliminar"
                                                    + archivo.getName() + "\" class=\"btn btn-primary\"/>  "
                                                    + "<span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span></button>        ");
                                            out.print("<button type=\"submit\" value=\"Descargar\" name=\"btnQawBajar"
                                                    + archivo.getName() + "\" class=\"btn btn-primary\"/>  "
                                                    + "<span class=\"glyphicon glyphicon-download-alt\" aria-hidden=\"true\">"
                                                    + "</span></button>" + "</td>");
                                            out.print("</tr>");
                                        }
                                    }/**/
                                %>
                            </tbody>
                        </table>    
                    </div>
                    <h3>Razonamiento: </h3>
                    <textarea rows="5" cols="120" name="rationale" class="form-control parrafo"><%
                        if (ratq != null) {
                            out.print(ratq.getRatQawDescripcion());
                        }
                        %></textarea>
                    <!--<table class="tblCentfull" border="0" >
                        <tr><td class="alDer"><input type="submit" value="Guardar" name="btnContinuar" class="btn btn-primary alDer"/></td></tr>
                    </table>-->
                </div>
                <div class="modal-footer">
                <!--    
                    <a href="<%
                       /* int este = Integer.parseInt("" + paso.charAt(3));
                        String siguiente = paso.substring(0, 3) + String.valueOf(este + 1);
                        if (paso.equals("qaw5")) {
                            request.getSession().removeAttribute("AtributoActual");
                        }
                        if (paso.equals("qaw8")) {
                            out.print("InicioUsuario.jsp");
                        } else {
                            out.print(siguiente + ".jsp");
                        }
*/
                       %>" class="btn btn-primary">Siguiente Paso</a>-->
                    <input type="submit" value="Siguiente paso" name="btnContinuar" class="btn btn-primary alDer"/>
                    <a href="#" data-dismiss="modal" class="btn btn-danger">Cerrar</a>
                </div>
            </form>
        </div>
    </div>
</div>

                    
                    
                    