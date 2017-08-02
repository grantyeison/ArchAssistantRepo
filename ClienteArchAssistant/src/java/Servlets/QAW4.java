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
import java.util.LinkedList;
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
import servicios.Proyecto;
import servicios.Rationaleqaw;

/**
 *
 * @author Prometheus
 */
@WebServlet(name = "QAW4", urlPatterns = {"/QAW4"})
public class QAW4 extends HttpServlet {

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
        String guardar = request.getParameter("btnQaw4Guardar");
        String continuar = request.getParameter("btnQaw4Continuar");
        String regresar = request.getParameter("btnQaw4anterior");
        String guardarAtributos = request.getParameter("btnqaw4GuardarSelec");
        ArchAssistantBean archB = new ArchAssistantBean();
        List<Atributocalidad> seleccionados;
        GuardarArchivo arch = new GuardarArchivo();
        Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
        String canc = request.getParameter("btnQawInicio");
        if (canc != null)
        {
            response.sendRedirect("InicioUsuario.jsp");
        }
/*        if(guardarAtributos != null)
        {
            String atris = "";
            
            List<Atributocalidad> atributos = archB.ListarAtr();
            seleccionados = new LinkedList<Atributocalidad>();
            String descripcion;
            int indAtri = 0;
            for (Atributocalidad atr : atributos)
            {
                if(request.getParameter("chk"+atr.getAcID())!=null)
                {
                    seleccionados.add(atr);
                    atris+=atr.getAcID()+",";
                }
            }
            atris += "~|~|";
            
            Rationaleqaw ratq = archB.RationaleQAW(proy.getProID(), "qaw4");
            if (ratq == null)
            {
                ratq = new Rationaleqaw();
            }
            descripcion = "";
            if (ratq.getRatQawDescripcion() != null)
            {
                indAtri = ratq.getRatQawDescripcion().indexOf("~|~|") + 5;
                descripcion = ratq.getRatQawDescripcion().substring(indAtri);
            }
            ratq.setRatQawDescripcion(atris+"\n"+descripcion);
            ratq.setTblProyectoProID(proy);
            ratq.setRatQawPaso("qaw4");
            guardarRationaleQaw(ratq);
            if (seleccionados.size()>=1)
            {
                request.getSession().setAttribute("AtributoActual",seleccionados.get(0));
            }
            response.sendRedirect("qaw4.jsp");
        }
        
        if (request.getParameter("BtnQaw4GuardarNuevoAtributo") != null)
        {
            Atributocalidad atri = new Atributocalidad();
            atri.setAcDescripcion(request.getParameter("TxtAtribDescripNueAtrib"));
            atri.setAcNombre(request.getParameter("TxtAtribNombreNueAtri"));
            crearAtributo(atri);
            response.sendRedirect("qaw4.jsp");
        }*/
        
        if (guardar != null)
        {
            String descripcion;
            String ratio = new String();
            String atributos = "";
            int indAtri = 0;
            Rationaleqaw ratq = archB.RationaleQAW(proy.getProID(), "qaw4");
            
            if (ratq == null)
            {
                ratq = new Rationaleqaw();
            }
            
            descripcion = request.getParameter("ratqaw4");
            
            if (!ratq.getRatQawDescripcion().isEmpty())
            {
                ratio = ratq.getRatQawDescripcion();
            }
            
            if (ratio != null || ratio != "")
            {
                indAtri = ratio.indexOf("~|~|");
            }
            if (indAtri > 0)
            {
                atributos = ratio.substring(0,indAtri);
            }
            
            ratq.setTblProyectoProID(proy);
            ratq.setRatQawPaso("qaw4");
            guardarRationaleQaw(ratq);
            
            ratq.setRatQawDescripcion(atributos+"~|~|\n"+descripcion);
            ratq.setRatQawPaso("qaw4");
            guardarRationaleQaw(ratq);
            proy.setProAvance("qaw4");
            modificarProyecto(proy);
            response.sendRedirect("progreso.jsp");
        }
        if (continuar != null)
        {
            if (request.getParameter("ratqaw4")!= "")
            {
                
                response.sendRedirect("qaw5.jsp");
            }
            else
            {
                try (PrintWriter out = response.getWriter()) {
                    out.println("debe llenar e campo Rationale antes de contunuar");
                }
            }
        }
        if (regresar != null)
        {
            response.sendRedirect("qaw3.jsp");
        }
        
        Rationaleqaw ratq = archB.RationaleQAW(proy.getProID(), "qaw4");
        if (ratq != null)
        {
            List<File> archivos = arch.listarArchivos(ratq.getRatQawArchivo());

            for (File archivo : archivos)
            {
                //String descargar = request.getParameter("btnQaw3Bajar"+archivo.getName());
                if (request.getParameter("btnQawBajar"+archivo.getName())!= null)
                {
                    arch.descargar(archivo.getAbsolutePath(), archivo.getName());
                    response.sendRedirect("qaw4.jsp");
                }

                if (request.getParameter("btnQawEliminar"+archivo.getName())!= null)
                {
                    arch.eliminarArchivo(archivo.getAbsolutePath());
                    response.sendRedirect("qaw4.jsp");
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
 
        
        Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
        PrintWriter out = response.getWriter();
        ArchAssistantBean p = new ArchAssistantBean();
        
        String escogidos = request.getParameter("listadot");
        Rationaleqaw ratq = p.RationaleQAW(proy.getProID(), "qaw4");
        String descripcion;
        String atris = "";
        String[] atrEscogidos = escogidos.split(",");
        atris = escogidos+"~|~|";
        int indAtri = 0;
        
        //List<Atributocalidad> atrEscogidos = p.ObtenerAtributosEscogidos(ratq);
        //out.println("<table border=\"0\" class=\"tblCentContent\">");
        
        //System.out.println("**********************atributos");
        
            
        //System.out.println("Escogidos:  "+escogidos);
        
    /*    List<Atributocalidad> atributos = p.ListarAtr();
        List<Atributocalidad>seleccionados = new LinkedList<Atributocalidad>();
        for (Atributocalidad atr : atributos)
        {
            if(request.getParameter("chk"+atr.getAcID())!=null)
            {
                seleccionados.add(atr);
                atris+=atr.getAcID()+",";
            }
        }*/
        
        //Rationaleqaw ratq = archB.RationaleQAW(proy.getProID(), "qaw4");
        /*/////////////////////////////////////////////guardar seleccionados
        if (request.getParameter("selec") != null)
        {
            //System.out.println("------------------guardando atributos escogidos");
            if (ratq == null)
            {
                ratq = new Rationaleqaw();
            }
            descripcion = "";
            if (ratq.getRatQawDescripcion() != null)
            {
                indAtri = ratq.getRatQawDescripcion().indexOf("~|~|") + 5;
                descripcion = ratq.getRatQawDescripcion().substring(indAtri);
            }
            ratq.setRatQawDescripcion(atris+"\n"+descripcion);
            ratq.setTblProyectoProID(proy);
            ratq.setRatQawPaso("qaw4");
            guardarRationaleQaw(ratq);
            
        }
        
        if (atrEscogidos.length>=1)
        {
            request.getSession().setAttribute("AtributoActual",p.buscarAtr(Integer.parseInt(atrEscogidos[0])));
        }
        */
        /*if (request.getParameter("GuardarNuevo") != null)
        {*/
            /*GuardarNuevo: guardar,
            nombre: nomAtri,
            desc: descAtri*/
            
            Atributocalidad atri = new Atributocalidad();
            atri.setAcDescripcion(request.getParameter("desc"));
            atri.setAcNombre(request.getParameter("nombre"));
            crearAtributo(atri);
            //response.sendRedirect("qaw4.jsp");
        //}
        
        ////////////////////////////////////////////////
        
        
        List<Atributocalidad> listaAtributos = p.ListarAtr();
        out.println("<tbody>");
        Atributocalidad atr;
        for (int i = 0; i <= listaAtributos.size(); i += 3) {
            if (listaAtributos.size() > i) {
                atr = listaAtributos.get(i);
                out.println("<tr>");
                out.println("<td class=\"alIzq\">");
                out.println("<input value=\""+atr.getAcID()+"\" type=\"checkbox\" class=\"check\" name=\"chk" + atr.getAcID() + "\" data-toggle=\"tooltip\" title=\""+atr.getAcDescripcion()+"\"");
                for (String atrEsc : atrEscogidos) {
                    if (atr.getAcID() == Integer.parseInt(atrEsc)) {
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
                for (String atrEsc : atrEscogidos) {
                    if (atr.getAcID() == Integer.parseInt(atrEsc)) {
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
                for (String atrEsc : atrEscogidos) {
                    if (atr.getAcID() == Integer.parseInt(atrEsc)) {
                        out.println("checked");
                    }
                }
                out.println(">\t" + atr.getAcNombre());
                out.println("<input readonly hidden='true' value ='" + atr.getAcDescripcion() + "' id=atrDesc'" + atr.getAcID() + "'/>");
                out.println("</td>");
            }
            out.println("</tr>");

        }

        //out.println("</div>");
        out.println("</tbody>");
      // out.println("</table>");
                   
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
        Rationaleqaw ratq = archB.RationaleQAW(pro.getProID(), "qaw4");
                
        try 
        {
            DirectorioArchivo = arch.guardarArchivo(request,pro.getProID().toString() , "QAW4");
        } 
        catch (Exception ex) 
        {
            Logger.getLogger(QAW4.class.getName()).log(Level.SEVERE, null, ex);
        }
         
        
        if (ratq == null)
        {
            ratq = new Rationaleqaw();
            ratq.setTblProyectoProID(pro);
            ratq.setRatQawPaso("qaw4");
        
        }
        
        if (ratq.getRatQawDescripcion()== null)
        {
            ratq.setRatQawDescripcion("debes registrar el rationale en este espacio!!");
        }

        ratq.setRatQawArchivo(DirectorioArchivo);
        guardarRationaleQaw(ratq);
         
                
        response.sendRedirect("qaw4.jsp");
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

    private void crearAtributo(servicios.Atributocalidad parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.crearAtributo(parameter);
    }

}
