/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {
    
        var rationale = $("#ratqaw4").val();
        $.get('cargarDatos', {            
            ratqaw4: rationale,
        }, function (responseText) {
            $('#tblAtributos4').html(responseText);
        });
        
        $('#4atrSelec2').click(function (event) {
            //crear nuevo atributo de calidad
        var rationale = $("#ratqaw4").val();
        //var guardar = "a";
        var nomAtri = $("#nomNueAtri").val();
        var descAtri = $("#descNueAtri").val();
        
        var atris = document.getElementsByClassName("check");
        var lista = "";
        for (var i = 0; i < atris.length; i++)
        {
            if (atris[i].checked) {
                resultado = atris[i].value;
                lista += resultado + ",";

            }
        }
        $.get('QAW4', {
            ratqaw4: rationale,
            nombre: nomAtri,
            desc: descAtri,
            listadot: lista
        }, function (responseText) {
            $('#tblAtributos4').html(responseText);
        });
    });
    
    
    
    $('#4atrSelec').click(function (event) {
        //guardar atributos seleccionados
        var rationale = $("#ratqaw4").val();
        var atris = document.getElementsByClassName("check");
        var lista = "";
        for (var i = 0; i < atris.length; i++)
        {
            if (atris[i].checked) {
                resultado = atris[i].value;
                lista += resultado + ",";
            }
        }
           // alert(lista);
        $.get('QAW5', {
            ratqaw4: rationale,
            listadot: lista
        }, function (responseText) {
            $('#slcAtributo').html(responseText);
        });
        alert(" Los atributos han sido guardados con éxito ");
    });

});