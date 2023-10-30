package bean;

import java.util.Date;

    public class Particular {
        private int idParticular;
        private int idVenta;
        private String dni;
        private String nombre;
        private int telefono;
        private String firma;
        private String direccion;
        private Date fechaTransaccion;

        // Default constructor
        public Particular() {
        }

        // Parameterized constructor
        public Particular(int idParticular, int idVenta, String dni, String nombre, int telefono, String firma, String direccion, Date fechaTransaccion) {
            this.idParticular = idParticular;
            this.idVenta = idVenta;
            this.dni = dni;
            this.nombre = nombre;
            this.telefono = telefono;
            this.firma = firma;
            this.direccion = direccion;
            this.fechaTransaccion = fechaTransaccion;
        }

        // Getters and setters

        public int getIdParticular() {
            return idParticular;
        }

        public void setIdParticular(int idParticular) {
            this.idParticular = idParticular;
        }

        public int getIdVenta() {
            return idVenta;
        }

        public void setIdVenta(int idVenta) {
            this.idVenta = idVenta;
        }

        public String getDni() {
            return dni;
        }

        public void setDni(String dni) {
            this.dni = dni;
        }

        public String getNombre() {
            return nombre;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public int getTelefono() {
            return telefono;
        }

        public void setTelefono(int telefono) {
            this.telefono = telefono;
        }

        public String getFirma() {
            return firma;
        }

        public void setFirma(String firma) {
            this.firma = firma;
        }

        public String getDireccion() {
            return direccion;
        }

        public void setDireccion(String direccion) {
            this.direccion = direccion;
        }

        public Date getFechaTransaccion() {
            return fechaTransaccion;
        }

        public void setFechaTransaccion(Date fechaTransaccion) {
            this.fechaTransaccion = fechaTransaccion;
        }

        // toString method for easy debugging
        @Override
        public String toString() {
            return "Particular{" +
                    "idParticular=" + idParticular +
                    ", idVenta=" + idVenta +
                    ", dni='" + dni + '\'' +
                    ", nombre='" + nombre + '\'' +
                    ", telefono=" + telefono +
                    ", firma='" + firma + '\'' +
                    ", direccion='" + direccion + '\'' +
                    ", fechaTransaccion=" + fechaTransaccion +
                    '}';
        }
    }

