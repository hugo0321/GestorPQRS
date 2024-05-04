/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.tutorial.ConexionBaseDeDatos;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/InsertarPQRSServlet")
@MultipartConfig
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
    
    // Obtener el usuario_id de la sesión
    HttpSession session = request.getSession();
    int usuarioId = 0; // Inicializamos el usuarioId
    
    if (session.getAttribute("username") != null) {
        // Si hay una sesión iniciada, obtener el ID de usuario de la sesión
        String nombreUsuario = (String) session.getAttribute("username");
        try {
            usuarioId = ConexionBaseDeDatos.obtenerIdUsuario(nombreUsuario);
        } catch (SQLException e) {
            // Manejar la excepción aquí
            e.printStackTrace();
            // Redirigir a una página de error
            response.sendRedirect("ErrorRegistroPQRS.jsp");
            return;
        }
    }

    // Obtener el archivo PDF
    Part filePart = request.getPart("pdfFile");
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // Nombre del archivo
    String filePath = null; // Inicializar la ruta del archivo en el servidor
    
    // Si se proporciona un archivo PDF, guardarlo en la carpeta del proyecto
    if (filePart != null && filePart.getSize() > 0) {
        filePath = getServletContext().getRealPath("/pdfs/") + File.separator + fileName; // Ruta del archivo en el servidor

        // Guardar el archivo en la carpeta del proyecto
        FileOutputStream outputStream = new FileOutputStream(new File(filePath));
        InputStream fileContent = filePart.getInputStream();
        int read = 0;
        byte[] bytes = new byte[1024];
        while ((read = fileContent.read(bytes)) != -1) {
            outputStream.write(bytes, 0, read);
        }
        outputStream.close();
    }

    // Verificar si la PQRS es duplicada del mismo usuario
    try {
        if (ConexionBaseDeDatos.existePQRS(usuarioId, primerNombre, segundoNombre, primerApellido, segundoApellido, motivo, email, telefono, mensaje, filePath)) {
            // Si ya existe una PQRS duplicada del mismo usuario, redirigir a una página de error
            response.sendRedirect("ErrorPQRSRepetida.jsp");
            return;
        }
    } catch (SQLException e) {
        // Manejar la excepción aquí
        e.printStackTrace();
        // Redirigir a una página de error
        response.sendRedirect("ErrorRegistroPQRS.jsp");
        return;
    }

    // Insertar la PQRS en la base de datos con la ruta del archivo y el usuario_id
    try {
        ConexionBaseDeDatos.insertarPQRS(primerNombre, segundoNombre, primerApellido, segundoApellido, motivo, email, telefono, mensaje, filePath, usuarioId);
        // Envía el correo electrónico al usuario
        ConexionBaseDeDatos.enviarCorreoRegistroExitoso(email, primerNombre, segundoNombre, primerApellido, segundoApellido, motivo, email, telefono, mensaje);
        response.sendRedirect("RegistroExitosoPQRS.jsp");
    } catch (SQLException e) {
        response.sendRedirect("ErrorRegistroPQRS.jsp");
        e.printStackTrace();
    }
}
}


