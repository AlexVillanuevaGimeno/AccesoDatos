package dao;

import bean.Ticket;
import motor.MotorDerby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoClientes {


    private String sql = "SELECT * FROM ";
    private MotorDerby motorDerby;
    public DaoClientes() {this.motorDerby = new MotorDerby();}


    //COMPLETAR MOSTRANDO EL TICKET
    public ArrayList<Ticket> muestraTicket(Ticket bean) {
        motorDerby.connect();
        String tablaNombre = "TICKET";
        String SQL = sql + tablaNombre + "where 1=1";
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

        motorDerby.close();
        return listaTickets;
    }
}
