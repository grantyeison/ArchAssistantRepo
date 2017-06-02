/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author GOMEZ
 */
@Entity
@Table(name = "tbl_responsabilidad", catalog = "archassistantbd", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Responsabilidad.findAll", query = "SELECT r FROM Responsabilidad r")
    , @NamedQuery(name = "Responsabilidad.findByRespID", query = "SELECT r FROM Responsabilidad r WHERE r.respID = :respID")
    , @NamedQuery(name = "Responsabilidad.findByRespNombre", query = "SELECT r FROM Responsabilidad r WHERE r.respNombre = :respNombre")
    , @NamedQuery(name = "Responsabilidad.findByRespDescripcion", query = "SELECT r FROM Responsabilidad r WHERE r.respDescripcion = :respDescripcion")
    , @NamedQuery(name = "Responsabilidad.findByRespOtro", query = "SELECT r FROM Responsabilidad r WHERE r.respOtro = :respOtro")})
public class Responsabilidad implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "respID", nullable = false)
    private Integer respID;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 500)
    @Column(name = "respNombre", nullable = false, length = 500)
    private String respNombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2000)
    @Column(name = "respDescripcion", nullable = false, length = 2000)
    private String respDescripcion;
    @Size(max = 1000)
    @Column(name = "respOtro", length = 1000)
    private String respOtro;
    @JoinColumn(name = "tbl_modulo_ModId", referencedColumnName = "ModId", nullable = false)
    @ManyToOne(optional = false)
    private Modulo tblmoduloModId;

    public Responsabilidad() {
    }

    public Responsabilidad(Integer respID) {
        this.respID = respID;
    }

    public Responsabilidad(Integer respID, String respNombre, String respDescripcion) {
        this.respID = respID;
        this.respNombre = respNombre;
        this.respDescripcion = respDescripcion;
    }

    public Integer getRespID() {
        return respID;
    }

    public void setRespID(Integer respID) {
        this.respID = respID;
    }

    public String getRespNombre() {
        return respNombre;
    }

    public void setRespNombre(String respNombre) {
        this.respNombre = respNombre;
    }

    public String getRespDescripcion() {
        return respDescripcion;
    }

    public void setRespDescripcion(String respDescripcion) {
        this.respDescripcion = respDescripcion;
    }

    public String getRespOtro() {
        return respOtro;
    }

    public void setRespOtro(String respOtro) {
        this.respOtro = respOtro;
    }

    public Modulo getTblmoduloModId() {
        return tblmoduloModId;
    }

    public void setTblmoduloModId(Modulo tblmoduloModId) {
        this.tblmoduloModId = tblmoduloModId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (respID != null ? respID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Responsabilidad)) {
            return false;
        }
        Responsabilidad other = (Responsabilidad) object;
        if ((this.respID == null && other.respID != null) || (this.respID != null && !this.respID.equals(other.respID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Modelo.Responsabilidad[ respID=" + respID + " ]";
    }
    
}
