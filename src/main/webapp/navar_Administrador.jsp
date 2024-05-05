<%-- 
    Document   : navar_Administrador
    Created on : 2/05/2024, 8:03:53 p. m.
    Author     : Hugo
--%>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navbar</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <!-- Custom CSS -->
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
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Navbar</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">
                    <!-- Enlace para "Inicio" con ventana emergente -->
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="ListaPQRS.jsp" ">Todas las PQRS</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ListaUsuarios.jsp">Usuarios</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Pricing</a>
                    </li>
                </ul>
                
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <form action="CerrarSesionServlet" method="post">
                            <button type="submit" class="btn btn-outline-danger">Cerrar sesión</button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

</body>
</html>
