/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Modelo.Patron;
import Modelo.Tactica;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author Prometheus
 */
public class PatronJPADAO implements PatronDAO
{

    EntityManager em;
    EntityManagerFactory emf;

    public PatronJPADAO()  
    {
        emf = Persistence.createEntityManagerFactory("ArchAssistantPU");
        em = emf.createEntityManager();
    }


    
    @Override
    public List<Patron> ListarPatrones() 
    {
        List<Patron> lst = null;
        Query q = em.createQuery("SELECT p FROM Patron p");
        lst = q.getResultList();
        return lst;
    }

    @Override
    public void CrearPatron(Patron pat)  
    {
        em.getTransaction().begin();
        em.persist(pat);
        em.getTransaction().commit();
    }

    @Override
    public Patron BuscarPatron(int id)  
    {
        Patron pat = new Patron();
        pat = em.find(pat.getClass(), id);
        return pat;
    }

    @Override
    public void ModificarPatron(Patron pat)  
    {
        if (BuscarPatron(pat.getPatID()) != null)
            EliminarPatron(pat);
        CrearPatron(pat);
    }

    @Override
    public void EliminarPatron(Patron pat) 
    {
        em.getTransaction().begin();
        em.remove(pat);
        em.getTransaction().commit();
    }

    @Override
    public List<Patron> ListarPatronesPorTactica(Tactica tac) {
        Query q = em.createNamedQuery("SELECT p FROM Patron p WHERE p.Tbl_Tactica_tacID = ?1");
        q.setParameter(1, tac);
        return q.getResultList();        
    }    
    
    @Override
    public List<Tactica> ListarTacticasDePatron(int id) {
        System.out.println("patron para consultar ID= " + id);
        Patron patron = this.BuscarPatron(id);
        if (patron != null) {
            System.out.println("el patron elegido es ()+ " + patron + " y sus tacticas asociadas son" + patron.getTacticaList());
            return patron.getTacticaList();
        }else   return null;
    }
}
