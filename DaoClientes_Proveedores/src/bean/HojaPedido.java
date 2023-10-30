package bean;

import java.util.Date;

public class HojaPedido {
    private int idHojaPedido;
    private int idDetallePedido;
    private Date fechaRealiza;
    private String nombreMiEmpresa;
    private String direccionEnvio;

    // Default constructor
    public HojaPedido() {
    }

    // Parameterized constructor
    public HojaPedido(int idHojaPedido, int idDetallePedido, Date fechaRealiza, String nombreMiEmpresa, String direccionEnvio) {
        this.idHojaPedido = idHojaPedido;
        this.idDetallePedido = idDetallePedido;
        this.fechaRealiza = fechaRealiza;
        this.nombreMiEmpresa = nombreMiEmpresa;
        this.direccionEnvio = direccionEnvio;
    }

    // Getters and setters

    public int getIdHojaPedido() {
        return idHojaPedido;
    }

    public void setIdHojaPedido(int idHojaPedido) {
        this.idHojaPedido = idHojaPedido;
    }

    public int getIdDetallePedido() {
        return idDetallePedido;
    }

    public void setIdDetallePedido(int idDetallePedido) {
        this.idDetallePedido = idDetallePedido;
    }

    public Date getFechaRealiza() {
        return fechaRealiza;
    }

    public void setFechaRealiza(Date fechaRealiza) {
        this.fechaRealiza = fechaRealiza;
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

    // toString method for easy debugging
    @Override
    public String toString() {
        return "HojaPedido{" +
                "idHojaPedido=" + idHojaPedido +
                ", idDetallePedido=" + idDetallePedido +
                ", fechaRealiza=" + fechaRealiza +
                ", nombreMiEmpresa='" + nombreMiEmpresa + '\'' +
                ", direccionEnvio='" + direccionEnvio + '\'' +
                '}';
    }
}
