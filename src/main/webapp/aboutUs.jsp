<%@include file="/lib/header.jsp"%>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <!-- Título principal -->
            <div class="text-center mb-5">
                <h1 class="fw-bold" style="color: #2E7D32;">
                    <i class="fas fa-leaf me-2"></i>Greene PharmaCorp
                </h1>
                <p class="lead text-muted">"Comprometidos con tu salud, conectando vidas"</p>
            </div>
            
            <!-- Descripción del negocio -->
            <div class="card shadow-lg border-0 mb-4" style="border-radius: 15px;">
                <div class="card-body p-5">
                    <h3 class="mb-4" style="color: #2E7D32;">
                        <i class="fas fa-store me-2"></i>¿Quiénes somos?
                    </h3>
                    <p class="text-justify" style="font-size: 1.1rem; line-height: 1.6;">
                        Greene PharmaCorp nace como una iniciativa académica dentro del programa de Ingeniería de Sistemas 
                        de la Universidad Mariana. Esta plataforma fue desarrollada como un proyecto de aprendizaje para 
                        demostrar la integración de tecnologías web como Java EE, MySQL, Bootstrap y Tailwind CSS en un 
                        sistema de gestión farmacéutica funcional.
                    </p>
                    <p class="text-justify mt-3" style="font-size: 1.1rem; line-height: 1.6;">
                        El nombre "Greene PharmaCorp" es un homenaje al universo de Criminal Case, un juego que inspiró 
                        la estética y la identidad visual del proyecto. La farmacia virtual permite a los pacientes consultar 
                        medicamentos disponibles y al personal administrativo gestionar el inventario, simular ventas y 
                        mantener actualizada la información de los productos.
                    </p>
                </div>
            </div>
            
            <!-- Misión -->
            <div class="card shadow-lg border-0 mb-4" style="border-radius: 15px;">
                <div class="card-body p-5">
                    <h3 class="mb-4" style="color: #2E7D32;">
                        <i class="fas fa-bullseye me-2"></i>Misión
                    </h3>
                    <p class="text-justify" style="font-size: 1.1rem; line-height: 1.6;">
                        Proveer una plataforma tecnológica eficiente y confiable que permita a los usuarios acceder a 
                        información precisa sobre medicamentos, facilitando el proceso de consulta y gestión farmacéutica, 
                        mientras se promueve el aprendizaje y la innovación en el desarrollo de software.
                    </p>
                </div>
            </div>
            
            <!-- Visión -->
            <div class="card shadow-lg border-0 mb-4" style="border-radius: 15px;">
                <div class="card-body p-5">
                    <h3 class="mb-4" style="color: #2E7D32;">
                        <i class="fas fa-eye me-2"></i>Visión
                    </h3>
                    <p class="text-justify" style="font-size: 1.1rem; line-height: 1.6;">
                        Convertirnos en un referente académico en el desarrollo de sistemas de gestión farmacéutica, 
                        demostrando que las herramientas modernas de programación pueden aplicarse para resolver 
                        necesidades reales y mejorar la calidad de vida de las personas.
                    </p>
                </div>
            </div>
            
            <!-- Lema -->
            <div class="card shadow-lg border-0 mb-4" style="background: linear-gradient(135deg, #1B5E20 0%, #2E7D32 100%); color: white; border-radius: 15px;">
                <div class="card-body p-5 text-center">
                    <i class="fas fa-quote-left" style="font-size: 2.5rem; opacity: 0.7; margin-bottom: 1rem;"></i>
                    <h3 class="mb-0 fst-italic" style="font-weight: 400;">"Cuidamos tu salud con tecnología, compromiso y corazón verde"</h3>
                    <i class="fas fa-quote-right" style="font-size: 2.5rem; opacity: 0.7; margin-top: 1rem;"></i>
                </div>
            </div>
            
            <!-- Razón de creación -->
            <div class="card shadow-lg border-0" style="border-radius: 15px;">
                <div class="card-body p-5">
                    <h3 class="mb-4" style="color: #2E7D32;">
                        <i class="fas fa-graduation-cap me-2"></i>¿Por qué este proyecto?
                    </h3>
                    <p class="text-justify" style="font-size: 1.1rem; line-height: 1.6;">
                        Este proyecto nace como parte del proceso de formación en el programa de Ingeniería de Sistemas 
                        de la Universidad Mariana. La idea principal era construir una aplicación web completa que integrara 
                        conceptos fundamentales como:
                    </p>
                    <ul class="mt-3" style="font-size: 1rem; line-height: 1.8;">
                        <li><i class="fas fa-database me-2" style="color: #2E7D32;"></i>Conexión y gestión de bases de datos MySQL</li>
                        <li><i class="fas fa-code me-2" style="color: #2E7D32;"></i>Desarrollo de interfaces dinámicas con JSP, Bootstrap y Tailwind CSS</li>
                        <li><i class="fas fa-users me-2" style="color: #2E7D32;"></i>Control de acceso diferenciado para clientes y personal administrativo</li>
                        <li><i class="fas fa-pills me-2" style="color: #2E7D32;"></i>Operaciones CRUD (Crear, Leer, Actualizar, Eliminar) sobre medicamentos</li>
                        <li><i class="fas fa-chart-line me-2" style="color: #2E7D32;"></i>Paginación y búsqueda avanzada de información</li>
                    </ul>
                    <p class="text-justify mt-3" style="font-size: 1.1rem; line-height: 1.6;">
                        A través de Greene PharmaCorp, se busca demostrar cómo las tecnologías web modernas pueden aplicarse 
                        para construir soluciones útiles, funcionales y escalables, sentando las bases para futuros desarrollos 
                        más complejos.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .text-justify {
        text-align: justify;
    }
    
    .card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
    }
</style>

<%@include file="/lib/footer.jsp"%>