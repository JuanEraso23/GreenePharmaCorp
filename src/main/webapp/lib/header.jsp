<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es" class="h-100">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Tailwind CSS -->
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>GreenePharmaCorp</title>
        <style>
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            .content-wrapper {
                flex: 1 0 auto;
                width: 100%;
                margin-bottom: 30px;
            }
            .navbar-nav .nav-link:hover {
                background-color: #81C784 !important;
                color: #1B5E20 !important;
                transform: translateY(-2px);
            }
            
            .navbar-nav .nav-link {
                transition: all 0.3s ease;
                font-weight: 500;
            }
            
            .brand-icon {
                transition: transform 0.3s ease;
            }
            
            .navbar-brand:hover .brand-icon {
                transform: rotate(10deg) scale(1.1);
            }
            
            .navbar {
                min-height: 80px;
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark py-3" style="background: linear-gradient(135deg, #1B5E20 0%, #2E7D32 100%); box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
            <div class="container">
                <!-- Brand / Logo (Redirige a Index) -->
                <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                    <div class="brand-icon me-2" style="background-color: #81C784; width: 40px; height: 40px; border-radius: 10px; display: flex; align-items: center; justify-content: center;">
                        <i class="fas fa-flask text-white" style="font-size: 1.2rem;"></i>
                    </div>
                    <div>
                        <span style="font-weight: 700; font-size: 1.3rem; letter-spacing: 1px;">Greene</span>
                        <span style="font-weight: 300; font-size: 1.3rem; color: #81C784;">PharmaCorp</span>
                    </div>
                </a>
                
                <!-- Toggler para Móvil -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                        style="border-color: #81C784;">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <!-- Menú de Navegación -->
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item mx-1">
                            <a class="nav-link active" href="index.jsp" 
                               style="color: white; border-radius: 8px; transition: all 0.3s; padding: 8px 16px;"
                               onmouseover="this.style.backgroundColor='#81C784'; this.style.color='#1B5E20';" 
                               onmouseout="this.style.backgroundColor='transparent'; this.style.color='white';">
                                <i class="fas fa-home me-1"></i>Inicio
                            </a>
                        </li>
                        <li class="nav-item mx-1">
                            <a class="nav-link" href="aboutUs.jsp" 
                               style="color: white; border-radius: 8px; transition: all 0.3s; padding: 8px 16px;"
                               onmouseover="this.style.backgroundColor='#81C784'; this.style.color='#1B5E20';" 
                               onmouseout="this.style.backgroundColor='transparent'; this.style.color='white';">
                                <i class="fas fa-info-circle me-1"></i>Acerca de
                            </a>
                        </li>
                        <li class="nav-item mx-1">
                            <a class="nav-link" href="contactUs.jsp" 
                               style="color: white; border-radius: 8px; transition: all 0.3s; padding: 8px 16px;"
                               onmouseover="this.style.backgroundColor='#81C784'; this.style.color='#1B5E20';" 
                               onmouseout="this.style.backgroundColor='transparent'; this.style.color='white';">
                                <i class="fas fa-envelope me-1"></i>Contacto
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <!-- CONTENIDO PRINCIPAL (WRAPPER) -->
        <div class="content-wrapper">