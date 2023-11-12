package GestorXml;

import motor.MotorDerby;

import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamWriter;
import java.io.FileWriter;
import java.sql.ResultSet;

public class ExportarTablaToXml {
    public static void exportarTablaToXml(MotorDerby motor, String nombreTabla) {
        motor.connect();
        ResultSet resultSet;
        try {
            // Consulta para obtener datos de la tabla
            String query = "SELECT * FROM " + nombreTabla + " WHERE 1=1";
            System.out.println("Consulta SQL: " + query);
            resultSet = motor.executeQuery(query);

            // Crear un archivo XML
            XMLOutputFactory xmlOutputFactory = XMLOutputFactory.newFactory();
            XMLStreamWriter writer = xmlOutputFactory.createXMLStreamWriter(
                    new FileWriter(nombreTabla + ".xml"));

            // Escribir la estructura XML
            writer.writeStartDocument();
            //Poner tablas en plural en XML
            String sufijo = "";
            if (nombreTabla.endsWith("a") || nombreTabla.endsWith("e") || nombreTabla.endsWith("i") ||
                    nombreTabla.endsWith("o") || nombreTabla.endsWith("u")) {
                sufijo = "s";
            } else {
                sufijo = "es";
            }
            writer.writeStartElement(nombreTabla + sufijo);
            System.out.println(nombreTabla + " intento escribir");


            // Escribir datos de la tabla
            while (resultSet.next()) {
                writer.writeStartElement(nombreTabla);
                for (int i = 1; i <= resultSet.getMetaData().getColumnCount(); i++) {
                    String columnName = resultSet.getMetaData().getColumnName(i);
                    String columnValue = resultSet.getString(i);
                    writer.writeStartElement(columnName);
                    writer.writeCharacters(columnValue);
                    System.out.println("Columna: " + columnName + "Valor: " + columnValue);
                    writer.writeEndElement();
                    System.out.println("Printo elemento" + i);
                    System.out.println("Número de filas en ResultSet: " + resultSet.getFetchSize());

                }
                writer.writeEndElement(); // Fin de la fila
                System.out.println("he escrito");
            }

            // Fin del documento XML
            writer.writeEndElement(); // Fin de la tabla
            writer.writeEndDocument();
            writer.close();

            System.out.println("Exportación completada: " + nombreTabla + ".xml \n\n");

        } catch (Exception e) {
//            System.out.println("No he podido exportar");
            e.printStackTrace();
        } finally {
            motor.close();
        }
    }
}
