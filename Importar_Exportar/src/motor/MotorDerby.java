package motor;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MotorDerby {
    private String url = "jdbc:mysql://localhost/importar_exportar_xml";
    private String username = "root";
    private String password = "";

    private Connection connection;
    private Statement statement;
    private ResultSet resultSet;

    DriverManager driverManager;
    private ResultSet resultSet1;

    public void connect() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
            statement = connection.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(MotorDerby.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
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
            resultSet = statement.executeQuery(SQL);
        } catch (SQLException ex) {
            Logger.getLogger(MotorDerby.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resultSet;
    }

    public boolean existeRegistro(String SQL) {
        try (ResultSet resultSet = statement.executeQuery(SQL)) {
            System.out.println("No esta repetido");
            return resultSet.next(); // ==TRUE
        } catch (SQLException e) {
            System.out.println("Repetido");
            e.printStackTrace();
            return false;
        }
    }
}
