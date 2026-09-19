<%@include file="/lib/header.jsp"%>
<%@page import="java.util.List"%>
<%@page import="Classes.Medicamento"%>
<%@page import="Classes.Laboratorio"%>
<%@page import="Classes.GestionarMedicamentos"%>

<div class="container mt-4">
    
    <%
        // Parámetros de Paginación y Búsqueda
        int pagina = 1;
        int registrosPorPagina = 10;
        String busqueda = request.getParameter("busqueda");
        String filtroLaboratorio = request.getParameter("filtroLaboratorio");
        String accion = request.getParameter("accion");
        
        if (request.getParameter("pagina") != null) {
            try {
                pagina = Integer.parseInt(request.getParameter("pagina"));
                if (pagina < 1) pagina = 1;
            } catch (NumberFormatException e) {
                pagina = 1;
            }
        }
        
        GestionarMedicamentos g = new GestionarMedicamentos();
        List<Medicamento> listaMedicamentos = null;
        int totalRegistros = 0;
        
        // Determinar qué Listado Mostrar según los Filtros
        if ("buscarPorLaboratorio".equals(accion) && filtroLaboratorio != null && !filtroLaboratorio.isEmpty()) {
            // Buscar por Laboratorio
            int idLab = Integer.parseInt(filtroLaboratorio);
            listaMedicamentos = g.getMedicamentosPorLaboratorio(idLab, pagina, registrosPorPagina);
            totalRegistros = g.getTotalMedicamentosPorLaboratorio(idLab);
        } else if (busqueda != null && !busqueda.trim().isEmpty()) {
            // Búsqueda por nombre
            listaMedicamentos = g.getMedicamentosPorNombre(busqueda, pagina, registrosPorPagina);
            totalRegistros = g.getTotalMedicamentosPorNombre(busqueda);
        } else {
            // Listado general
            listaMedicamentos = g.getMedicamentos(pagina, registrosPorPagina);
            totalRegistros = g.getTotalMedicamentos();
        }
        
        int totalPaginas = (int) Math.ceil((double) totalRegistros / registrosPorPagina);
        if (totalPaginas == 0) totalPaginas = 1;
        if (pagina > totalPaginas) pagina = totalPaginas;
    %>
    
    <!-- Barra de Búsqueda y Filtros -->
    <div class="row mb-4">
        <div class="col-md-8">
            <form action="cliente.jsp" method="GET" class="d-flex">
                <input type="text" class="form-control me-2" name="busqueda" 
                       placeholder="Buscar medicamento por nombre..." 
                       value="<%= busqueda != null ? busqueda : "" %>"
                       style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 10px;">
                <button type="submit" class="btn" style="background-color: #2E7D32; color: white; border-radius: 8px; padding: 10px 20px;">
                    <i class="fas fa-search me-2"></i>Buscar
                </button>
            </form>
        </div>
        <div class="col-md-4">
            <form action="cliente.jsp" method="GET" class="d-flex">
                <input type="hidden" name="accion" value="buscarPorLaboratorio">
                <select class="form-select me-2" name="filtroLaboratorio" 
                        style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 10px;">
                    <option value="">Todos los laboratorios</option>
                    <%
                        List<Laboratorio> laboratorios = g.getLaboratorios();
                        for (Laboratorio lab : laboratorios) {
                            String selected = (filtroLaboratorio != null && filtroLaboratorio.equals(String.valueOf(lab.getId_lab()))) ? "selected" : "";
                    %>
                    <option value="<%= lab.getId_lab() %>" <%= selected %>><%= lab.getNombre() %></option>
                    <%
                        }
                    %>
                </select>
                <button type="submit" class="btn" style="background-color: #2E7D32; color: white; border-radius: 8px; padding: 10px 20px;">
                    <i class="fas fa-filter me-2"></i>Filtrar
                </button>
            </form>
        </div>
    </div>
    
    <!-- Información de Resultados -->
    <div class="row mb-3">
        <div class="col-12">
            <p>
                <i class="fas fa-info-circle me-1" style="color: #2E7D32;"></i>
                Mostrando <%= (listaMedicamentos != null ? listaMedicamentos.size() : 0) %> de <%= totalRegistros %> medicamentos disponibles
                <% if (busqueda != null && !busqueda.isEmpty()) { %>
                    para "<strong><%= busqueda %></strong>"
                <% } %>
                <% if (filtroLaboratorio != null && !filtroLaboratorio.isEmpty()) { %>
                    en el laboratorio seleccionado
                <% } %>
            </p>
        </div>
    </div>
    
    <!-- Tabla de Medicamentos -->
    <div class="card shadow-lg border-0" style="border-radius: 15px;">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead style="background-color: #2E7D32; color: white;">
                        <tr>
                            <th>Laboratorio</th>
                            <th>Medicamento</th>
                            <th>Presentación</th>
                            <th>Descripción</th>
                            <th>Precio</th>
                            <th>Receta</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listaMedicamentos != null && !listaMedicamentos.isEmpty()) {
                                for (Medicamento m : listaMedicamentos) {
                        %>
                        <tr>
                            <td><span style="background-color: #81C784; color: #1B5E20; padding: 4px 8px; border-radius: 4px;"><%= m.getNombre_laboratorio() %></span></td>
                            <td>
                                <strong><%= m.getNombre_comercial() %></strong><br>
                                <small><%= m.getNombre_generico() != null ? m.getNombre_generico() : "" %></small>
                            </td>
                            <td><%= m.getPresentacion() %> <%= m.getConcentracion() %></td>
                            <td><%= m.getDescripcion() != null ? m.getDescripcion() : "Sin descripción" %></td>
                            <td><span style="color: #2E7D32; font-weight: bold;">$<%= String.format("%,.0f", m.getPrecio_publico()) %></span></td>
                            <td>
                                <% if (m.isRequiere_receta()) { %>
                                    <span style="background-color: #ffc107; color: #000; padding: 4px 8px; border-radius: 4px;">Requiere receta</span>
                                <% } else { %>
                                    <span style="background-color: #28a745; color: #fff; padding: 4px 8px; border-radius: 4px;">Venta libre</span>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center py-4">
                                <i class="fas fa-pills me-2" style="color: #81C784; font-size: 2rem;"></i>
                                <p>No se encontraron medicamentos disponibles</p>
                                <p><small>Total en BD: <%= totalRegistros %></small></p>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            
            <!-- Paginación -->
            <% if (totalPaginas > 1) { %>
            <div class="d-flex justify-content-between align-items-center mt-4">
                <div>
                    <i class="fas fa-file me-1" style="color: #2E7D32;"></i>
                    Página <%= pagina %> de <%= totalPaginas %>
                </div>
                <nav>
                    <ul class="pagination">
                        <li class="page-item <%= pagina == 1 ? "disabled" : "" %>">
                            <a class="page-link" href="<%= construirUrlPaginacion(request, 1) %>" style="color: #2E7D32;">
                                <i class="fas fa-angle-double-left"></i>
                            </a>
                        </li>
                        <li class="page-item <%= pagina == 1 ? "disabled" : "" %>">
                            <a class="page-link" href="<%= construirUrlPaginacion(request, pagina - 1) %>" style="color: #2E7D32;">
                                <i class="fas fa-angle-left"></i>
                            </a>
                        </li>
                        
                        <%
                            int inicio = Math.max(1, pagina - 2);
                            int fin = Math.min(totalPaginas, inicio + 4);
                            if (fin - inicio < 4) {
                                inicio = Math.max(1, fin - 4);
                            }
                            
                            for (int i = inicio; i <= fin; i++) {
                        %>
                        <li class="page-item <%= i == pagina ? "active" : "" %>">
                            <a class="page-link" href="<%= construirUrlPaginacion(request, i) %>" 
                               style="<%= i == pagina ? "background-color: #2E7D32; border-color: #2E7D32; color: white;" : "color: #2E7D32;" %>">
                                <%= i %>
                            </a>
                        </li>
                        <%
                            }
                        %>
                        
                        <li class="page-item <%= pagina == totalPaginas ? "disabled" : "" %>">
                            <a class="page-link" href="<%= construirUrlPaginacion(request, pagina + 1) %>" style="color: #2E7D32;">
                                <i class="fas fa-angle-right"></i>
                            </a>
                        </li>
                        <li class="page-item <%= pagina == totalPaginas ? "disabled" : "" %>">
                            <a class="page-link" href="<%= construirUrlPaginacion(request, totalPaginas) %>" style="color: #2E7D32;">
                                <i class="fas fa-angle-double-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            <% } %>
        </div>
    </div>
</div>

<%!
    // Función para Construir URL con Parámetros de Paginación
    private String construirUrlPaginacion(HttpServletRequest request, int pagina) {
        String busqueda = request.getParameter("busqueda");
        String filtroLaboratorio = request.getParameter("filtroLaboratorio");
        
        StringBuilder url = new StringBuilder("cliente.jsp?pagina=" + pagina);
        
        if (busqueda != null && !busqueda.isEmpty()) {
            url.append("&busqueda=").append(busqueda);
        }
        
        if (filtroLaboratorio != null && !filtroLaboratorio.isEmpty()) {
            url.append("&filtroLaboratorio=").append(filtroLaboratorio);
            url.append("&accion=buscarPorLaboratorio");
        }
        
        return url.toString();
    }
%>

<style>
    .table thead th {
        font-weight: 500;
        text-transform: uppercase;
        font-size: 0.85rem;
        letter-spacing: 0.5px;
    }
    
    .table tbody tr:hover {
        background-color: #81C78420;
    }
    
    .page-link {
        border: none;
        margin: 0 2px;
        border-radius: 8px !important;
    }
    
    .page-item.active .page-link {
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    
    .page-item.disabled .page-link {
        opacity: 0.5;
    }
    
    td:nth-child(4) {
        max-width: 250px;
        white-space: normal;
        word-wrap: break-word;
    }
</style>

<%@include file="/lib/footer.jsp"%>