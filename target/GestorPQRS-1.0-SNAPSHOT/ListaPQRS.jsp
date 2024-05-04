<%-- 
    Document   : ListaPQRS
    Created on : 2/05/2024, 11:58:19 a. m.
    Author     : Hugo
--%>
<%-- 
    Document   : ListaPQRS
    Created on : 2/05/2024, 11:58:19 a. m.
    Author     : Hugo
--%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<%@page import="com.mycompany.tutorial.PQRS"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.tutorial.ConexionBaseDeDatos"%>
<%@page import="java.util.List"%>
<%
    // Verificar si hay una sesión activa y si el usuario es el administrador
    HttpSession misession = request.getSession(false);
    if (misession == null || !"admin".equals((String)misession.getAttribute("username"))) {
        // Si no hay sesión activa o si el usuario no es el administrador, redirigir a index.jsp
        response.sendRedirect("index.jsp");
        return; // Terminar la ejecución de la página actual
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <jsp:include page="navar_Administrador.jsp" />
    <meta charset="UTF-8">
    <title>Listado de PQRS</title>
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
            background-color: #fff;
        }
        th, td {
            padding: 12px;
            text-align: left;
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
</head>
<body>
    <div class="container">
        <h1>Listado de PQRS</h1>
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
                    </tr>
                </thead>
                <tbody>
                    <% 
                    ConexionBaseDeDatos controlador = new ConexionBaseDeDatos();
                    List<PQRS> listaPQRS = controlador.obtenerPQRS();
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
</body>
</html>

