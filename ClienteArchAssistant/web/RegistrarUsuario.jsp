<%-- 
    Document   : RegistrarUsuario
    Created on : 29/12/2016, 10:11:17 AM
    Author     : Prometheus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - Registrar Usuario</title>
    </head>
    <body>
        <h1>Registrar nuevo usuario</h1>
        <form name="FormRegUsuario" action="RegistrarUsuario" method="POST">
            <table border="0" style="margin-left: 28%;">
                <tr>
                    <td>Nombre: </td>
                    <td><input type="text" name="txtUsuNueNombre" value="" /></td>
                </tr>
                <tr>
                    <td>Usuario: </td>
                    <td><input type="text" name="txtUsuNueUsuario" value="" /></td>
                </tr>
                <tr>
                    <td>Contraseña: </td>
                    <td><input type="password" name="txtUsuNueContrasena1" value="" /></td>
                </tr>
                <tr>
                    <td>Repita contraseña: </td>
                    <td><input type="password" name="txtUsuNueContrasena2" value="" /></td>
                </tr>
                <tr>
                    <td><input type="submit" value="Guardar" name="btnGuardarNuevoUsuario" /></td>
                    <td><input type="reset" value="Cancelar" /></td>
                </tr>
            </table>
        </form>

    </body>
</html>
