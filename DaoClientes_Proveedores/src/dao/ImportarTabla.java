package dao;

import motor.MotorDerby;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import java.io.FileReader;

public class ImportarTabla {
    /**
     *  XMLStreamReader para leer el archivo XML
     *  llama a importarFila para procesar cada fila de datos en el archivo XML.
     *  en  llamada a importarTabla cambiar nombre de la tabla según tus necesidades.
     *
     * @param motor
     * @param nombreTabla
     * @param archivoXML
     */
    public static void importarTabla(MotorDerby motor, String nombreTabla, String archivoXML) {
        motor.connect();
        try {
            // Crear un lector XML
            XMLInputFactory xmlInputFactory = XMLInputFactory.newFactory();
            XMLStreamReader reader = xmlInputFactory.createXMLStreamReader(new FileReader(archivoXML));

            // Saltar hasta el elemento principal
            while (reader.hasNext()) {
                if (reader.isStartElement() && reader.getLocalName().equals("table")) {
                    break;
                }
                reader.next();
            }

            // Importar datos de la tabla desde el archivo XML
            while (reader.hasNext()) {
                if (reader.isStartElement() && reader.getLocalName().equals("row")) {
                    importarFila(motor, reader, nombreTabla);
                }
                reader.next();
            }
            reader.close();
            System.out.println("Importación completada en la tabla: " + nombreTabla);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            motor.close();
        }
    }

    private static void importarFila(MotorDerby motor, XMLStreamReader reader, String nombreTabla) throws XMLStreamException {
        StringBuilder values = new StringBuilder();
        while (reader.hasNext()) {
            reader.next();
            if (reader.isStartElement()) {
                values.append(reader.getLocalName()).append(": ").append(reader.getElementText()).append(", ");
            } else if (reader.isEndElement() && reader.getLocalName().equals("row")) {
                break;
            }
        }

        // Eliminar la última coma
        values.delete(values.length() - 2, values.length());

        // Construir la consulta de inserción
        String query = "INSERT INTO " + nombreTabla + " VALUES (" + values + ")";
        motor.executeUpdate(query);
    }
}
