package com.mycompany.greenepharmacorp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Clase encargada de establecer la conexión con la base de datos MySQL
 * @author Juan
 */
public class DataBaseConnection {
    
    // Logger para registrar eventos y errores
    private static final Logger LOGGER = Logger.getLogger(DataBaseConnection.class.getName());
    
    // URL de conexión a la base de datos GreenePharmaCorp
    // useSSL=false: deshabilita SSL para conexiones locales
    // serverTimezone=UTC: establece la zona horaria
    // allowPublicKeyRetrieval=true: permite recuperar la clave pública
    private static final String URL = "jdbc:mysql://localhost:3306/GreenePharmaCorp?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    
    // Usuario de MySQL (por defecto es root)
    private static final String USER = "root";
    
    // Contraseña de MySQL (Según la configuración actual)
    private static final String PASSWORD = "";
    
    /**
     * Bloque estático que se ejecuta al cargar la clase
     * Se encarga de registrar el driver de MySQL
     */
    static {
        try {
            // Registra el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            LOGGER.log(Level.INFO, "Driver MySQL cargado exitosamente");
        } catch (ClassNotFoundException e) {
            // Si hay error al cargar el driver, se registra en el log
            LOGGER.log(Level.SEVERE, "Error al cargar el driver MySQL", e);
        }
    }
    
    /**
     * Método para establecer la conexión con la base de datos
     * @return Connection objeto de conexión a la base de datos
     * @throws SQLException si hay error al conectar
     */
    public static Connection conectar() throws SQLException {
        // Establece y retorna la conexión con los parámetros configurados
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}