package Servlets;

import Classes.GestionarMedicamentos;
import Classes.Medicamento;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Juan
 */
@WebServlet(name = "SV_EditarMed", urlPatterns = {"/SV_EditarMed"})
public class SV_EditarMed extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtener los parámetros del formulario
        int id_med = Integer.parseInt(request.getParameter("id_med"));
        String cod_barras = request.getParameter("cod_barras");
        String nombre_comercial = request.getParameter("nombre_comercial");
        String nombre_generico = request.getParameter("nombre_generico");
        String presentacion = request.getParameter("presentacion");
        String concentracion = request.getParameter("concentracion");
        int id_lab = Integer.parseInt(request.getParameter("id_lab"));
        String descripcion = request.getParameter("descripcion");
        BigDecimal precio_publico = new BigDecimal(request.getParameter("precio_publico"));
        boolean requiere_receta = request.getParameter("requiere_receta") != null;
        BigDecimal precio = new BigDecimal(request.getParameter("precio"));
        int stock_actual = Integer.parseInt(request.getParameter("stock_actual"));
        int stock_minimo = Integer.parseInt(request.getParameter("stock_minimo"));
        String ubicacion = request.getParameter("ubicacion");
        String fecha_vencimientoStr = request.getParameter("fecha_vencimiento");
        String proveedor = request.getParameter("proveedor");
        
        // Convertir fecha si existe
        Date fecha_vencimiento = null;
        if (fecha_vencimientoStr != null && !fecha_vencimientoStr.isEmpty()) {
            fecha_vencimiento = Date.valueOf(fecha_vencimientoStr);
        }
        
        // Crear objeto Medicamento
        Medicamento m = new Medicamento();
        m.setId_med(id_med);
        m.setCod_barras(cod_barras);
        m.setNombre_comercial(nombre_comercial);
        m.setNombre_generico(nombre_generico);
        m.setPresentacion(presentacion);
        m.setConcentracion(concentracion);
        m.setId_lab(id_lab);
        m.setDescripcion(descripcion);
        m.setPrecio_publico(precio_publico);
        m.setRequiere_receta(requiere_receta);
        m.setPrecio(precio);
        m.setStock_actual(stock_actual);
        m.setStock_minimo(stock_minimo);
        m.setUbicacion(ubicacion);
        m.setFecha_vencimiento(fecha_vencimiento);
        m.setProveedor(proveedor);
        
        // Editar en la base de datos
        GestionarMedicamentos gestion = new GestionarMedicamentos();
        boolean editado = gestion.editarMedicamento(m);
        
        if (editado) {
            response.sendRedirect("admin.jsp?exito=editado");
        } else {
            response.sendRedirect("admin.jsp?error=edicion");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para editar medicamentos";
    }
}