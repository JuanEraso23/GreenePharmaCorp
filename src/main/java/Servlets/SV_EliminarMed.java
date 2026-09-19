package Servlets;

import Classes.GestionarMedicamentos;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Juan
 */
@WebServlet(name = "SV_EliminarMed", urlPatterns = {"/SV_EliminarMed"})
public class SV_EliminarMed extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtener el ID del medicamento a eliminar
        String idParam = request.getParameter("id_med");
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("admin.jsp?error=eliminacion");
            return;
        }
        
        try {
            int id_med = Integer.parseInt(idParam);
            
            // Eliminar de la base de datos
            GestionarMedicamentos gestion = new GestionarMedicamentos();
            boolean eliminado = gestion.eliminarMedicamento(id_med);
            
            if (eliminado) {
                response.sendRedirect("admin.jsp?exito=eliminado");
            } else {
                response.sendRedirect("admin.jsp?error=eliminacion");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("admin.jsp?error=eliminacion");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para eliminar medicamentos";
    }
}