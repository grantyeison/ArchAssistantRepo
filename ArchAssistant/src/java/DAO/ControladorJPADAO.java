/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Modelo.Controlador;
import Modelo.Proyecto;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author Prometheus
 */
public class ControladorJPADAO implements ControladorDAO
{

    EntityManager em;
    EntityManagerFactory emf;
    
    public ControladorJPADAO() 
    {
        emf = Persistence.createEntityManagerFactory("ArchAssistantPU");
        em = emf.createEntityManager();
    }

    @Override
    public void CrearControlador(Controlador con) {
        em.getTransaction().begin();
        em.persist(con);
        em.getTransaction().commit();
    }

    @Override
    public List<Controlador> ListarControladores(Proyecto proy) {
        List<Controlador> lst = null;
        Query q = em.createQuery("SELECT c FROM Controlador c");
        lst = q.getResultList();
        return lst;
    }

    @Override
    public Controlador BuscarControlador(int id) {
        Controlador con = new Controlador();        
        con = em.find(con.getClass(), id);
        return con;
    }

    @Override
    public void ModificarControlador(Controlador con) {
        if(BuscarControlador(con.getContID()) != null){
            EliminarControlador(con);
            CrearControlador(con);
        }
    }

    @Override
    public void EliminarControlador(Controlador con) {
        em.getTransaction().begin();
        em.remove(con);
        em.getTransaction().commit();
    }

}
