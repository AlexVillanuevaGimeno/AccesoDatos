package bean;

public class DetalleAlbaran {
    private int idDetalleAlbaran;
    private int idJuguete;

    // Default constructor
    public DetalleAlbaran() {
    }

    // Parameterized constructor
    public DetalleAlbaran(int idDetalleAlbaran, int idJuguete) {
        this.idDetalleAlbaran = idDetalleAlbaran;
        this.idJuguete = idJuguete;
    }

    // Getters and setters

    public int getIdDetalleAlbaran() {
        return idDetalleAlbaran;
    }

    public void setIdDetalleAlbaran(int idDetalleAlbaran) {
        this.idDetalleAlbaran = idDetalleAlbaran;
    }

    public int getIdJuguete() {
        return idJuguete;
    }

    public void setIdJuguete(int idJuguete) {
        this.idJuguete = idJuguete;
    }

    // toString method for easy debugging
    @Override
    public String toString() {
        return "DetalleAlbaran{" +
                "idDetalleAlbaran=" + idDetalleAlbaran +
                ", idJuguete=" + idJuguete +
                '}';
    }
}
