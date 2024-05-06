/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.tutorial.ControladorEmails;
import com.mycompany.tutorial.ControladorUsuarios;
import com.mycompany.tutorial.Usuario;


/**
 *
 * @author Hugo
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RecuperarUsuarioServlet")
public class RecuperarUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros de la solicitud
        String cedula = request.getParameter("cedulaRecuperar");
        String correo = request.getParameter("correoRecuperar");

        // Imprimir los valores en la consola
        System.out.println("Cédula recuperada de modal: " + cedula);
        System.out.println("Correo electrónico recuperado de modal: " + correo);

        try {
            // Llamar al método recuperarUsuario para buscar al usuario
            Usuario usuario = ControladorUsuarios.recuperarUsuario(cedula, correo);

            // Verificar si se encontró al usuario
            if (usuario != null) {
                // Si se encuentra el usuario, enviar correo de recuperación
                ControladorEmails.enviarRecuperacion(usuario.getEmailRegistro(), usuario.getNombreUsuario(), usuario.getCedula(), usuario.getContrasena(), usuario.getEmailRegistro());
                
                // Mostrar mensaje de usuario encontrado
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Usuario encontrado. Se ha enviado un correo electrónico.');");
                out.println("window.location.href='index.jsp';");
                out.println("</script>");
            } else {
                // Si no se encuentra el usuario, mostrar mensaje de usuario no encontrado
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Usuario no encontrado.');");
                out.println("window.location.href='index.jsp';");
                out.println("</script>");
            }
        } catch (SQLException e) {
            // Si ocurre un error de SQL, mostrar el mensaje de error
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Error al recuperar el usuario: " + e.getMessage() + "');");
            out.println("window.location.href='index.jsp';");
            out.println("</script>");
        }
    }
}


