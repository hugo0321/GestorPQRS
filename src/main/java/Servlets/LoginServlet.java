/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;




import com.mycompany.tutorial.ConexionBaseDeDatos;
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
        response.setContentType("text/html");
        String nombreUsuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // Verificar las credenciales
        boolean loginExitoso = ConexionBaseDeDatos.loginAdmin(nombreUsuario, contrasena);

        if (loginExitoso) {
            // Crear sesión y almacenar el nombre de usuario
            HttpSession miSesion = request.getSession();
            miSesion.setAttribute("username", nombreUsuario);
            // Redirigir a la página ListaPQRS.jsp
            response.sendRedirect("ListaPQRS.jsp");
        } else {
            response.sendRedirect("login.jsp?error=true");
        }
    }
}


