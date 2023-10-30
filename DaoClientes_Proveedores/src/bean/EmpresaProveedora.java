package bean;

public class EmpresaProveedora {
    private int idEmpProveedora;
    private int idPedido;
    private String cif;
    private String nombre;
    private String direccionPostal;
    private String direccionWeb;
    private int telefono;
    private String personaContacto;

    // Default constructor
    public EmpresaProveedora() {
    }

    // Parameterized constructor
    public EmpresaProveedora(int idEmpProveedora, int idPedido, String cif, String nombre, String direccionPostal, String direccionWeb, int telefono, String personaContacto) {
        this.idEmpProveedora = idEmpProveedora;
        this.idPedido = idPedido;
        this.cif = cif;
        this.nombre = nombre;
        this.direccionPostal = direccionPostal;
        this.direccionWeb = direccionWeb;
        this.telefono = telefono;
        this.personaContacto = personaContacto;
    }

    // Getters and setters

    public int getIdEmpProveedora() {
        return idEmpProveedora;
    }

    public void setIdEmpProveedora(int idEmpProveedora) {
        this.idEmpProveedora = idEmpProveedora;
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public String getCif() {
        return cif;
    }

    public void setCif(String cif) {
        this.cif = cif;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccionPostal() {
        return direccionPostal;
    }

    public void setDireccionPostal(String direccionPostal) {
        this.direccionPostal = direccionPostal;
    }

    public String getDireccionWeb() {
        return direccionWeb;
    }

    public void setDireccionWeb(String direccionWeb) {
        this.direccionWeb = direccionWeb;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    public String getPersonaContacto() {
        return personaContacto;
    }

    public void setPersonaContacto(String personaContacto) {
        this.personaContacto = personaContacto;
    }

    // toString method for easy debugging
    @Override
    public String toString() {
        return "EmpresaProveedora{" +
                "idEmpProveedora=" + idEmpProveedora +
                ", idPedido=" + idPedido +
                ", cif='" + cif + '\'' +
                ", nombre='" + nombre + '\'' +
                ", direccionPostal='" + direccionPostal + '\'' +
                ", direccionWeb='" + direccionWeb + '\'' +
                ", telefono=" + telefono +
                ", personaContacto='" + personaContacto + '\'' +
                '}';
    }
}
