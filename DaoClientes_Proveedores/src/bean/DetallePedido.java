package bean;

public class DetallePedido {
    private int idDetallePedido;
    private int idJuguete;
    private int cantidad;

    // Default constructor
    public DetallePedido() {
    }

    // Parameterized constructor
    public DetallePedido(int idDetallePedido, int idJuguete, int cantidad) {
        this.idDetallePedido = idDetallePedido;
        this.idJuguete = idJuguete;
        this.cantidad = cantidad;
    }

    // Getters and setters

    public int getIdDetallePedido() {
        return idDetallePedido;
    }

    public void setIdDetallePedido(int idDetallePedido) {
        this.idDetallePedido = idDetallePedido;
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
        return "DetallePedido{" +
                "idDetallePedido=" + idDetallePedido +
                ", idJuguete=" + idJuguete +
                ", cantidad=" + cantidad +
                '}';
    }
}
