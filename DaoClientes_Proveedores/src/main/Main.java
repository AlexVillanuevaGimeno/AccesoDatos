package main;



import bean.Ticket;
import dao.DaoClientes;
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
                String sql = "SELECT * FROM ";

                int opcion;

                do {
                    // Mostrar el menú
                    System.out.println("Menú:");
                    System.out.println("1.  DETALLES NOTA DE PAGO");
                    System.out.println("2. DETALLES DE PEDIDO");
                    System.out.println("3.  DETALLES ALBARAN");
                    System.out.println("4. TICKET");
                    System.out.println("0. Salir");

                    // Obtener la opción del usuario
                    System.out.print("Elige una opción: ");
                    opcion = scanner.nextInt();

                    // Realizar acciones según la opción seleccionada
                    switch (opcion) {
                        case 1:

                            break;
                        case 2:
                            System.out.println("Seleccionaste la Opción 2");

                            break;
                        case 3:
                            System.out.println("Seleccionaste la Opción 3");

                            break;
                        case 4:
                            System.out.println("CONTENIDO TICKET");
                            motorDerby.connect();
                            String SQL = sql + "TICKET where 1=1";
                            ArrayList<Ticket> listaTickets = new ArrayList<>();
                            ResultSet resultSet;
                            resultSet = motorDerby.executeQuery(SQL);

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
