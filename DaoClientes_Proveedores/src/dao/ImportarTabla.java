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

            //Poner tablas en plural en XML
            String sufijo = "";
            if (nombreTabla.endsWith("a") || nombreTabla.endsWith("e") || nombreTabla.endsWith("i") ||
                    nombreTabla.endsWith("o") || nombreTabla.endsWith("u")) {
                sufijo = "s";
            } else {
                sufijo = "es";
            }

            // Saltar hasta el elemento principal
            while (reader.hasNext()) {
                if (reader.isStartElement() && reader.getLocalName().equals(nombreTabla + sufijo)) {
                    break;
                }
                reader.next();
            }

            // Importar datos de la tabla desde el archivo XML
            while (reader.hasNext()) {
                if (reader.isStartElement() && reader.getLocalName().equals(nombreTabla)) {
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
            } else if (reader.isEndElement() && reader.getLocalName().equals(nombreTabla)) {
                break;
            }
        }

        // Eliminar la última coma
        values.delete(values.length() - 2, values.length());

        // Construir la consulta de inserción
        String query = "INSERT INTO " + nombreTabla + " VALUES (" + values + ")";
        motor.executeUpdate(query);
    }


//    import javax.xml.stream.XMLInputFactory;
//import javax.xml.stream.XMLStreamException;
//import javax.xml.stream.XMLStreamReader;
//import java.io.FileReader;
//
//    public class XmlImporter {
//
//        public static void main(String[] args) {
//            String nombreTabla = "ticket";
//            String archivoXML = "ruta/del/archivo.xml"; // Reemplaza con la ruta correcta de tu archivo XML
//
//            try {
//                XMLInputFactory xmlInputFactory = XMLInputFactory.newFactory();
//                XMLStreamReader reader = xmlInputFactory.createXMLStreamReader(new FileReader(archivoXML));
//
//                String sufijo = (nombreTabla.endsWith("a") || nombreTabla.endsWith("e") || nombreTabla.endsWith("i") ||
//                        nombreTabla.endsWith("o") || nombreTabla.endsWith("u")) ? "s" : "es";
//
//                while (reader.hasNext()) {
//                    if (reader.isStartElement() && reader.getLocalName().equals(nombreTabla + sufijo)) {
//                        break;
//                    }
//                    reader.next();
//                }
//
//                while (reader.hasNext()) {
//                    if (reader.isStartElement() && reader.getLocalName().equals(nombreTabla)) {
//                        importarFila(reader, nombreTabla);
//                    }
//                    reader.next();
//                }
//
//                reader.close();
//                System.out.println("Importación completada en la tabla: " + nombreTabla);
//
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//
//        private static void importarFila(XMLStreamReader reader, String nombreTabla) throws XMLStreamException {
//            System.out.println("Importando datos para la tabla: " + nombreTabla);
//            while (reader.hasNext()) {
//                if (reader.isEndElement() && reader.getLocalName().equals(nombreTabla)) {
//                    break;
//                }
//
//                if (reader.isStartElement()) {
//                    String elemento = reader.getLocalName();
//                    reader.next();
//                    String valor = reader.getText();
//                    System.out.println(elemento + ": " + valor);
//                }
//
//                reader.next();
//            }
//        }
//    }

}
