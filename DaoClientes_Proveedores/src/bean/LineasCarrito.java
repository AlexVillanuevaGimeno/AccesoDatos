package bean;

public class LineasCarrito {
    private int idLineasCarrito;
    private int cantidad;
    private int devuelto;
    private int idJuguete;
    private int idCarrito;

    public LineasCarrito(int idLineasCarrito, int cantidad, int devuelto, int idJuguete, int idCarrito) {
        this.idLineasCarrito = idLineasCarrito;
        this.cantidad = cantidad;
        this.devuelto = devuelto;
        this.idJuguete = idJuguete;
        this.idCarrito = idCarrito;
    }

    public int getIdLineasCarrito() {
        return idLineasCarrito;
    }

    public void setIdLineasCarrito(int idLineasCarrito) {
        this.idLineasCarrito = idLineasCarrito;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getDevuelto() {
        return devuelto;
    }

    public void setDevuelto(int devuelto) {
        this.devuelto = devuelto;
    }

    public int getIdJuguete() {
        return idJuguete;
    }

    public void setIdJuguete(int idJuguete) {
        this.idJuguete = idJuguete;
    }

    public int getIdCarrito() {
        return idCarrito;
    }

    public void setIdCarrito(int idCarrito) {
        this.idCarrito = idCarrito;
    }
}
