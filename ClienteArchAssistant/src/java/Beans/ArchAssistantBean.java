/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import Servlets.GuardarArchivo;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import servicios.Atributocalidad;
import servicios.Escenario;
import servicios.Modulo;
import servicios.Patron;
import servicios.Preocupacion;
import servicios.Proyecto;
import servicios.Rationaleadd;
import servicios.Rationaleqaw;
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
    private static final Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
     
    
    public void GenerarReporteQAW(Proyecto pro) throws FileNotFoundException, DocumentException, IOException
    {
        
        Rationaleqaw ratq;
        String paso = pro.getProAvance();
        Paragraph parrafo;
        int anexo = 1;
        GuardarArchivo arch = new GuardarArchivo();
        List<File> archivos = null;
        FileOutputStream archivo = new FileOutputStream(System.getProperty("user.home")+File.separator+"Downloads"+File.separator+"InformeQAW"+pro.getProNombre()+".pdf");
        String razonamiento;
        Document documento = new Document();
        PdfWriter.getInstance(documento, archivo);
        documento.open();
        parrafo = new Paragraph("INFORME QAW ",chapterFont);
        parrafo.setAlignment(1);
        documento.add(parrafo);
        parrafo = new Paragraph("Proyecto "+pro.getProNombre(),categoryFont);
        parrafo.setAlignment(1);
        documento.add(parrafo);
        parrafo = new Paragraph("ArchAssistant\n\n",blueFont);
        parrafo.setAlignment(1);
        documento.add(parrafo);
        for (int i = 1; i <= 8; i ++)
        {
            ratq = obtenerRationaleQAW(pro.getProID(), "qaw"+String.valueOf(i));
            documento.add(new Paragraph("QAW paso "+i+"\n",subcategoryFont));
            if (ratq != null)
            {
                archivos = arch.listarArchivos(ratq.getRatQawArchivo());
                razonamiento = ratq.getRatQawDescripcion();
                if (razonamiento != null)
                {            
                    documento.add(new Paragraph(razonamiento+"\n\n",paragraphFont));
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
            modu.setModFinal("no");
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
            if (indiceAtribs != 0)
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
                    //AtributosEscogidos.add(atr);
                    if (Integer.parseInt(id) == atr.getAcID())
                    {
                        
                        AtributosEscogidos.add(atr);
                    }/**/
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
    
    public List<Preocupacion> ListarPreocupacionPorAtri(Atributocalidad atr){
        return listarPreocupacionPorAtributo(atr);
    }
    
    public List<Tactica> ListarTacticaPorPreo(Preocupacion pre){
        return listarTacticaPorPreocupacion(pre);
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
        return port.buscarModuloDescomposicion(idProy);
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

    private static java.util.List<servicios.Preocupacion> listarPreocupacionPorAtributo(servicios.Atributocalidad parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarPreocupacionPorAtributo(parameter);
    }

    private static java.util.List<servicios.Tactica> listarTacticaPorPreocupacion(servicios.Preocupacion parameter) {
        servicios.ArcAssistantService_Service service = new servicios.ArcAssistantService_Service();
        servicios.ArcAssistantService port = service.getArcAssistantServicePort();
        return port.listarTacticaPorPreocupacion(parameter);
    }

    
}
