package bean;

public class DetalleAlbaranVenta {
    private int idDetalleAlbaran;
    private int idJuguete;
    private int idAlbaran;

    public DetalleAlbaranVenta(int idDetalleAlbaran, int idJuguete, int idAlbaran) {
        this.idDetalleAlbaran = idDetalleAlbaran;
        this.idJuguete = idJuguete;
        this.idAlbaran = idAlbaran;
    }

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

    public int getIdAlbaran() {
        return idAlbaran;
    }

    public void setIdAlbaran(int idAlbaran) {
        this.idAlbaran = idAlbaran;
    }
}
