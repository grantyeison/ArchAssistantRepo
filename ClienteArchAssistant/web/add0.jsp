<%-- 
    Document   : add0
    Created on : 25/01/2017, 11:26:21 AM
    Author     : Prometheus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - ADD</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <script src="./js/jquery-3.2.1.js"></script>
        <!--<script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/bootstrap.min.js"></script>

    </head>
    <body>
        <form name="add-0" action="ADD0">
            <div class="col-lg-12 col-md-12 col-md-12">
                <h2 class="subtitle">ADD</h2>
                <h2 class="bienvenida">                    
                    <% if (session.getAttribute("validUsuario") == null) {
                            response.sendRedirect("InicioUsuario.jsp");
                            //redirijo al login
                        }%><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
                <table border="0" class="tblCentfull">
                    <tbody>
                        <tr>
                            <td><h1 class="bienvenida">Paso 1</h1></td>
                            <td><h3 class="bienvenida">Paso 2</h3></td>
                            <td><h3 class="bienvenida">Paso 3</h3></td>
                            <td><h3 class="bienvenida">Paso 4</h3></td>
                            <td><h3 class="bienvenida">Paso 5</h3></td>
                            <td><h3 class="bienvenida">Paso 6</h3></td>
                            <td><h3 class="bienvenida">Paso 7</h3></td>
                            <td><h3 class="bienvenida">Paso 8</h3></td>
                        </tr>
                    </tbody>
                </table>
                <h2 class="page-header">Que es ADD?</h2>
                <div class="col-lg-12 col-md-12 col-sm-12"> 
                    <div class="col-lg-1"></div>
                    <div class="col-lg-5 col-md-6 col-sm-12">
                        <p class="parrafo">El m&eacute;todo ADD es un enfoque a la definici&oacute;n de una arquitectura de software en el que se basa el proceso de dise&ntilde;o de los requisitos del software de atributos de calidad. ADD es un proceso de dise&ntilde;o recursivo que descompone un sistema o elemento del sistema mediante la aplicaci&oacute;n de t&aacute;cticas arquitect&oacute;nicas [Bass 03] y los patrones que satisfacen los drivers. ADD sigue esencialmente el ciclo &ldquo;Plan, Do, and Check&rdquo;:</p>

                        <p class="parrafo"> Plan: Los atributos de calidad y las restricciones de dise&ntilde;o son consideradas para seleccionar qu&eacute; tipos de elementos se utilizan en la arquitectura. Do: Los elementos son instanciados para satisfacer los atributos de calidad, as&iacute; como los requisitos funcionales. Check: El resultado es analizado para determinar si los requisitos son satisfechos.</p>                        

                    </div>
                    <div class="col-lg-5 col-md-6 col-sm-12">
                        <p class="parrafo"> Este proceso se repite hasta que todos los requisitos de gran importancia arquitect&oacute;nica se cumplen.</p>
                        
                        <img src="img/pasosadd.png" class="alCen" style="width: 400px" alt="pasosdel metodo ADD"/>

                    </div>
                    <div class="col-lg-1"></div>
                </div>
            </div>
            <table class="tblCentfull">
                <tr>
                    <td class="alDer"><input type="submit" value="Cerrar Proyecto" name="btnAddInicio" class="btn btn-primary btn-lg"/></td>
                    <td class="alIzq"><input type="submit" value="Continuar" name="btnAddContinuar" class="btn btn-primary btn-lg"/></td>
                </tr>
            </table>
        </form>
    </body>
</html>
