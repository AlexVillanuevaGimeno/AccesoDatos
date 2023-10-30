package bean;
public class NotaPago {
    private int idNotaPago;
    private int idDetalleNota;

    // Default constructor
    public NotaPago() {
    }

    // Parameterized constructor
    public NotaPago(int idNotaPago, int idDetalleNota) {
        this.idNotaPago = idNotaPago;
        this.idDetalleNota = idDetalleNota;
    }

    // Getters and setters

    public int getIdNotaPago() {
        return idNotaPago;
    }

    public void setIdNotaPago(int idNotaPago) {
        this.idNotaPago = idNotaPago;
    }

    public int getIdDetalleNota() {
        return idDetalleNota;
    }

    public void setIdDetalleNota(int idDetalleNota) {
        this.idDetalleNota = idDetalleNota;
    }

    // toString method for easy debugging
    @Override
    public String toString() {
        return "NotaPago{" +
                "idNotaPago=" + idNotaPago +
                ", idDetalleNota=" + idDetalleNota +
                '}';
    }
}
