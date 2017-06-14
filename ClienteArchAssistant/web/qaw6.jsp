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

        <div class="col-lg-12 col-md-12 col-md-12">
            
            <form name="qaw-6" action="QAW6">
                
                <h2 class="page-header">Consolidación de escenarios:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <p class="parrafo">
                            Teniendo una lista de varios escenarios generados durante la lluvia de ideas, se hace una consolidación de los mismos buscando escenarios que sean muy similares o que se puedan mezclar en uno solo, para esto, se hace una votación por parte de los stakeholders siendo cuidadosos de no perder funcionalidades al hacer la fusión, para evitar que no se pierda el trabajo hecho en el paso anterior.
                        </p>
                    </div>
                    <div class="col-lg-3 col-md-2"></div>
                </div>

                <h2 class="bienvenida page-header">Escenarios:</h2>


                <%
                    List<Integer> atributosEscogidos = new LinkedList<Integer>();
                    int id = 0;
                    int index = -1;
                    int bandera = Integer.parseInt(session.getAttribute("sigAtr").toString());
                    p2 = new ArchAssistantBean();
                    listaAtributos = p2.ListarAtr();
                    ratq4 = p2.RationaleQAW(proyectoActual.getProID(), "qaw4");
                    atrActual = (Atributocalidad) session.getAttribute("AtributoActual");
                    String ratio;
                    String[] listAc = null;
                    int indiceAtribs = 0;
                    if (ratq4 != null) {
                        ratio = ratq4.getRatQawDescripcion();
                        indiceAtribs = ratio.indexOf(",~|~|");
                        if (indiceAtribs != 0) {
                            String ac = ratio.substring(0, indiceAtribs);
                            listAc = ac.split(",");
                        }
                    }
                    for (String i : listAc) {
                        atributosEscogidos.add(Integer.parseInt(i));
                    }
                    atrActual = (Atributocalidad) session.getAttribute("AtributoActual");
                    if (atrActual != null) {
                        index = atributosEscogidos.indexOf(atrActual.getAcID());
                    }
                    if (atributosEscogidos.size() > index + 1) {
                        if (bandera != -1)
                        {
                            if (bandera == 1) {
                                id = atributosEscogidos.get(index + 1);
                            } else {
                                if (index == -1) {
                                    index = 0;
                                }
                                id = atributosEscogidos.get(index);
                            }
                        }
                        else
                        {
                            id = -1;
                        }
                        
                    } else {
                        id = atributosEscogidos.get(index);
                    }
                    atrActual = p2.buscarAtr(id);

                    session.setAttribute("AtributoActual", atrActual);

                    //out.println("<h2> Escenarios de Atributo " + atrActual.getAcNombre() + "</h2>");
                %>

                <div class="col-lg-6 col-md-12 col-sm-12">
                    <div class="divScrollG2 tblCentfullP">
                    <table width="100%" border="3" class="tblCentfull">
                        <tbody>
                            <tr>
                                <th scope="col">Código</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Estímulo</th>
                                <th scope="col">ambiente</th>
                                <th scope="col">Respuesta</th>
                            </tr>
                            <%
                                 archB = new ArchAssistantBean();
                                 listaEsc = archB.ListEscenarios(proyectoActual);
                                for (Escenario esce : listaEsc) {
                                    if (esce.getTblAtributoCalidadacID().getAcID() == id) {
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
                </div>
                    <table width="100%" border="0" class="tblCentfull">
                        <tr>
                            <td class="alDer"><input type="submit" value="Siguiente" name="btnQaw6SiguienteAtributo" class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </table>
                </div>
                <div class="col-lg-6 col-md-12 col-sm-12">
                    <div class="divG tblCentfullP">
                    <table width="100" border="0" class="tblCentContent">
                        <tbody>
                            <tr>
                                <td>Código del Escenario: </td>
                                <td><input type="text" name="txtQaw6CodigoSeleccionar"/></td>
                            </tr>
                            <tr>
                                <td><input type="submit" value="Seleccionar o crear" name="btnQaw6SeleccionarEscenario" class="btn btn-primary"/></td>
                                <td><input type="submit" value="Eliminar" name="btnQaw6EliminarEscenario"  class="btn btn-primary"/></td>
                            </tr>

                        </tbody>
                    </table>
                    </div>
                </div>
                
                <div class="col-lg-7 col-md-6 col-sm-12">
                    <h2 class="page-header">Rationale:</h2>
                    <textarea rows="5" cols="120" name="ratqaw6" class="form-control parrafo"><%
                         p = new ArchAssistantBean();
                        session.setAttribute("pasoActual", "qaw6");
                         ratq = p2.RationaleQAW(proyectoActual.getProID(), "qaw6");
                        if (ratq != null) {
                            out.print(ratq.getRatQawDescripcion());
                        }
                %></textarea>
            <br/>
            <input type="submit" value="Guardar" name="btnQaw6Guardar"  class="btn btn-primary"/>

        </div>
    </form>

    <div class="col-lg-5 col-md-6 col-sm-12">
        <div>
            <h2 class="page-header">Archivos:</h2>

            <form name="qaw-6" action="QAW6" method="post" enctype="multipart/form-data">
                <table width="400" border="0" class="tblCent">
                    <tr><td><input type="file" name="archivo" id="myfile"/></td>
                        <td><input type="submit" value="subir archivo" name="btnQawsubir" class="btn btn-primary"/></td>
                </table>
            </form>
        </div>
        <div class="divScroll">
            <form name="qaw-6" action="QAW6"> 
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
<div class="col-lg-12 col-md-12 col-sm-12">
<form name="qaw-6" action="QAW6">   
                <table border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td class="alDer"><input type="submit" value="Regresar" name="btnQaw6anterior" class="btn btn-primary btn-lg"/></td>
                            <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnQawInicio" class="btn btn-primary btn-lg"/></td>
                            <td class="alCen"><input id="btnCont" type="button" value="Continuar" name="btnQaw6Continuar" class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
             </div><!---->
        </div>
        <%//@include file='popupRationale.jsp'%>      
        <script>
            $("#btnCont").click(function ()
            {
                $("#mostrarmodal").modal("show");
            });
        </script>
   