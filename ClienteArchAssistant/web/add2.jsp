<%-- 
    Document   : add2
    Created on : 25/01/2017, 12:30:08 PM
    Author     : Prometheus
--%>

<%@page import="servicios.Proyecto"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Dictionary"%>
<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="servicios.Modulo"%>
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
        <script src="./js/funciones.js"></script>
        <title>ArchAssistant - ADD</title>
    </head>
    <body>
        <div class="col-lg-12 col-md-12 col-md-12">
            <form name="add-2" action="ADD2">
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
                            <td><h1 class="bienvenida">Paso 2</h1></td>
                            <td><h3 class="bienvenida">Paso 3</h3></td>
                            <td><h3 class="bienvenida">Paso 4</h3></td>
                            <td><h3 class="bienvenida">Paso 5</h3></td>
                            <td><h3 class="bienvenida">Paso 6</h3></td>
                            <td><h3 class="bienvenida">Paso 7</h3></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                        </tr>
                    </tbody>
                </table>
                <h2 class="page-header">Escoger un elemento del sistema para descomponerlo:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12"> 
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <p class="parrafo">
                            Durante este paso, se escoge el elemento en el cual se enfocará el proceso, el primer elemento que se descompone es el sistema en sí, en caso de ya haber sido descompuesto, cada elemento debe tener asignados algunos de los requerimientos.
                            Para escoger un elemento, hay que basarse en las siguientes áreas:
                        </p>
                        <ul>
                            <li>Conocimiento de la arquitectura.</li>
                            <li>Riesgo y dificultad.</li>
                            <li>Criterio de negocios.</li>
                            <li>Criterio organizacional.</li>
                        </ul>
                        <p class="parrafo">
                            inicialmente será todo el sistema, además todos los escenarios estarán asociados a este único módulo
                            posteriormente, se dividirá el sistema en módulos y a cada uno se le asignará un conjunto de escenarios
                        </p>
                    </div>
                    <div class="col-lg-3 col-md-2"></div>
                </div>
                <div class="col-lg-1"></div>
                <div class="col-lg-10 col-md-12 col-sm-12">                   
                    <h2 class="page-header"> Módulos del sistema:</h2>
                    <!--  -->
                    <table width="100%" border="3" class="tblCentfull">
                        <tbody>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Descripción</th>
                                <th scope="col">Estado modulo</th>
                                    <%
                                        /*ArchAssistantBean archB = new ArchAssistantBean();
                                        Modulo padre = null;
                                        Map<Modulo, List<Modulo>> arbol = new HashMap<Modulo, List<Modulo>>();
                                        for (Modulo mod : listaMod) {
                                            padre = mod;
                                            List<Modulo> hijos = new LinkedList<Modulo>();
                                            for (Modulo m : listaMod) {                                
                                                if (m.getTblModuloModId()== padre) {
                                                    hijos.add(m);
                                                }
                                            }
                                            arbol.put(padre, hijos);
                                        }*/
                                        session.setAttribute("pasoActual", "add2");
                                        ArchAssistantBean archB = new ArchAssistantBean();
                                        List<Modulo> listaMod = archB.ListarModulos(proyectoActual);
                                        /*if (listaMod == null || listaMod.size() == 0) {
                                            Modulo sys = new Modulo();
                                            sys.setModNombre("Modulo " + proyectoActual.getProNombre());
                                            sys.setModDescripcion("Para la primera iteración se como modulo a descomponer el sistema completo ");
                                            sys.setModFinal("Descomposicion");
                                            sys.setTblModuloModId(null);
                                            sys.setTblProyectoProID(proyectoActual);
                                            archB.crearMod(sys);
                                            Modulo descMod = (Modulo) session.getAttribute("padreActual");
                                            if (descMod == null) {
                                                descMod = sys;
                                                session.setAttribute("padreActual", descMod);
                                            }
                                            listaMod.add(sys);
                                        }*/
                                        for (Modulo mod : listaMod) {
                                            out.println("<tr>");
                                            out.println("<td>");
                                            String estado = mod.getModFinal();
                                            if (estado.equals("Descomposicion")) {
                                                out.println("<input checked type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "' checked />");
                                            } else {
                                                if (estado.equals("Procesado")) {
                                                    out.println("<input disabled  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "'/>");
                                                } else {
                                                    out.println("<input  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "'/>");
                                                }
                                            }
                                            //out.println(mod.getModId());
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println(mod.getModNombre());
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println(mod.getModDescripcion());
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println(mod.getModFinal());
                                            out.println("</td>");
                                            out.println("</tr>");
                                        }


                                        /*
                                        if (padre != null) {                            
                                            for (Modulo mod : listaMod) {
                                                String estado = mod.getModFinal();
                                                if (mod.getTblModuloModId() == padre) {
                                                    out.println("<table width='100%' border='3' class='tblCentfull'>");
                                                    out.println("<tbody>");
                                                    out.println("<tr>");
                                                    out.println("<th scope='col'></th>");
                                                    out.println("<th scope='col'>Nombre</th>");
                                                    out.println("<th scope='col'>Descripción</th>");
                                                    out.println("<th scope='col'>Módulo final</th>");
                                                    out.println("</tr>");
                                                    out.println("<tr>");
                                                    out.println("<td>");
                                                    if (estado.equals("Descomposicion")) {
                                                        out.println("<input  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "' checked />");
                                                    } else {
                                                        if (estado.equals("Procesado")) {
                                                            out.println("<input disabled  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "'/>");
                                                        } else {
                                                            out.println("<input  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "'/>");
                                                        }
                                                    }
                                                    //out.println(mod.getModId());
                                                    out.println("</td>");
                                                    out.println("<td>");
                                                    out.println(mod.getModNombre());
                                                    out.println("</td>");
                                                    out.println("<td>");
                                                    out.println(mod.getModDescripcion());
                                                    out.println("</td>");
                                                    out.println("<td>");
                                                    out.println(mod.getModFinal());
                                                    out.println("</td>");
                                                    out.println("</tr>");
                                                } else {
                                                    out.println("<tr>");
                                                    out.println("<td>");

                                                    if (estado.equals("Descomposicion")) {
                                                        out.println("<input  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "' checked />");
                                                    } else {
                                                        if (estado.equals("Procesado")) {
                                                            out.println("<input disabled  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "'/>");
                                                        } else {
                                                            out.println("<input  type = 'radio' name = 'selPadre' onchange='SeleccionPadre()' value = '" + mod.getModId() + "'/>");
                                                        }
                                                    }
                                                    //out.println(mod.getModId());
                                                    out.println("</td>");
                                                    out.println("<td>");
                                                    out.println(mod.getModNombre());
                                                    out.println("</td>");
                                                    out.println("<td>");
                                                    out.println(mod.getModDescripcion());
                                                    out.println("</td>");
                                                    out.println("<td>");
                                                    out.println(mod.getModFinal());
                                                    out.println("</td>");
                                                    out.println("</tr>");

                                                }
                                            }
                                        }*/%>
                        </tbody>
                    </table>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1"></div>
                    <input type="hidden" name="modPadre" value=""/>
                    <div>
                        <form name="popupRatio" action="popupRationale" method="post"  enctype="multipart/form-data">
                            <h4>Archivos:</h4>
                            <table width="400" border="0" class="tblCent">
                                <tr><td><input type="file" name="archivo" id="myfile" class="filestyle"/></td>
                                    <td><input type="submit" value="subir archivo" name="btnSubirArchivo" class="btn btn-primary"/></td></tr>
                            </table>
                        </form>
                    </div>
                    <div class="divScroll" id="divArchivos">
                        <form name="add-1" action="ADD1">
                            <table width="400" border="0" class="tblCentfull">
                                <tbody>
                                    <%
                                        Proyecto proyecto = (Proyecto) session.getAttribute("proyectoActual");
                                        String paso = (String) session.getAttribute("pasoActual");

                                        Rationaleadd rata = archB.RationaleADD(proyecto.getProID(), paso);

                                        GuardarArchivo arch = new GuardarArchivo();
                                        List<File> archivos = null;
                                        if (rata != null) {
                                            archivos = arch.listarArchivos(rata.getRatAddArchivo());
                                        }
                                        if (archivos != null) {
                                            for (File archivo : archivos) {
                                                out.print("<tr>");
                                                out.print("<td>" + archivo.getName() + "</td>");
                                                out.print("<td class='alIzq'>" + "<button type=\"submit\" value=\"Eliminar\" name=\"btnEliminar"
                                                        + archivo.getName() + "\" class=\"btn btn-primary\"/>  "
                                                        + "<span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span></button>        ");
                                                out.print("<button type=\"submit\" value=\"Descargar\" name=\"btnBajar"
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
                    <div class="col-lg-1"></div> 
                </div>
            </form>
            <form name="add-2" action="ADD2">    
                <table border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td class="alDer"><input type="submit" value="Regresar" name="btnAdd2anterior" class="btn btn-primary btn-lg"/></td>
                            <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnInicio" class="btn btn-primary btn-lg"/></td>
                            <td class="alIzq"><input type="submit" value="Continuar" name="btnContinuar" class="btn btn-primary btn-lg"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </body>
</html>
