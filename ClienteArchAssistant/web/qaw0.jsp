<%-- 
    Document   : qaw0
    Created on : 20/01/2017, 03:43:34 PM
    Author     : Prometheus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - QAW</title>
    </head>
    <body>
        <h1 align="center">ArchAssistant</h1>
        <h2 align="center">QAW</h2>
        <h2 align="center"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
        <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
        <form name="qaw-0" action="QAW0">
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
            <p>Que es QAW?</p>
            <input type="submit" value="Continuar" name="btnQaw0Continuar"/>
            <input type="submit" value="Cancelar" name="btnQaw0Cancelar"/>
        </form>
    </body>
</html>
