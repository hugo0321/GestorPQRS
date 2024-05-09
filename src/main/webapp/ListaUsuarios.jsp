<%-- 
    Document   : ListaUsuarios
    Created on : 2/05/2024, 11:58:19 a. m.
    Author     : Hugo
--%>
<%@page import="com.mycompany.tutorial.ControladorUsuarios"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.mycompany.tutorial.Usuario" %>
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
        <jsp:include page="navar_Administrador.jsp" />
        <meta charset="UTF-8">
        <title>Listado de Usuarios</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
            /* Estilos CSS aquí */
        </style>
        <script>
            $(document).ready(function () {
                $(".btn-editar").click(function () {
                    var idUsuario = $(this).closest("tr").find(".id-usuario").text();
                    var nombreUsuario = $(this).closest("tr").find(".nombre-usuario").text();
                    var cedula = $(this).closest("tr").find(".cedula").text();
                    var emailRegistro = $(this).closest("tr").find(".email-registro").text();
                    $("#edit-id").val(idUsuario);
                    $("#edit-nombre-usuario").val(nombreUsuario);
                    $("#edit-cedula").val(cedula);
                    $("#edit-email-registro").val(emailRegistro);
                    $("#editarUsuarioModal").modal("show");
                });

                $(".btn-visualizar").click(function () {
                    var nombreUsuario = $(this).closest("tr").find(".nombre-usuario").text();
                    var cedula = $(this).closest("tr").find(".cedula").text();
                    var emailRegistro = $(this).closest("tr").find(".email-registro").text();
                    $("#view-nombre-usuario").val(nombreUsuario);
                    $("#view-cedula").val(cedula);
                    $("#view-email-registro").val(emailRegistro);
                    $("#visualizarUsuarioModal").modal("show");
                });


                $(".btn-eliminar").click(function () {
                    var confirmacion = confirm("¿Estás seguro de que quieres eliminar este usuario?");
                    if (confirmacion) {
                        // Aquí puedes implementar la lógica para enviar una solicitud de eliminación al servidor
                        // Puedes usar AJAX para esto
                    }
                });
            });
             $(document).ready(function() {
        $(".btn-cambiar-rol").click(function() {
            var idUsuario = $(this).data("id");

            // Realizar una solicitud AJAX para llamar al servlet o endpoint correspondiente que maneje el cambio de rol
            $.post("CambiarRolServlet", { idUsuario: idUsuario })
                .done(function(response) {
                    // Manejar la respuesta del servidor, por ejemplo, mostrar un mensaje de éxito o recargar la página
                    alert("¡Rol cambiado exitosamente!");
                    location.reload(); // Recargar la página para reflejar el cambio de rol
                })
                .fail(function(xhr, status, error) {
                    // Manejar errores, por ejemplo, mostrar un mensaje de error
                    alert("Error al cambiar el rol del usuario: " + xhr.responseText);
                });
        });
    });
        </script>
    </head>
    <body>
        <div class="container">
            <h1>Listado de Usuarios</h1>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Nombre de Usuario</th>
                            <th>Cédula</th>
                            <th>Email de Registro</th>
                            <th>Tipo Usuario</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ControladorUsuarios controlador = new ControladorUsuarios();
                            List<Usuario> listaUsuarios;
                            try {
                                listaUsuarios = controlador.obtenerUsuarios();
                                if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                                    for (Usuario usuario : listaUsuarios) {
                        %>
                        <tr>
                            <td class="id-usuario"><%= usuario.getId()%></td>
                            <td class="nombre-usuario"><%= usuario.getNombreUsuario()%></td>
                            <td class="cedula"><%= usuario.getCedula()%></td>
                            <td class="email-registro"><%= usuario.getEmailRegistro()%></td>
                            <td class="email-registro"><%= usuario.getRollUsuario()%></td>
                            <td>
                                <button class="btn btn-info btn-sm btn-visualizar">Visualizar</button>
                                <button class="btn btn-warning btn-sm btn-editar">Editar</button>
                                <button class="btn btn-danger btn-sm btn-eliminar" data-id="<%= usuario.getId()%>">Eliminar</button>
                                <button class="btn btn-primary btn-sm btn-cambiar-rol" data-id="<%= usuario.getId()%>">Cambiar Rol</button>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" class="no-data">No hay usuarios disponibles.</td>
                        </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                out.println("Error al obtener usuarios: " + e.getMessage());
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Modal para editar usuario -->
        <div class="modal fade" id="editarUsuarioModal" tabindex="-1" role="dialog" aria-labelledby="editarUsuarioModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editarUsuarioModalLabel">Editar Usuario</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editarUsuarioForm" action="editarUsuario.jsp" method="post">
                            <input type="hidden" id="edit-id" name="id">
                            <div class="form-group">
                                <label for="edit-nombre-usuario">Nombre de Usuario</label>
                                <input type="text" class="form-control" id="edit-nombre-usuario" name="nombreUsuario" required pattern="^(?!admin)[a-zA-Z0-9.,]+$">
                                <small class="form-text text-muted">No se permite el nombre "admin" y solo se admiten letras, números, ".", y ",".</small>
                            </div>
                            <div class="form-group">
                                <label for="edit-cedula">Cédula</label>
                                <input type="number" class="form-control" id="edit-cedula" name="cedula" required max="999999999999" pattern="[0-9]{1,12}">
                                <small class="form-text text-muted">Máximo 12 dígitos numéricos.</small>
                            </div>
                            <div class="form-group">
                                <label for="edit-email-registro">Email de Registro</label>
                                <input type="email" class="form-control" id="edit-email-registro" name="emailRegistro" required>
                            </div>
                            <button type="submit" class="btn btn-primary" onclick="return validarEditarUsuario()">Guardar Cambios</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function validarEditarUsuario() {
                var nombreUsuario = document.getElementById("edit-nombre-usuario").value;
                var cedula = document.getElementById("edit-cedula").value;

                // Validar nombre de usuario
                if (nombreUsuario === "admin" || !/^[a-zA-Z0-9.,]+$/.test(nombreUsuario)) {
                    alert("El nombre de usuario no puede ser 'admin' y solo se admiten letras, números, '.', y ','.");
                    return false;
                }

                // Validar cédula
                if (!/^\d{1,12}$/.test(cedula)) {
                    alert("La cédula solo puede contener hasta 12 dígitos numéricos.");
                    return false;
                }

                return true; // Enviar el formulario si pasa todas las validaciones
            }
        </script>
        <script>
            $(document).ready(function () {
                $(".btn-eliminar").click(function () {
                    var idUsuario = $(this).data("id");
                    var confirmacion = confirm("¿Estás seguro de que quieres eliminar este usuario?");
                    if (confirmacion) {
                        // Enviar una solicitud AJAX al servidor para eliminar el usuario
                        $.ajax({
                            type: "POST",
                            url: "eliminarUsuario.jsp",
                            data: {id: idUsuario},
                            success: function (data) {
                                // Recargar la página después de eliminar el usuario
                                location.reload();
                            },
                            error: function (xhr, status, error) {
                                // Manejar errores de AJAX, si es necesario
                                console.error("Error al eliminar el usuario:", error);
                            }
                        });
                    }
                });
            });
        </script>


        <!-- Modal para visualizar usuario -->
        <div class="modal fade" id="visualizarUsuarioModal" tabindex="-1" role="dialog" aria-labelledby="visualizarUsuarioModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="visualizarUsuarioModalLabel">Detalles del Usuario</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="view-nombre-usuario">Nombre de Usuario</label>
                            <input type="text" class="form-control" id="view-nombre-usuario" readonly>
                        </div>
                        <div class="form-group">
                            <label for="view-cedula">Cédula</label>
                            <input type="text" class="form-control" id="view-cedula" readonly>
                        </div>
                        <div class="form-group">
                            <label for="view-email-registro">Email de Registro</label>
                            <input type="email" class="form-control" id="view-email-registro" readonly>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer class="bg-light py-5">
            <div class="container px-4 px-lg-5">
                <div class="small text-center text-muted">Copyright &copy; 2024 - Company HL</div>
            </div>
        </footer>
    </body>
</html>
