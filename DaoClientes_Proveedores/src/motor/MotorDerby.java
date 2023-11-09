package motor;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
/*
--------------ORACLE-----------------------
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Ejemplo_conexion_oracle {
public static void main(String[] args) {
try {
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conexion = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","USER","PASS");
} catch (SQLException | ClassNotFoundException ex) {
System.out.println("Error en la conexión de la base de datos");
}

}
}
 */
public class MotorDerby {
    private String url = "jdbc:mysql://localhost/prov_clientesinpkfk";
    private String username = "root";
    private String password = "";

    private Connection connection;
    private Statement statement;
    private ResultSet resultSet;

    DriverManager driverManager;
    private ResultSet resultSet1;

    public void connect() {
        try {
            connection = DriverManager.getConnection(url, username, password);
            statement = connection.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(MotorDerby.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void close() {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException ex) {
                Logger.getLogger(MotorDerby.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException ex) {
                Logger.getLogger(MotorDerby.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MotorDerby.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    public int executeUpdate(String SQL) {
        int columnasModificadas = 0;
        try {
            columnasModificadas = statement.executeUpdate(SQL);
        } catch (SQLException ex) {
            Logger.getLogger(MotorDerby.class.getName()).log(Level.SEVERE, null, ex);
        }
        return columnasModificadas;
    }

    public ResultSet executeQuery(String SQL) {
        try {
            System.out.println("EXECUTE QUERY");
            resultSet1 = statement.executeQuery(SQL);
        } catch (SQLException ex) {
            Logger.getLogger(MotorDerby.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resultSet;
    }

    public boolean existeRegistro(String SQL) {
        try (ResultSet resultSet = statement.executeQuery(SQL)) {
            return resultSet.next(); // ==TRUE
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
