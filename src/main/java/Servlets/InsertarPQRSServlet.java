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

/**
 *
 * @author Hugo
 */
@WebServlet("/InsertarPQRSServlet")
public class InsertarPQRSServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        
        // Obtener parámetros del formulario
        String primerNombre = request.getParameter("primerNombre");
        String segundoNombre = request.getParameter("segundoNombre");
        String primerApellido = request.getParameter("primerApellido");
        String segundoApellido = request.getParameter("segundoApellido");
        String motivo = request.getParameter("motivo");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String mensaje = request.getParameter("mensaje");

        // Llamar al método insertarPQRS
        try {
            ConexionBaseDeDatos.insertarPQRS(primerNombre, segundoNombre, primerApellido, segundoApellido, motivo, email, telefono, mensaje);
            response.getWriter().println("<html><body><h2>PQRS insertada correctamente.</h2></body></html>");
        } catch (SQLException e) {
            response.getWriter().println("<html><body><h2>Error al insertar la PQRS: " + e.getMessage() + "</h2></body></html>");
            e.printStackTrace();
        }
    }
}