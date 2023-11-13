package main;

import GestorXml.ExportarTablaToXml;
import GestorXml.ImportarXmlToSql;
import motor.MotorDerby;

import java.sql.ResultSet;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        ResultSet resultSet;
        MotorDerby motorDerby = new MotorDerby();
        Scanner scanner = new Scanner(System.in);

        int opcion;
        do{
            System.out.println("Menú:");
            System.out.println("1. Exportar Usuarios");
            System.out.println("2. Importar Productos");
            System.out.println("0. Salir");
            // Obtener la opción del usuario
            System.out.print("Elige una opción: ");
            opcion = scanner.nextInt();

            switch(opcion){
                case 1:
                    System.out.println("Exporto a XML");
                    ExportarTablaToXml.exportarTablaToXml(motorDerby, "usuario");
                    break;
                case 2:
                    System.out.println("Importo en la SQL");
                    ImportarXmlToSql.importarXml( motorDerby,  "producto",  "C:\\Users\\S2-PC00\\Documents\\GitHub\\AccesoDatos\\Importar_Exportar\\producto.xml");
                    break;
                case 0:
                    System.out.println("SALIENDO");
                    break;
                default:
                    System.out.println("Opción no válida. Por favor, elige una opción válida.");
                    break;
            }

        }while(opcion !=0);
        scanner.close();
    }
}