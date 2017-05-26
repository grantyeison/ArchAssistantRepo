/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Beans.ArchAssistantBean;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.WebServiceRef;
import servicios.ArcAssistantService_Service;
import servicios.Proyecto;
import servicios.Rationaleqaw;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Prometheus
 */
@WebServlet(name = "popupRationale", urlPatterns = {"/popupRationale"})
public class popupRationale extends HttpServlet {

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
        //response.setContentType("text/html;charset=UTF-8");
        
        String paso = (String) request.getSession().getAttribute("pasoActual");
        ArchAssistantBean archB = new ArchAssistantBean();
        Proyecto proy = (Proyecto)request.getSession().getAttribute("proyectoActual");
        Rationaleqaw ratq = archB.RationaleQAW(proy.getProID(), paso);
        GuardarArchivo arch = new GuardarArchivo();
        
        if (request.getParameter("btnContinuar") != null)
        {
            
                if (ratq == null)
                {
                    ratq = new Rationaleqaw();
                }
                ratq.setRatQawDescripcion(request.getParameter("rationale"));
                ratq.setTblProyectoProID(proy);
                ratq.setRatQawPaso(paso);
                guardarRationaleQaw(ratq);
                proy.setProAvance(paso);
                modificarProyecto(proy);
                System.out.println("guardar activao"+" "+proy.getProNombre()+" "+ratq.getRatQawDescripcion());
                int este = Integer.parseInt("" + paso.charAt(3));
                String siguiente = paso.substring(0, 3) + String.valueOf(este + 1);
                if (paso.equals("qaw5")) {
                    request.getSession().removeAttribute("AtributoActual");
                }
                if (paso.equals("qaw8")) {
                    response.sendRedirect("InicioUsuario.jsp");
                } else {
                    response.sendRedirect(siguiente + ".jsp");
                }
               // response.sendRedirect(paso+".jsp");
                //response.sendRedirect("");
            //request.getRequestDispatcher(paso+".jsp").forward(request,response);
        }
        if (ratq != null)
        {
            List<File> archivos = arch.listarArchivos(ratq.getRatQawArchivo());

            for (File archivo : archivos)
            {
                if (request.getParameter("btnQawBajar"+archivo.getName())!= null)
                {
                    arch.descargar(archivo.getAbsolutePath(), archivo.getName());
            response.sendRedirect(paso+".jsp");
                }

                if (request.getParameter("btnQawEliminar"+archivo.getName())!= null)
                {
                    arch.eliminarArchivo(archivo.getAbsolutePath());
                    response.sendRedirect(paso+".jsp");
                }
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
        
        GuardarArchivo arch = new GuardarArchivo();
        Proyecto pro = (Proyecto) request.getSession().getAttribute("proyectoActual");
        String DirectorioArchivo = "";
        ArchAssistantBean archB = new ArchAssistantBean();
        String paso = (String) request.getSession().getAttribute("pasoActual");
        Rationaleqaw ratq = archB.RationaleQAW(pro.getProID(), paso);
          
        if (paso.equals("qaw6"))
        {
            request.getSession().setAttribute("sigAtr", 0);
        }
        
        try 
        {
            DirectorioArchivo = arch.guardarArchivo(request,pro.getProID().toString() , paso);
        } 
        catch (Exception ex) 
        {
            Logger.getLogger(QAW1.class.getName()).log(Level.SEVERE, null, ex);
        }
         
        
        if (ratq == null)
        {
            ratq = new Rationaleqaw();
            ratq.setTblProyectoProID(pro);
            ratq.setRatQawPaso(paso);
        
        }
        
        if (ratq.getRatQawDescripcion()== null)
        {
            ratq.setRatQawDescripcion("debes registrar el rationale en este espacio!!");
        }

        ratq.setRatQawArchivo(DirectorioArchivo);
        guardarRationaleQaw(ratq);
         
                
        response.sendRedirect(paso+".jsp");
        
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

    private void guardarRationaleQaw(servicios.Rationaleqaw parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.guardarRationaleQaw(parameter);
    }

    private void modificarProyecto(servicios.Proyecto parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.modificarProyecto(parameter);
    }

}
