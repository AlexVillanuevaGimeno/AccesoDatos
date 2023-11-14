public class Contador {
    int contador;

    public Contador(int contador) {
        this.contador = contador++;
    }

    public int getContador() {
        return contador;
    }

    public void setContador(int contador) {
        this.contador = contador;
    }

}
