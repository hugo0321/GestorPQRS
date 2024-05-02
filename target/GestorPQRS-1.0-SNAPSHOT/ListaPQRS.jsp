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

<!DOCTYPE html>
<html lang="es">
<head>
    
    <meta charset="UTF-8">
    <title>Listado de Tutoriales</title>
    
</head>
<body>
    <div class="container">
        <h1>Listado de PQRS</h1>
        <h2>Esta es la lista de todas las PQRS:</h2>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Primer Nombre</th>
                    <th scope="col">Segundo Nombre</th>
                    <th scope="col">Primer Apellido</th>
                    <th scope="col">Segundo Apellido</th>
                    <th scope="col">Motivo</th>
                    <th scope="col">Email</th>
                    <th scope="col">Teléfono</th>
                    <th scope="col">Mensaje</th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <% 
                ConexionBaseDeDatos controlador = new ConexionBaseDeDatos();
                List<PQRS> listaPQRS = controlador.obtenerPQRS();
                if (listaPQRS != null && !listaPQRS.isEmpty()) {
                    for (PQRS pqrs : listaPQRS) {
                %>
                <tr>
                    <th scope="row"><%= pqrs.getId() %></th>
                    <td><%= pqrs.getPrimerNombre()%></td>
                    <td><%= pqrs.getSegundoNombre() %></td>
                    <td><%= pqrs.getPrimerApellido() %></td>
                    <td><%= pqrs.getSegundoApellido() %></td>
                    <td><%= pqrs.getMotivo() %></td>
                    <td><%= pqrs.getEmail() %></td>
                    <td><%= pqrs.getTelefono() %></td>
                    <td><%= pqrs.getMensaje() %></td>
                </tr>
                <% 
                    }
                } else {
                %>
                <tr>
                    <td colspan="9">No hay PQRS disponibles.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
