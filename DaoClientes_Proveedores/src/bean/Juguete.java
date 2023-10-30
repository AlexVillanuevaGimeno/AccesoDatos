package bean;
public class Juguete {
    private int idJuguete;
    private String nombreJuguete;
    private int precioUnidad;

    // Default constructor
    public Juguete() {
    }

    // Parameterized constructor
    public Juguete(int idJuguete, String nombreJuguete, int precioUnidad) {
        this.idJuguete = idJuguete;
        this.nombreJuguete = nombreJuguete;
        this.precioUnidad = precioUnidad;
    }

    // Getters and setters

    public int getIdJuguete() {
        return idJuguete;
    }

    public void setIdJuguete(int idJuguete) {
        this.idJuguete = idJuguete;
    }

    public String getNombreJuguete() {
        return nombreJuguete;
    }

    public void setNombreJuguete(String nombreJuguete) {
        this.nombreJuguete = nombreJuguete;
    }

    public int getPrecioUnidad() {
        return precioUnidad;
    }

    public void setPrecioUnidad(int precioUnidad) {
        this.precioUnidad = precioUnidad;
    }

    // toString method for easy debugging
    @Override
    public String toString() {
        return "Juguete{" +
                "idJuguete=" + idJuguete +
                ", nombreJuguete='" + nombreJuguete + '\'' +
                ", precioUnidad=" + precioUnidad +
                '}';
    }
}
