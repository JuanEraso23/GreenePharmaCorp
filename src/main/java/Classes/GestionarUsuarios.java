package Classes;

import com.mycompany.greenepharmacorp.DataBaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Juan
 */
public class GestionarUsuarios {
    
    private static final Logger LOGGER = Logger.getLogger(GestionarUsuarios.class.getName());
    
    /**
     * Verifica si un usuario existe y de qué tipo es
     * @param doc Tipo de documento
     * @param tipo_doc Número de documento
     * @param nombre Nombres
     * @param apellido Apellidos
     * @return "CLIENTE", "PERSONAL" o null si no existe
     */
    public String verificarTipoUsuario(String doc, String tipo_doc, String nombre, String apellido) {
        String sql = "SELECT tipo_usuario FROM usuarios WHERE doc = ? AND tipo_doc = ? AND nombre = ? AND apellido = ? AND activo = 1";
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, doc);
            ps.setString(2, tipo_doc);
            ps.setString(3, nombre);
            ps.setString(4, apellido);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("tipo_usuario"); // "CLIENTE" o "PERSONAL"
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error verificando tipo de usuario", e);
        }
        return null; // Usuario no existe
    }
    
    /**
     * Valida si un cliente existe en la base de datos
     */
    public boolean validarCliente(String doc, String tipo_doc, String nombre, String apellido) {
        String sql = "SELECT * FROM usuarios WHERE doc = ? AND tipo_doc = ? AND nombre = ? AND apellido = ? AND tipo_usuario = 'CLIENTE' AND activo = 1";
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, doc);
            ps.setString(2, tipo_doc);
            ps.setString(3, nombre);
            ps.setString(4, apellido);
            
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error validando cliente", e);
            return false;
        }
    }
    
    /**
     * Valida si un personal existe en la base de datos (solo existencia básica)
     */
    public boolean validarPersonalBasico(String doc, String tipo_doc, String nombre, String apellido) {
        String sql = "SELECT * FROM usuarios WHERE doc = ? AND tipo_doc = ? AND nombre = ? AND apellido = ? AND tipo_usuario = 'PERSONAL' AND activo = 1";
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, doc);
            ps.setString(2, tipo_doc);
            ps.setString(3, nombre);
            ps.setString(4, apellido);
            
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error validando personal básico", e);
            return false;
        }
    }
    
    /**
     * Valida si un personal existe con cargo y código
     */
    public boolean validarPersonalCompleto(String doc, String tipo_doc, String nombre, String apellido, String cargo, String cod) {
        String sql = "SELECT * FROM usuarios WHERE doc = ? AND tipo_doc = ? AND nombre = ? AND apellido = ? AND cargo = ? AND cod = ? AND tipo_usuario = 'PERSONAL' AND activo = 1";
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, doc);
            ps.setString(2, tipo_doc);
            ps.setString(3, nombre);
            ps.setString(4, apellido);
            ps.setString(5, cargo);
            ps.setString(6, cod);
            
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error validando personal completo", e);
            return false;
        }
    }
}