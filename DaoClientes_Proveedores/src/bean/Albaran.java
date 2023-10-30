package bean;

import java.util.Date;

public class Albaran {
    private int idAlbaran;
    private int idDetalleAlbaran;
    private String nombreMiEmpresa;
    private String direccionEnvio;
    private Date fechaRealiza;
    private Date fechaPedido;

    // Default constructor
    public Albaran() {
    }

    // Parameterized constructor
    public Albaran(int idAlbaran, int idDetalleAlbaran, String nombreMiEmpresa, String direccionEnvio, Date fechaRealiza, Date fechaPedido) {
        this.idAlbaran = idAlbaran;
        this.idDetalleAlbaran = idDetalleAlbaran;
        this.nombreMiEmpresa = nombreMiEmpresa;
        this.direccionEnvio = direccionEnvio;
        this.fechaRealiza = fechaRealiza;
        this.fechaPedido = fechaPedido;
    }

    // Getters and setters

    public int getIdAlbaran() {
        return idAlbaran;
    }

    public void setIdAlbaran(int idAlbaran) {
        this.idAlbaran = idAlbaran;
    }

    public int getIdDetalleAlbaran() {
        return idDetalleAlbaran;
    }

    public void setIdDetalleAlbaran(int idDetalleAlbaran) {
        this.idDetalleAlbaran = idDetalleAlbaran;
    }

    public String getNombreMiEmpresa() {
        return nombreMiEmpresa;
    }

    public void setNombreMiEmpresa(String nombreMiEmpresa) {
        this.nombreMiEmpresa = nombreMiEmpresa;
    }

    public String getDireccionEnvio() {
        return direccionEnvio;
    }

    public void setDireccionEnvio(String direccionEnvio) {
        this.direccionEnvio = direccionEnvio;
    }

    public Date getFechaRealiza() {
        return fechaRealiza;
    }

    public void setFechaRealiza(Date fechaRealiza) {
        this.fechaRealiza = fechaRealiza;
    }

    public Date getFechaPedido() {
        return fechaPedido;
    }

    public void setFechaPedido(Date fechaPedido) {
        this.fechaPedido = fechaPedido;
    }

    // toString method for easy debugging
    @Override
    public String toString() {
        return "Albaran{" +
                "idAlbaran=" + idAlbaran +
                ", idDetalleAlbaran=" + idDetalleAlbaran +
                ", nombreMiEmpresa='" + nombreMiEmpresa + '\'' +
                ", direccionEnvio='" + direccionEnvio + '\'' +
                ", fechaRealiza=" + fechaRealiza +
                ", fechaPedido=" + fechaPedido +
                '}';
    }
}
