package Servlets;

import com.mycompany.greenepharmacorp.DataBaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet para verificar la conexión entre la aplicación web y la base de datos
 * @author Juan
 */
@WebServlet(name = "SV_RecibeInfo", urlPatterns = {"/SV_RecibeInfo"})
public class SV_RecibeInfo extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(SV_RecibeInfo.class.getName());

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Intentar establecer la conexión con la base de datos
        try (Connection c = DataBaseConnection.conectar()) {
                
            if (c != null) {
                // Conexión exitosa
                LOGGER.log(Level.INFO, "Conexión exitosa a la base de datos: ", c.getCatalog());
            }
        } catch (SQLException e) {
            // Error en la conexión
            LOGGER.log(Level.SEVERE, "Error de conexión: " + e.getMessage());
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet para probar conexión con base de datos GreenePharmaCorp (método POST)";
    }
}