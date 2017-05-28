/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Modelo.Patron;
import Modelo.Tactica;
import Modelo.Atributocalidad;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author Prometheus
 */
public class TacticaJPADAO implements TacticaDAO {

    EntityManager em;
    EntityManagerFactory emf;

    public TacticaJPADAO() {
        emf = Persistence.createEntityManagerFactory("ArchAssistantPU");
        em = emf.createEntityManager();
    }

    @Override
    public List<Tactica> ListarTacticas() {
        List<Tactica> lst = null;
        Query q = em.createQuery("SELECT t FROM Tactica t");
        lst = q.getResultList();
        return lst;
    }

    @Override
    public void CrearTactica(Tactica tac) {
        em.getTransaction().begin();
        em.persist(tac);
        em.getTransaction().commit();
    }

    @Override
    public Tactica BuscarTactica(int id) {
        Tactica tac = new Tactica();
        tac = em.find(tac.getClass(), id);
        return tac;
    }

    @Override
    public void ModificarTactica(Tactica tac) {
        if (BuscarTactica(tac.getTacID()) != null) {
            EliminarTactica(tac);
        }
        CrearTactica(tac);
    }

    @Override
    public void EliminarTactica(Tactica tac) {
        em.getTransaction().begin();
        em.remove(tac);
        em.getTransaction().commit();
    }

    @Override
    public List<Tactica> BuscarTacticaPorAtributoDeCalidad(Atributocalidad atr) {
        Query q = em.createNamedQuery("SELECT t FROM Tactica t WHERE t.Tbl_Atributocalidad_acID = ?1");
        q.setParameter(1, atr);
        System.out.println("DAO.TacticaJPADAO.BuscarTacticaPorAtributoDeCalidad()"+atr+ "nombre atributo"+atr.getAcNombre());
        return (List<Tactica>) q.getResultList();
    }

    @Override
    public List<Patron> ListarPatrones() {
        Tactica t = new Tactica();
        return t.getPatronList();
    }

    @Override
    public List<Patron> ListadoPatronesDeTactica(int tac) {
        System.out.println("Tactica para consultar ID= " + tac);
        Tactica tactica = this.BuscarTactica(tac);
        if (tactica != null) {
            System.out.println("DAO.TacticaJPADAO.ListarPatronesDeTactica()+ " + tac + " y sus patrones asociados" + tactica.getPatronList());
            return tactica.getPatronList();
        }else   return null;
    }
    
    @Override
    public List<Tactica> ListarTacticasPorPatron(Patron pat) {
        Query q = em.createNamedQuery("SELECT t FROM Tactica t WHERE t.tacticaList = ?1");
        q.setParameter(1, pat);
        return q.getResultList();        
    }  
}
