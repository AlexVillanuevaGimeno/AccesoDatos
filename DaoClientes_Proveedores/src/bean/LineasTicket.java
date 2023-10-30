package bean;

public class LineasTicket {
    private int idLineasTicket;
    private int devuelto;
    private int idJuguete;
    private int idTicket;

    public LineasTicket(int idLineasTicket, int devuelto, int idJuguete, int idTicket) {
        this.idLineasTicket = idLineasTicket;
        this.devuelto = devuelto;
        this.idJuguete = idJuguete;
        this.idTicket = idTicket;
    }

    public int getIdLineasTicket() {
        return idLineasTicket;
    }

    public void setIdLineasTicket(int idLineasTicket) {
        this.idLineasTicket = idLineasTicket;
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

    public int getIdTicket() {
        return idTicket;
    }

    public void setIdTicket(int idTicket) {
        this.idTicket = idTicket;
    }
}
