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
    } else if (!"admin".equals((String) misession.getAttribute("username"))) {
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
            $(document).ready(function () {
                $(".btn-visualizar").click(function () {
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

                $("#expandir-mensaje").click(function () {
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
                            <td class="id"><%= pqrs.getId()%></td>
                            <td class="primerNombre"><%= pqrs.getPrimerNombre()%></td>
                            <td class="segundoNombre"><%= pqrs.getSegundoNombre()%></td>
                            <td class="primerApellido"><%= pqrs.getPrimerApellido()%></td>
                            <td class="segundoApellido"><%= pqrs.getSegundoApellido()%></td>

                            <td class="motivo"><%= pqrs.getMotivo()%></td>
                            <td class="email"><%= pqrs.getEmail()%></td>
                            <td class="telefono"><%= pqrs.getTelefono()%></td>
                            <td class="mensaje"><%= pqrs.getMensaje()%></td>
                            <td class="rutaPDF"><%= pqrs.getRutaPDF()%></td>
                            <td class="horaSolicitud"><%= pqrs.getHoraSolicitud()%></td>                 
                            <td class="estado"><%= pqrs.getEstado()%></td>
                            <td>
                                <button type="button" class="btn btn-info btn-sm btn-visualizar">Visualizar</button>
                                <button type="button" class="btn btn-danger btn-sm btn-eliminar" data-id="<%= pqrs.getId()%>">Eliminar</button>
                                <button type="button" class="btn btn-success btn-sm btn-responder" data-toggle="modal" data-target="#responderPQRSModal" data-email="<%= pqrs.getEmail()%>" data-motivo="<%= pqrs.getMotivo()%>">
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
                        <% }%>
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
        <!-- Script para prellenar los campos de destinatario, motivo y otros campos ocultos -->
        <script>
            $(document).ready(function () {
                $(".btn-responder").click(function () {
                    var id = $(this).closest("tr").find(".id").text();
                    var email = $(this).closest("tr").find(".email").text();
                    var motivo = $(this).closest("tr").find(".motivo").text();
                    var primerNombre = $(this).closest("tr").find(".primerNombre").text();
                    var segundoNombre = $(this).closest("tr").find(".segundoNombre").text();
                    var primerApellido = $(this).closest("tr").find(".primerApellido").text();
                    var segundoApellido = $(this).closest("tr").find(".segundoApellido").text();
                    var telefono = $(this).closest("tr").find(".telefono").text();
                    var mensaje = $(this).closest("tr").find(".mensaje").text();
                    var rutaPDF = $(this).closest("tr").find(".rutaPDF").text();

                    console.log("Email:", email);
                    console.log("Motivo:", motivo);
                    console.log("Primer Nombre:", primerNombre);
                    console.log("Segundo Nombre:", segundoNombre);
                    console.log("Primer Apellido:", primerApellido);
                    console.log("Segundo Apellido:", segundoApellido);
                    console.log("Teléfono:", telefono);
                    console.log("Mensaje:", mensaje);
                    console.log("Ruta PDF:", rutaPDF);
                    console.log("ID:", id);

                    $("#destinatario").val(email);
                    $("#motivo").val(motivo);
                    $("#primerNombre").val(primerNombre);
                    $("#segundoNombre").val(segundoNombre);
                    $("#primerApellido").val(primerApellido);
                    $("#segundoApellido").val(segundoApellido);
                    $("#telefono").val(telefono);
                    $("#mensaje").val(mensaje);
                    $("#rutaPDF").val(rutaPDF);
                    $("#id").val(id);

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
                            <!-- Campos ocultos para pasar los parámetros necesarios -->
                            <input type="hidden" id="primerNombre" name="primerNombre">
                            <input type="hidden" id="segundoNombre" name="segundoNombre">
                            <input type="hidden" id="primerApellido" name="primerApellido">
                            <input type="hidden" id="segundoApellido" name="segundoApellido">
                            <input type="hidden" id="email" name="email">
                            <input type="hidden" id="telefono" name="telefono">
                            <input type="hidden" id="mensaje" name="mensaje">
                            <input type="hidden" id="rutaPDF" name="rutaPDF">
                            <input type="hidden" id="id" name="id">
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
            $(document).ready(function () {
                // Función para copiar la ruta del PDF al portapapeles
                $('.btn-copiar').click(function () {
                    // Seleccionar el campo de texto que contiene la ruta del PDF
                    var rutaPDF = $('#view-rutaPDF');
                    rutaPDF.select();

                    // Intentar copiar el contenido del campo de texto al portapapeles
                    navigator.clipboard.writeText(rutaPDF.val())
                            .then(function () {
                                // Mostrar un mensaje de éxito
                                alert('La ruta del PDF se ha copiado al portapapeles: ' + rutaPDF.val());
                            })
                            .catch(function (err) {
                                console.error('Error al copiar al portapapeles: ', err);
                                alert('Hubo un error al copiar la ruta del PDF al portapapeles.');
                            });
                });
            });
        </script>
        <!-- Agrega este script JavaScript en tu página para manejar el clic del botón -->
        <script>
            // Obtener todos los botones de clase btn-eliminar
            var botonesEliminar = document.querySelectorAll('.btn-eliminar');

            // Agregar un evento de clic a cada botón
            botonesEliminar.forEach(function (boton) {
                boton.addEventListener('click', function () {
                    // Obtener el ID de la PQRS desde el atributo data-id
                    var idPQRS = this.getAttribute('data-id');

                    // Mostrar una confirmación al usuario
                    var confirmacion = confirm('¿Estás seguro de que quieres eliminar esta PQRS?');

                    // Si el usuario confirma la eliminación, enviar la solicitud HTTP
                    if (confirmacion) {
                        // Crear una nueva solicitud HTTP
                        var xhr = new XMLHttpRequest();

                        // Especificar la URL y el método HTTP (POST o GET) para la solicitud
                        xhr.open('GET', 'eliminarPQRS.jsp?idPQRS=' + idPQRS, true);

                        // Enviar la solicitud
                        xhr.send();

                        // Redireccionar a ListaPQRS.jsp después de eliminar la PQRS
                        xhr.onreadystatechange = function () {
                            if (xhr.readyState === 4 && xhr.status === 200) {
                                window.location.href = 'ListaPQRS.jsp';
                            }
                        };
                    }
                });
            });
        </script>
        <!-- Script para deshabilitar el botón Responder si el estado es Respondida -->
        <script>
            // Esperar a que el contenido de la página esté completamente cargado
            document.addEventListener('DOMContentLoaded', function () {
                // Obtener todos los botones de clase btn-responder
                var botonesResponder = document.querySelectorAll('.btn-responder');

                // Iterar sobre cada botón de Responder
                botonesResponder.forEach(function (boton) {
                    // Obtener el estado de la PQRS desde la fila de la tabla
                    var estadoPQRS = boton.parentElement.parentElement.querySelector('.estado').textContent.trim();

                    // Deshabilitar el botón si el estado es "Respondida"
                    if (estadoPQRS === 'Respondida') {
                        boton.disabled = true; // Deshabilitar el botón
                    }
                });
            });
        </script>

    </body>
</html>
