/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.tutorial.ConexionBaseDeDatos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/RegistroServlet"})
public class RegistroServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Procesar los datos del formulario de registro
            String nombreUsuario = request.getParameter("nombreUsuario");
            String cedula = request.getParameter("cedula");
            String email = request.getParameter("email");
            String contrasena = request.getParameter("contrasenaRegistro");

            // Aquí deberías insertar el nuevo usuario en la base de datos
            try {
                ConexionBaseDeDatos.insertarUsuario(nombreUsuario, cedula, contrasena, email);
                
                // Envío del correo de registro exitoso
                ConexionBaseDeDatos.enviarRegistroExitoso(email, nombreUsuario, cedula, contrasena, email);

                // Redireccionar a index.jsp si el registro es exitoso
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Registro exitoso. Se ha enviado un correo con los detalles de la cuenta.');");
                out.println("window.location.href = 'index.jsp';");
                out.println("</script>");
            } catch (SQLException e) {
                // Manejar cualquier error de la base de datos
                out.println("Error en la base de datos: " + e.getMessage());
            }
        }
    }

    // Métodos doGet y doPost para manejar las solicitudes GET y POST
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
