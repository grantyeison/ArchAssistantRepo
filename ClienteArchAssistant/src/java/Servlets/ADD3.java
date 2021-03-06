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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.WebServiceRef;
import servicios.ArcAssistantService_Service;
import servicios.Atributocalidad;
import servicios.Escenario;
import servicios.Modulo;
import servicios.Proyecto;
import servicios.Rationaleadd;
import servicios.Tactica;

/**
 *
 * @author Prometheus
 */
@WebServlet(name = "ADD3", urlPatterns = {"/ADD3"})
public class ADD3 extends HttpServlet {

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
        String guardar = request.getParameter("btnAdd3Guardar");
        String continuar = request.getParameter("btnContinuar");
        String regresar = request.getParameter("btnAdd3anterior");
        String canc = request.getParameter("btnInicio");
        String pasoAct = "add3";

        ArchAssistantBean archB = new ArchAssistantBean();
        Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
        Modulo descMod = (Modulo) request.getSession().getAttribute("padreActual");
        if (descMod == null) {
            descMod = archB.buscarModDescomposicion(proy);
            request.getSession().setAttribute("padreActual", descMod);
        }
        Rationaleadd rata = archB.RationaleADD(proy.getProID(), pasoAct+"_"+descMod.getModId());
        if (canc != null) {
            response.sendRedirect("InicioUsuario.jsp");
        }
        if (guardar != null) {
            for (Escenario es : archB.ListEscenarios(proy)) {
                String aux1 = request.getParameter("impacto_1");
                String impactoOpc = (String) request.getParameter("impacto_" + es.getEscID());
                if (impactoOpc != null) {
                    String estado = (String) es.getEscEstado();
                    if (estado != null) {
                        String[] aux = estado.split(";");
                        if (aux.length > 1) {
                            aux[1] = impactoOpc;
                            es.setEscEstado(aux[0] + ";" + aux[1]);
                        }
                        es.setEscEstado(aux[0] + ";" + impactoOpc);
                    } else {
                        es.setEscEstado(";" + impactoOpc);
                    }
                    modificarEscenario(es);
                }
            }
            if (rata == null) {
                rata = new Rationaleadd();
            }
            rata.setRatAddDescripcion(request.getParameter("ratadd3"));
            rata.setTblProyectoProID(proy);
            rata.setRatAddPaso(pasoAct + "_" + descMod.getModId());
            guardarRationaleAdd(rata);
            proy.setProAvance(pasoAct);
            modificarProyecto(proy);
            response.sendRedirect("add3.jsp");
        }
        if (continuar != null) {
            if (request.getParameter("ratadd3") != "") {
                response.sendRedirect("add4.jsp");
            } else {
                try (PrintWriter out = response.getWriter()) {
                    out.println("debe llenar e campo Rationale antes de contunuar");
                }
            }
        }
        if (regresar != null) {
            response.sendRedirect("add2.jsp");
        }

        GuardarArchivo arch = new GuardarArchivo();
        if (rata != null) {
            List<File> archivos = arch.listarArchivos(rata.getRatAddArchivo());

            for (File archivo : archivos) {
                if (request.getParameter("btnAddBajar" + archivo.getName()) != null) {
                    arch.descargar(archivo.getPath(), archivo.getName());
                    response.sendRedirect("add3.jsp");
                }

                if (request.getParameter("btnAddEliminar" + archivo.getName()) != null) {
                    arch.eliminarArchivo(archivo.getAbsolutePath());
                    response.sendRedirect("add3.jsp");
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
        String pasoAc = "add3";
        GuardarArchivo arch = new GuardarArchivo();
        Proyecto pro = (Proyecto) request.getSession().getAttribute("proyectoActual");
        String DirectorioArchivo = "";
        ArchAssistantBean archB = new ArchAssistantBean();
        Rationaleadd rata = archB.RationaleADD(pro.getProID(), pasoAc);
        try {
            DirectorioArchivo = arch.guardarArchivo(request, pro.getProID().toString(), "ADD3");
        } catch (Exception ex) {
            Logger.getLogger(ADD3.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (rata == null) {
            rata = new Rationaleadd();
            rata.setTblProyectoProID(pro);
            rata.setRatAddPaso(pasoAc);
        }

        if (rata.getRatAddDescripcion() == null) {
            rata.setRatAddDescripcion("debes registrar el rationale en este espacio!!");
        }

        rata.setRatAddArchivo(DirectorioArchivo);
        guardarRationaleAdd(rata);

        response.sendRedirect("add3.jsp");
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

    private void modificarEscenario(servicios.Escenario parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.modificarEscenario(parameter);
    }

}
