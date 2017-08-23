<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page import="servicios.Rationaleadd"%>
<%@page import="servicios.Modulo"%>
<%@page import="servicios.Proyecto"%>

<script src="./js/fileinput.js" type="text/javascript"></script>
<link href="./css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
<div class="col-lg-12 col-md-12 col-sm-12">
    <div class="col-lg-7 col-md-6 col-sm-12">
        <h2 class="page-header">Rationale:</h2>
        <form name="" action=""  method="">
            <textarea rows="5" cols="120" name="ratadd1" class="form-control parrafo" id="txtEditor">
            </textarea>  
            <br/>
            <input type="button" id="btnGuardarRat" value="Guardar" name="btnAdd1Guardar" class="btn btn-primary"/>
        </form>
    </div>
    <div>
        <form name="multiform" id="multiform" action="Rationale" method="POST" enctype="multipart/form-data"><!--<form name="frSubirArchivo" id="frSubirArchivo" action="Rationale" method="POST"  enctype="multipart/form-data">-->
            <h4>Archivos:</h4>
            <table width="400" border="0" class="tblCent">
                <tr>
                    
                    <td><input type="file" name="archivo" id="myfile" class=""/></td>
                    <td><input type="submit" value="subir archivo" id="btnSubirArchivo" name="btnSubirArchivo" class="btn btn-primary"/></td></tr>
                    
                    
                        <!--<label class="control-label">Seleccione archivo</label>
                        <input id="" type="file" class="file">-->
                    
                </tr>
            </table>
        </form>
    </div>
    <div class="divScroll" id="divArchivos">
        <form name="Rationale" action="Rationale">
            <table width="400" border="0" class="tblCentfull">
                <tbody id="divListaArchivos">
                    <%
                        Proyecto proyecto = (Proyecto) session.getAttribute("proyectoActual");
                        Modulo descomp = (Modulo) session.getAttribute("padreActual");
                        String paso = (String) session.getAttribute("pasoActual");
                        Rationaleadd rata = null;//new Rationaleadd();
                        archB = new ArchAssistantBean();
                        if (descomp == null) {
                            rata = archB.RationaleADD(proyecto.getProID(), paso);
                        } else {
                            rata = archB.RationaleADD(proyecto.getProID(), paso + "_" + descomp.getModId());
                        }

                        GuardarArchivo arch = new GuardarArchivo();
                        List<File> archivos = null;
                        if (rata != null) {
                            archivos = arch.listarArchivos(rata.getRatAddArchivo());
                        }
                        if (archivos != null) {
                            for (File archivo : archivos) {
                                out.print("<tr>");
                                out.print("<td>" + archivo.getName() + "</td>");
                                out.print("<td class='alIzq'>" + "<button type='button' value='Eliminar' name='btnEliminar"
                                        + archivo.getName() + " class='btn btn-primary'>  "
                                        + "<span class='glyphicon glyphicon-trash' aria-hidden='true'></span></button>        ");
                                out.print("<button type='button' value='Descargar' name='btnBajar"
                                        + archivo.getName() + " class='btn btn-primary download'>  "
                                        + "<span class='glyphicon glyphicon-download-alt' aria-hidden='true'>"
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
<div id="divMensaje">
    <div style="padding: 5px;">

    </div>
</div>