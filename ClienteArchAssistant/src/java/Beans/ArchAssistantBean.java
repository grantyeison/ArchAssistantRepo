/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import Servlets.GuardarArchivo;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.awt.Desktop;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;
import servicios.Atributocalidad;
import servicios.Escenario;
import servicios.Interface;
import servicios.Modulo;
import servicios.Patron;
import servicios.Proyecto;
import servicios.Rationaleadd;
import servicios.Rationaleqaw;
import servicios.Responsabilidad;
import servicios.Tactica;

/**
 *
 * @author Prometheus
 */
public class ArchAssistantBean {
    //fuentes para el documento: 
    private static final Font chapterFont = FontFactory.getFont(FontFactory.HELVETICA, 26, Font.BOLDITALIC);
    private static final Font paragraphFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL);
         
    private static final Font categoryFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
    private static final Font subcategoryFont = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD);
    private static final Font blueFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.ITALIC);    
    private static final Font blueFontArchAssistant = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.ITALIC, BaseColor.RED);    
    private static final Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
     
    
    public void GenerarReporteQAW(Proyecto pro) throws FileNotFoundException, DocumentException, IOException
    {
        
        Rationaleqaw ratq, ratq4;
        String paso = pro.getProAvance();
        Paragraph parrafo;
        int anexo = 1;
        GuardarArchivo arch = new GuardarArchivo();
        List<File> archivos = null;
        FileOutputStream archivo = new FileOutputStream(System.getProperty("user.home")+File.separator+"Downloads"+File.separator+"InformeQAW"+pro.getProNombre()+".pdf");
        String razonamiento;
        Document documento = new Document();
        PdfWriter.getInstance(documento, archivo);
        List<Atributocalidad> listaAtributos = ListarAtr();
        List<Atributocalidad> atrEscogidos;
        
                
        documento.open();
        documento.addHeader("ArchAssistant", "ArchAssistant");
        //documento.setMargins(2, 2, 4, 4);
        parrafo = new Paragraph("INFORME QAW ",chapterFont);
        parrafo.setAlignment(1);
        documento.add(parrafo);
        parrafo = new Paragraph("Proyecto "+pro.getProNombre(),chapterFont);
        parrafo.setAlignment(1);
        documento.add(parrafo);
        parrafo = new Paragraph("ArchAssistant\n\n",blueFontArchAssistant);
        parrafo.setAlignment(1);
        documento.add(parrafo);
        documento.add(new Paragraph("\n\n"+pro.getProDescripcion(),paragraphFont));
        parrafo = new Paragraph("Autor: "+pro.getTblUsuarioidUsuario().getUsuNombre(),blueFont);
        parrafo.setAlignment(2);
        documento.add(parrafo);
        for (int i = 1; i <= 8; i ++)
        {
            ratq = obtenerRationaleQAW(pro.getProID(), "qaw"+String.valueOf(i));
            ratq4 = obtenerRationaleQAW(pro.getProID(), "qaw4");
            
            documento.add(new Paragraph("QAW paso "+i+"\n",categoryFont));
            if (ratq != null)
            {
                archivos = arch.listarArchivos(ratq.getRatQawArchivo());
                razonamiento = ratq.getRatQawDescripcion();
                if (razonamiento != null)
                {            
                    if (ratq.getRatQawPaso().equals("qaw4"))
                    {
                        ratq4 = ratq;
                        atrEscogidos = ObtenerAtributosEscogidos(ratq);
                        documento.add(new Paragraph("Atributos de Calidad:\n",subcategoryFont));
                        for (Atributocalidad atr : listaAtributos)
                        {
                            for (Atributocalidad atrEsc : atrEscogidos)
                            {
                                if (atr.getAcID() == atrEsc.getAcID())
                                {
                                    documento.add(new Paragraph(atr.getAcNombre(),blueFont));
                                }
                            }
                        }
                        int indiceAtribs = 0;
                        if (razonamiento != null || razonamiento != "")
                        {
                            indiceAtribs = razonamiento.indexOf("~|~|")+4;
                        }
                        documento.add(new Paragraph("Justificación de las decisiones",smallBold));
                        documento.add(new Paragraph(razonamiento.substring(indiceAtribs)+"\n",paragraphFont));
                    }   
                    else
                    {
                        if (ratq.getRatQawPaso().equals("qaw5"))
                        {
                            documento.add(new Paragraph("Escenarios generados en la lluvia de ideas:\n",subcategoryFont));
                            atrEscogidos = ObtenerAtributosEscogidos(ratq4);
                            for (Atributocalidad atr : atrEscogidos)
                            {
                                documento.add(new Paragraph("\n"+atr.getAcNombre()+"\n\n",smallBold));
                                PdfPTable tabla = new PdfPTable(4);
                                
                                tabla.addCell("Nombre");
                                tabla.addCell("Estimulo");
                                tabla.addCell("Ambiente");
                                tabla.addCell("Respuesta");
                                
                                List<Escenario> listaEsc = ListEscenarios(pro);
                                
                                for (Escenario esce : listaEsc)
                                {
                                    if (esce.getTblAtributoCalidadacID().getAcID() == atr.getAcID())
                                    {
                                        tabla.addCell(esce.getEscNombre());
                                        tabla.addCell(esce.getEscEstimulo());
                                        tabla.addCell(esce.getEscAmbiente());
                                        tabla.addCell(esce.getEscRespuesta());
                                    }
                                }
                                documento.add(tabla);
                            }
                        }
                        if (ratq.getRatQawPaso().equals("qaw6"))
                        {
                            documento.add(new Paragraph("Escenarios consolodados:\n",subcategoryFont));
                            atrEscogidos = ObtenerAtributosEscogidos(ratq4);
                            for (Atributocalidad atr : atrEscogidos)
                            {
                                documento.add(new Paragraph("\n"+atr.getAcNombre()+"\n\n",smallBold));
                                PdfPTable tabla = new PdfPTable(4);
                                tabla.addCell("Nombre");
                                tabla.addCell("Estimulo");
                                tabla.addCell("Ambiente");
                                tabla.addCell("Respuesta");
                                
                                List<Escenario> listaEsc = ListEscenarios(pro);
                                
                                for (Escenario esce : listaEsc)
                                {
                                    if (esce.getTblAtributoCalidadacID().getAcID() == atr.getAcID())
                                    {
                                        tabla.addCell(esce.getEscNombre());
                                        tabla.addCell(esce.getEscEstimulo());
                                        tabla.addCell(esce.getEscAmbiente());
                                        tabla.addCell(esce.getEscRespuesta());
                                    }
                                }
                                documento.add(tabla);
                            }
                        }
                        if (ratq.getRatQawPaso().equals("qaw7"))
                        {
                            documento.add(new Paragraph("Escenarios priorizados:\n\n",subcategoryFont));
                            
                            PdfPTable tabla = new PdfPTable(6);
                            tabla.addCell("Nombre");
                            tabla.addCell("Estimulo");
                            tabla.addCell("Ambiente");
                            tabla.addCell("Respuesta");
                            tabla.addCell("Atributo");
                            tabla.addCell("Voto");

                            List<Escenario> listaEsc = ListEscenarios(pro);
                            
                            Collections.sort(listaEsc, new Comparator() {
                                @Override
                                public int compare(Object o1, Object o2) {
                                    Escenario esc1, esc2;
                                    esc1 = (Escenario) o1;
                                    esc2 = (Escenario) o2;
                                    return new Integer(esc1.getEscPrioridad()).compareTo(new Integer(esc2.getEscPrioridad()));

                                }
                            });

                            for (Escenario esce : listaEsc)
                            {
                                    tabla.addCell(esce.getEscNombre());
                                    tabla.addCell(esce.getEscEstimulo());
                                    tabla.addCell(esce.getEscAmbiente());
                                    tabla.addCell(esce.getEscRespuesta());
                                    tabla.addCell(esce.getTblAtributoCalidadacID().getAcNombre());
                                    tabla.addCell(String.valueOf(esce.getEscPrioridad()));
                                
                            }
                            documento.add(tabla);
                        }
                        if (ratq.getRatQawPaso().equals("qaw8"))
                        {
                            documento.add(new Paragraph("Escenarios Refinados:\n\n",subcategoryFont));
                            
                            PdfPTable tabla = new PdfPTable(9);
                            tabla.addCell("Nombre");
                            tabla.addCell("Estimulo");
                            tabla.addCell("Fuente");
                            tabla.addCell("Ambiente");
                            tabla.addCell("Artefacto");
                            tabla.addCell("Respuesta");
                            tabla.addCell("Medida");
                            tabla.addCell("Atributo");
                            tabla.addCell("Prioridad");
                            
                            List<Escenario> listaEsc = ListEscenarios(pro);
                            
                            Collections.sort(listaEsc, new Comparator() {
                                @Override
                                public int compare(Object o1, Object o2) {
                                    Escenario esc1, esc2;
                                    esc1 = (Escenario) o1;
                                    esc2 = (Escenario) o2;
                                    return new Integer(esc1.getEscPrioridad()).compareTo(new Integer(esc2.getEscPrioridad()));

                                }
                            });

                            for (Escenario esce : listaEsc)
                            {
                                tabla.addCell(esce.getEscNombre());
                                tabla.addCell(esce.getEscEstimulo());
                                tabla.addCell(esce.getEscFuente());
                                tabla.addCell(esce.getEscAmbiente());
                                tabla.addCell(esce.getEscArtefacto());
                                tabla.addCell(esce.getEscRespuesta());
                                tabla.addCell(esce.getEscMedidaRespuesta());
                                tabla.addCell(esce.getTblAtributoCalidadacID().getAcNombre());
                                tabla.addCell(String.valueOf(esce.getEscPrioridad()));
                              
                            }
                            documento.add(tabla);
                        }
                        documento.add(new Paragraph("Justificación de las decisiones",smallBold));
                        documento.add(new Paragraph(razonamiento+"\n",paragraphFont));
                    }
                }
                if (archivos != null)
                {
                    documento.add(new Paragraph("Archivos anexos:\n",smallBold));
                    for(File archi : archivos)
                    {
                        documento.add(new Paragraph("Anexo"+anexo+": "+archi.getName(),blueFont));
                        anexo++;
                    }
                }
            }
            else
            {
                documento.add(new Paragraph("No se registró información para este paso\n\n",paragraphFont));
            }
        }
        documento.close();    
        archivo.close();
        
    }
    
    public List<Proyecto> Listar(String usuario)
    {
        return listarProyectos(usuario);
    }
    
    public void aumentarVoto(Escenario esc)
    {
        if (esc.getEscPrioridad() != null)
        {
            esc.setEscPrioridad(esc.getEscPrioridad()+1);
        }
        else
        {
            esc.setEscPrioridad(1);
        }
        modificarEscenario(esc);
    }
    
    public List<Atributocalidad> ListarAtr()
    {
        return listarAtributos();
    }
    
    public List<Escenario> ListEscenarios(Proyecto proy)
    {
        return listarEscenario(proy);
    }
    
    public Rationaleqaw RationaleQAW(int proyecto, String paso)
    {
        return obtenerRationaleQAW(proyecto, paso);
    }
    
    public Rationaleadd RationaleADD(int proyecto, String paso)
    {
        return obtenerRationaleAdd(proyecto, paso);
    }
    
    public Escenario obtenerEscenario(int id, Proyecto proy)
    {
        List<Escenario> lista = listarEscenario(proy);
        
        for (Escenario esc : lista)
        {
            if (esc.getEscID() == id)
            {
                return esc;
            }
        }
        return null;
    }
    
    public Atributocalidad buscarAtr(int indice)
    {
        return buscarAtributo(indice);
    }

    public List<Modulo> ListarModulos(Proyecto proy)
    {
        List<Modulo> lista = new LinkedList<Modulo>();
        lista = listarModulo(proy);
        if (lista == null || lista.isEmpty())
        {
            Modulo modu = new Modulo();
            modu.setModNombre(proy.getProNombre());
            modu.setModDescripcion(proy.getProDescripcion());
            modu.setModFinal("Descomposicion");
            modu.setTblModuloModId(buscarModulo(1));
            modu.setTblProyectoProID(proy);
            crearModulo(modu);
            lista.add(modu);
        }
        return lista;
    }
    
    public List<Atributocalidad> ObtenerAtributosEscogidos(Rationaleqaw ratq4)
    {
        List<Atributocalidad> listaAtributos  = ListarAtr();
        List<Atributocalidad> AtributosEscogidos = new LinkedList<Atributocalidad>();
        String ratio;
        String[] listAc = null;
        int indiceAtribs = 0;
        if (ratq4 != null)
        {
            ratio = ratq4.getRatQawDescripcion();
            indiceAtribs = ratio.indexOf(",~|~|");
            if (indiceAtribs > 0)
            {
                String ac = ratio.substring(0, indiceAtribs);
                listAc = ac.split(",");
            }
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
        return AtributosEscogidos;
    }
    
    public Modulo buscarMod(int id)
    {
        return buscarModulo(id);
    }
    
    public Modulo buscarModDescomposicion(Proyecto id)
    {
        return buscarModuloDescomposicion(id);
    }
    
    public void crearMod(Modulo nMod)
    {
        crearModulo(nMod);
    }
    
     public void modificarMod(Modulo Mod)
    {
        modificarModulo(Mod);
    }
     
    public List<Tactica> ListarTacticas(){
        return listarTactica();
    }
    
    public List<Patron> ListarPatronesT(){
        return listarPatrones();
    }
    
    public List<Escenario> ListarCandidatosDriver(Proyecto py){
        return obtenerDriverArquitectonicos(py);
    }
    
    public Tactica ObtenerTactica(int id){
        return this.buscarTactica(id);
    }
    
    public List<Patron> ListarPatronesDeTactica(int id){
        return this.listadoPatronesDeTactica(id);
    }
    public List<Tactica> ListarTacticasDeAtributo(Atributocalidad atr)
    {
        return this.listarTacticaPorAtributoDeCalidad(atr);
    }
    
    public List<Responsabilidad> ListarResponsabilidadesDeModulo(Modulo m)
    {
        return this.listarResponsabilidad(m);
    }
    
    public List<Responsabilidad> ListarResponsabilidadesDeModulo()
    {
        return this.listarResponsabilidades();
    }
    
    public void CrearResponsabilidad(Responsabilidad resp)
    {
        crearResponsabilidad(resp);
    }
    
    public void ModificarResponsabilidad(Responsabilidad resp)
    {
        modificarResponsabilidad(resp);
    }
    
    public void EliminarResponsabilidad(Responsabilidad resp)
    {
        eliminarResponsabilidad(resp);
    }
    
    public List<Interface> ListarInterfaces()
    {
        return listarInterfaces();
    }
    
    public void CrearInterface(Interface parameter)
    {
        crearInterface(parameter);
    }
    
    public void ModificarInterface(Interface parameter)
    {
        modificarInterface(parameter);
    }
    
    public void EliminarInterface(Interface parameter)
    {
        eliminarInterface(parameter);
    }
    
    public List<Modulo> ListarModulos()
    {
        return listarModulos();
    }
            
    private static java.util.List<servicios.Proyecto> listarProyectos(java.lang.String parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarProyectos(parameter);
    }

    private static Rationaleqaw obtenerRationaleQAW(int idpro, java.lang.String paso) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.obtenerRationaleQAW(idpro, paso);
    }

    private static Rationaleadd obtenerRationaleAdd(int idpro, java.lang.String paso) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.obtenerRationaleAdd(idpro, paso);
    }

    private static java.util.List<servicios.Atributocalidad> listarAtributos() {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarAtributos();
    }

    private static java.util.List<servicios.Escenario> listarEscenario(servicios.Proyecto parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarEscenario(parameter);
    }

    private static void modificarEscenario(servicios.Escenario parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.modificarEscenario(parameter);
    }

    private static Atributocalidad buscarAtributo(int parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.buscarAtributo(parameter);
    }

    private static java.util.List<servicios.Modulo> listarModulo(servicios.Proyecto parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarModulo(parameter);
    }

    private static Modulo buscarModulo(int parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.buscarModulo(parameter);
    }

    private static void crearModulo(servicios.Modulo parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.crearModulo(parameter);
    }
    
    private static void modificarModulo(servicios.Modulo parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.modificarModulo(parameter);
    }

    private static Modulo buscarModuloDescomposicion(servicios.Proyecto idProy) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.buscarModuloEnDescomposicion(idProy);
    }

    private static java.util.List<servicios.Tactica> listarTactica() {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarTactica();
    }

    private static java.util.List<servicios.Patron> listarPatrones() {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarPatrones();
    }

    private static java.util.List<servicios.Escenario> obtenerDriverArquitectonicos(servicios.Proyecto parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.obtenerDriverArquitectonicos(parameter);
    }

    

    private static Tactica buscarTactica(int parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.buscarTactica(parameter);
    }

    private static java.util.List<servicios.Tactica> listarTacticaPorAtributoDeCalidad(servicios.Atributocalidad parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarTacticaPorAtributoDeCalidad(parameter);
    }

    private static java.util.List<servicios.Tactica> listarTacticasDePatron(int parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarTacticasDePatron(parameter);
    }

    private static java.util.List<servicios.Patron> listarPatronPorTactica(servicios.Tactica parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarPatronPorTactica(parameter);
    }

    private static java.util.List<servicios.Tactica> listarTacticasPorPatron(servicios.Patron parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarTacticasPorPatron(parameter);
    }

    private static java.util.List<servicios.Patron> listadoPatronesDeTactica(int parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listadoPatronesDeTactica(parameter);
    }

    private static void crearResponsabilidad(servicios.Responsabilidad parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.crearResponsabilidad(parameter);
    }

    private static void eliminarResponsabilidad(servicios.Responsabilidad parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.eliminarResponsabilidad(parameter);
    }

    private static java.util.List<servicios.Responsabilidad> listarResponsabilidad(servicios.Modulo parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarResponsabilidad(parameter);
    }

    private static java.util.List<servicios.Responsabilidad> listarResponsabilidades() {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarResponsabilidades();
    }

    private static void modificarResponsabilidad(servicios.Responsabilidad parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.modificarResponsabilidad(parameter);
    }

    private static void crearInterface(servicios.Interface parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.crearInterface(parameter);
    }

    private static void eliminarInterface(servicios.Interface parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.eliminarInterface(parameter);
    }

    private static Interface buscarInterface(int parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.buscarInterface(parameter);
    }

    private static java.util.List<servicios.Interface> listarInterfaces() {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarInterfaces();
    }

    private static void modificarInterface(servicios.Interface parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        port.modificarInterface(parameter);
    }

    private static java.util.List<servicios.Modulo> listarModulos() {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarModulos();
    }
    
    

    
}
