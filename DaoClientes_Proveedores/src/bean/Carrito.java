package bean;

import java.sql.Date;

public class Carrito {
    private int idCarrito;
    private Date fecha;
    private int idUsuario;

    public Carrito(int idCarrito, Date fecha, int idUsuario) {
        this.idCarrito = idCarrito;
        this.fecha = fecha;
        this.idUsuario = idUsuario;
    }

    public int getIdCarrito() {
        return idCarrito;
    }

    public void setIdCarrito(int idCarrito) {
        this.idCarrito = idCarrito;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
}
