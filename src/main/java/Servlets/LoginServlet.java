/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.tutorial.ControladorUsuarios;
import com.mycompany.tutorial.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombreUsuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // Autenticar al usuario y obtener su rol
        String rolUsuario = ControladorUsuarios.autenticarUsuario(nombreUsuario, contrasena);

        if (rolUsuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", nombreUsuario);

            // Redirigir según el rol del usuario
            if (rolUsuario.equals("Administrador")) {
                  session.setAttribute("rolUsuario", rolUsuario); // Almacena el rol en la sesión
                response.sendRedirect("ListaPQRS.jsp");
            } else if (rolUsuario.equals("usuarioNormal")) {
                  session.setAttribute("rolUsuario", rolUsuario); // Almacena el rol en la sesión
                response.sendRedirect("indexEntrada.jsp");
            }
        } else {
            // Si las credenciales son incorrectas, redirige a login.jsp con un mensaje de error
            String mensaje = "Usuario o contraseña incorrectos";
            response.sendRedirect("index.jsp?error=" + mensaje);
        }
    }
}
