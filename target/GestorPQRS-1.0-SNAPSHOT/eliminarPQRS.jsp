<%-- 
    Document   : eliminarPQRS
    Created on : 5/05/2024, 9:27:21 p. m.
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
    
    // Intentar eliminar la PQRS con el ID especificado
    try {
        ControladorPQRS controlador = new ControladorPQRS(); // Instancia del controlador
        controlador.eliminarPQRS(idPQRS); // Llamada al método eliminarPQRS
        
        // Redireccionar a ListaPQRS.jsp después de eliminar la PQRS
        response.sendRedirect("ListaPQRS.jsp");
    } catch (SQLException e) {
        // Redireccionar a una página de error en caso de excepción
        response.sendRedirect("error.jsp");
    }
%>

