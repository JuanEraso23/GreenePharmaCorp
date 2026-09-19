package Classes;

import com.mycompany.greenepharmacorp.DataBaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Juan
 */
public class GestionarMedicamentos {
    
    private static final Logger LOGGER = Logger.getLogger(GestionarMedicamentos.class.getName());
    
    /**
     * ========================================================
     * LISTA LOS MEDICAMENTOS DISPONIBLES (PAGINADO)
     * ========================================================
     * Obtiene una lista paginada de medicamentos ordenados del
     * más reciente al más antiguo (por ID descendente).
     * Cada medicamento se completa con todos sus datos.
     * 
     * @param pagina Número de página actual
     * @param registrosPorPagina Cantidad de registros por página
     * @return Lista de medicamentos
     */
    public List<Medicamento> getMedicamentos(int pagina, int registrosPorPagina) {
        List<Medicamento> medicamentos = new ArrayList<>();
        String sql = "SELECT id_med, nombre_comercial FROM medicamentos ORDER BY id_med DESC LIMIT ? OFFSET ?";

        int offset = (pagina - 1) * registrosPorPagina;

        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, registrosPorPagina);
            ps.setInt(2, offset);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Medicamento m = new Medicamento();
                    m.setId_med(rs.getInt("id_med"));
                    m.setNombre_comercial(rs.getString("nombre_comercial"));
                    
                    // Completar TODOS los datos del medicamento
                    completarDatosMedicamento(m);
                    
                    medicamentos.add(m);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al listar medicamentos", e);
        }

        return medicamentos;
    }
    
    /**
     * ========================================================
     * COMPLETA TODOS LOS DATOS DE UN MEDICAMENTO USANDO SU ID
     * ========================================================
     * Método auxiliar que recibe un medicamento con ID y
     * carga todos sus campos desde la base de datos.
     * También asigna el nombre del laboratorio correspondiente.
     * 
     * @param m Objeto Medicamento con el ID a completar
     */
    private void completarDatosMedicamento(Medicamento m) {
        String sql = "SELECT id_med, cod_barras, nombre_comercial, nombre_generico, "
                   + "presentacion, concentracion, id_lab, descripcion, precio_publico, "
                   + "requiere_receta, precio, stock_actual, stock_minimo, ubicacion, "
                   + "fecha_vencimiento, proveedor "
                   + "FROM medicamentos WHERE id_med = ?";
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, m.getId_med());
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Información básica (Todos)
                    m.setCod_barras(rs.getString("cod_barras"));
                    m.setNombre_comercial(rs.getString("nombre_comercial"));
                    m.setNombre_generico(rs.getString("nombre_generico"));
                    m.setPresentacion(rs.getString("presentacion"));
                    m.setConcentracion(rs.getString("concentracion"));
                    m.setId_lab(rs.getInt("id_lab"));
                    m.setDescripcion(rs.getString("descripcion"));
                    m.setPrecio_publico(rs.getBigDecimal("precio_publico"));
                    m.setRequiere_receta(rs.getBoolean("requiere_receta"));
                    
                    // Información de Administración (Personal)
                    m.setPrecio(rs.getBigDecimal("precio"));
                    m.setStock_actual(rs.getInt("stock_actual"));
                    m.setStock_minimo(rs.getInt("stock_minimo"));
                    m.setUbicacion(rs.getString("ubicacion"));
                    m.setFecha_vencimiento(rs.getDate("fecha_vencimiento"));
                    m.setProveedor(rs.getString("proveedor"));
                    
                    // Obtener el nombre del laboratorio
                    String nombreLab = getNombreLaboratorio(m.getId_lab());
                    m.setNombre_laboratorio(nombreLab);
                } else {
                    System.out.println("ERROR: No se encontró medicamento con ID " + m.getId_med());
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            LOGGER.log(Level.SEVERE, "Error al completar datos del medicamento ID: " + m.getId_med(), e);
        }
    }
    
    /**
     * ========================================================
     * OBTIENE EL NOMBRE DE UN LABORATORIO POR SU ID
     * ========================================================
     * Realiza una consulta a la tabla laboratorios para
     * obtener el nombre correspondiente al ID proporcionado.
     * 
     * @param id_lab ID del laboratorio
     * @return Nombre del laboratorio o mensaje por defecto
     */
    private String getNombreLaboratorio(int id_lab) {
        String sql = "SELECT nombre FROM laboratorios WHERE id_lab = ?";
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id_lab);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String nombre = rs.getString("nombre");
                    return nombre;
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al obtener nombre del laboratorio", e);
        }
        
        return "Laboratorio " + id_lab;
    }
    
    /**
     * ========================================================
     * OBTIENE EL TOTAL DE MEDICAMENTOS REGISTRADOS
     * ========================================================
     * Cuenta todos los registros existentes en la tabla
     * medicamentos, sin aplicar ningún filtro adicional.
     * 
     * @return Número total de medicamentos en la base de datos
     */
    public int getTotalMedicamentos() {
        String sql = "SELECT COUNT(*) as total FROM medicamentos";

        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al contar medicamentos", e);
        }

        return 0;
    }
    
    /**
     * ========================================================
     * BUSCA MEDICAMENTOS POR NOMBRE (PAGINADO)
     * ========================================================
     * Realiza una búsqueda de medicamentos cuyo nombre
     * comercial o nombre genérico coincidan con el término.
     * Los resultados se ordenan del más reciente al más antiguo.
     * 
     * @param termino Término de búsqueda
     * @param pagina Número de página
     * @param registrosPorPagina Cantidad por página
     * @return Lista de medicamentos que coinciden con la búsqueda
     */
    public List<Medicamento> getMedicamentosPorNombre(String termino, int pagina, int registrosPorPagina) {
        List<Medicamento> medicamentos = new ArrayList<>();
        
        // PRIMERO: Obtenemos los IDs que coinciden con la búsqueda (ordenados por ID descendente)
        String sqlIds = "SELECT id_med FROM medicamentos "
                      + "WHERE (nombre_comercial LIKE ? OR nombre_generico LIKE ?) "
                      + "ORDER BY id_med DESC "
                      + "LIMIT ? OFFSET ?";
        
        int offset = (pagina - 1) * registrosPorPagina;
        String patron = "%" + termino + "%";
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sqlIds)) {
            
            ps.setString(1, patron);
            ps.setString(2, patron);
            ps.setInt(3, registrosPorPagina);
            ps.setInt(4, offset);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Medicamento m = new Medicamento();
                    m.setId_med(rs.getInt("id_med"));
                    
                    // Completar TODOS los datos
                    completarDatosMedicamento(m);
                    
                    if (m.getNombre_comercial() != null) {
                        medicamentos.add(m);
                    }
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al buscar medicamentos por nombre", e);
        }
        
        return medicamentos;
    }
    
    /**
     * ========================================================
     * TOTAL DE RESULTADOS DE BÚSQUEDA POR NOMBRE
     * ========================================================
     * Cuenta cuántos medicamentos coinciden con el término
     * de búsqueda proporcionado (por nombre comercial o genérico).
     * 
     * @param termino Término de búsqueda
     * @return Número total de resultados que coinciden
     */
    public int getTotalMedicamentosPorNombre(String termino) {
        String sql = "SELECT COUNT(*) as total FROM medicamentos "
                   + "WHERE (nombre_comercial LIKE ? OR nombre_generico LIKE ?)";
        
        String patron = "%" + termino + "%";
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, patron);
            ps.setString(2, patron);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al contar búsqueda por nombre", e);
        }
        
        return 0;
    }
    
    /**
     * ========================================================
     * BUSCA MEDICAMENTOS POR LABORATORIO (PAGINADO)
     * ========================================================
     * Obtiene todos los medicamentos que pertenecen al
     * laboratorio especificado por su ID.
     * Los resultados se ordenan del más reciente al más antiguo.
     * 
     * @param id_lab ID del laboratorio
     * @param pagina Número de página
     * @param registrosPorPagina Cantidad por página
     * @return Lista de medicamentos del laboratorio
     */
    public List<Medicamento> getMedicamentosPorLaboratorio(int id_lab, int pagina, int registrosPorPagina) {
        List<Medicamento> medicamentos = new ArrayList<>();
        
        // PRIMERO: Obtenemos los IDs del laboratorio (ordenados por ID descendente)
        String sqlIds = "SELECT id_med FROM medicamentos WHERE id_lab = ? "
                      + "ORDER BY id_med DESC "
                      + "LIMIT ? OFFSET ?";
        
        int offset = (pagina - 1) * registrosPorPagina;
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sqlIds)) {
            
            ps.setInt(1, id_lab);
            ps.setInt(2, registrosPorPagina);
            ps.setInt(3, offset);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Medicamento m = new Medicamento();
                    m.setId_med(rs.getInt("id_med"));
                    
                    // Completar TODOS los datos
                    completarDatosMedicamento(m);
                    
                    if (m.getNombre_comercial() != null) {
                        medicamentos.add(m);
                    }
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al buscar medicamentos por laboratorio", e);
        }
        
        return medicamentos;
    }
    
    /**
     * ========================================================
     * TOTAL DE MEDICAMENTOS DE UN LABORATORIO
     * ========================================================
     * Cuenta cuántos medicamentos están asociados al
     * laboratorio especificado por su ID.
     * 
     * @param id_lab ID del laboratorio
     * @return Número total de medicamentos del laboratorio
     */
    public int getTotalMedicamentosPorLaboratorio(int id_lab) {
        String sql = "SELECT COUNT(*) as total FROM medicamentos WHERE id_lab = ?";
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id_lab);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al contar medicamentos por laboratorio", e);
        }
        
        return 0;
    }
    
    /**
     * ========================================================
     * LISTA DE LABORATORIOS DISPONIBLES
     * ========================================================
     * Obtiene todos los laboratorios registrados en la base
     * de datos, ordenados alfabéticamente por su nombre.
     * 
     * @return Lista de laboratorios ordenada alfabéticamente
     */
    public List<Laboratorio> getLaboratorios() {
        List<Laboratorio> laboratorios = new ArrayList<>();
        String sql = "SELECT id_lab, nombre FROM laboratorios ORDER BY nombre";
        
        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Laboratorio l = new Laboratorio();
                l.setId_lab(rs.getInt("id_lab"));
                l.setNombre(rs.getString("nombre"));
                laboratorios.add(l);
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al listar laboratorios", e);
        }
        
        return laboratorios;
    }
    
    /**
     * ========================================================
     * CREA UN NUEVO MEDICAMENTO EN LA BASE DE DATOS
     * ========================================================
     * Inserta un nuevo registro en la tabla medicamentos con
     * todos los datos proporcionados. El campo 'activo' se
     * establece automáticamente en 1.
     * 
     * @param m Objeto Medicamento con los datos a insertar
     * @return true si se creó exitosamente, false si hubo error
     */
    public boolean crearMedicamento(Medicamento m) {
        String sql = "INSERT INTO medicamentos (cod_barras, nombre_comercial, nombre_generico, "
                  + "presentacion, concentracion, id_lab, descripcion, precio_publico, "
                  + "requiere_receta, precio, stock_actual, stock_minimo, ubicacion, "
                  + "fecha_vencimiento, proveedor, activo) "
                  + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)";

        try (Connection conn = DataBaseConnection.conectar();
            PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, m.getCod_barras());
            ps.setString(2, m.getNombre_comercial());
            ps.setString(3, m.getNombre_generico());
            ps.setString(4, m.getPresentacion());
            ps.setString(5, m.getConcentracion());
            ps.setInt(6, m.getId_lab());
            ps.setString(7, m.getDescripcion());
            ps.setBigDecimal(8, m.getPrecio_publico());
            ps.setBoolean(9, m.isRequiere_receta());
            ps.setBigDecimal(10, m.getPrecio());
            ps.setInt(11, m.getStock_actual());
            ps.setInt(12, m.getStock_minimo());
            ps.setString(13, m.getUbicacion());
            ps.setDate(14, m.getFecha_vencimiento() != null ? new java.sql.Date(m.getFecha_vencimiento().getTime()) : null);
            ps.setString(15, m.getProveedor());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al crear medicamento", e);
            return false;
        }
    }
    
    /**
     * ========================================================
     * EDITA UN MEDICAMENTO EXISTENTE EN LA BASE DE DATOS
     * ========================================================
     * Actualiza todos los campos de un medicamento existente
     * identificado por su ID. El campo 'activo' no se modifica.
     * 
     * @param m Objeto Medicamento con los datos actualizados
     * @return true si se editó exitosamente, false si hubo error
     */
    public boolean editarMedicamento(Medicamento m) {
        String sql = "UPDATE medicamentos SET cod_barras = ?, nombre_comercial = ?, nombre_generico = ?, "
                    + "presentacion = ?, concentracion = ?, id_lab = ?, descripcion = ?, precio_publico = ?, "
                    + "requiere_receta = ?, precio = ?, stock_actual = ?, stock_minimo = ?, ubicacion = ?, "
                    + "fecha_vencimiento = ?, proveedor = ? "
                    + "WHERE id_med = ?";

        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, m.getCod_barras());
            ps.setString(2, m.getNombre_comercial());
            ps.setString(3, m.getNombre_generico());
            ps.setString(4, m.getPresentacion());
            ps.setString(5, m.getConcentracion());
            ps.setInt(6, m.getId_lab());
            ps.setString(7, m.getDescripcion());
            ps.setBigDecimal(8, m.getPrecio_publico());
            ps.setBoolean(9, m.isRequiere_receta());
            ps.setBigDecimal(10, m.getPrecio());
            ps.setInt(11, m.getStock_actual());
            ps.setInt(12, m.getStock_minimo());
            ps.setString(13, m.getUbicacion());
            ps.setDate(14, m.getFecha_vencimiento() != null ? new java.sql.Date(m.getFecha_vencimiento().getTime()) : null);
            ps.setString(15, m.getProveedor());
            ps.setInt(16, m.getId_med());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al editar medicamento", e);
            return false;
        }
    }
    
    /**
     * ========================================================
     * ELIMINA UN MEDICAMENTO DE LA BASE DE DATOS (FÍSICO)
     * ========================================================
     * Realiza una eliminación física del registro en la tabla
     * medicamentos. El registro desaparece permanentemente.
     * 
     * @param id_med ID del medicamento a eliminar
     * @return true si se eliminó exitosamente, false si hubo error
     */
    public boolean eliminarMedicamento(int id_med) {
        String sql = "DELETE FROM medicamentos WHERE id_med = ?";

        try (Connection conn = DataBaseConnection.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_med);

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al eliminar medicamento con ID: " + id_med, e);
            return false;
        }
    }
}