<%-- 
    Document   : crearProyecto
    Created on : 29/12/2016, 07:16:41 PM
    Author     : Prometheus
--%>

<div class="modal fade" id="crearProyecto" role="dialog">
    <div class="modal-dialog">
    <div class="modal-content">
            <form action="GuardarProyecto" method="POST">
        <div class="modal-header modal-header-success">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h1>Crear Proyecto </h1>
        </div>
        <div class="modal-body">

                <table border="0" class="tblCentfull">
                    <tbody>
                        <tr>
                            <td>Nombre Proyecto: </td>
                            <td><input type="text" name="txtNombreProyecto" value="" class="form-control"/></td>
                        </tr>
                        <tr>
                            <td>Descripcion: </td>
                            <td><textarea name="txtDescripcionProyecto" rows="10" cols="50" class="form-control"></textarea></td>
                        </tr>
                        
                    </tbody>
                </table>

        </div>
        <div class="modal-footer">
            <table class="tblCentfull">
                <tr>
                   <td class="alIzq"><button type="button" class="btn btn-default pull-left btn-lg" data-dismiss="modal">Cancelar</button></td> 
                   <td class="alDer"><input type="submit" value="Guardar" name="btnGuardarProyecto" class="btn btn-primary btn-lg"/></td>
                </tr>
            </table>
        </div>
            </form>
    </div><!-- /.modal-content -->
    </div>
</div><!-- /.modal-dialog -->




<!--<h4><kbd>esc</kbd> or click anyway to close</h4>
<hr>
<div class="alert alert-danger"><h4>You can add any html and css ;)</h4></div>-->




