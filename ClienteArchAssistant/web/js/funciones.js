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

function SeleccionarPatrones() {
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
        peticion: msj,
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
<<<<<<< .mine
    
    $('#btnAddsubir').click(function (event) {
        event.preventDefault();
        var formData = new FormData(document.getElementById("frmArchivos"));
        //alert("Click en guardar seleccionados");
        $.ajax({
            url: "ADD1",
            type: "post",
            dataType: "html",
            data: formData,
            cache: false,
            contentType: false,
            processData: false
        }).done(function (res){
             $('#divArchivos').html(res);
        });
        
    });
||||||| .r65
=======

    $('#btnCrearModulo').click(function (event) {
        var nom = $("#txtNomMod").val();
        var desc = $("#txtDesMod").val();
        if (nom != null && desc != null) {
            alert(nom + "  " + desc)
            $.post('ADD4', {
                //nombre: nombreVar,
                //apellido: apellidoVar,
                //edad: edadVar
                mensaje: "crearModulo",
                nombreModulo: nom,
                descripcionModulo: desc
            }, function (responseText) {
                $('#tblModulos').html(responseText);
            });
        }
    });

    $('#btnCrearResp').click(function (event) {

        var nom = $("#txtNomResp").val();
        var desc = $("#txtDesResp").val();
        var sel = $("#selModelo").val();
        alert("click" + nom + desc + sel);
        if (nom != null && desc != null && sel != null) {
            alert(nom + "  " + desc)
            $.post('ADD5', {
                //nombre: nombreVar,
                //apellido: apellidoVar,
                //edad: edadVar
                mensaje: "crear",
                seleccion: sel,
                nombre: nom,
                descripcion: desc
            }, function (responseText) {
                //alert(responseText);
                $("#txtNomResp").val("");
                $("#txtDesResp").val("");
                $("#selModelo").val(null);                
                $('#tblResponsabilidades').html(responseText);
            });
        }
    });
>>>>>>> .r80
});




