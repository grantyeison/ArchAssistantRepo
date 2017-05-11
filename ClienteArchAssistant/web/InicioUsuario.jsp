<%-- 
    Document   : InicioUsuario
    Created on : 29/12/2016, 09:37:25 AM
    Author     : Prometheus
--%>

<%@page import="Beans.ArchAssistantBean"%>
<%@page import="java.util.List"%>
<%@page import="servicios.Proyecto"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - Gestionar Proyectos</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <script src="./js/jquery-3.2.1.js"></script>
        <!--<script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/bootstrap.min.js"></script>
    </head>
    <body class="loading">
        <div class="col-lg-12 col-md-12 col-md-12">
            <form name="gestionarProyectos" action="GestionarProyectos" method="POST">
                <table class="tblCentfull">
                    <tr>
                        <td>
                            <h1 class="bienvenida"> Bienvenido 
                                <jsp:useBean id="validUsuario" scope="session" class="servicios.Usuario" />
                                <jsp:getProperty name="validUsuario" property="usuNombre" />
                            </h1>
                        </td>
                        <td>
                           <input type="submit" name="CerrarSesion" value="Cerrar Sesión" class="btn btn-primary alDer"/>
                                
                        </td>
                    </tr>
                </table>
            </form>


            <form name="gestionarProyectos" action="GestionarProyectos">
                <table border="1" class="tblCentContent table table-hover">
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Avance</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Proyecto> lista;
                            ArchAssistantBean p = new ArchAssistantBean();
                            lista = p.Listar(validUsuario.getUsuUsuario());
                            for (Proyecto pro : lista)
                            {
                                out.println("<tr><td>" + pro.getProID()+ "</td>");
                                out.println("<td>" + pro.getProNombre()+ "</td>");
                                out.println("<td>" + pro.getProDescripcion()+ "</td>");
                                out.println("<td>" + pro.getProAvance()+ "</td>");
                                if (pro.getProAvance().equals("qaw8"))
                                {
                                    out.println("<td><input type=\"submit\" value=\"Reporte\" name=\"btnGenerarReporte"+pro.getProID()+"\" class =\"btn btn-primary\"/></td></tr>");
                                }
                            }
                        %>
                    </tbody>
                </table>
                    <table border="0" class="tblCent">
                    <tbody>
                        <tr>
                            <td>ID del proyecto: </td>
                            <!-- buscar ccampos de texto y botones con iconos para eliminar, seleccionar y crear -->
                            <td><input type="text" name="txtIdProyecto" value="" /></td>
                        </tr>
                        <tr>
                            <td><input type="submit" value="Seleccionar" name="btnSeleccionarProyecto" class="btn btn-primary"/></td>
                            <td><input type="submit" value="Eliminar" name="btnEliminarProyecto" class="btn btn-primary"/></td>
                            <td><input type="submit" value="Nuevo" name="btnCrearProyecto" class="btn btn-primary"/></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </body>
</html>
