<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.mycompany.tutorial.ConexionBaseDeDatos" %>

<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>

<%
    HttpSession misession = request.getSession(false);
    if (misession != null && "admin".equals((String) misession.getAttribute("username"))) {
        response.sendRedirect("ListaPQRS.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .login-container {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding: 40px;
                max-width: 400px;
                width: 100%;
                text-align: center;
            }
            h2 {
                margin-bottom: 20px;
                color: #333;
            }
            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            button {
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 4px;
                padding: 12px 20px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h2>Login de Administrador</h2>

            <%  // Manejar mensaje de error, si existe
                String error = request.getParameter("error");
                if (error != null && error.equals("true")) {
            %>
            <p style="color: red;">Error: Nombre de usuario o contraseña incorrectos.</p>
            <% }%>

            <form action="LoginServlet" method="post">
                <input type="text" name="usuario" placeholder="Usuario" required>
                <input type="password" name="contrasena" placeholder="Contraseña" required>
                <button type="submit">Iniciar sesión</button>
            </form>
        </div>
        <!-- Botón para volver a la página de inicio -->
        <a href="index.jsp" style="position: fixed; bottom: 10px; left: 10px; color: #007bff; text-decoration: none;">Volver a la página de inicio</a>
    </div>
</body>
</html>
