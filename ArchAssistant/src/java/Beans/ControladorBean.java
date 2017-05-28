/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;
import DAO.ControladorDAO;
import DAO.ControladorJPADAO;
import Modelo.Controlador;
import Modelo.Modulo;
import Modelo.Patron;
import Modelo.Proyecto;
import java.util.List;
import javax.ejb.EJB;

/**
 *
 * @author Prometheus
 */
public class ControladorBean 
{
    @EJB
    private ControladorDAO dao;

    public ControladorBean() 
    {
        dao = new ControladorJPADAO();
        System.out.println("***Controlador DAO ha sido creado***");
    }
    
    
    public void Crear(Controlador con)
    {
        dao.CrearControlador(con);
    }
    
    public void Modificar(Controlador con)
    {
        dao.ModificarControlador(con);
    }
    
    public List<Controlador> Listar(Proyecto proy)
    {
        return dao.ListarControladores(proy);
    }
        
    public Controlador Buscar(int id)
    {
        return dao.BuscarControlador(id);
    }
    
    public void Eliminar(Controlador con)
    {
        dao.EliminarControlador(con);
    }
        
    public List<Controlador> ListarControladoresPorPatron(Patron pt)
    {
        //return dao.ListarControladoresPorPatron(pt);
        return null;
    }
    
}