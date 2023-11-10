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
                System.out.println(nombreTabla +sufijo);
            } else {
                sufijo = "es";
                System.out.println(nombreTabla +sufijo );
            }

            // Saltar hasta el elemento principal
            while (reader.hasNext()) {
                if (reader.isStartElement() && reader.getLocalName().equals(nombreTabla + sufijo)) {

                    System.out.println("Elemento principal " + reader.getLocalName());
                    break;
                }
                reader.next();
            }

            // Importar datos de la tabla desde el archivo XML
            while (reader.hasNext()) {
                if (reader.isStartElement() && reader.getLocalName().equals(nombreTabla)) {
                    System.out.println("Elemento actual: " + reader.getLocalName());
                    importarFila(motor, reader, nombreTabla);
//                    System.out.println("IMPORTO FILAS");

                }
                reader.next();
            }
            reader.close();
            System.out.println("Importación completada en la tabla: " + nombreTabla+ "\n\n");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            motor.close();
        }
    }

    private static void importarFila(MotorDerby motor, XMLStreamReader reader, String nombreTabla) throws XMLStreamException {
        StringBuilder columnas = new StringBuilder();
        StringBuilder values = new StringBuilder();
//        boolean inserto = true;

        while (reader.hasNext()) {
            reader.next();
            if (reader.isStartElement()) {
                String columnName = reader.getLocalName();
                String columnValue = reader.getElementText();

                columnas.append(columnName).append(",");
                // Si el valor es numérico, no lo entrecomilles
                if (esNumero(columnValue)) {
                    values.append(columnValue);
                } else {
                    values.append("'").append(columnValue).append("'");
                }
                values.append(", ");

            } else if (reader.isEndElement() && reader.getLocalName().equals(nombreTabla)) {
                break;
            }
        }

        // Eliminar la última coma
        columnas.delete(columnas.length() - 2, columnas.length());
        values.delete(values.length() - 2, values.length());

        // Construir la consulta de inserción
        String sql = "INSERT INTO " + nombreTabla + " VALUES (" + values + ")";
        System.out.println(sql + "\n\n");
        motor.executeUpdate(sql);
    }

    // COMPROBACIONES HACEN QUE EXPLOTE EN EL READER.NEXT() LINEA 56
    /*
    COMPROBACION POR ID en todas las tablas
    String idTablaValue = obtenerValorParaColumna("Id_"+nombreTabla, reader);
    String checkSql = "SELECT * FROM " + nombreTabla + " WHERE Id_"+nombreTabla + " = " + idTablaValue;
    boolean registroExistente = motor.existeRegistro(checkSql);

        if (!registroExistente) {
        // Continuar con la inserción
        String sql = "INSERT INTO " + nombreTabla + " (" + columnas + ") VALUES (" + values + ")";
        System.out.println(sql + "\n\n");
        motor.executeUpdate(sql);
    } else {
        System.out.println("El Id_" + nombreTabla + " ya existe en la base de datos.");
    }


    COMPROBACION POR NOMBRE en todas las tablas
    String TablaValue = obtenerValorParaColumna("Nombre_"+nombreTabla, reader);
    String checkSql = "SELECT * FROM " + nombreTabla + " WHERE Nombre_" + nombreTabla + " = '" + TablaValue + "'";
    boolean registroExistente = motor.existeRegistro(checkSql);

        if (!registroExistente) {
        // Continuar con la inserción
        String sql = "INSERT INTO " + nombreTabla + " (" + columnas + ") VALUES (" + values + ")";
        System.out.println(sql + "\n\n");
        motor.executeUpdate(sql);
    } else {
        System.out.println("El Id_" + nombreTabla + " ya existe en la base de datos.");
   }

    */


    /**
     * METODO COMPRUEBA QUE EL DATO DE XML NO ES NUMERICO PARA ENTRE COMILLARLO EN EL SQL
     * @param str
     * @return
     */
    private static boolean esNumero(String str) {
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * OBTENER VALOR DE CADA COLUMNA PARA COMPROBAR SI ESTA EN LA BASE DE DATOS
     * @param columnName
     * @param reader
     * @return
     * @throws XMLStreamException
     */
    private static String obtenerValorParaColumna(String columnName, XMLStreamReader reader) throws XMLStreamException {
        while (reader.hasNext()) {
            reader.next();
            if (reader.isStartElement() && reader.getLocalName().equals(columnName)) {
                return reader.getElementText();
            }
        }
        return null; // O maneja el caso cuando no se encuentra el valor
    }




}
