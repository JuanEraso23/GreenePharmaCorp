<%@include file="/lib/header.jsp"%>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-lg border-0" style="border-radius: 15px;">
                <div class="card-body p-5">
                    
                    <!-- Título del Formulario -->
                    <div class="text-center mb-4">
                        <h1 class="fw-bold" style="color: #2E7D32; font-size: 2.5rem;">Sistema de Gestión Farmacéutica</h1>
                        <p style="color: #81C784; font-size: 1rem; letter-spacing: 1px;">FORMULARIO DE CONSULTA</p>
                    </div>
                    
                    <!-- FORMULARIO: Identificación del Usuario -->
                    <form id="formIdentificacionUsuario" action="SV_ValidarUsuario" method="POST">
                        <div class="row mb-3">
                            <div class="col-md-5">
                                <select class="form-select" id="doc" name="doc" required style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 12px; width: 100%;">
                                    <option value="" disabled selected>Tipo de Documento</option>
                                    <option value="TI">Tarjeta de Identidad</option>
                                    <option value="CC">Cédula de Ciudadanía</option>
                                    <option value="CE">Cédula de Extranjería</option>
                                    <option value="pasaporte">Pasaporte</option>
                                </select>
                            </div>
                            <div class="col-md-7">
                                <input type="text" class="form-control" id="tipo_doc" name="tipo_doc" 
                                       placeholder="Número de Documento" required style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 12px;">
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <input type="text" class="form-control" id="nombre" name="nombre" 
                                       placeholder="Nombres" required style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 12px;">
                            </div>
                            <div class="col-md-6">
                                <input type="text" class="form-control" id="apellido" name="apellido" 
                                       placeholder="Apellidos" required style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 12px;">
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <select class="form-select" id="tipo_usuario" name="tipo_usuario" required style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 12px;">
                                <option value="" disabled selected>Tipo de Rol</option>
                                <option value="cliente">Cliente/Paciente</option>
                                <option value="personal">Personal</option>
                            </select>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-lg" style="background-color: #2E7D32; color: white; border: none; border-radius: 8px; padding: 12px; font-weight: 600;">
                                <i class="fas fa-arrow-right me-2"></i>Continuar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- MODAL: Verificación (Personal) -->
<div class="modal fade" id="modalVerificacionPersonal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="border-radius: 15px;">
            <div class="modal-header" style="background-color: #2E7D32; color: white; border-radius: 15px 15px 0 0;">
                <h5 class="modal-title">
                    <i class="fas fa-shield-alt me-2"></i>Verificación de Personal
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" style="filter: brightness(0) invert(1);"></button>
            </div>
            
            <form id="formVerificacionPersonal" action="SV_ValidarPersonal" method="POST">
                <div class="modal-body">
                    <!-- Campos ocultos -->
                    <input type="hidden" id="modalDoc" name="doc">
                    <input type="hidden" id="modalTipo_doc" name="tipo_doc">
                    <input type="hidden" id="modalNombre" name="nombre">
                    <input type="hidden" id="modalApellido" name="apellido">
                    
                    <!-- Campo para el cargo -->
                    <div class="mb-3">
                        <select class="form-select" id="modalCargo" name="cargo" required 
                                style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 12px;">
                            <option value="" disabled selected>Cargo</option>
                            <option value="Administrador">Administrador</option>
                            <option value="Farmaceutico Jefe">Farmacéutico Jefe</option>
                            <option value="Farmaceutico">Farmacéutico</option>
                            <option value="Asistente">Asistente</option>
                        </select>
                    </div>
                    
                    <!-- Campo para el código de verificación -->
                    <div class="mb-3">
                        <input type="password" class="form-control" id="modalCod" name="cod" 
                               placeholder="Código de Verificación" required 
                               style="border: 2px solid #e0e0e0; border-radius: 8px; padding: 12px;">
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" 
                            style="border-radius: 8px; padding: 8px 20px;">
                        <i class="fas fa-times me-2"></i>Cancelar
                    </button>
                    <button type="submit" class="btn" 
                            style="background-color: #2E7D32; color: white; border-radius: 8px; padding: 8px 20px; border: none;">
                        <i class="fas fa-check-circle me-2"></i>Verificar Acceso
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Función para obtener parámetros de la URL
        function getUrlParameter(name) {
            name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
            var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
            var results = regex.exec(location.search);
            return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
        }
        
        // Verificar si debe abrir el modal automáticamente
        if (getUrlParameter('personal') === 'true') {
            // Llenar los campos ocultos con los datos de la sesión (si es necesario)
            // Esto se puede hacer vía AJAX o simplemente confiar en la sesión del servlet
            
            $('#modalVerificacionPersonal').modal('show');
            
            // Limpiar el parámetro de la URL
            if (history.pushState) {
                var newUrl = window.location.protocol + "//" + 
                            window.location.host + 
                            window.location.pathname;
                window.history.pushState({path: newUrl}, '', newUrl);
            }
        }
        
        // Verificar errores
        var error = getUrlParameter('error');
        if (error === 'verificacion') {
            alert('¡Código de verificación o cargo incorrecto!');
        } else if (error === 'credenciales') {
            alert('¡Usuario no encontrado o credenciales incorrectas!');
        }
        
        // Validación del formulario del modal
        $('#formVerificacionPersonal').on('submit', function(e) {
            var cargo = $('#modalCargo').val();
            var cod = $('#modalCod').val().trim();
            
            if (cargo === '' || cargo === null) {
                e.preventDefault();
                alert('Por favor seleccione un cargo');
                return false;
            }
            
            if (cod === '') {
                e.preventDefault();
                alert('Por favor ingrese el código de verificación');
                return false;
            }
            
            return true;
        });
        
        // Efectos hover
        $('.form-control, .form-select').hover(
            function() { $(this).css('border-color', '#81C784'); },
            function() { $(this).css('border-color', '#e0e0e0'); }
        );
        
        $('button[type="submit"]').hover(
            function() { $(this).css('background-color', '#1B5E20'); },
            function() { $(this).css('background-color', '#2E7D32'); }
        );
        
        // Efecto focus en los campos
        $('.form-control, .form-select').focus(function() {
            $(this).css('border-color', '#2E7D32').css('box-shadow', '0 0 0 0.2rem rgba(46, 125, 50, 0.25)');
        }).blur(function() {
            $(this).css('border-color', '#e0e0e0').css('box-shadow', 'none');
        });
    });
</script>

<style>
    .card {
        border-radius: 15px;
        transition: transform 0.3s;
    }
    
    .card:hover {
        transform: translateY(-5px);
    }
    
    .form-control:focus, .form-select:focus {
        border-color: #2E7D32 !important;
        box-shadow: 0 0 0 0.2rem rgba(46, 125, 50, 0.25) !important;
    }
    
    .btn {
        transition: all 0.3s;
    }
    
    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    }
    
    .modal-content {
        border: none;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    }
    
    .modal-header {
        border-bottom: none;
        padding: 1.5rem;
    }
    
    .modal-body {
        padding: 1.5rem;
    }
    
    .modal-footer {
        border-top: none;
        padding: 1.5rem;
    }
    
    .form-label {
        font-size: 0.95rem;
        margin-bottom: 0.5rem;
    }
    
    .form-text {
        font-size: 0.85rem;
    }
    
    select option:hover {
        background-color: #81C784 !important;
    }
    
    #doc {
        width: 100%;
        white-space: normal;
        overflow: visible;
        text-overflow: clip;
    }
    
    #doc option {
        white-space: normal;
        padding: 8px;
    }
</style>

<%@include file="/lib/footer.jsp"%>