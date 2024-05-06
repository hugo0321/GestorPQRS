<%-- 
    Document   : eliminarUsuario
    Created on : 5/05/2024, 10:04:32 a. m.
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
        <title>Eliminar Usuario</title>
    </head>
    <body>
        <%
            // Recibir el ID del usuario a eliminar desde la solicitud AJAX
            int idUsuario = Integer.parseInt(request.getParameter("id"));

            // Eliminar al usuario en la base de datos utilizando el método eliminarUsuario
            try {
                ControladorUsuarios.eliminarUsuario(idUsuario);
                // Enviar una respuesta exitosa a la solicitud AJAX
                response.getWriter().write("Usuario eliminado exitosamente.");
            } catch (SQLException e) {
                // Enviar un mensaje de error en caso de fallo
                response.setStatus(500); // Establecer código de error HTTP 500 (Error interno del servidor)
                response.getWriter().write("Error al eliminar el usuario: " + e.getMessage());
            }
        %>
    </body>
</html>
