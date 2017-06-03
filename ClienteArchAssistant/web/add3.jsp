<%-- 
    Document   : add3
    Created on : 25/01/2017, 12:30:18 PM
    Author     : Prometheus
--%>
<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="servicios.Escenario"%>
<%@page import="servicios.Modulo"%>
<%@page import="servicios.Rationaleqaw"%>
<%@page import="servicios.Atributocalidad"%>
<%@page import="java.util.List"%>
<%@page import="servicios.Rationaleadd"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="./css/bootstrap.min.css" />
        <link rel="stylesheet" href="./css/estilos.css" />
        <script src="./js/jquery-3.2.1.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <title>ArchAssistant - ADD</title>
    </head>
    <body>
        <form name="add-3" action="ADD3">
            <div class="col-lg-12 col-md-12 col-md-12">            
                <h2 class="subtitle">ADD</h2>
                <h2 class="bienvenida">                    
                    <% if (session.getAttribute("validUsuario") == null) {
                            response.sendRedirect("InicioUsuario.jsp");
                            //redirijo al login
                        }%>
                    <jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
                <table border="0" class="tblCentfull">
                    <tbody>
                        <tr>
                            <td><a href="add1.jsp"><h3 class="bienvenida">Paso 1</h3></a></td>
                            <td><a href="add2.jsp"><h3 class="bienvenida">Paso 2</h3></a></td>
                            <td><h1 class="bienvenida">Paso 3</h1></td>
                            <td><h3 class="bienvenida">Paso 4</h3></td>
                            <td><h3 class="bienvenida">Paso 5</h3></td>
                            <td><h3 class="bienvenida">Paso 6</h3></td>
                            <td><h3 class="bienvenida">Paso 7</h3></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                        </tr>
                    </tbody>
                </table><% Modulo m = (Modulo) session.getAttribute("padreActual");
                    if (m == null) {
                        ArchAssistantBean archB = new ArchAssistantBean();
                        Modulo padre = archB.buscarModDescomposicion(proyectoActual);
                        m = padre;
                        session.setAttribute("padreActual", m);
                    }
                    String modNombre = m.getModNombre();%>            
                <h2 class="page-header">Identificar candidatos a drivers para el modulo <%=modNombre%>:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12"> 
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <p class="parrafo">
                            Identificar candidatos a conductores (drivers) arquitecturales, en este punto, usted ha elegido un elemento del sistema para descomponerse, 
                            han priorizado cualquier requisito que afecte a ese elemento. 
                            Durante este paso, usted clasificar&aacute; estos mismos requisitos una segunda 
                            vez basado en su impacto relativo en la arquitectura. Esta segunda clasificaci&oacute;n 
                            puede ser tan simple como asignar &quot;alto impacto&quot;, &quot;Impacto medio&quot; o &quot;bajo impacto&quot;
                            para cada requisito. Dado que los interesados clasificaron inicialmente los requisitos, el segundo Basado en
                            la arquitectura tiene el efecto de ordenar parcialmente los requisitos En varios grupos. 
                            Si usas rankings sencillos altos / medios / bajos, los grupos Ser&iacute;a (H,H) (H,M) (H,L) (M,H) (M,M) (M,L) (L,H) (L,M) (L,L)
                            <!--
                                La primera letra de cada grupo indica la importancia de los requisitos para las partes interesadas. 
                                La segunda letra de cada grupo indica el impacto potencial de los requisitos en la arquitectura. 
                                Los requisitos en el grupo (H, H) son muy importantes para las partes interesadas y se espera que tengan 
                                un alto impacto en la estructura de la arquitectura, y as&iacute; sucesivamente. De estos pares, debe elegir 
                                varios (cinco o seis) requisitos de alta prioridad como el enfoque para los pasos siguientes en el proceso 
                                de dise&ntilde;o. Los requisitos seleccionados se denominan &quot;drivers de arquitectura candidatos&quot;
                                para el elemento que se est&aacute; descomponiendo actualmente. Un an&aacute;lisis posterior puede eliminar 
                                algunos candidatos De la consideraci&oacute;n como conductores arquitect&oacute;nicos, mientras que otros 
                                requisitos pueden ser a&ntilde;adidos A la lista de candidatos. Por ejemplo, aunque un requisito se clasifica 
                                como Alto impacto en la estructura de la arquitectura, la investigaci&oacute;n posterior puede revelar que no lo hace. 
                                El an&aacute;lisis tambi&eacute;n podr&iacute;a revelar que un requisito que no Considera que tiene un alto impacto 
                                en la estructura de la arquitectura, por lo que es A la lista de candidatos. En &uacute;ltima instancia, nuestro 
                                objetivo en los pasos posteriores es identificar los verdaderos conductores de la arquitectura. La lista de requisitos 
                                que resulta de este paso Pueden o no tener un impacto en la estructura de la arquitectura. Los que Se llamar&aacute;n 
                                conductores de arquitectura. Hasta entonces, se les llama conductores de arquitectura candidatos.
                            -->
                        </p>
                    </div>
                    <div class="col-lg-3 col-md-2"></div>                        
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1"></div>
                    <div class="col-lg-10 col-md-12 col-sm-12">                        
                        <fieldset>
                            <legend>ATRIBUTOS DE CALIDAD SELECCIONADOS</legend>
                            <%List<Atributocalidad> listaAtributos;
                                ArchAssistantBean p = new ArchAssistantBean();
                                listaAtributos = p.ListarAtr();

                                Rationaleqaw ratq4 = p.RationaleQAW(proyectoActual.getProID(), "qaw4");
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
                                }%>
                            <table width="100%" border="3" class="tblCentfull">
                                <tbody>
                                    <tr>
                                        <!--<th scope="col">Código</th>-->
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Descripción</th>
                                    </tr>                                
                                    <%for (String cod : listAc) {
                                            for (Atributocalidad at : listaAtributos) {
                                                if (Integer.parseInt(cod) == at.getAcID()) {
                                                    out.println("<tr>");
                                                    /*out.println("<td>");
                                                    out.println("<input type='checkbox' name='attrControl' value='" + at.getAcID() + "'> </input>");
                                                    out.println("</td>");*/
                                                    out.println("<td>");
                                                    out.println(at.getAcNombre());
                                                    out.println("</td>");
                                                    out.println("<td>");
                                                    out.println(at.getAcDescripcion());
                                                    out.println("</td>");
                                                    out.println("</tr>");
                                                }
                                            }
                                        }%>
                                    </tr>
                                </tbody>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-lg-1"></div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1"></div>
                    <div class="col-lg-10 col-md-12 col-sm-12">                    
                        <fieldset>
                            <h2><legend>ESCENARIOS</legend></h2>
                            <table width="100%" border="3" class="tblCentfull">
                                <tbody>
                                    <tr>
                                        <!--<th scope="col">Código</th>-->
                                        <th scope="col">Nombre Atributo</th>
                                        <th scope="col">Nombre Escenario</th>
                                        <th scope="col">Estímulo</th>
                                        <th scope="col">Fuente</th>
                                        <th scope="col">Ambiente</th>
                                        <th scope="col">Artefacto</th>
                                        <th scope="col">Respuesta</th>
                                        <th scope="col">Medida</th>
                                        <th scope="col">Prioridad</th>
                                        <th scope="col">Impacto</th>
                                    </tr>
                                    <%
                                        ArchAssistantBean archB = new ArchAssistantBean();
                                        List<Escenario> listaEsc = archB.ListEscenarios(proyectoActual);
                                        for (Escenario esce : listaEsc) {
                                            if (esce.getEscPrioridad() != null && esce.getEscPrioridad() > 0) {

                                                /*
                                                out.println("<tr>");
                                                out.println("<td>");
                                                out.println(esce.getEscID());
                                                out.println("</td>");
                                                 */
                                                out.println("<td>");
                                                out.println(esce.getTblAtributoCalidadacID().getAcNombre());
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
                                                out.println("<td>");
                                                out.println("<div class='uk-form-select' data-uk-form-select>");

                                                out.println("<select name='impacto_" + esce.getEscID() + "' id='impacto_" + esce.getEscID() + "'>");

                                                String estado = esce.getEscEstado();
                                                if (estado != null) {
                                                    String vec[] = estado.split(";");
                                                    String impacto = "";
                                                    if (vec.length > 1) {
                                                        impacto = vec[1];
                                                    } else {
                                                        impacto = vec[0];
                                                    }
                                                    if (impacto.equals("Alto")) {
                                                        out.println("<option value='null'>Eliga impacto </option> <option value='Alto' selected='selected'>Alto </option> <option value='Medio'>Medio </option> <option value='Bajo'>Bajo </option>");
                                                    } else {
                                                        if (impacto.equals("Medio")) {
                                                            out.println("<option value='null'>Eliga impacto</option> <option value='Alto'>Alto</option> <option value='Medio' selected='selected' >Medio</option> <option value='Bajo'>Bajo</option>");
                                                        } else {
                                                            if (impacto.equals("Bajo")) {
                                                                out.println("<option value='null'>Eliga impacto </option> <option value='Alto'>Alto </option> <option value='Medio'>Medio </option> <option value='Bajo' selected='selected'>Bajo </option>");
                                                            } else {
                                                                out.println("<option value='null' selected='selected'>Eliga impacto </option> <option value='Alto'>Alto </option> <option value='Medio'>Medio </option> <option value='Bajo'>Bajo</option>");
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    out.println("<option value='null' selected='selected'>Eliga impacto </option> <option value='Alto'>Alto </option> <option value='Medio'>Medio </option> <option value='Bajo'>Bajo</option>");
                                                }

                                                //out.println("<option value='null' selected='selected'>Eliga impacto<option value='Alto'>Alto<option value='Medio'>Medio<option value='Bajo'>Bajo");
                                                out.println("</select>");
                                                out.println("</div>");
                                                out.println("</td>");
                                                out.println("</tr>");
                                            }
                                        }
                                    %>
                                </tbody>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-lg-1"></div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1"></div>
                    <div class="col-lg-5 col-md-6 col-sm-12">
                        <h2 class="page-header">Rationale:</h2>
                        <textarea rows="9" cols="120" class="form-control parrafo" name="ratadd3"><%
                            Rationaleadd rata = p.RationaleADD(proyectoActual.getProID(), "add3_" + m.getModId());
                            if (rata != null) {
                                out.print(rata.getRatAddDescripcion());
                            }
                            %></textarea>
                        <br/>
                        <input type="submit" value="Guardar" name="btnAdd3Guardar" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-5 col-md-6 col-sm-12">
                        <div>
                            <h2 class="page-header">Archivos:</h2>
                            <form name="add-3" action="ADD3" method="post" enctype="multipart/form-data">
                                <table width="400" border="0" class="tblCent">
                                    <tr><td><input type="file" name="archivo" id="myfile"/></td>
                                        <td><input type="submit" value="subir archivo" name="btnAddsubir" class="btn btn-primary"/></td></tr>
                                </table>
                            </form>
                        </div>
                        <div class="divScroll">
                            <table width="400" border="0" class="tblCentfull">
                                <tbody>
                                    <%
                                        GuardarArchivo arch = new GuardarArchivo();
                                        List<File> archivos = null;
                                        if (rata != null) {
                                            archivos = arch.listarArchivos(rata.getRatAddArchivo());
                                        }
                                        if (archivos != null) {
                                            for (File archivo : archivos) {
                                                out.print("<tr>");
                                                out.print("<td>" + archivo.getName() + "</td>");
                                                out.print("<td class='alDer'>" + "<button type=\"submit\"  name=\"btnAddEliminar" + archivo.getName() + "\" class=\"btn btn-primary \">  <span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span></button>        ");
                                                out.print("<button type=\"submit\" value=\"Descargar\" name=\"btnAddBajar" + archivo.getName() + "\" class=\"btn btn-primary\"/>  <span class=\"glyphicon glyphicon-download-alt\" aria-hidden=\"true\"></span></button>" + "</td>");
                                                out.print("</tr>");
                                            }
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-1"></div>
                </div>                               

            </div>
        </form>
        <form name="add-3" action="ADD3">    
            <table border="0" class="tblCent">
                <tbody>
                    <tr>
                        <td class="alDer"><input type="submit" value="Regresar" name="btnAdd3anterior" class="btn btn-primary btn-lg"/></td>
                        <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnInicio" class="btn btn-primary btn-lg"/></td>
                        <td class="alIzq"><input type="submit" value="Continuar" name="btnContinuar" class="btn btn-primary btn-lg"/></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>
