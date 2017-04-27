/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.WebServiceRef;
import servicios.ArcAssistantService_Service;
import servicios.Proyecto;
import servicios.Usuario;

/**
 *
 * @author Prometheus
 */
@WebServlet(name = "GestionarProyectos", urlPatterns = {"/GestionarProyectos"})
public class GestionarProyectos extends HttpServlet {

    @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/ArchAssistant/ArcAssistantService.wsdl")
    private ArcAssistantService_Service service;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String crear, eliminar, seleccionar;
        crear = request.getParameter("btnCrearProyecto");
        eliminar = request.getParameter("btnEliminarProyecto");
        seleccionar = request.getParameter("btnSeleccionarProyecto");
                
        if (crear != null)
        {
            response.sendRedirect("crearProyecto.jsp");
        }
        
        if (eliminar != null)
        {
            Proyecto pro = buscarProyecto(Integer.parseInt(request.getParameter("txtIdProyecto")));
            Usuario usu = (Usuario)request.getSession().getAttribute("validUsuario");
            if (usu.getIdUsuario() == pro.getTblUsuarioidUsuario().getIdUsuario())
            {
                boolean elim = eliminarProyecto(pro, usu.getIdUsuario());
            }
            response.sendRedirect("InicioUsuario.jsp");
        }
        
        if (seleccionar != null)
        {
            int idpro = Integer.parseInt(request.getParameter("txtIdProyecto"));
            Proyecto pro = buscarProyecto(idpro);
            request.getSession().setAttribute("proyectoActual", pro);
            if (pro.getProAvance().equals("qaw8"))
            {
                response.sendRedirect("add0.jsp");
            }
            else
            {
                response.sendRedirect(pro.getProAvance()+".jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        request.getSession().invalidate();
        response.sendRedirect("index.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>


    

    private Proyecto buscarProyecto(int parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.buscarProyecto(parameter);
    }

    private boolean eliminarProyecto(servicios.Proyecto proyecto, int usuario) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.eliminarProyecto(proyecto, usuario);
    }

    

}
