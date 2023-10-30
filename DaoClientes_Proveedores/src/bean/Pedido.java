package bean;

public class Pedido {
    private int idPedido;
    private int idHojaPedido;

    // Default constructor
    public Pedido() {
    }

    // Parameterized constructor
    public Pedido(int idPedido, int idHojaPedido) {
        this.idPedido = idPedido;
        this.idHojaPedido = idHojaPedido;
    }

    // Getters and setters

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public int getIdHojaPedido() {
        return idHojaPedido;
    }

    public void setIdHojaPedido(int idHojaPedido) {
        this.idHojaPedido = idHojaPedido;
    }

    // toString method for easy debugging
    @Override
    public String toString() {
        return "Pedido{" +
                "idPedido=" + idPedido +
                ", idHojaPedido=" + idHojaPedido +
                '}';
    }
}
