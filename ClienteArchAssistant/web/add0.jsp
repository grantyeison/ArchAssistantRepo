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
        <h1 align="center" class="title">ArchAssistant</h1>
        <h2 align="center">ADD</h2>
        <h2 align="center"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
        <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
        <form name="add-0" action="ADD0">
            <table width="100%" border="0" align="center">
              <tbody>
                <tr>
                  <td><h3>Paso 1</h3></td>
                  <td><h3>Paso 2</h3></td>
                  <td><h3>Paso 3</h3></td>
                  <td><h3>Paso 4</h3></td>
                  <td><h3>Paso 5</h3></td>
                  <td><h3>Paso 6</h3></td>
                  <td><h3>Paso 7</h3></td>
                  <td><h3>Paso 8</h3></td>
                </tr>
              </tbody>
            </table>
            <h2 class="page-header">Que es ADD?</h2>
            <p class="col-lg-6 col-md-9 col-sm-12 parrafo">
                
            </p>
            
            <img src="img/add.png" class="img-rounded"/>
            
            <p class="col-lg-6 col-md-9 col-sm-12 parrafo">
                
            </p>
            
            <table class="tblCentfull">
                <tr>
                    <td class="alDer"><input type="submit" value="Cerrar Proyecto" name="btnAddInicio" class="btn btn-primary btn-lg"/></td>
                    <td class="alIzq"><input type="submit" value="Continuar" name="btnAddContinuar" class="btn btn-primary btn-lg"/></td>
                </tr>
            </table>
        </form>
    </body>
</html>
