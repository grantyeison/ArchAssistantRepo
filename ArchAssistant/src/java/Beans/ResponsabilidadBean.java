/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;
import DAO.ResponsabilidadDAO;
import DAO.ResponsabilidadJPADAO;
import Modelo.Modulo;
import Modelo.Responsabilidad;
import Modelo.Responsabilidad;
import java.util.List;
import javax.ejb.EJB;

/**
 *
 * @author Prometheus
 */
public class ResponsabilidadBean 
{
    @EJB
    private ResponsabilidadDAO dao;

    public ResponsabilidadBean() 
    {
            dao = new ResponsabilidadJPADAO();
    }
    
    public List<Responsabilidad> Listar(Modulo mod)
    {
        return dao.ListarResponsabilidades(mod);
    }
    
    public List<Responsabilidad> Listar()
    {
        return dao.ListarResponsabilidades();
    }
    
    public void Crear(Responsabilidad resp)
    {
        dao.CrearResponsabilidad(resp);
    }
    
    public Responsabilidad Buscar(int id)
    {
        return dao.BuscarResponsabilidad(id);
    }
    
    public void Eliminar(Responsabilidad resp)
    {
        dao.EliminarResponsabilidad(resp);
    }
    
    public void Modificar(Responsabilidad resp)
    {
        dao.ModificarResponsabilidad(resp);
    }   
}
