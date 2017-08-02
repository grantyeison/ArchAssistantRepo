/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Beans.ArchAssistantBean;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import servicios.Atributocalidad;
import servicios.Proyecto;
import servicios.Rationaleqaw;

/**
 *
 * @author Prometheus
 */
@WebServlet(name = "cargarDatos", urlPatterns = {"/cargarDatos"})
public class cargarDatos extends HttpServlet {

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
        /*try (PrintWriter out = response.getWriter()) {
        Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
        ArchAssistantBean arcbean = new ArchAssistantBean();
        out.println(arcbean.cargarAtributosCheck(proy));
        }*/
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
       
        PrintWriter out = response.getWriter();
        Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
        ArchAssistantBean arcbean = new ArchAssistantBean();
        
        
        String ratio = request.getParameter("ratqaw4");
        
        List<Atributocalidad> listaAtributos = arcbean.ListarAtr();
        List<Atributocalidad> AtributosEscogidos = new LinkedList<Atributocalidad>();
        String[] listAc = null;
        int indiceAtribs = 0;
        System.out.println("*********--------------ratio:   "+ratio);
        indiceAtribs = ratio.indexOf(",~|~|");
        if (indiceAtribs > 0)
        {
            String ac = ratio.substring(0, indiceAtribs);
            listAc = ac.split(",");
        }
        for (Atributocalidad atr : listaAtributos)
        {
            if (listAc != null)
            {
                for (String id : listAc)
                {   
                    if (Integer.parseInt(id) == atr.getAcID())
                    {
                        
                        AtributosEscogidos.add(atr);
                    }
                }
            }
        }
        
        out.println("<tbody>");
        Atributocalidad atr;
        for (int i = 0; i <= listaAtributos.size(); i += 3) {
            if (listaAtributos.size() > i) {
                atr = listaAtributos.get(i);
                out.println("<tr>");
                out.println("<td class=\"alIzq\">");
                out.println("<input value=\""+atr.getAcID()+"\" type=\"checkbox\" class=\"check\" name=\"chk" + atr.getAcID() + "\" data-toggle=\"tooltip\" title=\""+atr.getAcDescripcion()+"\"");
                for (Atributocalidad atrEsc : AtributosEscogidos) {
                    if (atr.getAcID() == atrEsc.getAcID()) {
                        out.println("checked");
                    }
                }
                out.println(">\t" + atr.getAcNombre());
                out.println("<input readonly hidden='true' value ='" + atr.getAcDescripcion() + "' id=atrDesc'" + atr.getAcID() + "'/>");
                out.println("</td>");
            }

            if (listaAtributos.size() > i + 1) {
                atr = listaAtributos.get(i + 1);
                out.println("<td class=\"alIzq\">");
                out.println("<input value=\""+atr.getAcID()+"\" class=\"check\" type=\"checkbox\" name=\"chk" + atr.getAcID()+ "\" data-toggle=\"tooltip\" title=\""+atr.getAcDescripcion()+"\"");
                for (Atributocalidad atrEsc : AtributosEscogidos) {
                    if (atr.getAcID() == atrEsc.getAcID()) {
                        out.println("checked");
                    }
                }
                out.println(">\t" + atr.getAcNombre());
                out.println("<input readonly hidden='true' value ='" + atr.getAcDescripcion() + "' id=atrDesc'" + atr.getAcID() + "'/>");
                out.println("</td>");
            }

            if (listaAtributos.size() > i + 2) {
                atr = listaAtributos.get(i + 2);
                out.println("<td class=\"alIzq\">");
                out.println("<input value=\""+atr.getAcID()+"\" class=\"check\" type=\"checkbox\" class=\"margenS\" name=\"chk" + atr.getAcID()+ "\" data-toggle=\"tooltip\" title=\""+atr.getAcDescripcion()+"\"");
                for (Atributocalidad atrEsc : AtributosEscogidos) {
                    if (atr.getAcID() == atrEsc.getAcID()) {
                        out.println("checked");
                    }
                }
                out.println(">\t" + atr.getAcNombre());
                out.println("<input readonly hidden='true' value ='" + atr.getAcDescripcion() + "' id=atrDesc'" + atr.getAcID() + "'/>");
                out.println("</td>");
            }
            out.println("</tr>");

        }

        out.println("</tbody>");
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
