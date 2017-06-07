/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Modelo.Modulo;
import Modelo.Responsabilidad;
import java.util.List;

/**
 *
 * @author GOMEZ
 */
public interface ResponsabilidadDAO {
    
    List<Responsabilidad> ListarResponsabilidades(Modulo mod);
    
    List<Responsabilidad> ListarResponsabilidades();
    
    void CrearResponsabilidad(Responsabilidad resp);
    
    Responsabilidad BuscarResponsabilidad(int id);
        
    void ModificarResponsabilidad (Responsabilidad resp);
    
    void EliminarResponsabilidad (Responsabilidad resp);
    
}
