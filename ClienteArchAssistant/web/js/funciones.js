/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function SeleccionPadre() {

    var resultado = "ninguno";

    var porNombre = document.getElementsByName("selPadre");
    var padre = document.frmadd2.modPadre;
    // Recorremos todos los valores del radio button para encontrar el
    // seleccionado
    for (var i = 0; i < porNombre.length; i++)
    {
        if (porNombre[i].checked)
            resultado = porNombre[i].value;
        padre.value = resultado;
    }
    session.setAttribute("moduloActual", resultado);
    alert("Se ha seleccionado el modulo #" + resultado + " Como el modulo padre");
}

function Seleccionados(sel) {
    //alert("Entra a Guardar Tacticas");
    var resultado = "ninguno";
    var porNombre = document.getElementsByName(sel);

    var lista = "";
    // Recorremos todos los valores del radio button para encontrar el
    // seleccionado
    for (var i = 0; i < porNombre.length; i++)
    {
        if (porNombre[i].checked) {
            resultado = porNombre[i].value;
            lista += resultado + ",";
        }
    }
    return lista
}

function SeleccionarPatrones(){
    var selp = Seleccionados("patronSel");
    var selt = Seleccionados("tacticaSel");
    $("#txtTacticas").val(selt);
    $("#txtPatrones").val(selp);
    //var listaTacticas = $("#txtTacticas").val();
    var rationale = $("#txtRationale").val();
    //var listaPatrones = $("#txtPatrones").val();
    alert("Tacticas seleccionados___" + selt);
    alert("Patrones seleccionados___" + selp);
    var msj = "guardarPatrones";
    $.get('ADD4', {
        //nombre: nombreVar,
        //apellido: apellidoVar,
        //edad: edadVar
        listadot: selt,
        ratadd4: rationale,
        peticion:msj,
        listadop: selp
    }, function (responseText) {
        $('#tabla').html(responseText);
    });
}

$(document).ready(function () {
    $('#submit').click(function (event) {
        var porNombre = document.getElementsByName("tacticaSel");
        var rationale = $("#txtRationale").val();
        var resultado = "ninguno";
        alert("Click en guardar seleccionados")
        var lista = "";
        // Recorremos todos los valores del radio button para encontrar el
        // seleccionado
        for (var i = 0; i < porNombre.length; i++)
        {
            if (porNombre[i].checked) {
                resultado = porNombre[i].value;
                lista += resultado + ",";

            }
        }
        alert("Lista " + lista);
        //var nombre = $('#nombre').val();
        //var apellidoVar = $('#apellido').val();
        //var edadVar = $('#edad').val();
        // Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
        $.get('ADD4', {
            //nombre: nombreVar,
            //apellido: apellidoVar,
            //edad: edadVar
            ratadd4: rationale,
            listadot: lista
        }, function (responseText) {
            $('#tabla').html(responseText);
        });
    });
});




