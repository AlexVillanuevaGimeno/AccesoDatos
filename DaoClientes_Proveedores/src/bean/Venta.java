package bean;
public class Venta {
    private int idVenta;
    private int idNotaPago;

    // Default constructor
    public Venta() {
    }

    // Parameterized constructor
    public Venta(int idVenta, int idNotaPago) {
        this.idVenta = idVenta;
        this.idNotaPago = idNotaPago;
    }

    // Getters and setters

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public int getIdNotaPago() {
        return idNotaPago;
    }

    public void setIdNotaPago(int idNotaPago) {
        this.idNotaPago = idNotaPago;
    }

    // toString method for easy debugging
    @Override
    public String toString() {
        return "Venta{" +
                "idVenta=" + idVenta +
                ", idNotaPago=" + idNotaPago +
                '}';
    }
}
