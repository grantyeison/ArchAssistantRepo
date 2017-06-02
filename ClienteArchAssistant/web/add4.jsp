<%-- 
    Document   : add4
    Created on : 25/01/2017, 12:30:27 PM
    Author     : Prometheus
--%>

<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="servicios.Usuario"%>
<%@page import="servicios.Modulo"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javafx.beans.binding.ListBinding"%>
<%@page import="servicios.Preocupacion"%>
<%@page import="servicios.Atributocalidad"%>
<%@page import="servicios.Escenario"%>
<%@page import="servicios.Patron"%>
<%@page import="servicios.Tactica"%>
<%@page import="java.util.List"%>
<%@page import="servicios.Rationaleadd"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <script src="./js/jquery-3.2.1.js"></script>
        <!--<script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/funciones.js"></script>
        <title>ArchAssistant - ADD</title>
    </head>
    <body>
        <div class="col-lg-12 col-md-12 col-md-12">
            <form name="add-4" action="ADD4">
                <h2 class="subtitle">ADD</h2>
                <%Usuario u = (Usuario) session.getAttribute("validUsuario");
                    if (u == null) {
                        response.sendRedirect("InicioUsuario.jsp");
                    }%>
                <h2 class="bienvenida"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
                <table width="100%" class="tblCentfull">
                    <tbody>
                        <tr>
                            <td><a href="add1.jsp"><h3 class="bienvenida">Paso 1</h3></a></td>
                            <td><a href="add2.jsp"><h3 class="bienvenida">Paso 2</h3></a></td>
                            <td><a href="add3.jsp"><h3 class="bienvenida">Paso 3</h3></a></td>
                            <td><h1 class="bienvenida">Paso 4</h1></td>
                            <td><h3 class="bienvenida">Paso 5</h3></td>
                            <td><h3 class="bienvenida">Paso 6</h3></td>
                            <td><h3 class="bienvenida">Paso 7</h3></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                        </tr>
                    </tbody>
                </table>
                <h2 class="page-header">Escoger las tácticas de diseño que satisfaga a los drivers arquitecturales:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12"> 
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <p class="parrafo">
                            A esta altura, se debe escoger los principales elementos que aparecerán en la arquitectura y las relaciones entre ellos; para determinar estos elementos se debe tener en cuenta las restricciones y los requerimientos que son candidatos a drivers.
                        </p>
                    </div>
                    <div class="col-lg-3 col-md-2"></div>                        
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-2"></div>  
                    <div class="col-lg-10 col-md-6 col-sm-12" name="listaTacticas" id="listaTacticas">                        
                        <h2 class="page-header">Tácticas:</h2>
                        <!-- las tácticas listadas corresponde únicamente a las que satisfagan los drivers del escenario escogido -->
                        <input hidden name="listadoTac"  id="listadoTac" value="" />
                        <table border="1" class="tblCentfull">
                            <tbody>
                                <tr>
                                    <!--<th scope="col">Código</th>-->
                                    <th >Seleccionar</th>
                                    <th >Nombre</th>
                                    <th >Descripción</th>                        
                                </tr>
                            <label value="TacticasSeleccionadas" id="lblTactSel"></label>
                            <label value="TacticasSeleccionadas" id="lblPatSel"></label>
                                <%ArchAssistantBean archB = new ArchAssistantBean();
                                    List<Escenario> listaEsc = archB.ListarCandidatosDriver(proyectoActual);
                                    List<Tactica> listaTacSel = new LinkedList<Tactica>();
                                    List<Tactica> listaTac = archB.ListarTacticas();
                                    Rationaleadd rata = archB.RationaleADD(proyectoActual.getProID(), "add4");
                                    String[] rationale = null;
                                    if (rata != null) {
                                        rationale = rata.getRatAddDescripcion().split("/@/");
                                    }
                                    for (Escenario esc : listaEsc) {
                                        Atributocalidad atr = esc.getTblAtributoCalidadacID();
                                        for (Tactica tac : listaTac) {
                                            Atributocalidad tacAtributo = tac.getTblAtributocalidadID();
                                            if (tacAtributo != null) {
                                                if (tacAtributo.getAcID() == atr.getAcID()) {
                                                    //listaTacSel.add(tac);
                                                    //List<Patron> listadoPat = archB.ListarPatronesDeTactica(tac.getTacID());
                                                    out.println("<tr>");
                                                    out.println("<td>");
                                                    if (rationale != null) {
                                                        if (rationale.length > 1) {                                                            
                                                            String[] tact = ((String) rationale[0]).split(",");
                                                            boolean band=true;
                                                            for (String s : tact) {
                                                                if (Integer.parseInt(s) == tac.getTacID()) {
                                                                    band=false;
                                                                    out.println("<input  type = 'checkbox' checked name = 'tacticaSel' id='chkTac' value = '" + tac.getTacID() + "'/>");
                                                                }
                                                            }
                                                            if(band) out.println("<input  type = 'checkbox' name = 'tacticaSel' id='chkTac' value = '" + tac.getTacID() + "'/>");
                                                        }
                                                        else{
                                                            out.println("<input  type = 'checkbox' name = 'tacticaSel' id='chkTac' value = '" + tac.getTacID() + "'/>");
                                                        }
                                                    } else {
                                                        out.println("<input  type = 'checkbox' name = 'tacticaSel' id='chkTac' value = '" + tac.getTacID() + "'/>");
                                                    }
                                                    //out.println(mod.getModId());
                                                    out.println("</td>");
                                                    out.println("<td>");
                                                    out.println(tac.getTacNombre());
                                                    out.println("</td>");
                                                    out.println("<td>");
                                                    out.println(tac.getTacDescripcion());
                                                    out.println("</td>");
                                                    //out.println("<td>");
                                                    //out.println(mod.getModFinal());
                                                    //out.println("</td>");
                                                    out.println("</tr>");
                                                }
                                            }
                                        }
                                    }
                                %>
                                <tr>
                                    <td colspan="3" class="alDer">
                                        <input class="btn btn-primary" type="button" value="Guardar Seleccion" name="btnGuardarSeleccion" id="submit"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-lg-1 "></div>
                    <div id="tabla">

                    </div>
                    <p:editor/>
                    <!--
                    <div hidden class="col-lg-10 col-md-6 col-sm-12" id="listaPatrones">
                        <h2 class="page-header">Patrones:</h2>
                    <!-- Los patrones listados corresponden únicamente los que asociados a las tácticas seleccionadas en la tabla anterior -->
                    <!--<table width="100%" border="3" class="tblCentfull">
                        <tbody>
                            <tr>
                    <!--<th scope="col">Código</th>-->
                    <!--<th scope="col">Nombre</th>
                    <th scope="col">Descripción</th>
                    <th scope="col">Seleccionar</th>
                </tr>                    
                    <%/*List<Patron> listaPat = archB.ListarPatronesT();

                        for (Patron pat : listaPat) {
                            out.println("<tr>");
                            out.println("<td>");
                            out.println(pat.getPatNombre());
                            out.println("</td>");
                            out.println("<td>");
                            out.println(pat.getPatDescripcion());
                            out.println("</td>");
                            //out.println("<td>");
                            //out.println(mod.getModFinal());
                            //out.println("</td>");
                            out.println("<td>");
                            out.println("<input  type = 'checkbox' name = 'patronSel' id='chkTac' value = '" + pat.getPatID() + "'/>");
                            //out.println(mod.getModId());
                            out.println("</td>");

                            out.println("</tr>");
                        }*/%>
                </tbody>
            </table>
            </fieldset>
        </div>
    </div>
                    -->
                    <div class="col-lg-12 col-md-12 col-sm-12">                    
                        <div class="col-lg-1"></div>
                        <div class="col-lg-4 col-md-8 col-sm-12" >
                            <from namr="add-4" action="ADD4">
                                <h2 class="page-header">Datos del nuevo modulo</h2>
                                <table class="tblCentContent">
                                    <tbody>
                                        <tr><td>
                                                <input type="text" name="nombreMod" value="" placeholder="Nombre modulo" class="form-control" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <textarea name="descMod" value="" placeholder="Descripcion Modulo" class="form-control descripcion" rows="10"></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="submit" name="btnCrearModulo" value="Crear" class="btn btn-primary"/>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </from>
                        </div>
                        <div class="col-lg-6 col-md-12 col-sm-12">
                            <h2 class="page-header">Submódulos del sistema:</h2>
                            <p>En este momento se debe aplicar los patrones seleccionados, tras ésto, el módulo seleccionado anteriormente se 
                                dividirá en submódulos, por favor lístelos en la siguiente tabla:</p>
                            <table width="100%" border="3">
                                <tbody>
                                    <tr>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Descripción</th>
                                    </tr>
                                    <%
                                        List<Modulo> listaMod = archB.ListarModulos(proyectoActual);
                                        Modulo padreActual = (Modulo) session.getAttribute("padreActual");
                                        if (padreActual
                                                == null) {
                                            padreActual = archB.buscarModDescomposicion(proyectoActual);
                                        }
                                        for (Modulo m : listaMod) {
                                            Modulo padreM = m.getTblModuloModId();
                                            if (padreM != null) {
                                                if (padreM.getModId() == padreActual.getModId()) {
                                                    out.println("<tr>");
                                                    out.println("<td>");
                                                    out.println(m.getModNombre());
                                                    out.println("</td>");
                                                    out.println("<td>");
                                                    out.println(m.getModDescripcion());
                                                    out.println("</td>");
                                                    //out.println("<td>");
                                                    //out.println(mod.getModFinal());
                                                    //out.println("</td>");                                        
                                                    out.println("</tr>");
                                                }
                                            }
                                        }%>
                                </tbody>
                            </table>                                                
                        </div>                        
                        <div class="col-lg-1"></div>
                    </div>

                    <div class="col-lg-7 col-md-6 col-sm-12">
                        <h2 class="page-header">Rationale:</h2>
                        <textarea rows="5" cols="120" name="ratadd4" id="txtRationale" class="form-control parrafo"><%session.setAttribute(
                                    "paso", "add4");
                            if (rata != null&&rationale!=null) {
                                if(rationale.length>1){
                                out.print(rationale[1]);
                                }else{
                                    out.print(rationale[0]);
                                }
                            }
                            %></textarea>
                        <br/>
                        <input type="submit" value="Guardar" name="btnAdd4Guardar" class="btn btn-primary"/>
                    </div>

            </form>
            <div class="col-lg-5 col-md-6 col-sm-12">
                <div>
                    <h2 class="page-header">Archivos:</h2>
                    <form name="add-4" action="ADD4" method="post" enctype="multipart/form-data">
                        <table width="400" border="0" class="tblCent">
                            <tr><td><input type="file" name="archivo" id="myfile"/></td>
                                <td><input type="submit" value="subir archivo" name="btnAddsubir" class="btn btn-primary"/></td></tr>
                        </table>
                    </form>
                </div>
                <div class="divScroll">
                    <form name="add-5" action="ADD5">
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
                    </form>
                </div>
            </div>
            <form name="add-4" action="ADD4">    
                <table border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td class="alDer"><input type="submit" value="Regresar" name="btnAdd4anterior" class="btn btn-primary btn-lg"/></td>
                            <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnInicio" class="btn btn-primary btn-lg"/></td>
                            <td class="alIzq"><input type="submit" value="Continuar" name="btnContinuar" class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>            
            <!--<h2>Ejemplo de AJAX con JSP y Servelts</h2>
            <form id="form1">
                Nombre:<input type="text" id="nombre" /> <br>
                Apellido: <input type="text" id="apellido" /> <br>
                Edad: <input type="text" id="edad" /> <br>
                <input type="button" id="submit1" value="Añadir" /> 
            </form>
            <br>-->
            <!-- 	En este div metemos el contenido de la tabla con AJAX -->

        </div>
    </body>
</html>
