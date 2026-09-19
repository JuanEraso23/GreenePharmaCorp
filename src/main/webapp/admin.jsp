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
            <form action="admin.jsp" method="GET" class="d-flex">
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
            <form action="admin.jsp" method="GET" class="d-flex">
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
                            <th>Precio Compra</th>
                            <th>Precio Venta</th>
                            <th>Stock</th>
                            <th>Ubicación</th>
                            <th>Vencimiento</th>
                            <th>Receta</th>
                            <th>Opciones</th>
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
                            <td><span style="color: #2E7D32; font-weight: bold;">$<%= String.format("%,.0f", m.getPrecio()) %></span></td>
                            <td><span style="color: #2E7D32; font-weight: bold;">$<%= String.format("%,.0f", m.getPrecio_publico()) %></span></td>
                            <td>
                                <% if (m.getStock_actual() <= m.getStock_minimo()) { %>
                                    <span style="background-color: #dc3545; color: white; padding: 4px 8px; border-radius: 4px;">
                                        <%= m.getStock_actual() %> / <%= m.getStock_minimo() %>
                                    </span>
                                <% } else { %>
                                    <span style="background-color: #28a745; color: white; padding: 4px 8px; border-radius: 4px;">
                                        <%= m.getStock_actual() %>
                                    </span>
                                <% } %>
                            </td>
                            <td><%= m.getUbicacion() != null ? m.getUbicacion() : "N/A" %></td>
                            <td><%= m.getFecha_vencimiento() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(m.getFecha_vencimiento()) : "N/A" %></td>
                            <td>
                                <% if (m.isRequiere_receta()) { %>
                                    <span style="background-color: #ffc107; color: #000; padding: 4px 8px; border-radius: 4px;">Sí</span>
                                <% } else { %>
                                    <span style="background-color: #28a745; color: #fff; padding: 4px 8px; border-radius: 4px;">No</span>
                                <% } %>
                            </td>
                            <td>
                                <button class="btn btn-sm" style="background-color: #0d6efd; color: white; border: none; border-radius: 4px; padding: 4px 8px;"
                                        onclick="abrirModalMenuOpciones(<%= m.getId_med() %>, '<%= m.getNombre_comercial() %>', '<%= m.getNombre_generico() != null ? m.getNombre_generico() : "" %>', '<%= m.getPresentacion() %>', '<%= m.getConcentracion() %>', <%= m.getId_lab() %>, '<%= m.getDescripcion() != null ? m.getDescripcion().replace("'", "\\'") : "" %>', <%= m.getPrecio() %>, <%= m.getPrecio_publico() %>, <%= m.getStock_actual() %>, <%= m.getStock_minimo() %>, '<%= m.getUbicacion() != null ? m.getUbicacion() : "" %>', '<%= m.getFecha_vencimiento() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(m.getFecha_vencimiento()) : "" %>', '<%= m.getProveedor() != null ? m.getProveedor() : "" %>', <%= m.isRequiere_receta() ? 1 : 0 %>, '<%= m.getCod_barras() != null ? m.getCod_barras() : "" %>')">
                                    <i class="fas fa-cog"></i>
                                </button>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="11" class="text-center py-4">
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
            
            <!-- Botón para Agregar Nuevo Medicamento -->
            <div class="mt-3 mb-3">
                <button class="btn" style="background-color: #2E7D32; color: white; border-radius: 8px; padding: 10px 20px;"
                        data-bs-toggle="modal" data-bs-target="#modalAgregarMedicamento">
                    <i class="fas fa-plus-circle me-2"></i>Nuevo Medicamento
                </button>
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

<!-- MODAL 1: Agregar Nuevo Medicamento -->
<div class="modal fade" id="modalAgregarMedicamento" tabindex="-1" aria-labelledby="modalAgregarLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="border-radius: 15px;">
            <div class="modal-header" style="background-color: #2E7D32; color: white; border-radius: 15px 15px 0 0;">
                <h5 class="modal-title" id="modalAgregarLabel">
                    <i class="fas fa-plus-circle me-2"></i>Nuevo Medicamento
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: brightness(0) invert(1);"></button>
            </div>
            <form id="formAgregarMedicamento" action="SV_CrearMed" method="POST">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <input type="text" class="form-control" name="cod_barras" placeholder="Código de Barras" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <input type="text" class="form-control" name="nombre_comercial" placeholder="Nombre Comercial" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <input type="text" class="form-control" name="nombre_generico" placeholder="Nombre Genérico" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <select class="form-select" name="id_lab" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                                <option value="">Laboratorio</option>
                                <%
                                    List<Laboratorio> labs = g.getLaboratorios();
                                    for (Laboratorio lab : labs) {
                                %>
                                <option value="<%= lab.getId_lab() %>"><%= lab.getNombre() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <input type="text" class="form-control" name="presentacion" placeholder="Presentación" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <input type="text" class="form-control" name="concentracion" placeholder="Concentración. Ej: 500mg" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <textarea class="form-control" name="descripcion" rows="2" placeholder="Descripción" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required></textarea>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Precio de Compra</label>
                            <input type="text" class="form-control" name="precio" placeholder="0" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Precio de Venta</label>
                            <input type="text" class="form-control" name="precio_publico" placeholder="0" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Stock Actual</label>
                            <input type="number" class="form-control" name="stock_actual" value="0" min="0" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Stock Mínimo</label>
                            <input type="number" class="form-control" name="stock_minimo" value="10" min="1" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Ubicación</label>
                            <input type="text" class="form-control" name="ubicacion" placeholder="Ej: A-01" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;"required/>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Fecha de Vencimiento</label>
                            <input type="date" class="form-control" name="fecha_vencimiento" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Proveedor</label>
                            <input type="text" class="form-control" name="proveedor" placeholder="..." style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;" required/>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="requiere_receta" id="requiereReceta"/>
                            <label class="form-check-label" for="requiereReceta">
                                Receta Médica
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius: 8px; padding: 8px 20px;">
                        <i class="fas fa-times me-2"></i>Cancelar
                    </button>
                    <button type="submit" class="btn" style="background-color: #2E7D32; color: white; border-radius: 8px; padding: 8px 20px; border: none;">
                        <i class="fas fa-save me-2"></i>Continuar
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- MODAL 2: Menú de Opciones -->
<div class="modal fade" id="modalMenuOpciones" tabindex="-1" aria-labelledby="modalMenuOpcionesLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="border-radius: 15px;">
            <div class="modal-header" style="background-color: #2E7D32; color: white; border-radius: 15px 15px 0 0;">
                <h5 class="modal-title" id="modalMenuOpcionesLabel">
                    <i class="fas fa-cog me-2"></i>Menú de Opciones
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: brightness(0) invert(1);"></button>
            </div>
            <div class="modal-body">
                <!-- Pestañas de navegación -->
                <ul class="nav nav-tabs mb-3" id="opcionesTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="editar-tab" data-bs-toggle="tab" data-bs-target="#editar" type="button" role="tab" aria-controls="editar" aria-selected="true" style="color: #2E7D32;">
                            <i class="fas fa-edit me-2"></i>Editar
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="eliminar-tab" data-bs-toggle="tab" data-bs-target="#eliminar" type="button" role="tab" aria-controls="eliminar" aria-selected="false" style="color: #2E7D32;">
                            <i class="fas fa-trash-alt me-2"></i>Eliminar
                        </button>
                    </li>
                </ul>
                
                <!-- Contenido de las pestañas -->
                <div class="tab-content" id="opcionesTabContent">
                    <!-- Pestaña de Edición -->
                    <div class="tab-pane fade show active" id="editar" role="tabpanel" aria-labelledby="editar-tab">
                        <!-- Pestaña de Edición -->
                        <form id="formEditarMedicamento" action="SV_EditarMed" method="POST">
                            <input type="hidden" name="id_med" id="edit_id_med">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Código de Barras</label>
                                    <input type="text" class="form-control" name="cod_barras" id="edit_cod_barras" placeholder="Ingrese el código de barras" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Nombre Comercial</label>
                                    <input type="text" class="form-control" name="nombre_comercial" id="edit_nombre_comercial" required placeholder="Ingrese el nombre comercial" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Nombre Genérico</label>
                                    <input type="text" class="form-control" name="nombre_generico" id="edit_nombre_generico" placeholder="Ingrese el nombre genérico" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Laboratorio</label>
                                    <select class="form-select" name="id_lab" id="edit_id_lab" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                        <option value="">Seleccione un laboratorio</option>
                                        <%
                                            List<Laboratorio> labsEdit = g.getLaboratorios();
                                            for (Laboratorio lab : labsEdit) {
                                        %>
                                        <option value="<%= lab.getId_lab() %>"><%= lab.getNombre() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Presentación</label>
                                    <input type="text" class="form-control" name="presentacion" id="edit_presentacion" placeholder="Ej: Tabletas, Cápsulas" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Concentración</label>
                                    <input type="text" class="form-control" name="concentracion" id="edit_concentracion" placeholder="Ej: 500mg" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Descripción</label>
                                <textarea class="form-control" name="descripcion" id="edit_descripcion" rows="2" placeholder="Ingrese una descripción del medicamento" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;"></textarea>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Precio de Compra</label>
                                    <input type="text" class="form-control" name="precio" id="edit_precio" placeholder="0" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Precio de Venta</label>
                                    <input type="text" class="form-control" name="precio_publico" id="edit_precio_publico" placeholder="0" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Stock Actual</label>
                                    <input type="number" class="form-control" name="stock_actual" id="edit_stock_actual" min="0" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Stock Mínimo</label>
                                    <input type="number" class="form-control" name="stock_minimo" id="edit_stock_minimo" min="1" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Ubicación</label>
                                    <input type="text" class="form-control" name="ubicacion" id="edit_ubicacion" placeholder="Ej: A-01" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Fecha de Vencimiento</label>
                                    <input type="date" class="form-control" name="fecha_vencimiento" id="edit_fecha_vencimiento" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Proveedor</label>
                                    <input type="text" class="form-control" name="proveedor" id="edit_proveedor" placeholder="Ingrese el nombre del proveedor" style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 8px;">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="requiere_receta" id="edit_requiere_receta">
                                    <label class="form-check-label" for="edit_requiere_receta">
                                        Receta Médica
                                    </label>
                                </div>
                            </div>
                            
                            <div class="text-end">
                                <button type="submit" class="btn" style="background-color: #2E7D32; color: white; border-radius: 8px; padding: 8px 20px; border: none;">
                                    <i class="fas fa-save me-2"></i>Continuar
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Pestaña de Eliminación -->
                    <div class="tab-pane fade" id="eliminar" role="tabpanel" aria-labelledby="eliminar-tab">
                        <div class="text-center py-4">
                            <i class="fas fa-exclamation-triangle" style="font-size: 4rem; color: #dc3545;"></i>
                            <h4 class="mt-3" style="color: #dc3545;">¿Está seguro de eliminar este medicamento?</h4>
                            <p id="eliminar_nombre_medicamento" class="text-muted"></p>
                            <p class="text-danger"><small>Esta acción no se puede deshacer</small></p>
                            
                            <form id="formEliminarMedicamento" action="SV_EliminarMed" method="POST" class="d-inline">
                                <input type="hidden" name="id_med" id="delete_id_med">
                                <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal" style="border-radius: 8px; padding: 8px 20px;">
                                    <i class="fas fa-times me-2"></i>Cancelar
                                </button>
                                <button type="submit" class="btn" style="background-color: #dc3545; color: white; border-radius: 8px; padding: 8px 20px; border: none;">
                                    <i class="fas fa-trash-alt me-2"></i>Continuar
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Script para Alertas (window.alert) -->
<%
    String exito = request.getParameter("exito");
    String error = request.getParameter("error");
    
    if (exito != null && "creado".equals(exito)) {
%>
    <script>
        window.alert("Medicamento creado exitosamente!");
        window.location.href = "admin.jsp";
    </script>
<%
    } else if (exito != null && "editado".equals(exito)) {
%>
    <script>
        window.alert("Medicamento editado exitosamente!");
        window.location.href = "admin.jsp";
    </script>
<%
    } else if (exito != null && "eliminado".equals(exito)) {
%>
    <script>
        window.alert("Medicamento eliminado exitosamente!");
        window.location.href = "admin.jsp";
    </script>
<%
    } else if (error != null && "creacion".equals(error)) {
%>
    <script>
        window.alert("Error al crear el medicamento. Verifique los datos.");
        window.location.href = "admin.jsp";
    </script>
<%
    } else if (error != null && "edicion".equals(error)) {
%>
    <script>
        window.alert("Error al editar el medicamento. Verifique los datos.");
        window.location.href = "admin.jsp";
    </script>
<%
    } else if (error != null && "eliminacion".equals(error)) {
%>
    <script>
        window.alert("Error al eliminar el medicamento.");
        window.location.href = "admin.jsp";
    </script>
<%
    }
%>

<script>
    function abrirModalMenuOpciones(id, nombreComercial, nombreGenerico, presentacion, concentracion, idLab, descripcion, precio, precioPublico, stockActual, stockMinimo, ubicacion, fechaVencimiento, proveedor, requiereReceta, codBarras) {
        // Llenar el formulario de edición
        document.getElementById('edit_id_med').value = id;
        document.getElementById('edit_cod_barras').value = codBarras || '';
        document.getElementById('edit_nombre_comercial').value = nombreComercial || '';
        document.getElementById('edit_nombre_generico').value = nombreGenerico || '';
        document.getElementById('edit_presentacion').value = presentacion || '';
        document.getElementById('edit_concentracion').value = concentracion || '';
        document.getElementById('edit_id_lab').value = idLab;
        document.getElementById('edit_descripcion').value = descripcion || '';
        document.getElementById('edit_precio').value = precio || 0;
        document.getElementById('edit_precio_publico').value = precioPublico || 0;
        document.getElementById('edit_stock_actual').value = stockActual || 0;
        document.getElementById('edit_stock_minimo').value = stockMinimo || 10;
        document.getElementById('edit_ubicacion').value = ubicacion || '';
        document.getElementById('edit_fecha_vencimiento').value = fechaVencimiento || '';
        document.getElementById('edit_proveedor').value = proveedor || '';
        document.getElementById('edit_requiere_receta').checked = requiereReceta === 1;
        
        // Llenar la información de eliminación
        document.getElementById('delete_id_med').value = id;
        document.getElementById('eliminar_nombre_medicamento').innerHTML = '<strong>' + nombreComercial + '</strong>';
        
        // Abrir el modal
        new bootstrap.Modal(document.getElementById('modalMenuOpciones')).show();
    }
</script>

<%!
    // Función para Construir URL con Parámetros de Paginación
    private String construirUrlPaginacion(HttpServletRequest request, int pagina) {
        String busqueda = request.getParameter("busqueda");
        String filtroLaboratorio = request.getParameter("filtroLaboratorio");
        
        StringBuilder url = new StringBuilder("admin.jsp?pagina=" + pagina);
        
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
        white-space: nowrap;
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
    
    .btn-sm {
        font-size: 0.85rem;
        padding: 0.25rem 0.5rem;
    }
    
    .modal-content {
        border: none;
    }
    
    .modal-header {
        border-bottom: none;
    }
    
    .modal-footer {
        border-top: none;
    }
    
    .nav-tabs .nav-link {
        border: none;
        color: #666;
        font-weight: 500;
    }
    
    .nav-tabs .nav-link:hover {
        border: none;
        color: #2E7D32;
        background-color: transparent;
    }
    
    .nav-tabs .nav-link.active {
        border: none;
        border-bottom: 3px solid #2E7D32;
        color: #2E7D32;
        background-color: transparent;
    }
    
    .form-label {
        font-weight: 500;
        color: #555;
        margin-bottom: 0.25rem;
        font-size: 0.9rem;
    }
    
    input[type=number]::-webkit-inner-spin-button, 
    input[type=number]::-webkit-outer-spin-button { 
        opacity: 0.5;
    }
    
    input[type=number] {
        -moz-appearance: textfield;
    }
</style>

<%@include file="/lib/footer.jsp"%>