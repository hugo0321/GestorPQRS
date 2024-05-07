<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navbar</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
   <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <style>
        .navbar {
            background-color: #343a40; /* Cambia el color de fondo del navbar */
        }

        .navbar-brand {
            color: #ffffff; /* Cambia el color del texto de la marca del navbar */
            font-size: 1.5rem; /* Cambia el tamaño del texto de la marca del navbar */
        }

        .navbar-nav .nav-link {
            color: #ffffff; /* Cambia el color del texto de los enlaces del navbar */
            font-size: 1rem; /* Cambia el tamaño del texto de los enlaces del navbar */
            margin-left: 20px; /* Añade un margen izquierdo entre los enlaces del navbar */
        }

        .navbar-nav .nav-link:hover {
            color: #ffffff; /* Cambia el color del texto de los enlaces del navbar al pasar el mouse sobre ellos */
        }

        .dropdown-menu {
            background-color: #343a40; /* Cambia el color de fondo del menú desplegable */
        }

        .dropdown-menu .dropdown-item {
            color: #ffffff; /* Cambia el color del texto de los elementos del menú desplegable */
            font-size: 1rem; /* Cambia el tamaño del texto de los elementos del menú desplegable */
        }

        .dropdown-menu .dropdown-item:hover {
            background-color: #007bff; /* Cambia el color de fondo de los elementos del menú desplegable al pasar el mouse sobre ellos */
            color: #ffffff; /* Cambia el color del texto de los elementos del menú desplegable al pasar el mouse sobre ellos */
        }

        .btn-outline-danger {
            color: #dc3545; /* Cambia el color del borde del botón */
            border-color: #dc3545; /* Cambia el color del borde del botón */
        }

        .btn-outline-danger:hover {
            color: #ffffff; /* Cambia el color del texto del botón al pasar el mouse sobre él */
            background-color: #dc3545; /* Cambia el color de fondo del botón al pasar el mouse sobre él */
            border-color: #dc3545; /* Cambia el color del borde del botón al pasar el mouse sobre él */
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#page-top">Constructora</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="indexEntrada.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="indexEntrada.jsp#services">Servicios</a></li>
                    <li class="nav-item"><a class="nav-link" href="indexEntrada.jsp#portfolio">Portfolio</a></li>
                    <li class="nav-item"><a class="nav-link" href="indexEntrada.jsp#contact">PQRS</a></li>
                    <li class="nav-item"><a class="nav-link" href="ListadoPQRSUsuario.jsp">Sigue tus PQRS</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <% HttpSession laSesion = request.getSession(false);
                                if (laSesion != null && laSesion.getAttribute("username") != null) {
                                    String username = (String) laSesion.getAttribute("username");
                            %>
                            Bienvenido, <%= username%>!
                            <% } else { %>
                            No se ha iniciado sesión
                            <% } %>
                        </a>
                         <li class="nav-item"><a class="nav-link" href="svCerrarSesionUsuario">Cerrar sesión</a></li>
                            
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap JS (debe estar al final del cuerpo) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>