/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Modelo.Modulo;
import Modelo.Responsabilidad;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author GOMEZ
 */
public class ResponsabilidadJPADAO implements ResponsabilidadDAO{
    
    EntityManager em;
    EntityManagerFactory emf;


    public ResponsabilidadJPADAO() 
    {
        emf = Persistence.createEntityManagerFactory("ArchAssistantPU");
        em = emf.createEntityManager();
    }

    @Override
    public List<Responsabilidad> ListarResponsabilidades() {
        Query q = em.createQuery("SELECT r FROM Responsabilidad r");
        //q.setParameter(1, proy);
        return q.getResultList();
    }

    @Override
    public void CrearResponsabilidad(Responsabilidad resp) {
        em.getTransaction().begin();
        em.persist(resp);
        em.getTransaction().commit();
    }

    @Override
    public Responsabilidad BuscarResponsabilidad(int id) {
        Responsabilidad resp = new Responsabilidad();
        resp = em.find(resp.getClass(), id);
        return resp;
    }

    @Override
    public List<Responsabilidad> ListarResponsabilidades(Modulo mod) {
        System.out.println("DAO.ResponsabilidadJPADAO.ListarResponsabilidades() "+ mod.getModNombre());
        Query q = em.createQuery("SELECT r FROM Responsabilidad r WHERE r.tblmoduloModId = ?1");
        q.setParameter(1, mod);
        System.out.println("DAO.ResponsabilidadJPADAO.ListarResponsabilidades() "+ q.getResultList());
        return q.getResultList();
    }

    @Override
    public void ModificarResponsabilidad(Responsabilidad resp) {
        em.getTransaction().begin();
        em.merge(resp);
        em.getTransaction().commit();
    }

    @Override
    public void EliminarResponsabilidad(Responsabilidad resp) {
        em.getTransaction().begin();
        em.remove(resp);
        em.getTransaction().commit();
    }    
}
