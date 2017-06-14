<%-- 
    Document   : qaw5
    Created on : 25/01/2017, 08:33:48 AM
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

    <form name="qaw-5" action="QAW5">

        <h2 class="page-header">Lluvia de ideas de escenarios:</h2>
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="col-lg-3 col-md-2"></div>
            <div class="col-lg-6 col-md-8 col-sm-12">
                <p class="parrafo">
                    una vez hecha la presentación de los atributos directores o drivers del sistema, el o los facilitadores guiarán a los stakeholders en una lluvia de ideas en modo round-robin en la que cada uno generará un escenario dependiendo de sus funciones e intereses en el sistema, cada escenario debe constar de un estímulo, un ambiente y una respuesta, se espera que cada stakeholder genere al menos dos escenarios; hay que tener en cuenta que este paso es el corazón del proceso QAW por lo tanto hay que ser muy cuidadosos.
                </p>
            </div>
            <div class="col-lg-3 col-md-2"></div>
        </div>

        <h2 class="bienvenida page-header">Escenarios:</h2>
        <div class="col-lg-6 col-md-12 col-sm-12">
            <select name="slcAtributo">
                <%

                    ArchAssistantBean p2 = new ArchAssistantBean();

                    Rationaleqaw ratq4 = p2.RationaleQAW(proyectoActual.getProID(), "qaw4");
                    Atributocalidad atrActual = (Atributocalidad) session.getAttribute("AtributoActual");
                    listaAtributos = p2.ObtenerAtributosEscogidos(ratq4);

                    for (Atributocalidad atr2 : listaAtributos) {
                        out.println("<option value=\"" + atr2.getAcID() + "\" ");
                        if (atrActual != null) {
                            if (atrActual.getAcID() == atr2.getAcID()) {
                                out.println("selected=\"selected\"");
                            }
                        }

                        out.println(">" + atr2.getAcNombre() + "</option>");
                    }
                    session.setAttribute("sigAtr", 0);
                %>
            </select>
            <input type="submit" name="btnQaw5AtriSelecc" value="Seleccionar" class="btn btn-primary"/>

            <table width="100" border="0" class="tblCentContent">
                <tbody>
                    <tr>
                        <td>Nombre:</td>
                        <td><input type="text" name="txtqaw5Nombre" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>Estímulo:</td>
                        <td><input type="text" name="txtqaw5Estimulo" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>Ambiente:</td>
                        <td><input type="text" name="txtqaw5Ambiente" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>Respuesta:</td>
                        <td><input type="text" name="txtqaw5Respuesta" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Agregar" name="btnqaw5GuardarEscenario" class="btn btn-primary"/></td>
                        <td><input type="reset" value="Cancelar" class="btn btn-danger"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="col-lg-6 col-md-12 col-sm-12">
            <div class="divScrollG tblCentfullP">
                <table width="100%" border="3" class="tblCentfull">
                    <tbody>
                        <tr>
                            <th scope="col">Nombre</th>
                            <th scope="col">Estímulo</th>
                            <th scope="col">Ambiente</th>
                            <th scope="col">Respuesta</th>
                        </tr>
                        <%
                            ArchAssistantBean archB = new ArchAssistantBean();
                            List<Escenario> listaEsc = archB.ListEscenarios(proyectoActual);

                            if (atrActual != null) {
                                for (Escenario esce : listaEsc) {
                                    System.out.println("escenarios " + esce.getTblAtributoCalidadacID());
                                    if (esce.getTblAtributoCalidadacID().getAcID() == atrActual.getAcID()) {
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
                                        out.println("</tr>");
                                    }

                                }
                            }

                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="col-lg-7 col-md-6 col-sm-12">
            <h2 class="page-header">Rationale:</h2>
            <textarea rows="5" cols="120" name="ratqaw5" class="form-control parrafo"><%                            session.setAttribute("pasoActual", "qaw5");
                p = new ArchAssistantBean();
                ratq = p.RationaleQAW(proyectoActual.getProID(), "qaw5");
                if (ratq != null) {
                    String ratio = ratq.getRatQawDescripcion();
                    if (ratio != null) {
                        out.print(ratio);
                    }
                }
                %></textarea>
            <br/>
            <input type="submit" value="Guardar" name="btnQaw5Guardar"  class="btn btn-primary"/>

        </div>
    </form>

    <div class="col-lg-5 col-md-6 col-sm-12">
        <div>
            <h2 class="page-header">Archivos:</h2>

            <form name="qaw-5" action="QAW5" method="post" enctype="multipart/form-data">
                <table width="400" border="0" class="tblCent">
                    <tr><td><input type="file" name="archivo" id="myfile"/></td>
                        <td><input type="submit" value="subir archivo" name="btnQawsubir" class="btn btn-primary"/></td></tr>
                </table>
            </form>
        </div>
        <div class="divScroll">
            <form name="qaw-5" action="QAW5"> 
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
        <form name="qaw-5" action="QAW5">    
            <table border="0" class="tblCent">
                <tbody>
                    <tr>
                        <td class="alDer"><input type="submit" value="Regresar" name="btnQaw5anterior" class="btn btn-primary btn-lg"/></td>
                        <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnQawInicio" class="btn btn-primary btn-lg"/></td>
                        <td class="alCen"><input id="btnCont" type="button" value="Continuar" name="btnQaw5Continuar" class="btn btn-primary btn-lg"/></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div><!---->
</div>
