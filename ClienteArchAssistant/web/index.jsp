<%-- 
    Document   : index
    Created on : 29/12/2016, 09:03:43 AM
    Author     : Prometheus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant inicio</title>
        <link rel="stylesheet" href="assets/css/" /><!---->
        <script language="JavaScript">
            function usuarioNoValido()
            {
                window.alert("usuario no válido, verifique usuario y contraseña");
            }
         </script>   
    </head>
    <body class="loading">
        <div id="wrapper">
            <div id="bg"></div>
            <div id="overlay"></div>
            <div id="main">
                <h1>Iniciar Sesión</h1>
                <form action="AutenticarUsuario" method="POST">
                    <table border="0">
                        <tbody>
                            <tr>
                                <td>Usuario:</td>
                                <td><input type="text" name="txtUsuario" value="" /></td>
                            </tr>
                            <tr>
                                <td>Contraseña</td>
                                <td><input type="password" name="txtpass" value="" /></td>
                            </tr>
                            <tr>
                                <td><input type="submit" value="Registrar Usuario" name="btnRegistrar" /></td>
                                <td><input type="submit" value="Ingresar" name="btnIngresarUsuario" /></td>
                            </tr>
                        </tbody>
                    </table>

                </form>
            </div>
        </div>
    </body>
</html>
