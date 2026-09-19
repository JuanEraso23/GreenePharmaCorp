package Servlets;

import Classes.GestionarUsuarios;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Juan
 */
@WebServlet(name = "SV_ValidarPersonal", urlPatterns = {"/SV_ValidarPersonal"})
public class SV_ValidarPersonal extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Recibir datos del modal
        String cargo = request.getParameter("cargo");
        String cod = request.getParameter("cod");
        
        // Obtener datos de la sesión
        HttpSession session = request.getSession();
        String doc = (String) session.getAttribute("temp_doc");
        String tipo_doc = (String) session.getAttribute("temp_tipo_doc");
        String nombre = (String) session.getAttribute("temp_nombre");
        String apellido = (String) session.getAttribute("temp_apellido");
        
        // Validar personal completo
        GestionarUsuarios gestion = new GestionarUsuarios();
        boolean existe = gestion.validarPersonalCompleto(doc, tipo_doc, nombre, apellido, cargo, cod);
        
        if (existe) {
            // Guardar datos en sesión permanente
            session.setAttribute("doc", doc);
            session.setAttribute("tipo_doc", tipo_doc);
            session.setAttribute("nombre", nombre);
            session.setAttribute("apellido", apellido);
            session.setAttribute("cargo", cargo);
            
            // Limpiar temporales
            session.removeAttribute("temp_doc");
            session.removeAttribute("temp_tipo_doc");
            session.removeAttribute("temp_nombre");
            session.removeAttribute("temp_apellido");
            
            response.sendRedirect("admin.jsp");
        } else {
            response.sendRedirect("index.jsp?error=verificacion");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para validar personal";
    }
}