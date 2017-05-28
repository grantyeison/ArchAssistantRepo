/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Modelo.Atributocalidad;
import Modelo.Patron;
import Modelo.Tactica;
import java.util.List;

/**
 *
 * @author Prometheus
 */
public interface TacticaDAO 
{
    List<Tactica> ListarTacticas();
    
    void CrearTactica(Tactica tac);
    
    Tactica BuscarTactica(int id);
    
    void ModificarTactica(Tactica tac);
    
    void EliminarTactica(Tactica tac);
    
    List<Tactica> BuscarTacticaPorAtributoDeCalidad(Atributocalidad atr);
    
    List<Patron> ListarPatrones();

    List<Patron> ListadoPatronesDeTactica(int id );

    List<Tactica> ListarTacticasPorPatron(Patron pat);

}
