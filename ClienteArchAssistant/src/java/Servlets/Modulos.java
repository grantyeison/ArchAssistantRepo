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
import javax.servlet.http.HttpSession;
import servicios.Modulo;
import servicios.Proyecto;
import servicios.Rationaleadd;

/**
 *
 * @author GOMEZ
 */
@WebServlet(name = "Modulos", urlPatterns = {"/Modulos"})
public class Modulos extends HttpServlet {

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
        //try (PrintWriter out = response.getWriter()) {
        /* TODO output your page here. You may use following sample code. */
 /*out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Modulos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Modulos at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");*/
        //}
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
        String mensaje = request.getParameter("modulos");
        int modId = Integer.parseInt(request.getParameter("id"));
        ArchAssistantBean archB = new ArchAssistantBean();
        HttpSession ss = request.getSession();
        Proyecto proy = (Proyecto) ss.getAttribute("proyectoActual");
        String paso = (String) ss.getAttribute("pasoActual");
        Modulo descMod = null;
        Rationaleadd rata = new Rationaleadd();
        String num = paso.substring(3, 4);
        if (Integer.parseInt(num) >= 2) {
            descMod = archB.buscarMod(modId);
            request.getSession().setAttribute("padreActual", descMod);
            rata = archB.RationaleADD(proy.getProID(), paso + "_" + descMod.getModId());
        } else {
            rata = archB.RationaleADD(proy.getProID(), paso);
        }
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (rata != null) {
                String Descp = rata.getRatAddDescripcion();
                if (Descp == null) {
                    out.println("");
                } else {
                    out.println(Descp);
                }
            } else {
                out.println("");
            }

            out.println("-----");
            GuardarArchivo arch = new GuardarArchivo();
            List<File> archivos = null;
            if (rata != null) {
                archivos = arch.listarArchivos(rata.getRatAddArchivo());
            }
            if (archivos != null) {
                for (File archivo : archivos) {
                    out.print("<tr>");
                    out.print("<td>" + archivo.getName() + "</td>");
                    out.print("<td class='alIzq'>" + "<button type=\"button\" value=\"Eliminar\" name=\"btnEliminar"
                            + archivo.getName() + "\" class=\"btn btn-primary download\">  "
                            + "<span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span></button>        ");
                    out.print("<button type=\"button\" value=\"Descargar\" name=\"btnBajar"
                            + archivo.getName() + "\" class=\"btn btn-primary download\">  "
                            + "<span class=\"glyphicon glyphicon-download-alt\" aria-hidden=\"true\">"
                            + "</span></button>" + "</td>");
                    out.print("</tr>");
                }
            }
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

}
