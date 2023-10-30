package bean;
public class DetalleNotaPago {
    private int idDetalleNota;
    private int idJuguete;
    private int cantidad;

    // Default constructor
    public DetalleNotaPago() {
    }

    // Parameterized constructor
    public DetalleNotaPago(int idDetalleNota, int idJuguete, int cantidad) {
        this.idDetalleNota = idDetalleNota;
        this.idJuguete = idJuguete;
        this.cantidad = cantidad;
    }

    // Getters and setters

    public int getIdDetalleNota() {
        return idDetalleNota;
    }

    public void setIdDetalleNota(int idDetalleNota) {
        this.idDetalleNota = idDetalleNota;
    }

    public int getIdJuguete() {
        return idJuguete;
    }

    public void setIdJuguete(int idJuguete) {
        this.idJuguete = idJuguete;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    // toString method for easy debugging
    @Override
    public String toString() {
        return "DetalleNotaPago{" +
                "idDetalleNota=" + idDetalleNota +
                ", idJuguete=" + idJuguete +
                ", cantidad=" + cantidad +
                '}';
    }
}
