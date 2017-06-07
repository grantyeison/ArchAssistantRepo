/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import servicios.Escenario;

/**
 *
 * @author GOMEZ
 */
public class Utilidad implements Comparator<Escenario> {
    private boolean asc;
    //List<Escenario> lst;
    
    public Utilidad(boolean asc){//, List<Escenario> l) {
        //this.lst=l;
        this.asc = asc;
    }
    
    @Override
    public int compare(Escenario o1, Escenario o2) {
        int ret;
        if (asc) {
            return new Integer(o1.getEscPrioridad()).compareTo(new Integer(o2.getEscPrioridad()));
        } else {
            return new Integer(o2.getEscPrioridad()).compareTo(new Integer(o1.getEscPrioridad()));
        }
    }
}
