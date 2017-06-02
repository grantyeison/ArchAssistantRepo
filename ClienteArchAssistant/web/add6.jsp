<%-- 
    Document   : add6
    Created on : 25/01/2017, 12:30:45 PM
    Author     : Prometheus
--%>

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
        <title>ArchAssistant - ADD</title>
    </head>
    <body>
        <form name="add-6" action="ADD6">
            <h1 align="center">ArchAssistant</h1>
            <h2 align="center">ADD</h2>
            <h2 align="center"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
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
            </table>
            <h2>Definir las interfaces para los elementos instanciados:</h2>
            <p align="justify">
                se deben definir las propiedades requeridas y proveídas por el diseño que se está implementando, ADD llama a estos servicios y propiedades como interfaces, éstas definen las necesidades de los elementos y lo que provee cada uno hacia los otros; una interface incluye uno de los siguientes ítems:
            </p>
            <ul>
                <li>Sintaxis de operaciones.</li>
                <li>Semántica de operaciones.</li>
                <li>Información que intercambia.</li>
                <li>Requerimientos de atributos de calidad de los elementos individuales y operaciones.</li>
                <li>Manejo de errores.</li>
            </ul>

            <h2>Submódulos del sistema:</h2>

            <table width="100%" border="3">
                <tbody>
                    <tr>
                        <th scope="col">Código</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Descripción</th>
                        <th scope="col">Final</th>

                    </tr>
                    <tr>
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
                    </tr>
                    <tr>
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
                    </tr>
                </tbody>
            </table>
            <h2>Interfaces</h2>
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

            <table width="100" border="0">
                <tbody>
                    <tr>
                        <td>Nombre: </td>
                        <td><input/></td>
                    </tr>
                    <tr>
                        <td>Descripción</td>
                        <td><input/></td>
                    </tr>
                    <tr>
                        <td>Tipo</td>
                        <td><select>
                                <option value=" Sintaxis de operaciones"> Sintaxis de operaciones</option>
                                <option value="Semántica de operaciones">Semántica de operaciones</option>
                                <option value="Información que intercambia">Información que intercambia</option>
                                <option value="Requerimientos de atributos de calidad de los elementos individuales y operaciones">Requerimientos de atributos de calidad de los elementos individuales y operaciones</option>
                                <option value="Manejo de errores">Manejo de errores</option>
                            </select></td>
                    </tr>

                    <tr>
                        <td>Submódulo</td>
                        <td><input/></td>
                    </tr>
                    <tr>
                        <td><input type="button" value="guardar"/></td>
                        <td><input type="reset" value="Cancelar"/></td>
                    </tr>
                </tbody>
            </table>

            <h2>Rationale:</h2>
            <textarea rows="5" cols="120" name="ratadd6">
                <%
                    ArchAssistantBean p = new ArchAssistantBean();
                    Rationaleadd rata = p.RationaleADD(proyectoActual.getProID(), "add6");
                    if (rata != null) {
                        out.print(rata.getRatAddDescripcion());
                    }
                %>
            </textarea>
            <table width="100" border="0">
                <tbody>
                    <tr>
                        <td><input type="submit" value="Guardar" name="btnAdd6Guardar"/></td>
                    </tr>
                    <!--<tr>
                        <td><input type="submit" value="Regresar" name="btnAdd6anterior"/></td>
                        <td class="alDer"><input type="submit" value="Cerrar Proyecto" name="btnQawInicio" class="btn btn-primary btn-lg"/></td>
                        <td><input type="submit" value="Continuar" name="btnAdd6Continuar"/></td>
                    </tr>-->
                </tbody>
            </table>
        </form>
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
