/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.tutorial.ConexionBaseDeDatos;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Obtener los parámetros del formulario
        String nombreUsuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // Verificar las credenciales
        boolean loginExitoso = ConexionBaseDeDatos.loginAdmin(nombreUsuario, contrasena);

        // Redirigir según el resultado del login
        if (loginExitoso) {
            // Login exitoso
            out.println("<h1>Login exitoso!</h1>");
            // Aquí puedes redirigir a la página de administrador, por ejemplo:
            // response.sendRedirect("pagina_admin.jsp");
        } else {
            // Login fallido
            out.println("<h1>Login fallido. Intente de nuevo.</h1>");
            // Aquí puedes redirigir de nuevo al formulario de login
            // response.sendRedirect("formulario_login.jsp");
        }

        out.close();
    }
}
