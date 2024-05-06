/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.tutorial.ControladorEmails;
import com.mycompany.tutorial.ControladorPQRS;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ResponderPQRSservlet", urlPatterns = {"/ResponderPQRSServlet"})
public class ResponderPQRSservlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Procesar los datos del formulario de respuesta a PQRS
           
            String motivo = request.getParameter("motivo");
            String email = request.getParameter("destinatario");
            String mensajeRespuesta = request.getParameter("mensajeRespuesta");
            int id = Integer.parseInt(request.getParameter("id"));

            // Llamar al método para responder PQRS y cambiar el estado
            boolean respuestaEnviada = responderPQRS(email, motivo, mensajeRespuesta);
            if (respuestaEnviada) {
                // Actualizar el estado de la PQRS a "Respondida"
                actualizarEstadoPQRS(id, "Respondida");
                
                // Redirigir a listarPQRS.jsp con un mensaje de confirmación
                String mensajeConfirmacion = "La respuesta se envió correctamente.";
                request.setAttribute("mensajeConfirmacion", mensajeConfirmacion);
                request.getRequestDispatcher("ListaPQRS.jsp").forward(request, response);
            } else {
                out.println("Error al enviar la respuesta.");
            }
        } catch (NumberFormatException e) {
            System.out.println("Error al obtener el ID de la PQRS: " + e.getMessage());
        } catch (SQLException ex) {
            System.out.println("Error al actualizar el estado de la PQRS: " + ex.getMessage());
        }
    }

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

    public static boolean responderPQRS(String destinatario, String motivo, String mensajeRespuesta) {
        // Llama al método responderPQRS de la otra clase
        ControladorEmails.responderPQRS(destinatario, motivo, mensajeRespuesta);
        // Aquí podrías agregar lógica adicional, como verificar si se envió la respuesta correctamente
        return true; // En este ejemplo, siempre asumimos que la respuesta se envió correctamente
    }
    
    public static void actualizarEstadoPQRS(int idPQRS, String nuevoEstado) throws SQLException {
        ControladorPQRS baseDeDatos = new ControladorPQRS();
        baseDeDatos.cambiarEstadoPQRS(idPQRS, nuevoEstado);
    }
}

