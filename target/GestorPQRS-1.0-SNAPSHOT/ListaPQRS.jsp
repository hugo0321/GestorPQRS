<%-- 
    Document   : ListaPQRS
    Created on : 2/05/2024, 11:58:19 a. m.
    Author     : Hugo
--%>
<%@page import="com.mycompany.tutorial.ControladorPQRS"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.tutorial.PQRS" %>
<%@ page import="com.mycompany.tutorial.ConexionBaseDeDatos" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    HttpSession misession = request.getSession(false);
    if (misession == null) {
        response.sendRedirect("index.jsp");
        return;
    } else if (!"admin".equals((String)misession.getAttribute("username"))) {
        response.sendRedirect("indexEntrada.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <jsp:include page="navar_Administrador.jsp" />
    <meta charset="UTF-8">
    <title>Listado de PQRS</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #495057;
        }
        .container {
            margin-top: 50px;
        }
        h1 {
            color: #007bff;
            margin-bottom: 30px;
        }
        table {
            width: 95%; /* Cambia el valor a lo que desees */
            max-width: 95%; /* Esto asegura que la tabla no sea más ancha que el 95% de la pantalla */
            margin: 0 auto; /* Esto centra la tabla horizontalmente en la página */
            background-color: #fff;
        }
        th, td {
            padding: 12px;
            text-align: left;
            white-space: nowrap; /* Esto evita que el texto se envuelva */
            overflow: hidden; /* Esto oculta cualquier contenido que se desborde del ancho del td */
            text-overflow: ellipsis; /* Esto añade puntos suspensivos (...) para indicar que hay más contenido oculto */
        }
        td.mensaje {
            max-width: 300px; /* Ancho máximo de la columna */
            white-space: nowrap; /* Evita que el texto se envuelva */
            overflow: hidden; /* Oculta el texto que desborde del ancho de la columna */
            text-overflow: ellipsis; /* Agrega puntos suspensivos (...) al final del texto truncado */
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .no-data {
            font-style: italic;
        }
        
    </style>
    <script>
        $(document).ready(function() {
            $(".btn-visualizar").click(function() {
                var motivo = $(this).closest("tr").find(".motivo").text();
                var email = $(this).closest("tr").find(".email").text();
                var telefono = $(this).closest("tr").find(".telefono").text();
                var mensaje = $(this).closest("tr").find(".mensaje").text();
                var rutaPDF = $(this).closest("tr").find(".rutaPDF").text();
                var horaSolicitud = $(this).closest("tr").find(".horaSolicitud").text();
                var estado = $(this).closest("tr").find(".estado").text();
                $("#view-motivo").val(motivo);
                $("#view-email").val(email);
                $("#view-telefono").val(telefono);
                $("#view-mensaje").val(mensaje);
                $("#view-rutaPDF").val(rutaPDF);
                $("#view-horaSolicitud").val(horaSolicitud);
                $("#view-estado").val(estado);
                $("#visualizarPQRSModal").modal("show");
            });

            $("#expandir-mensaje").click(function() {
                var mensajeCompleto = $("#view-mensaje").val();
                $("#mensajeCompletoModal .modal-body").text(mensajeCompleto);
                $("#mensajeCompletoModal").modal("show");
            });

            $(".draggable").draggable();
        });
        
    </script>
</head>
<body>
    <div class="container">
        <h1>Listado de PQRS</h1>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Primer Nombre</th>
                        <th>Segundo Nombre</th>
                        <th>Primer Apellido</th>
                        <th>Segundo Apellido</th>
                        <th>Motivo</th>
                        <th>Email</th>
                        <th>Teléfono</th>
                        <th>Mensaje</th>
                        <th>rutaPDF</th>
                        <th>Fecha/Hora</th>                 
                        <th>Estado</th>
                        <th>Acciones</th> <!-- Nueva columna para las acciones -->
                    </tr>
                </thead>
                <tbody>
                    <% 
                        ControladorPQRS controlador = new ControladorPQRS();
                        List<PQRS> listaPQRS = controlador.obtenerPQRS();
                        if (listaPQRS != null && !listaPQRS.isEmpty()) {
                            for (PQRS pqrs : listaPQRS) {
                    %>
                    <tr>
                        <td><%= pqrs.getId() %></td>
                        <td><%= pqrs.getPrimerNombre()%></td>
                        <td><%= pqrs.getSegundoNombre() %></td>
                        <td><%= pqrs.getPrimerApellido() %></td>
                        <td><%= pqrs.getSegundoApellido() %></td>
                        <td class="motivo"><%= pqrs.getMotivo() %></td>
                        <td class="email"><%= pqrs.getEmail() %></td>
                        <td class="telefono"><%= pqrs.getTelefono() %></td>
                        <td class="mensaje"><%= pqrs.getMensaje() %></td>
                        <td class="rutaPDF"><%= pqrs.getRutaPDF() %></td>
                        <td class="horaSolicitud"><%= pqrs.getHoraSolicitud() %></td>                 
                        <td class="estado"><%= pqrs.getEstado() %></td>
                        <td>
    <button type="button" class="btn btn-info btn-sm btn-visualizar">Visualizar</button>
<button type="button" class="btn btn-danger btn-sm btn-eliminar" data-id="<%= pqrs.getId() %>">Eliminar</button>
<button type="button" class="btn btn-success btn-sm btn-responder" data-toggle="modal" data-target="#responderPQRSModal" data-email="<%= pqrs.getEmail() %>" data-motivo="<%= pqrs.getMotivo() %>">
    Responder
</button>




                        </td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="10" class="no-data">No hay PQRS disponibles.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal para visualizar detalles de PQRS -->
    <div class="modal fade" id="visualizarPQRSModal" tabindex="-1" role="dialog" aria-labelledby="visualizarPQRSModalLabel" aria-hidden="true">
        <div class="modal-dialog draggable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="visualizarPQRSModalLabel">Detalles de la PQRS</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="view-motivo">Motivo</label>
                        <input type="text" class="form-control" id="view-motivo" readonly>
                    </div>
                    <div class="form-group">
                        <label for="view-email">Email</label>
                        <input type="email" class="form-control" id="view-email" readonly>
                    </div>
                    <div class="form-group">
                        <label for="view-telefono">Teléfono</label>
                        <input type="text" class="form-control" id="view-telefono" readonly>
                    </div>
                    <div class="form-group">
                        <label for="view-mensaje">Mensaje</label>
                        <textarea class="form-control" id="view-mensaje" readonly></textarea>
                        <span id="expandir-mensaje" class="expandir-mensaje" style="color: blue; cursor: pointer;">(Expandir)</span>
                    </div>
          <!-- Agrega un botón dentro del modal para copiar la ruta del PDF -->
<div class="form-group">
    <label for="view-rutaPDF">Ruta PDF</label>
    <div class="input-group">
        <input type="text" class="form-control" id="view-rutaPDF" readonly>
        <div class="input-group-append">
            <button class="btn btn-primary btn-copiar" type="button">Copiar</button>
        </div>
    </div>
</div>
                    <div class="form-group">
                        <label for="view-horaSolicitud">Fecha/Hora</label>
                        <input type="text" class="form-control" id="view-horaSolicitud" readonly>
                    </div>
                    <div class="form-group">
                        <label for="view-estado">Estado</label>
                        <input type="text" class="form-control" id="view-estado" readonly>
                    </div>
          



                </div>
            </div>
        </div>
    </div>
    <!-- Script para prellenar los campos de destinatario y motivo -->
<script>
    $(document).ready(function() {
        $(".btn-responder").click(function() {
            var email = $(this).closest("tr").find(".email").text();
            var motivo = $(this).closest("tr").find(".motivo").text();
            $("#destinatario").val(email);
            $("#motivo").val(motivo);
            $("#responderPQRSModal").modal("show");
        });
    });
</script>
<!-- Modal para responder a la PQRS -->
<div class="modal fade" id="responderPQRSModal" tabindex="-1" role="dialog" aria-labelledby="responderPQRSModalLabel" aria-hidden="true">
    <div class="modal-dialog draggable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="responderPQRSModalLabel">Responder a la PQRS</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Formulario para escribir la respuesta -->
                <form id="responderForm" action="ResponderPQRSServlet" method="post">
                    <div class="form-group">
                        <label for="destinatario">Destinatario:</label>
                        <input type="email" class="form-control" id="destinatario" name="destinatario" required>
                    </div>
                    <div class="form-group">
                        <label for="motivo">Motivo:</label>
                        <input type="text" class="form-control" id="motivo" name="motivo" required>
                    </div>
                    <div class="form-group">
                        <label for="mensajeRespuesta">Mensaje de respuesta:</label>
                        <textarea class="form-control" id="mensajeRespuesta" name="mensajeRespuesta" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Enviar respuesta</button>
                </form>
            </div>
        </div>
    </div>
</div>




    <!-- Modal para mostrar el mensaje completo -->
    <div class="modal fade" id="mensajeCompletoModal" tabindex="-1" role="dialog" aria-labelledby="mensajeCompletoModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="mensajeCompletoModalLabel">Mensaje Completo</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Aquí se mostrará el mensaje completo -->
                </div>
            </div>
        </div>
    </div>
   <!-- Script para copiar la ruta del PDF al portapapeles -->
<!-- Script para copiar la ruta del PDF al portapapeles -->
<script>
    $(document).ready(function() {
        // Función para copiar la ruta del PDF al portapapeles
        $('.btn-copiar').click(function() {
            // Seleccionar el campo de texto que contiene la ruta del PDF
            var rutaPDF = $('#view-rutaPDF');
            rutaPDF.select();
            
            // Intentar copiar el contenido del campo de texto al portapapeles
            navigator.clipboard.writeText(rutaPDF.val())
                .then(function() {
                    // Mostrar un mensaje de éxito
                    alert('La ruta del PDF se ha copiado al portapapeles: ' + rutaPDF.val());
                })
                .catch(function(err) {
                    console.error('Error al copiar al portapapeles: ', err);
                    alert('Hubo un error al copiar la ruta del PDF al portapapeles.');
                });
        });
    });
</script>

</body>
</html>
