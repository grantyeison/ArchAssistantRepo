/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Beans.ArchAssistantBean;
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
import servicios.Modulo;
import servicios.Proyecto;
import servicios.Rationaleadd;
import servicios.Responsabilidad;

/**
 *
 * @author Prometheus
 */
@WebServlet(name = "ADD5", urlPatterns = {"/ADD5"})
public class ADD5 extends HttpServlet {

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
        String guardar = request.getParameter("btnAdd5Guardar");
        String continuar = request.getParameter("btnContinuar");
        String regresar = request.getParameter("btnAdd5anterior");
        String canc = request.getParameter("btnInicio");
        if (canc != null) {
            response.sendRedirect("InicioUsuario.jsp");
        }
        if (guardar != null) {
            ArchAssistantBean archB = new ArchAssistantBean();
            Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
            Rationaleadd rata = archB.RationaleADD(proy.getProID(), "add5");
            if (rata == null) {
                rata = new Rationaleadd();
            }
            rata.setRatAddDescripcion(request.getParameter("ratadd5"));
            rata.setTblProyectoProID(proy);
            rata.setRatAddPaso("add5");
            guardarRationaleAdd(rata);
            proy.setProAvance("add5");
            modificarProyecto(proy);
            response.sendRedirect("add5.jsp");

        }
        if (continuar != null) {
            System.out.println("btnContinuar "+ continuar);
            if (request.getParameter("ratadd5") != "") {
                System.out.println("Continuar a add6 ");
                response.sendRedirect("add6.jsp");
            } else {
                try (PrintWriter out = response.getWriter()) {
                    out.println("debe llenar e campo Rationale antes de contunuar");
                }
            }
        }
        if (regresar != null) {
            response.sendRedirect("add4.jsp");
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
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
        ArchAssistantBean archB = new ArchAssistantBean();
        String msj = request.getParameter("mensaje");
        if (msj.equals("crear")) {

            Responsabilidad nResp = new Responsabilidad();
            String nom = request.getParameter("nombre");
            String desc = request.getParameter("descripcion");
            String modSel = request.getParameter("seleccion");

            nResp.setRespNombre(nom);
            nResp.setRespDescripcion(desc);
            nResp.setTblmoduloModId(archB.buscarMod(Integer.parseInt(modSel)));

            archB.CrearResponsabilidad(nResp);
        }
        out.println("<h2 class='page-header' > Listado Responsabilidades </h2>");
        out.println("<table width='100%' border='3' class='tblCentfull'>");
        out.println("<tbody>");
        out.println("<tr>");
        out.println("<th scope='col'>Nombre</th>");
        out.println("<th scope='col'>Descripción</th>");
        out.println("<th scope='col'>Modulo</th>");
        out.println("</tr>");
        List<Modulo> listaMod = archB.ListarModulos(proy);

        Modulo padreActual = (Modulo) request.getSession().getAttribute("padreActual");
        if (padreActual == null) {
            padreActual = archB.buscarModDescomposicion(proy);
        }
        for (Modulo m : listaMod) {
            Modulo padreM = m.getTblModuloModId();
            if (padreM != null) {
                if (padreM.getModId() == padreActual.getModId() && !m.getModFinal().equals("terminado")) {
                    List<Responsabilidad> lRespModulo = archB.ListarResponsabilidadesDeModulo(m);
                    if (lRespModulo != null) {
                        for (Responsabilidad respon : lRespModulo) {
                            out.println("<tr>");
                            out.println("<td>");
                            out.println(respon.getRespNombre());
                            out.println("</td>");
                            out.println("<td>");
                            out.println(respon.getRespDescripcion());
                            out.println("</td>");
                            out.println("<td>");
                            out.println(respon.getTblmoduloModId().getModNombre());
                            out.println("</td>");
                        }
                        out.println("</tr>");
                    }
                }
            }
        }
        out.println("</tbody>");
        out.println("</table>");
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
