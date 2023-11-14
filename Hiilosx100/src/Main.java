import java.sql.SQLOutput;
import java.util.ArrayList;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) {
        ArrayList<Hilo> lstHilos = new ArrayList<>();
        for (int i = 0; i < 100; i++) {
            Hilo hilo = new Hilo(i);
            lstHilos.add(hilo);
        }
        for (Hilo hilo: lstHilos) {
            hilo.start();
            System.out.printf("Cantidad en contador:" + hilo.getCount());
            System.out.println("\n\n");
        }
        System.out.println("Número de hilos en mi lista: " + lstHilos.size());

    }
}