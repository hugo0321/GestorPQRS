<%-- 
    Document   : index
    Created on : 1/05/2024, 9:23:45 p. m.
    Author     : Hugo
--%>

<%@page import="java.util.List"%>
<%@page import="com.mycompany.tutorial.PQRS"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.tutorial.ConexionBaseDeDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession miSesion = request.getSession(false);
    if (miSesion == null || miSesion.getAttribute("username") == null) {
        // Si no hay sesión o el nombre de usuario no está presente en la sesión, redirigir al formulario de inicio de sesión
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #495057;
        }
        .container {
            margin-top: 50px;
        }
        h1 {
            color: #007bff;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            background-color: #000;
        }
        th, td {
            padding: 12px;
            text-align: left;
            color: #fff; /* Cambio de color del texto a blanco */
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .no-data {
            font-style: italic;
        }
    </style>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Creative - Constructora </title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap Icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
    <!-- SimpleLightbox plugin CSS-->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="css/styles.css" rel="stylesheet" />
    <!-- Custom Navbar CSS -->
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
    </style>
</head>
<body id="page-top">
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#page-top">Constructora</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="indexEntrada.jsp">Inicio</a></li>
                <li class="nav-item"><a class="nav-link" href="#services">Servicios</a></li>
                <li class="nav-item"><a class="nav-link" href="#portfolio">Portfolio</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">PQRS</a></li>
                <li class="nav-item"><a class="nav-link" href="ListadoPQRSUsuario.jsp">Sigue tus PQRS</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <% 
                            HttpSession laSesion = request.getSession(false);
                            if (laSesion != null && laSesion.getAttribute("username") != null) {
                                String username = (String) laSesion.getAttribute("username");
                        %>
                            Bienvenido, <%= username %>!
                        <% } else { %>
                            No se ha iniciado sesión
                        <% } %>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="svCerrarSesionUsuario">Cerrar sesión</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>


 <div class="container" style="margin-top: 180px;">
    <% // Obtener el nombre de usuario de la sesión
        String nombreUsuario1 = (String) miSesion.getAttribute("username");
    %>
    <h1 style="color: #000;">Estas son las PQRS de <%= nombreUsuario1 %></h1>
    <!-- Resto del contenido de la página -->
</div>


    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>#</th>
                <th>Primer Nombre</th>
                <th>Segundo Nombre</th>
                <th>Primer Apellido</th>
                <th>Segundo Apellido</th>
                <th>Motivo</th>
                <th>Email</th>
                <th>Teléfono</th>
                <th>Mensaje</th>
                <th>Fecha/Hora</th>
                 <th>Estado</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Verificar si hay una sesión activa y si el usuario es el administrador
                HttpSession lsession = request.getSession(false); // Se establece como false para evitar que se cree una nueva sesión si no existe
                if (lsession == null) {
                    // Si no hay sesión activa, redirigir a index.jsp
                    response.sendRedirect("index.jsp");
                    return; // Terminar la ejecución de la página actual
                }

                int usuarioId = 0; // Inicializamos el usuarioId
                String nombreUsuario = (String) lsession.getAttribute("username");
                try {
                    usuarioId = ConexionBaseDeDatos.obtenerIdUsuario(nombreUsuario);
                } catch (SQLException e) {
                    // Manejar la excepción aquí
                    e.printStackTrace();
                    // Redirigir a una página de error
                    response.sendRedirect("ErrorRegistroPQRS.jsp");
                    return; // Terminar la ejecución de la página actual
                }

                ConexionBaseDeDatos controlador = new ConexionBaseDeDatos();
                List<PQRS> listaPQRS = null;

                try {
                    listaPQRS = controlador.obtenerPQRSUsuario(usuarioId);
                } catch (SQLException e) {
                    // Manejar la excepción aquí
                    e.printStackTrace();
                    // Puedes redirigir a una página de error o mostrar un mensaje al usuario
                }

                if (listaPQRS != null && !listaPQRS.isEmpty()) {
                    for (PQRS pqrs : listaPQRS) {
            %>
                <tr>
                    <td><%= pqrs.getId() %></td>
                    <td><%= pqrs.getPrimerNombre()%></td>
                    <td><%= pqrs.getSegundoNombre() %></td>
                    <td><%= pqrs.getPrimerApellido() %></td>
                    <td><%= pqrs.getSegundoApellido() %></td>
                    <td><%= pqrs.getMotivo() %></td>
                    <td><%= pqrs.getEmail() %></td>
                    <td><%= pqrs.getTelefono() %></td>
                    <td><%= pqrs.getMensaje() %></td>
                    <td><%= pqrs.getHoraSolicitud() %></td>
                    <td><%= pqrs.getEstado() %></td>
                </tr>
            <% 
                }
            } else {
            %>
                <tr>
                    <td colspan="10" class="no-data">No hay PQRS disponibles.</td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Footer-->
<footer class="bg-light py-5">
    <div class="container px-4 px-lg-5"><div class="small text-center text-muted">Copyright &copy; 2023 - Company Name</div></div>
</footer>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- SimpleLightbox plugin JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
<!-- * *                               SB Forms JS                               * *-->
<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>
