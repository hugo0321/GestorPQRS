<%-- 
    Document   : index
    Created on : 1/05/2024, 9:23:45 p. m.
    Author     : Hugo
--%>

<%@page import="com.mycompany.tutorial.ControladorUsuarios"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.tutorial.PQRS"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.tutorial.ConexionBaseDeDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession miSesion = request.getSession(false);
    if (miSesion == null || miSesion.getAttribute("username") == null) {
        // Si no hay sesión o el nombre de usuario no está presente en la sesión, redirigir al formulario de inicio de sesión
        response.sendRedirect("index.jsp");
        return;

    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>


        <meta charset="UTF-8">
        <jsp:include page="navarUsuario.jsp" />
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
            <% // Obtener el nombre de usuario de la sesión
                String nombreUsuario1 = (String) miSesion.getAttribute("username");
            %>
            <h1 style="color: #000; margin-top: 200px;">Estas son las PQRS de <%= nombreUsuario1%></h1>

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
                            <th>Archivo PDF</th>
                            <th>Fecha/Hora</th>                 
                            <th>Estado</th>
                            <th>Acciones</th> <!-- Nueva columna para las acciones -->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Verificar si hay una sesión activa y si el usuario es el administrador
                            HttpSession lsession = request.getSession(false); // Se establece como false para evitar que se cree una nueva sesión si no existe
                            if (lsession == null) {
                                // Si no hay sesión activa, redirigir a index.jsp
                                response.sendRedirect("index.jsp");
                                return; // Terminar la ejecución de la página actual
                            }

                            int usuarioId = 0; // Inicializamos el usuarioId
                            String nombreUsuario = (String) lsession.getAttribute("username");
                            try {
                                usuarioId = ControladorUsuarios.obtenerIdUsuario(nombreUsuario);
                            } catch (SQLException e) {
                                // Manejar la excepción aquí
                                e.printStackTrace();
                                // Redirigir a una página de error
                                response.sendRedirect("ErrorRegistroPQRS.jsp");
                                return; // Terminar la ejecución de la página actual
                            }

                            ControladorUsuarios controlador = new ControladorUsuarios();
                            List<PQRS> listaPQRS = null;

                            try {
                                listaPQRS = controlador.obtenerPQRSUsuario(usuarioId);
                            } catch (SQLException e) {
                                // Manejar la excepción aquí
                                e.printStackTrace();
                                // Puedes redirigir a una página de error o mostrar un mensaje al usuario
                            }

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

                            <!-- Agrega un ID único al elemento td que contiene la ruta del PDF -->
                            <td class="rutaPDF" id="rutaPDF"><%= pqrs.getRutaPDF()%></td>
                            <td class="horaSolicitud"><%= pqrs.getHoraSolicitud()%></td>                 
                            <td class="estado"><%= pqrs.getEstado()%></td>
                            <td>
                                <button type="button" class="btn btn-info btn-sm btn-visualizar">Visualizar</button>
                                <button type="button" class="btn btn-danger btn-sm btn-eliminar" data-id="<%= pqrs.getId()%>">Eliminar</button>
                                <button type="button" class="btn btn-success btn-sm btn-editar" data-toggle="modal" data-target="#editarPQRSModal" data-email="<%= pqrs.getEmail()%>" data-motivo="<%= pqrs.getMotivo()%>">
                                    Editar
                                </button>
<!--<button type="button" class="btn btn-primary btn-sm btn-ver-pdf" data-ruta-pdf="<%= pqrs.getRutaPDF()%>">Ver PDF</button>-->




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
        <script>
            // Espera a que el documento esté completamente cargado
            document.addEventListener("DOMContentLoaded", function () {
                // Obtener todos los botones de "Ver PDF"
                var verPdfButtons = document.querySelectorAll('.btn-ver-pdf');

                // Iterar sobre cada botón y agregar un event listener
                verPdfButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        // Obtener la ruta absoluta del PDF del atributo data del botón
                        var rutaPDF = button.getAttribute('data-ruta-pdf');

                        // Imprimir la ruta absoluta en la consola
                        console.log("Ruta absoluta del PDF:", rutaPDF);

                        // Verificar si la ruta del PDF no está vacía
                        if (rutaPDF) {
                            // Abrir el PDF en una nueva ventana o pestaña
                            window.open(rutaPDF, '_blank');
                        } else {
                            // Si no hay ruta del PDF, mostrar un mensaje de error
                            alert('No se encontró la ruta del PDF.');
                        }
                    });
                });
            });
        </script>





        <!-- Script para obtener el nombre del archivo PDF y mostrarlo -->
        <script>
            // Espera a que el contenido de la página esté completamente cargado
            document.addEventListener('DOMContentLoaded', function () {
                // Obtén todos los elementos td con la clase "rutaPDF"
                var rutasPDF = document.querySelectorAll('.rutaPDF');

                // Itera sobre cada elemento
                rutasPDF.forEach(function (rutaPDF) {
                    // Obtén el texto dentro del elemento td
                    var rutaCompleta = rutaPDF.textContent.trim();

                    // Normaliza la ruta para manejar caracteres especiales y el separador de directorios
                    var rutaNormalizada = rutaCompleta.replace(/\\/g, '/'); // Reemplaza todas las barras invertidas por barras inclinadas

                    // Extrae el nombre del archivo de la ruta completa
                    var nombreArchivo = rutaNormalizada.substring(rutaNormalizada.lastIndexOf('/') + 1);

                    // Asigna el nombre del archivo como texto al elemento td
                    rutaPDF.textContent = nombreArchivo;
                });
            });
        </script>



    </script>
    <!-- Modal para editar una PQRS -->
    <div class="modal fade" id="editarPQRSModal" tabindex="-1" role="dialog" aria-labelledby="editarPQRSModalLabel" aria-hidden="true">
        <div class="modal-dialog draggable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editarPQRSModalLabel">Editar PQRS</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Formulario para editar la PQRS -->
                    <form id="editarForm" action="EditarPQRSServlet" method="post">
                        <!-- Campos ocultos para pasar los parámetros necesarios -->
                        <input type="hidden" id="id" name="id">
                        <div class="form-group">
                            <label for="primerNombre">Primer Nombre:</label>
                            <input type="text" class="form-control" id="primerNombre" name="primerNombre" required>
                        </div>
                        <div class="form-group">
                            <label for="segundoNombre">Segundo Nombre:</label>
                            <input type="text" class="form-control" id="segundoNombre" name="segundoNombre">
                        </div>
                        <div class="form-group">
                            <label for="primerApellido">Primer Apellido:</label>
                            <input type="text" class="form-control" id="primerApellido" name="primerApellido" required>
                        </div>
                        <div class="form-group">
                            <label for="segundoApellido">Segundo Apellido:</label>
                            <input type="text" class="form-control" id="segundoApellido" name="segundoApellido">
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="telefono">Teléfono:</label>
                            <input type="text" class="form-control" id="telefono" name="telefono" required>
                        </div>
                        <div class="form-group">
                            <label for="mensaje">Mensaje:</label>
                            <textarea class="form-control" id="mensaje" name="mensaje" rows="5" required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="motivo">Motivo:</label>
                            <select class="form-control" id="motivo" name="motivo" required>
                                <option value="Peticion">Petición</option>
                                <option value="Queja">Queja</option>
                                <option value="Reclamo">Reclamo</option>
                                <option value="Sugerencia">Sugerencia</option>
                            </select>
                        </div>


                        <button type="submit" class="btn btn-primary">Guardar cambios</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
<!-- Script para validar y formatear campos -->
<!-- Script para validar y formatear campos -->
<script>
    $(document).ready(function() {
        // Función para convertir la primera letra en mayúscula y las demás en minúsculas
        function capitalizeFirstLetter(str) {
            return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase();
        }

        // Función para validar y formatear el campo de nombres y apellidos
        function formatNameInput(input) {
            // Eliminar tildes y cambiar la letra 'ñ' por 'n'
            var formatted = input.normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/ñ/gi, 'n');
            // Convertir la primera letra en mayúscula y las demás en minúsculas
            return capitalizeFirstLetter(formatted);
        }

        // Función para validar y formatear el campo de número de teléfono
        function formatPhoneNumber(input) {
            // Eliminar caracteres no numéricos
            var formatted = input.replace(/\D/g, '');
            // Limitar a 10 dígitos
            formatted = formatted.slice(0, 10);
            return formatted;
        }

        // Validar y formatear al perder el foco del campo de nombres y apellidos
        $("#primerNombre, #segundoNombre, #primerApellido, #segundoApellido").blur(function() {
            var value = $(this).val();
            // Eliminar números
            var formatted = value.replace(/[0-9]/g, '');
            $(this).val(formatNameInput(formatted));
        });

        // Validar y formatear al perder el foco del campo de teléfono
        $("#telefono").blur(function() {
            var value = $(this).val();
            $(this).val(formatPhoneNumber(value));
        });

        // Validar longitud máxima de la cédula
        $("#cedula").on("input", function() {
            var value = $(this).val();
            if (value.length > 12) {
                $(this).val(value.slice(0, 12));
            }
        });
    });
</script>


    <!-- Script para prellenar los campos de destinatario y motivo -->
    <!-- Script para prellenar los campos del modal de edición -->
    <!-- Script para prellenar los campos del modal de edición -->
    <script>
        $(document).ready(function () {
            $(".btn-editar").click(function () {
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

                // Preencher campos del formulario
                $("#email").val(email);
                $("#motivo").val(motivo);
                $("#primerNombre").val(primerNombre);
                $("#segundoNombre").val(segundoNombre);
                $("#primerApellido").val(primerApellido);
                $("#segundoApellido").val(segundoApellido);
                $("#telefono").val(telefono);
                $("#mensaje").val(mensaje);
                $("#id").val(id);

                // Mostrar modal de edición
                $("#editarPQRSModal").modal("show");
            });
        });
    </script>







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
            var botonesResponder = document.querySelectorAll('.btn-editar');

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

            // Obtener todos los botones de clase btn-eliminar
            var botonesEliminar = document.querySelectorAll('.btn-eliminar');

            // Iterar sobre cada botón de Eliminar
            botonesEliminar.forEach(function (boton) {
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
