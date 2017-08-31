<%-- 
    Document   : add
    Created on : 15/06/2017, 04:09:40 PM
    Author     : GOMEZ
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ArchAssistant - ADD</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css" /><!---->
        <link rel="stylesheet" href="./css/estilos.css" /><!---->
        <link rel="stylesheet" href="./css/editor.css" />
        <link rel="stylesheet" href="./css/font-awesome.min.css" />

        <!-- 
       <script src="./js/jquery-3.2.1.min.js" ></script>-->
        <script src="./js/jquery-3.2.1.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/editor.js"></script>
        <script src="./js/funciones.js"></script>
    <body>
        
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
                            <input type="submit" name="BtnCerrarSesion" value="Cerrar Sesión" class="btn btn-primary alDer"/>

                        </td>
                    </tr>
                </table>
                 <h2 class="subtitle">QAW</h2>
                <h2 class="bienvenida"><jsp:useBean id="proyectoActual" scope="session" class="servicios.Proyecto" />
                    <jsp:getProperty name="proyectoActual" property="proNombre" /></h2>
            </form>
       <div class="container">
         <div class="row">
          <div class="process">
           <div class="process-row nav nav-tabs">
               <div class="process-step">
                <button type="button" class="btn btn-info btn-circle" data-toggle="tab" href="#menu0"><i class="fa fa-info fa-3x"></i></button>
                <p><small>QAW 0</small></p>
               </div>
            <div class="process-step">
            <button type="button" class="btn btn-info btn-circle" data-toggle="tab" href="#menu0"><i class="fa fa-info fa-3x"></i></button>
                <p><small>QAW 0</small></p>
            </div>
               <div class="process-step">
            <button type="button" class="btn btn-info btn-circle" data-toggle="tab" href="#menu0"><i class="fa fa-info fa-3x"></i></button>
                <p><small>QAW 0</small></p>
            </div>
            <div class="process-step">
            <button type="button" class="btn btn-info btn-circle" data-toggle="tab" href="#menu0"><i class="fa fa-info fa-3x"></i></button>
                <p><small>QAW 0</small></p>
            </div>
            <div class="process-step">
            <button type="button" class="btn btn-info btn-circle" data-toggle="tab" href="#menu0"><i class="fa fa-info fa-3x"></i></button>
                <p><small>QAW 0</small></p>
            </div>
            <div class="process-step">
            <button type="button" class="btn btn-info btn-circle" data-toggle="tab" href="#menu0"><i class="fa fa-info fa-3x"></i></button>
                <p><small>QAW 0</small></p>
            </div>
            <div class="process-step">
            <button type="button" class="btn btn-info btn-circle" data-toggle="tab" href="#menu0"><i class="fa fa-info fa-3x"></i></button>
                <p><small>QAW 0</small></p>
            </div>
            <div class="process-step">
           <button type="button" class="btn btn-info btn-circle" data-toggle="tab" href="#menu0"><i class="fa fa-info fa-3x"></i></button>
                <p><small>QAW 0</small></p>
             </div>
            <div class="process-step">
            <button type="button" class="btn btn-info btn-circle" data-toggle="tab" href="#menu0"><i class="fa fa-info fa-3x"></i></button>
                <p><small>QAW 0</small></p>
            </div>
           </div>
          </div>
             
             
             
          <div class="tab-content">
           <div id="menu0" class="tab-pane fade active in">
            
               <%@include file='qaw0.jsp'%>    
               
            <ul class="list-unstyled list-inline pull-right">
             <li><button type="button" class="btn btn-info next-step">Next <i class="fa fa-chevron-right"></i></button></li>
            </ul>
           </div>
               
           <div id="menu1" class="tab-pane fade">
            
               <%@include file='qaw1.jsp'%>    
               
            <ul class="list-unstyled list-inline pull-right">
             <li><button type="button" class="btn btn-default prev-step"><i class="fa fa-chevron-left"></i> Back</button></li>
             <li><button type="button" class="btn btn-info next-step">Next <i class="fa fa-chevron-right"></i></button></li>
            </ul>
           </div>
           <div id="menu2" class="tab-pane fade">
            
               <%@include file='qaw2.jsp'%>
               
            <ul class="list-unstyled list-inline pull-right">
             <li><button type="button" class="btn btn-default prev-step"><i class="fa fa-chevron-left"></i> Back</button></li>
             <li><button type="button" class="btn btn-info next-step">Next <i class="fa fa-chevron-right"></i></button></li>
            </ul>
           </div>
           <div id="menu3" class="tab-pane fade">
            
               <%@include file='qaw3.jsp'%>
             
            <ul class="list-unstyled list-inline pull-right">
             <li><button type="button" class="btn btn-default prev-step"><i class="fa fa-chevron-left"></i> Back</button></li>
             <li><button type="button" class="btn btn-info next-step">Next <i class="fa fa-chevron-right"></i></button></li>
            </ul>
           </div>
           <div id="menu4" class="tab-pane fade">
           
               <%@include file='qaw4.jsp'%>
             
            <ul class="list-unstyled list-inline pull-right">
             <li><button type="button" class="btn btn-default prev-step"><i class="fa fa-chevron-left"></i> Back</button></li>
             <li><button type="button" class="btn btn-info next-step">Next <i class="fa fa-chevron-right"></i></button></li>
            </ul>
           </div>
            <div id="menu5" class="tab-pane fade">
           
               <%@include file='qaw5.jsp'%>
             
            <ul class="list-unstyled list-inline pull-right">
             <li><button type="button" class="btn btn-default prev-step"><i class="fa fa-chevron-left"></i> Back</button></li>
             <li><button type="button" class="btn btn-info next-step">Next <i class="fa fa-chevron-right"></i></button></li>
            </ul>
           </div>
            <div id="menu6" class="tab-pane fade">
           
               <%@include file='qaw6.jsp'%>
               
            <ul class="list-unstyled list-inline pull-right">
             <li><button type="button" class="btn btn-default prev-step"><i class="fa fa-chevron-left"></i> Back</button></li>
             <li><button type="button" class="btn btn-info next-step">Next <i class="fa fa-chevron-right"></i></button></li>
            </ul>
           </div>
               <div id="menu7" class="tab-pane fade">
           
               <%@include file='qaw7.jsp'%>
             
            <ul class="list-unstyled list-inline pull-right">
             <li><button type="button" class="btn btn-default prev-step"><i class="fa fa-chevron-left"></i> Back</button></li>
             <li><button type="button" class="btn btn-info next-step">Next <i class="fa fa-chevron-right"></i></button></li>
            </ul>
           </div>
           <div id="menu8" class="tab-pane fade">
            
               <%@include file='qaw8.jsp'%>
             
            <ul class="list-unstyled list-inline pull-right">
             <li><button type="button" class="btn btn-default prev-step"><i class="fa fa-chevron-left"></i> Back</button></li>
             <li><button type="button" class="btn btn-success"><i class="fa fa-check"></i> Done!</button></li>
            </ul>
           </div>
          </div>
         </div>
        </div>
    </body>
</html>
