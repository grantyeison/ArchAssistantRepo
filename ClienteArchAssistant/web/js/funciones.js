/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/*
 function seleccionarPaso(id)
 {
 $("#btnQAW0").removeClass("btn-info");
 $("#btnQAW1").removeClass("btn-info");
 $("#btnQAW2").removeClass("btn-info");
 $("#btnQAW3").removeClass("btn-info");
 $("#btnQAW4").removeClass("btn-info");
 $("#btnQAW5").removeClass("btn-info");
 $("#btnQAW6").removeClass("btn-info");
 $("#btnQAW7").removeClass("btn-info");
 $("#btnQAW8").removeClass("btn-info");
 
 $("#btnQAW0").addClass("btn-default");
 $("#btnQAW1").addClass("btn-default");
 $("#btnQAW2").addClass("btn-default");
 $("#btnQAW3").addClass("btn-default");
 $("#btnQAW4").addClass("btn-default");
 $("#btnQAW5").addClass("btn-default");
 $("#btnQAW6").addClass("btn-default");
 $("#btnQAW7").addClass("btn-default");
 $("#btnQAW8").addClass("btn-default");
 
 $("#"+id).removeClass("btn-default"); 
 $("#"+id).addClass("btn-info");    
 }
 */

function SeleccionPadre() {

    var resultado = "ninguno";

    var porNombre = document.getElementsByName("selPadre");
    var padre = $("#txtModDesc");
    // Recorremos todos los valores del radio button para encontrar el
    // seleccionado
    for (var i = 0; i < porNombre.length; i++)
    {
        //if()
        if (porNombre[i].checked)
            resultado = porNombre[i].value;

        padre.val(resultado);
    }
    //var se= '<%= session.setAttribute("moduloActual", resultado)%>';
    listarModulos(resultado);
    alert("Se ha seleccionado el modulo #" + resultado + " Como el modulo padre, lo que hay en el txt " + padre.val());
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
    return lista;
}

function SeleccionarPatrones() {
    var selp = Seleccionados("patronSel");
    var selt = Seleccionados("tacticaSel");
    $("#txtTacticas").val(selt);
    $("#txtPatrones").val(selp);
    //var listaTacticas = $("#txtTacticas").val();
    var rationale = $("#txtRationale").val();
    //var listaPatrones = $("#txtPatrones").val();
    //alert("Tacticas seleccionados___" + selt);
    //alert("Patrones seleccionados___" + selp);
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
        $('#tblPatrones').html(responseText);
    });
}

$(document).ready(function () {



    $('#submit').click(function (event) {
        var porNombre = document.getElementsByName("tacticaSel");
        var rationale = $("#txtRationale").val();
        var resultado = "ninguno";
        //alert("Click en guardar seleccionados")
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
        //alert("Lista " + lista);
        // Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
        $.get('ADD4', {
            //nombre: nombreVar,
            //apellido: apellidoVar,
            //edad: edadVar
            ratadd4: rationale,
            listadot: lista
        }, function (responseText) {
            $('#tblPatrones').html(responseText);
        });
    });

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
        }).done(function (res) {
            $('#divArchivos').html(res);
        });

    });
    $('.textColl').click(function (event) {
        var a = $('this').val();
        if (a == "ver más...")
        {
            $('this').val("...ver menos");
            $('this').show();
        } else
        {
            $('this').val("ver más...");
            $('this').show();
        }
    });
    $('#btnCrearModulo').click(function (event) {
        var nom = $("#txtNomMod").val();
        var desc = $("#txtDesMod").val();
        if (nom != null && desc != null) {
            //alert(nom + "  " + desc)
            $.post('ADD4', {
                //nombre: nombreVar,
                //apellido: apellidoVar,
                //edad: edadVar
                mensaje: "crear",
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
        var sel = $("#selModulo").val();
        //alert("click" + nom + desc + sel);
        if (nom != null && desc != null && sel != null) {
            //alert(nom + "  " + desc)
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
                $("#selModulo").val(null);
                $('#tblResponsabilidades').html(responseText);
            });
        }
    });

    $('#btnCrearInter').click(function (event) {
        var nom = $("#txtNom").val();
        var desc = $("#txtDesc").val();
        var tipo = $("#txtTipo").val();
        var sel = $("#selModulo").val();
        //alert("click" + nom + desc + sel + tipo);
        if (nom != null && desc != null && sel != null && tipo != null) {
            //alert(nom + "  " + desc)
            $.post('ADD6', {
                //nombre: nombreVar,
                //apellido: apellidoVar,
                //edad: edadVar
                mensaje: "crear",
                seleccion: sel,
                nombre: nom,
                tipo: tipo,
                descripcion: desc
            }, function (responseText) {
                //alert(responseText);
                $("#txtNom").val("");
                $("#txtDesc").val("");
                $("#txtTipo").val(" Sintaxis de operaciones");
                $("#selModulo").val(null);
                $("#tblAux").hide();
                $('#tblResponsabilidades').html(responseText);
            });
        }
    });

    $("#txtEditor").Editor();

    $("#btnGuardarRat").click(function () {
        var rationale = $("#txtEditor").Editor('getText');
        alert(rationale);

        //alert("click" + nom + desc + sel + tipo);
        if (rationale != null) {
            //alert(nom + "  " + desc)
            $.post('Rationale', {
                //nombre: nombreVar,
                //apellido: apellidoVar,
                //edad: edadVar
                mensaje: "guardar",
                rata: rationale

            }, function (responseText) {
                //alert("sale del llamado ");
                $("#divMensaje").show();
                $("#divMensaje").html(responseText);
                $("#divMensaje").hide(6000);
            });
        }
    });

    $.post('Rationale', {
        //nombre: nombreVar,
        //apellido: apellidoVar,
        //edad: edadVar
        mensaje: "obtener"

    }, function (responseText) {
        $("#txtEditor").Editor('setText', responseText);
    });

    $("#multiform").submit(function (e)
    {

        var formObj = $(this);
        var formURL = formObj.attr("action");
        var formData = new FormData(this);
        $.ajax({
            url: formURL,
            type: 'POST',
            data: formData,
            mimeType: "multipart/form-data",
            contentType: false,
            cache: false,
            processData: false,
            success: function (data, textStatus, jqXHR)
            {
                //alert("exito" + data);
                $("#divMensaje").show();
                $("#divMensaje").html("<div id='inner-message' class='alert alert-success alert-dismissable fade in'>"
                        + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>"
                        + "<strong>Archivo subido con exito!</strong> </div>");
                $("#divMensaje").hide(6000);
                $("#divListaArchivos").html(data);
            },
            error: function (jqXHR, textStatus, errorThrown)
            {
                alert("error eroor");
            }
        });
        e.preventDefault(); //Prevent Default action. 
        e.unbind();
    });

    $("#file-1").fileinput({
        showCaption: false,
        browseClass: "btn btn-primary btn-lg",
        fileType: "any"
    });


});

//funcion para guardar el modulo que se escoge para descomponer, este se llama cuando se selecciona 
//en la tabla de los moculos cuando se de click sobre un modulo inmediatamente se llama para decir que este 
//modulo sera el que se va a descomponer, entonces esta funcion debe recibir el id del modulo que se va a cambiar 
//de estado 
function listarModulos(id) {
    $.post('Modulos', {
        //nombre: nombreVar,
        //apellido: apellidoVar,
        //edad: edadVar
        mensaje: "modulos",
        id: id
    }, function (responseText) {
        $("#txtEditor").Editor('setText', responseText);
        alert("Rationale del modulo  "+ responseText);
        $.post('Rationale', {
            //nombre: nombreVar,
            //apellido: apellidoVar,
            //edad: edadVar
            jd: "guardar"
        }, function (responseText1) {
            //$("#divListaArchivos")
            alert("exito llamado para listar los archivos "+ responseText1);
            $("#divListaArchivos").Html(responseText1);
        });        
    });
}



