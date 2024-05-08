package Servlets;

import com.mycompany.tutorial.ControladorPQRS;
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
import javax.servlet.http.Part;

@WebServlet("/EditarPQRSServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 20) // Tamaño máximo de archivo: 20 MB
public class EditarPQRSServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        
        // Obtener parámetros del formulario
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);
        String primerNombre = request.getParameter("primerNombre");
        String segundoNombre = request.getParameter("segundoNombre");
        String primerApellido = request.getParameter("primerApellido");
        String segundoApellido = request.getParameter("segundoApellido");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String mensaje = request.getParameter("mensaje");
        String motivo = request.getParameter("motivo");
        
        // Obtener el archivo PDF adjunto
        Part filePart = request.getPart("pdfFile");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String filePath = null;

        // Si se proporciona un archivo PDF, guardarlo en la carpeta del proyecto
        if (filePart != null && filePart.getSize() > 0) {
            filePath = getServletContext().getRealPath("/pdfs/") + File.separator + fileName;

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

        // Realizar operaciones para editar la PQRS en la base de datos o en el sistema
        ControladorPQRS controlador = new ControladorPQRS();
        boolean edicionExitosa = false;
        try {
            controlador.editarPQRS(id, primerNombre, segundoNombre, primerApellido, segundoApellido, motivo, email, telefono, mensaje, filePath);
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
