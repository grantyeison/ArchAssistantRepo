<%-- 
    Document   : progreso
    Created on : 13/06/2017, 03:06:49 PM
    Author     : Prometheus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QAW</title>
        <link rel="stylesheet" href="./css/progreso.css">
        <link rel="stylesheet" href="./css/font-awesome.min.css" />
        <link rel="stylesheet" href="./css/bootstrap.min.css" />
        <link rel="stylesheet" href="./css/estilos.css" />
        <script src="./js/jquery-3.2.1.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/progreso.js"></script>
        <script src="./js/funciones.js"></script>
        <script src="./js/cargarDatos.js"></script>
        <script>
            $(document).ready(function(){
                $('[data-toggle="tooltip"]').tooltip();   
            });
        </script>
    </head>
    <body>

        <form name="gestionarProyectos" action="GestionarProyectos" method="POST">
            
            <table class="col-lg-12 col-md-12 col-sm-12">
                <tr>
                    <td class="col-lg-11 col-md-11 col-sm-11 alDer">
                        <h3> Bienvenido 
                            <jsp:useBean id="validUsuario" scope="session" class="servicios.Usuario" />
                            <jsp:getProperty name="validUsuario" property="usuNombre" />
                        </h3>
                    </td>
                    <td class="col-lg-1 col-md-1 col-sm-1 ">
                        <input type="submit" name="BtnCerrarSesion" value="Cerrar Sesión" class="btn btn-primary alDer"/>

                    </td>
            </table>
               
            <h2 class="subtitle">QAW</h2>
            <h2 class="bienvenida"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
        </form>
           <%
               String avance = proyectoActual.getProAvance();
               int pas = Integer.parseInt(avance.substring(3));
           %>       
        <div class="container">
            <div class="row">
                <div class="process">
                    <div class="process-row nav nav-tabs">
                        <div class="process-step">
                            <button type="button" class=" <%
                                if (pas == 0)
                                {
                                    out.println(" btn-danger btn-info");
                                }
                                else
                                {
                                    out.println(" btn-primary ");
                                }
                                %> btn-circle" data-toggle="tab" href="#menu0" data-toggle="tooltip" title="Que es QAW?"><i class="fa fa-3x">0</i></button>
                            
                        </div>
                        <div class="process-step">
                            <button type="button" class="<%
                                if (pas == 1)
                                {
                                    out.println(" btn-danger btn-info");
                                }
                                else
                                {
                                    if (pas > 1)
                                        out.println(" btn-primary ");
                                    else
                                        out.println(" btn-default ");
                                }
                                %>
                                  btn-circle " data-toggle="tab"  href='#menu1' data-toggle="tooltip" title="Presentación de QAW e introducciones"><i class="fa fa-3x">1</i></button>
                            
                        </div>
                        <div class="process-step">
                            <button <%
                                if (pas < 1)
                                {
                                    out.println(" disabled='true'");
                                }
                                else
                                {
                                    out.println("href='#menu2' ");
                                }
                                %>
                                type="button" class="<%
                                if (pas == 2)
                                {
                                    out.println(" btn-danger btn-info");
                                }
                                else
                                {
                                    if (pas > 2)
                                        out.println(" btn-primary ");
                                    else
                                        out.println(" btn-default ");
                                }
                                %>
                                   btn-default btn-circle" data-toggle="tab" data-toggle="tooltip" title="Presentación del negocio o misión del sistema a desarrollar"><i class="fa fa-3x">2</i></button>
                            
                        </div>
                        <div class="process-step">
                            <button <%
                                if (pas < 2)
                                {
                                    out.println(" disabled='true'");
                                }
                                else
                                {
                                    out.println("href='#menu3' ");
                                }
                                %>
                                type="button" class="<%
                                if (pas == 3)
                                {
                                    out.println(" btn-danger btn-info");
                                }
                                else
                                {
                                    if (pas > 3)
                                        out.println(" btn-primary ");
                                    else
                                        out.println(" btn-default ");
                                }
                                %>
                                   btn-default btn-circle" data-toggle="tab" data-toggle="tooltip" title="Presentación del plan arquitectural"><i class="fa fa-3x">3</i></button>
                            
                        </div>
                        <div class="process-step">
                            <button <%
                                if (pas < 3)
                                {
                                    out.println(" disabled='true'");
                                }
                                else
                                {
                                    out.println("href='#menu4' ");
                                }
                                %>
                                type="button" class="<%
                                if (pas == 4)
                                {
                                    out.println(" btn-danger btn-info");
                                }
                                else
                                {
                                    if (pas > 4)
                                        out.println(" btn-primary ");
                                    else
                                        out.println(" btn-default ");
                                }
                                %>
                                   btn-default btn-circle" data-toggle="tab" data-toggle="tooltip" title="Identificación de los drivers arquitecturales"><i class="fa fa-3x">4</i></button>
                            
                        </div>
                        <div class="process-step">
                            <button <%
                                if (pas < 4)
                                {
                                    out.println(" disabled='true'");
                                }
                                else
                                {
                                    out.println("href='#menu5' ");
                                }
                                %>
                                type="button" class="<%
                                if (pas == 5)
                                {
                                    out.println(" btn-danger btn-info");
                                }
                                else
                                {
                                    if (pas > 5)
                                        out.println(" btn-primary ");
                                    else
                                        out.println(" btn-default ");
                                }
                                %>
                                   btn-default btn-circle" data-toggle="tab"data-toggle="tooltip" title="Lluvia de ideas de escenarios"><i class="fa fa-3x">5</i></button>
                            
                        </div>
                        <div class="process-step">
                            <button <%
                                if (pas < 5)
                                {
                                    out.println(" disabled='true'");
                                }
                                else
                                {
                                    out.println("href='#menu6' ");
                                }
                                %>
                                type="button" class="<%
                                if (pas == 6)
                                {
                                    out.println(" btn-danger btn-info");
                                }
                                else
                                {
                                    if (pas > 6)
                                        out.println(" btn-primary ");
                                    else
                                        out.println(" btn-default ");
                                }
                                %>
                                   btn-default btn-circle" data-toggle="tab" data-toggle="tooltip" title="Consolidación de escenarios"><i class="fa fa-3x">6</i></button>
                            
                        </div>
                        <div class="process-step">
                            <button <%
                                if (pas < 6)
                                {
                                    out.println(" disabled='true'");
                                }
                                else
                                {
                                    out.println("href='#menu7' ");
                                }
                                %>
                                type="button" class="<%
                                if (pas == 7)
                                {
                                    out.println(" btn-danger btn-info");
                                }
                                else
                                {
                                    if (pas > 7)
                                        out.println(" btn-primary ");
                                    else
                                        out.println(" btn-default ");
                                }
                                %>
                                   btn-default btn-circle" data-toggle="tab" data-toggle="tooltip" title="Priorización de los escenarios"><i class="fa fa-3x">7</i></button>

                        </div>
                        <div class="process-step">
                            <button <%
                                if (pas < 7)
                                {
                                    out.println(" disabled='true'");
                                }
                                else
                                {
                                    out.println("href='#menu8' ");
                                }
                                %>
                                type="button" class="<%
                                if (pas == 8)
                                {
                                    out.println(" btn-danger btn-info");
                                }
                                else
                                {
                                    if (pas > 8)
                                        out.println(" btn-primary ");
                                    else
                                        out.println(" btn-default ");
                                }
                                %>
                                  btn-default btn-circle" data-toggle="tab" data-toggle="tooltip" title="Refinamiento de los escenarios"><i class="fa fa-3x">8</i></button>

                        </div>
                    </div>
                </div>



                <div class="tab-content">
                    <div id="menu0" class="tab-pane fade active in">

                        <%@include file='qaw0.jsp'%>    
                        <form action="GestionarProyectos">
                            <ul class="list-unstyled list-inline pull-right">
                                <li><button type="submit" class="btn btn-default btn-lg" name="cerrarProyecto">Cerrar Proyecto  <i class="fa fa-dot-circle-o"></i></button></li>
                                <li><button type="button" class="btn btn-info btn-lg next-step">Siguiente <i class="fa fa-chevron-right"></i></button></li>
                            </ul>
                        </form>
                    </div>

                    <div id="menu1" class="tab-pane fade">

                        <%@include file='qaw1.jsp'%>    

                        <ul class="list-unstyled list-inline pull-right">
                            <li><button type="button" class="btn btn-info btn-lg prev-step"><i class="fa fa-chevron-left"></i> Anterior</button></li>
                            <li><button type="submit" class="btn btn-lg btn-default" name="cerrarProyecto">Cerrar Proyecto  <i class="fa fa-dot-circle-o"></i></button></li>
                            <li><button type="button" class="btn btn-lg btn-info next-step">Siguiente <i class="fa fa-chevron-right"></i></button></li>
                        </ul>
                    </div>
                    <div id="menu2" class="tab-pane fade">

                        <%@include file='qaw2.jsp'%>

                        <ul class="list-unstyled list-inline pull-right">
                            <li><button type="button" class="btn btn-lg btn-info prev-step"><i class="fa fa-chevron-left"></i> Anterior</button></li>
                            <li><button type="submit" class="btn btn-lg btn-default" name="cerrarProyecto">Cerrar Proyecto  <i class="fa fa-dot-circle-o"></i></button></li>
                            <li><button type="button" class="btn btn-lg btn-info next-step">Siguiente <i class="fa fa-chevron-right"></i></button></li>
                        </ul>
                    </div>
                    <div id="menu3" class="tab-pane fade">

                        <%@include file='qaw3.jsp'%>

                        <ul class="list-unstyled list-inline pull-right">
                            <li><button type="button" class="btn btn-lg btn-info prev-step"><i class="fa fa-chevron-left"></i> Anterior</button></li>
                            <li><button type="submit" class="btn btn-lg btn-default" name="cerrarProyecto">Cerrar Proyecto  <i class="fa fa-dot-circle-o"></i></button></li>
                            <li><button type="button" class="btn btn-lg btn-info next-step">Siguiente <i class="fa fa-chevron-right"></i></button></li>
                        </ul>
                    </div>
                    <div id="menu4" class="tab-pane fade">

                        <%@include file='qaw4.jsp'%>

                        <ul class="list-unstyled list-inline pull-right">
                            <li><button type="button" class="btn btn-lg btn-info prev-step"><i class="fa fa-chevron-left"></i> Anterior</button></li>
                            <li><button type="submit" class="btn btn-lg btn-default" name="cerrarProyecto">Cerrar Proyecto  <i class="fa fa-dot-circle-o"></i></button></li>
                            <li><button type="button" class="btn btn-lg btn-info next-step">Siguiente <i class="fa fa-chevron-right"></i></button></li>
                        </ul>
                    </div>
                    <div id="menu5" class="tab-pane fade">

                        <%@include file='qaw5.jsp'%>

                        <ul class="list-unstyled list-inline pull-right">
                            <li><button type="button" class="btn btn-lg btn-info prev-step"><i class="fa fa-chevron-left"></i> Anterior</button></li>
                            <li><button type="submit" class="btn btn-lg btn-default" name="cerrarProyecto">Cerrar Proyecto  <i class="fa fa-dot-circle-o"></i></button></li>
                            <li><button type="button" class="btn btn-lg btn-info next-step">Siguiente <i class="fa fa-chevron-right"></i></button></li>
                        </ul>
                    </div>
                    <div id="menu6" class="tab-pane fade">

                        <%@include file='qaw6.jsp'%>

                        <ul class="list-unstyled list-inline pull-right">
                            <li><button type="button" class="btn btn-lg btn-info prev-step"><i class="fa fa-chevron-left"></i> Anterior</button></li>
                            <li><button type="submit" class="btn btn-lg btn-default" name="cerrarProyecto">Cerrar Proyecto  <i class="fa fa-dot-circle-o"></i></button></li>
                            <li><button type="button" class="btn btn-lg btn-info next-step">Siguiente <i class="fa fa-chevron-right"></i></button></li>
                        </ul>
                    </div>
                    <div id="menu7" class="tab-pane fade">

                        <%@include file='qaw7.jsp'%>

                        <ul class="list-unstyled list-inline pull-right">
                            <li><button type="button" class="btn btn-lg btn-info prev-step"><i class="fa fa-chevron-left"></i> Anterior</button></li>
                            <li><button type="submit" class="btn btn-lg btn-default" name="cerrarProyecto">Cerrar Proyecto  <i class="fa fa-dot-circle-o"></i></button></li>
                            <li><button type="button" class="btn btn-lg btn-info next-step">Siguiente <i class="fa fa-chevron-right"></i></button></li>
                        </ul>
                    </div>
                    <div id="menu8" class="tab-pane fade">

                        <%@include file='qaw8.jsp'%>

                        <ul class="list-unstyled list-inline pull-right">
                            <li><button type="button" class="btn btn-lg btn-default prev-step"><i class="fa fa-chevron-left"></i> Anterior</button></li>
                            <li><button type="submit" class="btn btn-lg btn-info" name="cerrarProyecto">Cerrar Proyecto  <i class="fa fa-dot-circle-o"></i></button></li>
                            <li><button type="button" class="btn btn-lg btn-success"><i class="fa fa-check"></i> Finalizado QAW!</button></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
