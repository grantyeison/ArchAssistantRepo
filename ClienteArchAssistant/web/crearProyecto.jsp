<%-- 
    Document   : crearProyecto
    Created on : 29/12/2016, 07:16:41 PM
    Author     : Prometheus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - Nuevo Proyecto</title>
    </head>
    <body>
        <h1>Crear Proyecto </h1>
        <form action="GuardarProyecto" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Nombre Proyecto: </td>
                        <td><input type="text" name="txtNombreProyecto" value="" /></td>
                    </tr>
                    <tr>
                        <td>Descripcion: </td>
                        <td><textarea name="txtDescripcionProyecto" rows="4" cols="20"></textarea></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Guardar" name="btnGuardarProyecto" /></td>
                        <td><input type="submit" value="Cancelar" name="btnCancelar" /></td>
                    </tr>
                </tbody>
            </table>
        </form>

    </body>
</html>
