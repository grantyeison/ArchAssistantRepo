/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.util.List;
import Modelo.Patron;
import Modelo.Tactica;

/**
 *
 * @author Prometheus
 */
public interface PatronDAO  
{
    List<Patron> ListarPatrones();
    
    void CrearPatron(Patron pat);
    
    Patron BuscarPatron(int id);
    
    void ModificarPatron(Patron pat);
    
    void EliminarPatron(Patron pat);

    List<Patron> ListarPatronesPorTactica(Tactica tac);
        
    List<Tactica> ListarTacticasDePatron(int id);
}
