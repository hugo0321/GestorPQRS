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

@WebServlet("/CambiarRolServlet")
public class CambiarRolServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del usuario cuyo rol se desea cambiar
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));

        try {
            // Llamar al método para cambiar el rol del usuario
            ControladorUsuarios.cambiarRolUsuario(idUsuario);
            
            // Redirigir a una página de éxito o mostrar un mensaje de éxito
            response.sendRedirect("ListaUsuarios.jsp"); // Puedes cambiar "exito.jsp" por la página que desees
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
            // Redirigir a una página de error o mostrar un mensaje de error
            response.sendRedirect("ListaUsuarios.jsp"); // Puedes cambiar "error.jsp" por la página que desees
        }
    }
}
