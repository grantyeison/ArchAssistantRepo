/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Beans.ArchAssistantBean;
import com.sun.jndi.toolkit.url.UrlUtil;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.xml.ws.WebServiceRef;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import servicios.ArcAssistantService_Service;
import servicios.Escenario;
import servicios.Modulo;
import servicios.Proyecto;
import servicios.Rationaleadd;
import servicios.Rationaleqaw;

/**
 *
 * @author Prometheus
 */
@WebServlet(name = "ADD1", urlPatterns = {"/ADD1"})
@MultipartConfig
public class ADD1 extends HttpServlet {

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
            throws ServletException, IOException, FileUploadException {
        response.setContentType("text/html;charset=UTF-8");
        String guardar = request.getParameter("btnAdd1Guardar");
        String continuar = request.getParameter("btnAddContinuar");
        String canc = request.getParameter("btnAddInicio");

        if (canc != null) {
            response.sendRedirect("InicioUsuario.jsp");
        }
        ArchAssistantBean archB = new ArchAssistantBean();
        Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
        List<Escenario> listaEsc = archB.ListEscenarios(proy);
        for (Escenario esce : listaEsc) {
            if (request.getParameter("btnQaw8Refinar" + esce.getEscID()) != null) {
                request.getSession().setAttribute("escenarioActual", esce);
                request.getSession().setAttribute("refinar", 1);
                response.sendRedirect("modificarEscenario.jsp");
            }
        }
        if (guardar != null) {
            Rationaleadd rata = archB.RationaleADD(proy.getProID(), "add1");
            //String nomArch = request.getParameter("nomarchivo");
            if (rata == null) {
                rata = new Rationaleadd();
            }

            rata.setRatAddDescripcion(request.getParameter(("ratadd1")));
            rata.setTblProyectoProID(proy);
            rata.setRatAddPaso("add1");
            guardarRationaleAdd(rata);
            proy.setProAvance("add1");
            modificarProyecto(proy);
            response.sendRedirect("add1.jsp");
        }
        if (continuar != null) {
            if (request.getParameter("ratadd1") != "") {
                List<Modulo> listaMod = archB.ListarModulos(proy);
                response.sendRedirect("add2.jsp");
            } else {
                try (PrintWriter out = response.getWriter()) {
                    out.println("debe justificar sus acciones en el campo Rationale antes de continuar");
                }
            }
        }

        GuardarArchivo arch = new GuardarArchivo();
        Rationaleadd rata = archB.RationaleADD(proy.getProID(), "add1");
        if (rata != null) {
            List<File> archivos = arch.listarArchivos(rata.getRatAddArchivo());

            for (File archivo : archivos) {
                if (request.getParameter("btnAddBajar" + archivo.getName()) != null) {
                    arch.descargar(archivo.getAbsolutePath(), archivo.getName());
                    response.sendRedirect("add1.jsp");
                }

                if (request.getParameter("btnAddEliminar" + archivo.getName()) != null) {
                    arch.eliminarArchivo(archivo.getAbsolutePath());
                    response.sendRedirect("add1.jsp");
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
        try {
            processRequest(request, response);
        } catch (FileUploadException ex) {
            Logger.getLogger(ADD1.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
            GuardarArchivo arch = new GuardarArchivo();
            Proyecto pro = (Proyecto) request.getSession().getAttribute("proyectoActual");
            String DirectorioArchivo = "";
            ArchAssistantBean archB = new ArchAssistantBean();
            Rationaleadd rata = archB.RationaleADD(pro.getProID(), "add1");

            try {
                DirectorioArchivo = arch.guardarArchivo(request, pro.getProID().toString(), "ADD1");
            } catch (Exception ex) {
                Logger.getLogger(ADD1.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (rata == null) {
                rata = new Rationaleadd();
                rata.setTblProyectoProID(pro);
                rata.setRatAddPaso("add1");

            }

            if (rata.getRatAddDescripcion() == null) {
                if (request.getParameter("ratadd1") == null) {
                    rata.setRatAddDescripcion("debes registrar la justificacion de sus decisiones en este espacio!!");
                } else {
                    rata.setRatAddDescripcion(request.getParameter("ratadd1"));
                }

            } else {
                String descrip = "";
                descrip = request.getParameter("ratadd1");
                if (descrip != null) {
                    //rata.setRatAddDescripcion(rata.getRatAddDescripcion() + descrip);
                }

            }

            rata.setRatAddArchivo(DirectorioArchivo);
            guardarRationaleAdd(rata);
            response.sendRedirect("add1.jsp");
        } catch (FileUploadException ex) {
            Logger.getLogger(ADD1.class.getName()).log(Level.SEVERE, null, ex);
        }
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
