/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Beans.ArchAssistantBean;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.WebServiceRef;
import servicios.ArcAssistantService_Service;
import servicios.Modulo;
import servicios.Patron;
import servicios.Proyecto;
import servicios.Rationaleadd;
import servicios.Tactica;

/**
 *
 * @author Prometheus
 */
@WebServlet(name = "ADD4", urlPatterns = {"/ADD4"})
public class ADD4 extends HttpServlet {

    @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/ArchAssistant/ArcAssistantService.wsdl")
    private ArcAssistantService_Service service;
    private ArrayList<Tactica> tacSel = new ArrayList<>();
    ArchAssistantBean archB = new ArchAssistantBean();

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
        String guardar = request.getParameter("btnAdd4Guardar");
        String continuar = request.getParameter("btnContinuar");
        String regresar = request.getParameter("btnAdd4anterior");
        String crearModulo = request.getParameter("btnCrearModulo");
        String canc = request.getParameter("btnInicio");
        if (canc != null) {
            response.sendRedirect("InicioUsuario.jsp");
        }
        if (guardar != null) {
            ArchAssistantBean archB = new ArchAssistantBean();
            Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
            String[] rationale = null;
            Rationaleadd rata = archB.RationaleADD(proy.getProID(), "add4");
            if (rata == null) {
                rata = new Rationaleadd();
            }
            rationale = rata.getRatAddDescripcion().split("/@/");
            if (rationale.length > 1) {
                if (rationale.length == 3) {
                    rata.setRatAddDescripcion(rationale[0] + "/@/" + request.getParameter("ratadd4") + "/@/" + rationale[2]);
                } else {
                    rata.setRatAddDescripcion(rationale[0] + "/@/" + request.getParameter("ratadd4"));
                }
            } else {
                rata.setRatAddDescripcion(request.getParameter("ratadd4"));
            }
            rata.setTblProyectoProID(proy);
            rata.setRatAddPaso("add4");
            guardarRationaleAdd(rata);
            proy.setProAvance("add4");
            modificarProyecto(proy);
            response.sendRedirect("add4.jsp");

        }
        if (continuar != null) {
            if (request.getParameter("ratadd4") != "") {
                response.sendRedirect("add5.jsp");
            } else {
                try (PrintWriter out = response.getWriter()) {
                    out.println("debe llenar e campo Rationale antes de contunuar");
                }
            }
        }
        if (regresar != null) {
            response.sendRedirect("add3.jsp");
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
        String mensaje = request.getParameter("peticion");
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<h2 class='page-header'>Patrones relacionados</h2>");
        out.println("<table style= cellspacing='1' bgcolor='#0099cc' class='tblCentfull' border='1' >");
        out.println("<tr>");
        out.println("<th style= rowspan='7' align='center' bgcolor='#f8f8f8'> TACTICA</th>");
        //out.println("<th style= rowspan='7' align='center' bgcolor='#f8f8f8'> ID PATRON </th>");
        out.println("<th style= rowspan='7' align='center' bgcolor='#f8f8f8'>Nombre</th>");
        out.println("<th style= rowspan='7' align='center' bgcolor='#f8f8f8'>Descripcion</th>");
        out.println("</tr>");
        String listado = request.getParameter("listadot");
        if (mensaje != null) {
            if (mensaje.equals("guardarPatrones")) {
                String listadop = request.getParameter("listadop");
                if (listadop != null) {
                    Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
                    Rationaleadd rata = archB.RationaleADD(proy.getProID(), "add4");
                    if (rata == null) {
                        rata = new Rationaleadd();
                    }
                    String[] ratio = rata.getRatAddDescripcion().split("/@/");
                    rata.setRatAddDescripcion(request.getParameter("listadot") + "/@/" + ratio[1] + "/@/" + request.getParameter("listadop"));
                    rata.setTblProyectoProID(proy);
                    rata.setRatAddPaso("add4");
                    guardarRationaleAdd(rata);
                    proy.setProAvance("add4");
                    modificarProyecto(proy);
                    String[] seleccionadas = listado.split(",");
                    String Listadop = request.getParameter("listadop");
                    String[] patSeleccionados = Listadop.split(",");
                    for (String t : seleccionadas) {
                        List<Patron> patrones = archB.ListarPatronesDeTactica(Integer.parseInt(t));
                        Tactica tac = archB.ObtenerTactica(Integer.parseInt(t));
                        out.println("<tr rowspan='" + patrones.size() + "'>");
                        out.println("<td style= rowspan='7' align='center' bgcolor='#f8f8f8'> " + tac.getTacNombre() + "</td>");
                        int i = 0;
                        for (Patron p : patrones) {
                            if (p != null) {
                                if (i != 0) {
                                    out.println("<tr><td></td>");
                                }
                                //out.println("<td style= rowspan='7' align='center' bgcolor='#f8f8f8'> " + p.getPatID() + "</td>");
                                out.println("<td style= rowspan='7' align='center' bgcolor='#f8f8f8'>" + p.getPatNombre() + "</td>");
                                out.println("<td style= rowspan='7' align='center' bgcolor='#f8f8f8'>" + p.getPatDescripcion() + "</td>");
                                out.println("<td>");
                                boolean band = false;
                                for (String ptn : patSeleccionados) {
                                    String[] ptp = ptn.split("_");
                                    if (p.getPatID() == Integer.parseInt(ptp[2])) {
                                        band = true;
                                    }
                                }
                                if (band) {
                                    out.println("<input  type = 'checkbox' checked name = 'patronSel' id='chkPat' value = '" + proy.getProID() + "_" + tac.getTacID() + "_" + p.getPatID() + "'/>");
                                } else {
                                    out.println("<input  type = 'checkbox' name = 'patronSel' id='chkPat' value = '" + proy.getProID() + "_" + tac.getTacID() + "_" + p.getPatID() + "'/>");
                                }
                                out.println("</td>");
                                if (i != 0) {
                                    out.println("</tr>");
                                }
                                i++;
                            }
                        }
                        out.println("</tr>");
                    }
                }
                out.println("</table>");
                out.println("<input type='button' class='btn btn-primary' id='btnElegirPatrones' onclick='SeleccionarPatrones()' value='Elegir patrones'>");
            }
        } else {

            if (listado != null) {
                Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
                Rationaleadd rata = archB.RationaleADD(proy.getProID(), "add4");
                if (rata == null) {
                    rata = new Rationaleadd();
                }
                String[] patSeleccionados = null;
                String[] ratio = rata.getRatAddDescripcion().split("/@/");
                if (ratio.length > 1) {
                    if (ratio.length == 3) {
                        patSeleccionados = ratio[2].split(",");
                        rata.setRatAddDescripcion(listado + "/@/" + ratio[1] + "/@/" + ratio[2]);
                    } else {
                        rata.setRatAddDescripcion(listado + "/@/" + ratio[1]);
                    }
                } else {
                    rata.setRatAddDescripcion(listado + "/@/" + ratio[0]);
                }

                rata.setTblProyectoProID(proy);
                rata.setRatAddPaso("add4");
                guardarRationaleAdd(rata);
                proy.setProAvance("add4");
                modificarProyecto(proy);
                String[] seleccionadas = listado.split(",");
                for (String t : seleccionadas) {
                    List<Patron> patrones = archB.ListarPatronesDeTactica(Integer.parseInt(t));
                    Tactica tac = archB.ObtenerTactica(Integer.parseInt(t));
                    out.println("<tr rowspan='" + patrones.size() + "'>");
                    out.println("<td style= rowspan='7' align='center' bgcolor='#f8f8f8'> " + tac.getTacNombre() + "</td>");
                    int i = 0;
                    for (Patron p : patrones) {
                        if (p != null) {
                            if (i != 0) {
                                out.println("<tr><td></td>");
                            }
                            //out.println("<td style= rowspan='7' align='center' bgcolor='#f8f8f8'> " + p.getPatID() + "</td>");
                            out.println("<td style= rowspan='7' align='center' bgcolor='#f8f8f8'>" + p.getPatNombre() + "</td>");
                            out.println("<td style= rowspan='7' align='center' bgcolor='#f8f8f8'>" + p.getPatDescripcion() + "</td>");
                            out.println("<td>");

                            if (patSeleccionados != null) {
                                boolean band = false;
                                for (String ptn : patSeleccionados) {
                                    String[] ptp = ptn.split("_");
                                    if (p.getPatID() == Integer.parseInt(ptp[2])) {
                                        band = true;
                                    }
                                }
                                if (band) {
                                    out.println("<input checked type = 'checkbox' name = 'patronSel' id='chkPat' value = '" + proy.getProID() + "_" + tac.getTacID() + "_" + p.getPatID() + "'/>");
                                } else {
                                    out.println("<input  type = 'checkbox' name = 'patronSel' id='chkPat' value = '" + proy.getProID() + "_" + tac.getTacID() + "_" + p.getPatID() + "'/>");
                                }
                            } else {
                                out.println("<input  type = 'checkbox' name = 'patronSel' id='chkPat' value = '" + proy.getProID() + "_" + tac.getTacID() + "_" + p.getPatID() + "'/>");
                            }
                            out.println("</td>");
                            if (i != 0) {
                                out.println("</tr>");
                            }
                            i++;
                        }
                    }
                    out.println("</tr>");
                }
            }
            out.println("</table>");
            out.println("<input type='button' class='btn btn-primary' id='btnElegirPatrones' onclick='SeleccionarPatrones()' value='Elegir patrones'>");
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
        processRequest(request, response);

        String msj = request.getParameter("mensaje");
        if (msj.equals("crearModulo")) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            Proyecto proy = (Proyecto) request.getSession().getAttribute("proyectoActual");
            ArchAssistantBean archB = new ArchAssistantBean();
            Modulo nmod = new Modulo();
            String nomMod = request.getParameter("nombreModulo");
            String descMod = request.getParameter("descripcionModulo");

            Modulo padreActual = (Modulo) request.getSession().getAttribute("padreActual");
            if (padreActual == null) {
                padreActual = archB.buscarModDescomposicion(proy);
                request.getSession().setAttribute("padreActual", padreActual);
            }
            nmod.setModNombre(nomMod);
            nmod.setModDescripcion(descMod);
            nmod.setModFinal("no");
            nmod.setTblModuloModId(padreActual);
            nmod.setTblProyectoProID(proy);
            archB.crearMod(nmod);
            out.println("<table width='100%' border='3' class='tblCentfull'>");
            out.println("<tbody>");
            out.println("<tr>");
            out.println("<th scope='col'>Nombre</th>");
            out.println("<th scope='col'>Descripción</th>");
            out.println("</tr>");
            List<Modulo> listaMod = archB.ListarModulos(proy);
            if (padreActual == null) {
                padreActual = archB.buscarModDescomposicion(proy);
            }
            for (Modulo m : listaMod) {
                Modulo padreM = m.getTblModuloModId();
                if (padreM != null) {
                    if (padreM.getModId() == padreActual.getModId() && !m.getModFinal().equals("terminado")) {
                        out.println("<tr>");
                        out.println("<td>");
                        out.println(m.getModNombre());
                        out.println("</td>");
                        out.println("<td>");
                        out.println(m.getModDescripcion());
                        out.println("</td>");
                        //out.println("<td>");
                        //out.println(mod.getModFinal());
                        //out.println("</td>");                                        
                        out.println("</tr>");
                    }
                }
            }
            out.println("</tbody>");
            out.println("</table>");
        }

        // Obtengo los datos de la peticion
        /*String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String edad = request.getParameter("edad");

        // Compruebo que los campos del formulario tienen datos para añadir a la tabla
        if (!nombre.equals("") && !apellido.equals("") && !edad.equals("")) {
            // Creo el objeto persona y lo añado al arrayList
            Tactica tac = new Tactica();
            tac.setTacNombre(nombre);
            tac.setTacDescripcion(apellido);
            personas.add(tac);
        }*/
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

    private void modificarProyecto(servicios.Proyecto parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.modificarProyecto(parameter);
    }

    private void guardarRationaleAdd(servicios.Rationaleadd parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.guardarRationaleAdd(parameter);
    }

    private void crearModulo(servicios.Modulo parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.crearModulo(parameter);
    }

    private Modulo buscarModulo(int parameter) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.buscarModulo(parameter);
    }
}
