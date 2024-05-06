<%-- 
    Document   : navarUsuario
    Created on : 4/05/2024, 7:18:31 p. m.
    Author     : Hugo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Navbar</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Constructora</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown">
                    <ul class="navbar-nav">
                        <!-- Enlace para "Inicio" con ventana emergente -->
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#" onclick="showPopup(event)">Inicio</a>

                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Features</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Pricing</a>
                        </li>
                    </ul>

                    <!-- Dropdown para el usuario -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="indexEntrada.jsp" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <%
                                // Obtener la sesión
                                HttpSession laSesion = request.getSession(false);
                                if (laSesion != null && laSesion.getAttribute("username") != null) {
                                    // Obtener el nombre de usuario de la sesión
                                    String username = (String) laSesion.getAttribute("username");
                            %>
                            Bienvenido, <%= username%>!
                            <% } else { %>
                            No se ha iniciado sesión
                            <% }%>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <!-- Formulario para solicitar contraseña -->


                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="svCerrarSesionUsuario ">Cerrar sesión</a></li>
                        </ul>
                    </li>
                    <!-- Fin del Dropdown -->
                </div>
            </div>
        </nav>


    </body>
</html>

