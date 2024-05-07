/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.tutorial.ControladorPQRS;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
@WebServlet("/EditarPQRSServlet")
public class EditarPQRSServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);
        String primerNombre = request.getParameter("primerNombre");
        String segundoNombre = request.getParameter("segundoNombre");
        String primerApellido = request.getParameter("primerApellido");
        String segundoApellido = request.getParameter("segundoApellido");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String mensaje = request.getParameter("mensaje");
        String destinatario = request.getParameter("destinatario");
        String motivo = request.getParameter("motivo");
        String mensajeRespuesta = request.getParameter("mensajeRespuesta");

        // Realizar operaciones para editar la PQRS en la base de datos o en el sistema
        ControladorPQRS controlador = new ControladorPQRS();
        boolean edicionExitosa = false;
        try {
            controlador.editarPQRS(id, primerNombre, segundoNombre, primerApellido, segundoApellido, motivo, email, telefono, mensaje);
            edicionExitosa = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (edicionExitosa) {
            // Si la edición es exitosa, redirigir a ListadoPQRSUsuario.jsp
            response.sendRedirect("ListadoPQRSUsuario.jsp");
        } else {
            // Si la edición falla, mostrar una ventana emergente con el mensaje de error y redirigir a ListadoPQRSUsuario.jsp
            String errorMessage = "Hubo un error al editar la PQRS. Por favor, inténtelo de nuevo más tarde.";
            response.getWriter().println("<script>alert('" + errorMessage + "');</script>");
            response.setHeader("Refresh", "0; URL=ListadoPQRSUsuario.jsp");
        }
    }
}
