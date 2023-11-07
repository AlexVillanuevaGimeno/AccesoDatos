package dao;

import motor.MotorDerby;

import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamWriter;
import java.io.FileWriter;
import java.sql.ResultSet;

public class ExportarTabla {
    /**
     *
     *  ajustar el nombre de la tabla en la llamada a exportarTabla según tus necesidades.
     *
     * @param motor
     * @param nombreTabla
     */
    public static void exportarTabla(MotorDerby motor, String nombreTabla) {
        motor.connect();
        try {
            // Consulta para obtener datos de la tabla
            String query = "SELECT * FROM " + nombreTabla;
            ResultSet resultSet = motor.executeQuery(query);

            // Crear un archivo XML
            XMLOutputFactory xmlOutputFactory = XMLOutputFactory.newFactory();
            XMLStreamWriter writer = xmlOutputFactory.createXMLStreamWriter(
                    new FileWriter(nombreTabla + ".xml"));

            // Escribir la estructura XML
            writer.writeStartDocument();
            writer.writeStartElement("table");

            // Escribir datos de la tabla
            while (resultSet.next()) {
                writer.writeStartElement("row");
                for (int i = 1; i <= resultSet.getMetaData().getColumnCount(); i++) {
                    String columnName = resultSet.getMetaData().getColumnName(i);
                    String columnValue = resultSet.getString(i);
                    writer.writeStartElement(columnName);
                    writer.writeCharacters(columnValue);
                    writer.writeEndElement();
                }
                writer.writeEndElement(); // Fin de la fila
            }

            // Fin del documento XML
            writer.writeEndElement(); // Fin de la tabla
            writer.writeEndDocument();

            System.out.println("Exportación completada: " + nombreTabla + ".xml");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            motor.close();
        }
    }
}
