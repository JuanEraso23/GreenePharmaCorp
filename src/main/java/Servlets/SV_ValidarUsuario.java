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
@WebServlet(name = "SV_ValidarUsuario", urlPatterns = {"/SV_ValidarUsuario"})
public class SV_ValidarUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Recibir datos del formulario
        String doc = request.getParameter("doc");
        String tipo_doc = request.getParameter("tipo_doc");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String tipo_usuario_seleccionado = request.getParameter("tipo_usuario");
        
        // Crear objeto de gestión
        GestionarUsuarios gestion = new GestionarUsuarios();
        
        // Verificar si el usuario existe en la BD y de qué tipo es
        String tipo_real = gestion.verificarTipoUsuario(doc, tipo_doc, nombre, apellido);
        
        // Si el usuario no existe en la BD
        if (tipo_real == null) {
            response.sendRedirect("index.jsp?error=credenciales");
            return;
        }
        
        // Verificar que el tipo seleccionado coincida con el tipo real
        if ("cliente".equals(tipo_usuario_seleccionado) && !"CLIENTE".equals(tipo_real)) {
            // Seleccionó cliente pero es personal en la BD
            response.sendRedirect("index.jsp?error=credenciales");
            return;
        }
        
        if ("personal".equals(tipo_usuario_seleccionado) && !"PERSONAL".equals(tipo_real)) {
            // Seleccionó personal pero es cliente en la BD
            response.sendRedirect("index.jsp?error=credenciales");
            return;
        }
        
        // Usuario existe y el tipo coincide
        if ("cliente".equals(tipo_usuario_seleccionado)) {
            // Es cliente - redirigir directamente
            HttpSession session = request.getSession();
            session.setAttribute("doc", doc);
            session.setAttribute("tipo_doc", tipo_doc);
            session.setAttribute("nombre", nombre);
            session.setAttribute("apellido", apellido);
            
            response.sendRedirect("cliente.jsp");
            
        } else {
            // Es personal - Guardar en sesión temporal y mostrar modal
            HttpSession session = request.getSession();
            session.setAttribute("temp_doc", doc);
            session.setAttribute("temp_tipo_doc", tipo_doc);
            session.setAttribute("temp_nombre", nombre);
            session.setAttribute("temp_apellido", apellido);
            
            response.sendRedirect("index.jsp?personal=true");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para validar usuarios";
    }
}