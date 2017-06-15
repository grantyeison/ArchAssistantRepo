/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Beans.ArchAssistantBean;
import com.sun.faces.renderkit.html_basic.HtmlResponseWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.WebServiceRef;
import servicios.ArcAssistantService_Service;
import servicios.Proyecto;
import servicios.Rationaleadd;

/**
 *
 * @author GOMEZ
 */
@WebServlet(name = "Rationale", urlPatterns = {"/Rationale"})
public class Rationale extends HttpServlet {

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
        String mensaje = request.getParameter("mensaje");
        ArchAssistantBean archB = new ArchAssistantBean();
        HttpSession ss = request.getSession();
        Proyecto proy = (Proyecto) ss.getAttribute("proyectoActual");
        String paso = (String) ss.getAttribute("pasoActual");

        Rationaleadd rata = archB.RationaleADD(proy.getProID(), paso);
        if (mensaje.equals("guardar")) {
            //String nomArch = request.getParameter("nomarchivo");
            if (rata == null) {
                rata = new Rationaleadd();
            }

            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                rata.setRatAddDescripcion(request.getParameter(("rata")));
                rata.setTblProyectoProID(proy);
                rata.setRatAddPaso(paso);
                guardarRationaleAdd(rata);
                proy.setProAvance(paso);
                modificarProyecto(proy);
                out.println("<div class='alert alert-success alert-dismissable fade in'>"
                        + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>"
                        + "<strong>Guardado con exito!</strong> "
                        + "This alert box could indicate a successful or positive action.</div>");
            }
        } else {
            if (mensaje.equals("obtener")) {
                response.setContentType("text/html;charset=UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    String Descp = rata.getRatAddDescripcion();
                    if (Descp == null) {
                        out.println("");
                    }else{
                        out.println(Descp);
                    }
                }
            }
        }

        /* TODO output your page here. You may use following sample code. */
 /*out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Rationale</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Rationale at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");*/
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

    private void guardarRationaleAdd(servicios.Rationaleadd parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.guardarRationaleAdd(parameter);
    }

    private void modificarProyecto(servicios.Proyecto parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.modificarProyecto(parameter);
    }

}
