/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;




import com.mycompany.tutorial.ConexionBaseDeDatos;
import com.mycompany.tutorial.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
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
        String origen = request.getHeader("Referer"); // Obtiene la URL de la página de origen

        // Verifica que la solicitud provenga del formulario de login.jsp
        if (origen != null && origen.endsWith("login.jsp")) {
            response.setContentType("text/html");
            String nombreUsuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");

            // Verificar las credenciales
            Usuario usuario = ConexionBaseDeDatos.login(nombreUsuario, contrasena);

            if (nombreUsuario.equals("admin") && contrasena.equals("password")) {
                // Si es el administrador fijo, redirige a ListaPQRS.jsp
                HttpSession miSesion = request.getSession();
                miSesion.setAttribute("username", nombreUsuario);
                response.sendRedirect("ListaPQRS.jsp");
            } else if (usuario != null && !nombreUsuario.equals("admin")) {
                // Si las credenciales son de un usuario normal registrado, redirige a indexEntrada.jsp
                HttpSession miSesion = request.getSession();
                miSesion.setAttribute("username", nombreUsuario);
                response.sendRedirect("indexEntrada.jsp");
            } else {
                // Si las credenciales son incorrectas, redirige a login.jsp con un mensaje de error
                String mensaje = "Usuario o contraseña incorrectos";
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('" + mensaje + "');");
                out.println("setTimeout(function(){window.location.href='login.jsp';}, 1000);");
                out.println("</script>");
            }
        } else {
            // Si la solicitud no proviene del formulario de login.jsp pero el usuario no es el administrador
            // y se encuentra registrado en la base de datos, redirige a indexEntrada.jsp
            String nombreUsuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");
            Usuario usuario = ConexionBaseDeDatos.login(nombreUsuario, contrasena);
            if (usuario != null && !nombreUsuario.equals("admin")) {
                HttpSession miSesion = request.getSession();
                miSesion.setAttribute("username", nombreUsuario);
                
                response.sendRedirect("indexEntrada.jsp");
            } else {
                // Si la solicitud no proviene de login.jsp y el usuario no está registrado, redirige a index.jsp
                response.sendRedirect("index.jsp");
            }
        }
    }  
}




