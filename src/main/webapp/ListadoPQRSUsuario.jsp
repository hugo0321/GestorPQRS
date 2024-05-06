<%-- 
    Document   : index
    Created on : 1/05/2024, 9:23:45 p. m.
    Author     : Hugo
--%>

<%@page import="com.mycompany.tutorial.ControladorUsuarios"%>
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
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    

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
    /* Estilos para la tabla */
      table {
        width: 100%;
        background-color: #000; /* Cambia el color de fondo de la tabla a negro */
        color: #fff; /* Cambia el color del texto en la tabla a blanco */
    }
    th, td {
        padding: 12px;
        text-align: left;
        color: #fff
    }
    th {
        background-color: #007bff; /* Color de fondo para las celdas de encabezado */
    }
    tr:nth-child(even) {
        background-color: #111; /* Cambia el color de fondo para las filas pares */
    }
    tr:nth-child(odd) {
        background-color: #222; /* Cambia el color de fondo para las filas impares */
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
                <li class="nav-item"><a class="nav-link" href="indexEntrada.jsp#services">Servicios</a></li>
                <li class="nav-item"><a class="nav-link" href="indexEntrada.jsp#portfolio">Portfolio</a></li>
                <li class="nav-item"><a class="nav-link" href="indexEntrada.jsp#contact">PQRS</a></li>
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
                    usuarioId = ControladorUsuarios.obtenerIdUsuario(nombreUsuario);
                } catch (SQLException e) {
                    // Manejar la excepción aquí
                    e.printStackTrace();
                    // Redirigir a una página de error
                    response.sendRedirect("ErrorRegistroPQRS.jsp");
                    return; // Terminar la ejecución de la página actual
                }

                ControladorUsuarios controlador = new ControladorUsuarios();
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
                   <td>
    <% if (pqrs.getMensaje() != null) { %>
        <%= pqrs.getMensaje().length() > 50 ? pqrs.getMensaje().substring(0, 50) + "..." : pqrs.getMensaje() %>
        <button class="btn btn-info btn-sm btn-ver-mensaje" data-mensaje="<%= pqrs.getMensaje() %>">Ver mensaje completo</button>
    <% } %>
</td> <!-- Mostrar solo los primeros 50 caracteres del mensaje si no es null -->

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

<!-- Modal para mostrar el mensaje completo -->
<div class="modal fade" id="mensajeCompletoModal" tabindex="-1" role="dialog" aria-labelledby="mensajeCompletoModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="mensajeCompletoModalLabel">Mensaje Completo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="mensajeCompletoModalContent"></p>
            </div>
        </div>
    </div>
</div>


<!-- Footer-->
<footer class="bg-light py-5">
    <div class="container px-4 px-lg-5"><div class="small text-center text-muted">Copyright &copy; 2024 - Company HL</div></div>
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
<script>
    $('.btn-ver-mensaje').on('click', function() {
        var mensajeCompleto = $(this).data('mensaje');
        $('#mensajeCompletoModalContent').text(mensajeCompleto);
        $('#mensajeCompletoModal').modal('show');
    });
</script>
</body>
</html>
