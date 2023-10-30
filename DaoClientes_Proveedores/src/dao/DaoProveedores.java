package dao;

import bean.DetalleAlbaran;
import bean.DetalleNotaPago;
import bean.DetallePedido;
import motor.MotorDerby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoProveedores {
    /*
    public void pideTabla(){
        Scanner sc = new Scanner(System.in);
        System.out.println("¿De que tabla quieres visionar los datos?");
        String tablaNombre = sc.nextLine();
        String sql = "SELECT * FROM " + tablaNombre + " WHERE 1=1";
    }
    */
    private String sql = "SELECT * FROM ";
    private MotorDerby motorDerby;
    public DaoProveedores() {
        this.motorDerby = new MotorDerby();
    }



    public ArrayList<DetalleNotaPago> muestraNota(DetalleNotaPago bean) {
        motorDerby.connect();
        String tablaNombre = "DetalleNotaPago";
        String SQL = sql + tablaNombre + "where 1=1";
        ArrayList<DetalleNotaPago> listaDetalleNota = new ArrayList<>();
        ResultSet resultSet;
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

        motorDerby.close();
        return listaDetalleNota;
    }

    public ArrayList<DetallePedido> muestraPedido(DetallePedido bean) {
        motorDerby.connect();
        String tablaNombre = "DetallePedido";
        String SQL = sql + tablaNombre + "where 1=1";
        ArrayList<DetallePedido> listaDetallePedido = new ArrayList<>();
        ResultSet resultSet;
        resultSet = motorDerby.executeQuery(SQL);

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

        motorDerby.close();
        return listaDetallePedido;
    }

    public ArrayList<DetalleAlbaran> muestraPedido(DetalleAlbaran bean) {
        motorDerby.connect();
        String tablaNombre = "DetalleAlbaran";
        String SQL = sql + tablaNombre + "where 1=1";
        ArrayList<DetalleAlbaran> listaDetalleAlbaran = new ArrayList<>();
        ResultSet resultSet;
        resultSet = motorDerby.executeQuery(SQL);

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

        motorDerby.close();
        return listaDetalleAlbaran;
    }




}
