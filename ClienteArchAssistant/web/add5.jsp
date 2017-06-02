<%-- 
    Document   : add5
    Created on : 25/01/2017, 12:30:37 PM
    Author     : Prometheus
--%>

<%@page import="java.io.File"%>
<%@page import="Servlets.GuardarArchivo"%>
<%@page import="servicios.Usuario"%>
<%@page import="servicios.Escenario"%>
<%@page import="servicios.Modulo"%>
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
            <form name="add-5" action="ADD5">
                <h2 class="subtitle">ADD</h2>
                <%Usuario u = (Usuario) session.getAttribute("validUsuario");
                    if (u == null) {
                        response.sendRedirect("InicioUsuario.jsp");
                    }%>
                <h2 class="bienvenida"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
                <table width="100%" border="0" align="center" class="tblCentfull">
                    <tbody>
                        <tr>
                            <td><a href="add1.jsp"><h3 class="bienvenida">Paso 1</h3></a></td>
                            <td><a href="add2.jsp"><h3 class="bienvenida">Paso 2</h3></a></td>
                            <td><a href="add3.jsp"><h3 class="bienvenida">Paso 3</h3></a></td>
                            <td><a href="add4.jsp"><h3 class="bienvenida">Paso 4</h3></a></td>
                            <td><h1 class="bienvenida">Paso 5</h1></td>
                            <td><h3 class="bienvenida">Paso 6</h3></td>
                            <td><h3 class="bienvenida">Paso 7</h3></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                        </tr>
                    </tbody>
                </table>
                <h2 class="page-header">Instanciar elementos arquitecturales y asignar responsabilidades:</h2>
                <div class="col-lg-12 col-md-12 col-sm-12"> 
                    <div class="col-lg-3 col-md-2"></div>
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <p class="parrafo">
                            Cada uno de los elementos que surgieron del paso anterior es instanciado y le son asignadas responsabilidades dependiendo de su tipo, éstas responsabilidades surgen de los requerimientos funcionales asociados a los candidatos a drivers y al elemento padre, al finalizar este paso se tiene una secuencia de responsabilidades dentro de los elementos hijos.
                        </p></div>
                    <div class="col-lg-3 col-md-2"></div>                        
                </div>                
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1"> </div>
                    <div class="col-lg-10 col-md-6 col-sm-12" name="listaEscenarios" id="listaEscenarios">                        
                        <h2 class="page-header">Escenarios candidatos a drivers</h2>
                        <table width="100%" border="3" class="tblCentfull">
                            <tbody>
                                <tr>
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
                    </div>
                    <div class="col-lg-1"> </div>
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
                                    List<Modulo> listaMod = archB.ListarModulos(proyectoActual);
                                    Modulo padreActual = (Modulo) session.getAttribute("padreActual");
                                    if (padreActual == null) {
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
                    <div class="col-lg-1"> </div>
                </div>
                <div class="col-lg-5 col-md-8 col-sm-12" >
                    <from namr="add-5" action="ADD5" method="POST">
                        <h2 class="page-header">Crear y asignar responsabilidades a los modulos hijos</h2>
                        <table class="tblCentContent">
                            <tbody>
                                <tr><td>
                                        <input type="text" id="txtNomResp" name="nombreMod" value="" placeholder="Nombre modulo" class="form-control" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <textarea name="descMod" id="txtDesResp" value="" placeholder="Descripcion Modulo" class="form-control descripcion" rows="10"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="button" id="btnCrearResp" name="btnCrearResp" value="Crear" class="btn btn-primary"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td><%
                                        Responsabilidad resp = new Responsabilidad();
                                        out.println("<select name='RespMod_" + resp.getID() + "' id='impacto_" + esce.getEscID() + "'>");
                                        for (Modulo m : listaMod) {
                                            Modulo padreM = m.getTblModuloModId();
                                            if (padreM != null) {
                                                if (padreM.getModId() == padreActual.getModId()) {
                                                    out.println("<tr>");
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
                                                }
                                            }
                                        }
                                        %>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </from>
                </div>
                <!-- se debe hacer una validación para comprobar que todos los escenarios han sido asignados a los nuevos módulos hijos  -->

                <div class="col-lg-7 col-md-6 col-sm-12">
                    <h2 class="page-header">Rationale:</h2>
                    <textarea rows="5" cols="120" name="ratadd5" class="form-control parrafo"><%
                        ArchAssistantBean p = new ArchAssistantBean();
                        Rationaleadd rata = p.RationaleADD(proyectoActual.getProID(), "add5");
                        if (rata != null) {
                            out.print(rata.getRatAddDescripcion());
                        }
                        %>
                    </textarea>
                    <table width="100" border="0">
                        <tbody>
                            <tr>
                                <td><input type="submit" value="Guardar" name="btnAdd5Guardar"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </form>
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
        </div>
        <form name="add-5" action="ADD5">    
            <table border="0" class="tblCent">
                <tbody>
                    <tr>
                        <td class="alDer"><input type="submit" value="Regresar" name="btnAdd5anterior" class="btn btn-primary btn-lg"/></td>
                        <td class="alCen"><input type="submit" value="Cerrar Proyecto" name="btnInicio" class="btn btn-primary btn-lg"/></td>
                        <td class="alIzq"><input type="submit" value="Continuar" name="btnContinuar" class="btn btn-primary btn-lg"/></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>            
</div>
</body>
</html>
