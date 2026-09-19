<%@include file="/lib/header.jsp"%>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Título principal -->
            <div class="text-center mb-5">
                <h1 class="fw-bold" style="color: #2E7D32;">
                    <i class="fas fa-envelope me-2"></i>Contacto
                </h1>
                <p class="lead text-muted">¿Tienes preguntas? Escríbenos</p>
            </div>
            
            <!-- Información de contacto -->
            <div class="card shadow-lg border-0 mb-4" style="border-radius: 15px;">
                <div class="card-body p-5">
                    <h3 class="mb-4" style="color: #2E7D32;">
                        <i class="fas fa-university me-2"></i>Universidad Mariana
                    </h3>
                    <p class="mb-3" style="font-size: 1.05rem;">
                        <i class="fas fa-map-marker-alt me-2" style="color: #2E7D32; width: 25px;"></i>
                        <strong>Dirección:</strong> Calle 18 # 34-104. San Juan de Pasto, Nariño, Colombia
                    </p>
                    <p class="mb-3" style="font-size: 1.05rem;">
                        <i class="fas fa-phone me-2" style="color: #2E7D32; width: 25px;"></i>
                        <strong>Teléfono:</strong> +57 (602) 7244460
                    </p>
                    <p class="mb-3" style="font-size: 1.05rem;">
                        <i class="fas fa-globe me-2" style="color: #2E7D32; width: 25px;"></i>
                        <strong>Sitio web:</strong> <a href="https://www.umariana.edu.co" target="_blank" style="color: #2E7D32; text-decoration: none;">www.umariana.edu.co</a>
                    </p>
                    <p class="mb-3" style="font-size: 1.05rem;">
                        <i class="fas fa-clock me-2" style="color: #2E7D32; width: 25px;"></i>
                        <strong>Horario de atención:</strong> Lunes a Viernes - 8:00 AM a 12:00 PM/2:00 PM a 6:00 PM
                    </p>
                </div>
            </div>
            
            <!-- Información del Desarrollador -->
            <div class="card shadow-lg border-0 mb-4" style="border-radius: 15px;">
                <div class="card-body p-5">
                    <h3 class="mb-4" style="color: #2E7D32;">
                        <i class="fas fa-user-graduate me-2"></i>Desarrollador
                    </h3>
                    <div class="text-center mb-4">
                        <div style="width: 100px; height: 100px; background-color: #81C784; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; margin-bottom: 15px;">
                            <i class="fas fa-code" style="font-size: 3rem; color: #1B5E20;"></i>
                        </div>
                        <h4 class="fw-bold" style="color: #2E7D32;">Juan Manuel Eraso Grijalba</h4>
                        <p class="text-muted">Estudiante de Ingeniería de Sistemas</p>
                    </div>
                    <p class="mb-3" style="font-size: 1.05rem;">
                        <i class="fas fa-envelope me-2" style="color: #2E7D32; width: 25px;"></i>
                        <strong>Correo institucional:</strong> <a href="mailto:juerasog@umariana.edu.co" style="color: #2E7D32; text-decoration: none;">jmeraso222@umariana.edu.co</a>
                    </p>
                    <p class="mb-3" style="font-size: 1.05rem;">
                        <i class="fab fa-github me-2" style="color: #2E7D32; width: 25px;"></i>
                        <strong>GitHub:</strong> <a href="#" style="color: #2E7D32; text-decoration: none;">github.com/JuanEraso23</a>
                    </p>
                    <p class="mb-0" style="font-size: 1.05rem;">
                        <i class="fab fa-linkedin me-2" style="color: #2E7D32; width: 25px;"></i>
                        <strong>LinkedIn:</strong> <a href="#" style="color: #2E7D32; text-decoration: none;">linkedin.com/in/juan-eraso</a>
                    </p>
                </div>
            </div>
            
            <!-- Mapa de Ubicación -->
            <div class="card shadow-lg border-0" style="border-radius: 15px;">
                <div class="card-body p-5">
                    <h3 class="mb-4" style="color: #2E7D32;">
                        <i class="fas fa-map-marked-alt me-2"></i>Ubicación
                    </h3>
                    <div class="ratio ratio-16x9">
                        <iframe 
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3987.549117530754!2d-77.2791251111459!3d1.2145984626089106!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e2ee101ed13987f%3A0x1f6a1c04f4cced0c!2sUniversidad%20Mariana!5e0!3m2!1ses!2sco!4v1742000000000!5m2!1ses!2sco" 
                            style="border:0; border-radius: 10px;" 
                            allowfullscreen="" 
                            loading="lazy" 
                            referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
    }
    
    a:hover {
        text-decoration: underline;
    }
    
    .ratio {
        border-radius: 10px;
        overflow: hidden;
    }
</style>

<%@include file="/lib/footer.jsp"%>