<%-- 
    Document   : add6
    Created on : 25/01/2017, 12:30:45 PM
    Author     : Prometheus
--%>

<%@page import="servicios.Usuario"%>
<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="servicios.Interface"%>
<%@page import="servicios.Modulo"%>
<%@page import="java.util.List"%>
<%@page import="servicios.Rationaleadd"%>
<%@page import="Beans.ArchAssistantBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - ADD</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <link rel="stylesheet" href="./css/editor.css" />
        <link rel="stylesheet" href="./css/font-awesome.min.css" />

        <!--
        <script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/jquery-3.2.1.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/editor.js"></script>
        <script src="./js/funciones.js"></script>
    </head>
    <body>
        <div class="col-lg-12 col-md-12 col-md-12">
            <form name="add-6" action="ADD6">
                <h2 class="subtitle">ADD</h2>
                <%
                    session.setAttribute("pasoActual", "add6");
                    Usuario u = (Usuario) session.getAttribute("validUsuario");
                    if (u == null) {
                        response.sendRedirect("InicioUsuario.jsp");
                    }%>
                <h2 class="bienvenida"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
                <table width="100%" border="0" align="center">
                    <tbody>
                        <tr>
                            <td><a href="add1.jsp"><h3 class="bienvenida">Paso 1</h3></a></td>
                            <td><a href="add2.jsp"><h3 class="bienvenida">Paso 2</h3></a></td>
                            <td><a href="add3.jsp"><h3 class="bienvenida">Paso 3</h3></a></td>
                            <td><a href="add4.jsp"><h3 class="bienvenida">Paso 4</h3></a></td>
                            <td><a href="add5.jsp"><h3 class="bienvenida">Paso 5</h3></a></td>
                            <td><h1 class="bienvenida">Paso 6</h1></td>
                            <td><h3 class="bienvenida">Paso 7</h3></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                        </tr>
                    </tbody>
                </table><h2 class="page-header">Definir las interfaces para los elementos instanciados:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12"> 
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <p class="parrafo">
                            se deben definir las propiedades requeridas y proveídas por el diseño que se está implementando, ADD llama a estos servicios y propiedades como interfaces, éstas definen las necesidades de los elementos y lo que provee cada uno hacia los otros; una interface incluye uno de los siguientes ítems:
                        </p>
                        <ul>
                            <li>Sintaxis de operaciones.</li>
                            <li>Semántica de operaciones.</li>
                            <li>Información que intercambia.</li>
                            <li>Requerimientos de atributos de calidad de los elementos individuales y operaciones.</li>
                            <li>Manejo de errores.</li>
                        </ul></div>
                    <div class="col-lg-3 col-md-2"></div>                        
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1"> </div>
                    <div class="col-lg-10 col-md-6 col-sm-12" name="listaModulos" id="listaModulos">                        
                        <h2 class="page-header">Submódulos del sistema:</h2>

                        <table width="100%" border="3" class="tblCentfull">
                            <tbody>
                                <tr>                        
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Descripción</th>

                                </tr>
                                <%
                                    ArchAssistantBean archB = new ArchAssistantBean();
                                    List<Modulo> listaMod = archB.ListarModulos(proyectoActual);
                                    Modulo padreActual = (Modulo) session.getAttribute("padreActual");
                                    if (padreActual == null) {
                                        padreActual = archB.buscarModDescomposicion(proyectoActual);
                                    }
                                    for (Modulo m : listaMod) {
                                        Modulo padreM = m.getTblModuloModId();
                                        if (padreM != null) {
                                            if (padreM.getModId() == padreActual.getModId() && m.getModFinal().equals("SubModulo")) {
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
                    <div class="col-lg-1"> </div>
                </div>                
                <div class="col-lg-12 col-md-8 col-sm-12">
                    <div class="col-lg-1"></div>   
                    <div class="col-lg-5 col-md-6 col-sm-12" >
                        <from namr="add-6" action="ADD6" method="POST">
                            <h2 class="page-header">Crear interfaces de submodulos</h2>
                            <table width="100%" border="0" align="center" class="tblCentfull">
                                <tbody>
                                    <tr>
                                        <td class="alIzq">Nombre: </td>
                                        <td><input class="form-control" id="txtNom"/></td>
                                    </tr>
                                    <tr>
                                        <td class="alIzq">Descripción</td>
                                        <td><textarea class="form-control" id ="txtDesc" rows="9" cols="60"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td class="alIzq">Tipo</td>
                                        <td><select class="form-control" id="txtTipo">
                                                <option class="form-control" value=" Sintaxis de operaciones"> Sintaxis de operaciones</option>
                                                <option class="form-control" value="Semántica de operaciones">Semántica de operaciones</option>
                                                <option class="form-control" value="Información que intercambia">Información que intercambia</option>
                                                <option class="form-control" value="Requerimientos de atributos de calidad de los elementos individuales y operaciones">Requerimientos de atributos de calidad de los elementos individuales y operaciones</option>
                                                <option class="form-control" value="Manejo de errores">Manejo de errores</option>
                                            </select></td>
                                    </tr>
                                    <tr>
                                        <td class="alIzq">SubModulo</td>
                                        <td><%
                                            Interface inter = new Interface();
                                            out.println("<select name='selModulo' id='selModulo'  class='form-control'>");
                                            out.println("<option value='null'>Eliga un modulo </option>");
                                            if (padreActual == null) {
                                                padreActual = archB.buscarModDescomposicion(proyectoActual);
                                            }
                                            for (Modulo m : listaMod) {
                                                Modulo padreM = m.getTblModuloModId();
                                                if (padreM != null) {
                                                    if (padreM.getModId() == padreActual.getModId() && !m.getModFinal().equals("terminado")) {
                                                        out.println("<option value='" + m.getModId() + "'>" + m.getModNombre() + " </option>");
                                                    }
                                                }
                                            }
                                            out.println("</select>");

                                            %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="alIzq">
                                            <input type="button" id="btnCrearInter" name="btnCrearInter" value="Crear" class="btn btn-primary"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </from>
                    </div>
                    <div class="col-lg-5 col-md-6 col-sm-12" id="tblInterfaces"> 
                        <div id="tblAux">
                            <h2 class="page-header">Interfaces</h2>
                            <table width="100%" border="3">
                                <tbody>
                                    <tr>
                                        <th scope="col">Código</th>
                                        <th scope="col">nombre</th>
                                        <th scope="col">Descrioción</th>
                                        <th scope="col">Tipo</th><!--  el tipo puede ser 
                                              •	Sintaxis de operaciones.
                                          •	Semántica de operaciones.
                                          •	Información que intercambia.
                                          •	Requerimientos de atributos de calidad de los elementos individuales y operaciones.
                                          •	Manejo de errores.
                                        -->
                                        <th scope="col">Submódulo</th>

                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-1"></div>
                </div>
            </form>
                                        <%@include file='rationale.jsp'%>
                                        <!--
            <div class="col-lg-12 col-md-8 col-sm-12">
                <div class="col-lg-1 " ></div>
                <div class="col-lg-5 col-md-6 col-sm-12">
                    <form id="add-6" name="add-6" action="ADD6">
                        <table width="100" border="0" class="tblCentfull">
                            <tbody>
                                <tr>
                                    <td>
                                        <h2 class="page-header">Rationale:</h2>
                                        <textarea rows="9" cols="120" name="ratadd6" class="form-control"><%
                                            /*
                                            Modulo descMod = (Modulo) request.getSession().getAttribute("padreActual");
                                            if (descMod == null) {
                                                descMod = archB.buscarModDescomposicion(proyectoActual);
                                                request.getSession().setAttribute("padreActual", descMod);
                                            }
                                            Rationaleadd rata = archB.RationaleADD(proyectoActual.getProID(), "add6_" + descMod.getModId());
                                            if (rata != null) {
                                                out.print(rata.getRatAddDescripcion());
                                            }*/
                                            %></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="alIzq"><input type="submit" value="Guardar" name="btnAdd6Guardar" class="btn btn-primary"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
                <div class="col-lg-5 col-md-6 col-sm-12">
                    <div>
                        <h2 class="page-header">Archivos:</h2>
                        <form name="add-7" action="ADD7" method="post" enctype="multipart/form-data">
                            <table width="400" border="0" class="tblCent">
                                <tr><td><input type="file" name="archivo" id="myfile" /></td>
                                    <td><input type="submit" value="subir archivo" name="btnAddsubir" class="btn btn-primary"/></td></tr>
                            </table>
                        </form>
                    </div>
                    <div class="divScroll">
                        <form name="add-6" action="ADD6">
                            <table width="400" border="0" class="tblCentfull">
                                <tbody>
                                    <%
                                        /*
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
                                        }*/
                                    %>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>
                                -->
                <div class="col-lg-1"></div>
            </div> 
        </div>
        <form name="add-6" action="ADD6">    
            <table border="0" class="tblCent">
                <tbody>
                    <tr>
                        <td class="alDer"><input type="submit" value="Regresar" name="btnAdd6anterior" class="btn btn-primary btn-lg"/></td>
                        <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnInicio" class="btn btn-primary btn-lg"/></td>
                        <td class="alIzq"><input type="submit" value="Continuar" name="btnContinuar" class="btn btn-primary btn-lg"/></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>
