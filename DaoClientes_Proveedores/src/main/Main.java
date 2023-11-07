package main;



import bean.DetalleAlbaran;
import bean.DetalleNotaPago;
import bean.DetallePedido;
import bean.Ticket;
import dao.DaoClientes;
import dao.DaoProveedores;
import dao.ExportarTabla;
import dao.ImportarTabla;
import motor.MotorDerby;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        MotorDerby motorDerby = new MotorDerby();
        ResultSet resultSet;


        int opcion;

        do {
            // Mostrar el menú
            System.out.println("Menú:");
            System.out.println("1. DETALLES NOTA DE PAGO");
            System.out.println("2. DETALLES DE PEDIDO");
            System.out.println("3.  DETALLES ALBARAN");
            System.out.println("4. TICKET");
            System.out.println("5. Exportar Tabla");
            System.out.println("6. Importar Tabla");
            System.out.println("0. Salir");

            // Obtener la opción del usuario
            System.out.print("Elige una opción: ");
            opcion = scanner.nextInt();

            // Realizar acciones según la opción seleccionada
            switch (opcion) {
                case 1:
                    motorDerby.connect();
                    String SQL =  "SELECT * FROM " + "DetalleNotaPago" + "where 1=1";
                    ArrayList<DetalleNotaPago> listaDetalleNota = new ArrayList<>();

                    resultSet = motorDerby.executeQuery(SQL);

                    try {
                        while (resultSet.next()) {
                            DetalleNotaPago detalleNota = new DetalleNotaPago();
                            detalleNota.setIdDetalleNota(resultSet.getInt(1));
                            detalleNota.setIdJuguete(resultSet.getInt(2));
                            detalleNota.setCantidad(resultSet.getInt(3));
                            listaDetalleNota.add(detalleNota);
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(DaoProveedores.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    for (DetalleNotaPago detalleNota: listaDetalleNota) {
                        System.out.println(detalleNota.toString());
                    }
                    motorDerby.close();
                    break;
                case 2:
                    System.out.println("Detalles Pedido");
                    motorDerby.connect();
                    String SQL1 =  "SELECT * FROM " + "DetallePedido" + " where 1=1";
                    ArrayList<DetallePedido> listaDetallePedido = new ArrayList<>();
                    resultSet = motorDerby.executeQuery(SQL1);

                    try {
                        while (resultSet.next()) {
                            DetallePedido detallePedido = new DetallePedido();
                            detallePedido.setIdDetallePedido(resultSet.getInt(1));
                            detallePedido.setIdJuguete(resultSet.getInt(2));
                            detallePedido.setCantidad(resultSet.getInt(3));
                            listaDetallePedido.add(detallePedido);
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(DaoProveedores.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    for (DetallePedido detallePedido: listaDetallePedido) {
                        System.out.println(detallePedido.toString());
                    }

                    motorDerby.close();
                    break;

                case 3:
                    System.out.println("Detalles Albaran");
                    motorDerby.connect();
                    String SQL2 = "SELECT * FROM "  + "DetalleAlbaran" + "where 1=1";
                    ArrayList<DetalleAlbaran> listaDetalleAlbaran = new ArrayList<>();
                    resultSet = motorDerby.executeQuery(SQL2);

                    try {
                        while (resultSet.next()) {
                            DetalleAlbaran detalleAlbaran = new DetalleAlbaran();
                            detalleAlbaran.setIdDetalleAlbaran(resultSet.getInt(1));
                            detalleAlbaran.setIdJuguete(resultSet.getInt(2));
                            listaDetalleAlbaran.add(detalleAlbaran);
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(DaoProveedores.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    for (DetalleAlbaran detalleAlbaran: listaDetalleAlbaran) {
                        System.out.println(detalleAlbaran.toString());
                    }
                    motorDerby.close();


                    break;
                case 4:
                    System.out.println("CONTENIDO TICKET");
                    motorDerby.connect();
                    String SQL3 = "SELECT * FROM "  + "TICKET where 1=1";
                    ArrayList<Ticket> listaTickets = new ArrayList<>();
                    resultSet = motorDerby.executeQuery(SQL3);

                    try {
                        while (resultSet.next()) {
                            Ticket ticket = new Ticket();
                            ticket.setIdTicket(resultSet.getInt(1));
                            ticket.setCif(resultSet.getString(2));
                            ticket.setNombre(resultSet.getString(3));
                            ticket.setDireccion(resultSet.getString(4));
                            ticket.setTelefono(resultSet.getInt(5));
                            ticket.setFechaVenta(resultSet.getDate(6));
                            listaTickets.add(ticket);
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(DaoClientes.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    for (Ticket ticket: listaTickets) {
                        System.out.println(ticket.toString());
                    }
                    motorDerby.close();
                    break;

                case 5:
                    ExportarTabla.exportarTabla(motorDerby, "nombre-tabla");

                case 6:
                    ImportarTabla.importarTabla(motorDerby, "nombre-de-la-tabla-a-importar", "nombre-tabla-en-xml");

                case 0:
                    System.out.println("Saliendo del programa. ¡Hasta luego!");
                    break;
                default:
                    System.out.println("Opción no válida. Por favor, elige una opción válida.");
                    break;
            }

        } while (opcion != 0);

        scanner.close();
    }
}
