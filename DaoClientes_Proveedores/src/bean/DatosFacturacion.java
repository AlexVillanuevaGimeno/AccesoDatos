package bean;

public class DatosFacturacion {
    private int idDatosFacturacion;
    private String cif;
    private String direccion;
    private String nombreEmpresa;

    public DatosFacturacion(int idDatosFacturacion, String cif, String direccion, String nombreEmpresa) {
        this.idDatosFacturacion = idDatosFacturacion;
        this.cif = cif;
        this.direccion = direccion;
        this.nombreEmpresa = nombreEmpresa;
    }

    public int getIdDatosFacturacion() {
        return idDatosFacturacion;
    }

    public void setIdDatosFacturacion(int idDatosFacturacion) {
        this.idDatosFacturacion = idDatosFacturacion;
    }

    public String getCif() {
        return cif;
    }

    public void setCif(String cif) {
        this.cif = cif;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getNombreEmpresa() {
        return nombreEmpresa;
    }

    public void setNombreEmpresa(String nombreEmpresa) {
        this.nombreEmpresa = nombreEmpresa;
    }
}
