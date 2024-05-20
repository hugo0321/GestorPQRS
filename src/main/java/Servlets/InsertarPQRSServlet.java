package Servlets;

import com.mycompany.tutorial.ControladorEmails;
import com.mycompany.tutorial.ControladorPQRS;
import com.mycompany.tutorial.ControladorUsuarios;
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
import java.util.UUID;


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
        int motivo = Integer.parseInt(request.getParameter("motivo"));
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String mensaje = request.getParameter("mensaje");
        String IDUnico = UUID.randomUUID().toString();

// Obtener el nombre del motivo
            String motivoNombre = null;
        // Obtener el usuario_id de la sesión
        HttpSession session = request.getSession();
        int usuarioId = 0; // Inicializamos el usuarioId

        if (session.getAttribute("username") != null) {
            // Si hay una sesión iniciada, obtener el ID de usuario de la sesión
            String nombreUsuario = (String) session.getAttribute("username");
            try {
                usuarioId = ControladorUsuarios.obtenerIdUsuario(nombreUsuario);
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

        // Inicializar la ruta del archivo en el servidor
        String filePath = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Si se proporciona un archivo, obtener su nombre y extensión
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // Nombre del archivo

            
            try {
                motivoNombre = ControladorPQRS.obtenerNombreMotivo(motivo);
            } catch (SQLException e) {
                // Manejar la excepción aquí
                e.printStackTrace();
                // Redirigir a una página de error o mostrar un mensaje al usuario
                response.sendRedirect("ErrorObtenerMotivo.jsp");
                return;
            }

            String extension = fileName.substring(fileName.lastIndexOf(".")); // Obtenemos la extensión del archivo original

            // Construir el nuevo nombre del archivo PDF
            String nuevoNombreArchivo = motivoNombre + "_" + primerNombre + "_" + usuarioId + "_"+ IDUnico + extension;

            // Si se proporciona un archivo PDF, guardarlo en la carpeta del proyecto
            filePath = getServletContext().getRealPath("/pdfs/") + File.separator + nuevoNombreArchivo; // Ruta del archivo en el servidor

            // Guardar el archivo en la carpeta del proyecto
            try (FileOutputStream outputStream = new FileOutputStream(new File(filePath));
                 InputStream fileContent = filePart.getInputStream()) {
                int read;
                byte[] bytes = new byte[1024];
                while ((read = fileContent.read(bytes)) != -1) {
                    outputStream.write(bytes, 0, read);
                }
            } catch (IOException e) {
                // Manejar la excepción aquí
                e.printStackTrace();
                // Redirigir a una página de error o mostrar un mensaje al usuario
                response.sendRedirect("ErrorGuardarArchivo.jsp");
                return;
            }
        }

        // Verificar si la PQRS es duplicada del mismo usuario
        try {
            if (ControladorPQRS.existePQRS(usuarioId, primerNombre, segundoNombre, primerApellido, segundoApellido, motivo, email, telefono, mensaje, filePath)) {
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
// Obtener el nombre del motivo
            
            try {
                motivoNombre = ControladorPQRS.obtenerNombreMotivo(motivo);
            } catch (SQLException e) {
                // Manejar la excepción aquí
                e.printStackTrace();
                // Redirigir a una página de error o mostrar un mensaje al usuario
                response.sendRedirect("ErrorObtenerMotivo.jsp");
                return;
            }
        // Insertar la PQRS en la base de datos con la ruta del archivo y el usuario_id
        try {
            ControladorPQRS.insertarPQRS(primerNombre, segundoNombre, primerApellido, segundoApellido, motivo, email, telefono, mensaje, filePath, usuarioId);
            // Envía el correo electrónico al usuario
            ControladorEmails.enviarCorreoRegistroExitoso(email, primerNombre, segundoNombre, primerApellido, segundoApellido, motivoNombre, email, telefono, mensaje);
            response.sendRedirect("RegistroExitosoPQRS.jsp");
        } catch (SQLException e) {
            response.sendRedirect("ErrorRegistroPQRS.jsp");
            e.printStackTrace();
        }
    }
}
