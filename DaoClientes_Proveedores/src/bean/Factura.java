package bean;

import java.sql.Date;

public class Factura {
    private int idFactura;
    private Date fecha;
    private int idDatosFacturacion;

    public Factura(int idFactura, Date fecha, int idDatosFacturacion) {
        this.idFactura = idFactura;
        this.fecha = fecha;
        this.idDatosFacturacion = idDatosFacturacion;
    }

    public int getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(int idFactura) {
        this.idFactura = idFactura;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public int getIdDatosFacturacion() {
        return idDatosFacturacion;
    }

    public void setIdDatosFacturacion(int idDatosFacturacion) {
        this.idDatosFacturacion = idDatosFacturacion;
    }
}
