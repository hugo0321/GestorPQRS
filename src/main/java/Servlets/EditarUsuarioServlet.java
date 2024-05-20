/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;


import com.mycompany.tutorial.ControladorUsuarios;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditarUsuarioServlet")
public class EditarUsuarioServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nombreUsuario = request.getParameter("nombreUsuario");
        String cedula = request.getParameter("cedula");
        String emailRegistro = request.getParameter("emailRegistro");

        try {
            ControladorUsuarios.editarUsuario(id, nombreUsuario, cedula, emailRegistro);
            response.sendRedirect("listaUsuarios.jsp"); // Redirige a la página de listado de usuarios
        } catch (SQLException e) {
            e.printStackTrace();
            // Manejo de errores
        }
    }
}
