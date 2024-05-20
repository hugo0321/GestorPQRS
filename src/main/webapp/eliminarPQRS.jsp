<%-- 
    Document   : eliminarPQRS
    Created on : 5/05/2024, 9:27:21 p. m.
    Author     : Hugo
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.tutorial.ControladorEmails"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.tutorial.ControladorPQRS"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Obtener el ID de la PQRS desde los datos enviados por el botón
    int idPQRS = Integer.parseInt(request.getParameter("idPQRS"));
    // Obtener la página de origen (referer)
    String origen = request.getHeader("referer");
 
    // Intentar eliminar la PQRS con el ID especificado
    try {
        ControladorPQRS controlador = new ControladorPQRS(); // Instancia del controlador
        controlador.eliminarPQRS(idPQRS); // Llamada al método eliminarPQRS

        // Mostrar mensaje emergente de éxito y redireccionar según la página de origen
        if (origen != null && origen.endsWith("ListadoPQRSUsuario.jsp")) {
%>
            <script type="text/javascript">
                alert("Eliminación exitosa de la PQRS con ID <%= idPQRS %>");
                window.location.href = "ListadoPQRSUsuario.jsp";
            </script>
<%
        } else {
%>
            <script type="text/javascript">
                alert("Eliminación exitosa de la PQRS con ID <%= idPQRS %>");
                window.location.href = "ListaPQRS.jsp";
            </script>
<%
        }
    } catch (SQLException e) {
        // Mostrar mensaje emergente de error y redireccionar a una página de error
%>
        <script type="text/javascript">
            alert("Error al eliminar la PQRS");
            window.location.href = "error.jsp";
        </script>
<%
    }
%>
