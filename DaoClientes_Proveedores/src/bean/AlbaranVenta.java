package bean;

import java.sql.Date;

public class AlbaranVenta {
    private int idAlbaranVenta;
    private Date fecha;
    private int idDireccionEnvio;

    public AlbaranVenta(int idAlbaranVenta, Date fecha, int idDireccionEnvio) {
        this.idAlbaranVenta = idAlbaranVenta;
        this.fecha = fecha;
        this.idDireccionEnvio = idDireccionEnvio;
    }

    public int getIdAlbaranVenta() {
        return idAlbaranVenta;
    }

    public void setIdAlbaranVenta(int idAlbaranVenta) {
        this.idAlbaranVenta = idAlbaranVenta;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public int getIdDireccionEnvio() {
        return idDireccionEnvio;
    }

    public void setIdDireccionEnvio(int idDireccionEnvio) {
        this.idDireccionEnvio = idDireccionEnvio;
    }
}
