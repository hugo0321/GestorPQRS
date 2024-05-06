<%-- 
    Document   : editarUsuario
    Created on : 5/05/2024, 9:44:11 a. m.
    Author     : Hugo
--%>

<%@page import="com.mycompany.tutorial.ControladorUsuarios"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mycompany.tutorial.ConexionBaseDeDatos" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Editar Usuario</title>
    </head>
    <body>
        <%
            // Recibir los datos del formulario
            int idUsuario = Integer.parseInt(request.getParameter("id"));
            String nombreUsuario = request.getParameter("nombreUsuario");
            String cedula = request.getParameter("cedula");
            String emailRegistro = request.getParameter("emailRegistro");

            // Actualizar los datos del usuario en la base de datos utilizando el método editarUsuario
            try {
                ControladorUsuarios.editarUsuario(idUsuario, nombreUsuario, cedula, emailRegistro);
                // Redirigir a ListaUsuarios.jsp y mostrar una alerta de éxito
                response.sendRedirect("ListaUsuarios.jsp?success=true");
            } catch (SQLException e) {
                out.println("<h2>Error al actualizar el usuario: " + e.getMessage() + "</h2>");
            }
        %>
    </body>
</html>
