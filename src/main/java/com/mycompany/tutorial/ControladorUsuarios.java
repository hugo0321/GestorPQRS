/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tutorial;

import static com.mycompany.tutorial.ConexionBaseDeDatos.getConexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Hugo
 */
public class ControladorUsuarios {

 /**
 * Autentica el inicio de sesión de un usuario y devuelve su rol.
 *
 * @param nombreUsuario Nombre de usuario.
 * @param contrasena Contraseña del usuario.
 * @return Rol del usuario: "Administrador" si las credenciales son válidas y el rol es "Administrador",
 *         "Usuario Normal" si las credenciales son válidas y el rol es "Usuario Normal",
 *         o null si las credenciales son inválidas o no se encuentra el usuario.
 */
public static String autenticarUsuario(String nombreUsuario, String contrasena) {
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    String rolUsuario = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            String sql = "SELECT Roll FROM Usuarios WHERE nombre_usuario = ? AND contrasena = ?";
            statement = conexion.prepareStatement(sql);
            statement.setString(1, nombreUsuario);
            statement.setString(2, contrasena);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Si las credenciales son correctas, obtiene el rol del usuario
                rolUsuario = resultSet.getString("Roll");
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al autenticar el usuario: " + e.getMessage());
        e.printStackTrace();
    } finally {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        } catch (SQLException ex) {
            System.out.println("Error al cerrar la conexión: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
    return rolUsuario; // Devuelve el rol del usuario, que puede ser null si las credenciales son inválidas
}


    /**
     * Obtiene el ID de un usuario basado en su nombre de usuario.
     *
     * @param nombreUsuario Nombre de usuario.
     * @return ID del usuario.
     * @throws SQLException Si ocurre un error de SQL durante la obtención.
     */
    public static int obtenerIdUsuario(String nombreUsuario) throws SQLException {
        Connection conexion = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        int usuarioId = 0; // Inicializamos el usuarioId

        try {
            conexion = getConexion();
            if (conexion != null) {
                String sql = "SELECT id FROM Usuarios WHERE nombre_usuario = ?";
                statement = conexion.prepareStatement(sql);
                statement.setString(1, nombreUsuario);
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    usuarioId = resultSet.getInt("id");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener el ID de usuario: " + e.getMessage());
            throw e; // Relanzamos la excepción para manejarla en el servlet
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (conexion != null) {
                    conexion.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar la conexión: " + ex.getMessage());
                throw ex; // Relanzamos la excepción para manejarla en el servlet
            }
        }

        return usuarioId;
    }

    /**
     * Obtiene todos los usuarios registrados en el sistema.
     *
     * @return Lista de objetos Usuario.
     * @throws SQLException Si ocurre un error de SQL al obtener los usuarios.
     */
    public List<Usuario> obtenerUsuarios() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            conexion = getConexion();
            if (conexion != null) {
                String sql = "SELECT * FROM Usuarios";
                statement = conexion.prepareStatement(sql);
                resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(resultSet.getInt("id"));
                    usuario.setNombreUsuario(resultSet.getString("nombre_usuario"));
                    usuario.setCedula(resultSet.getString("cedula"));
                    usuario.setContrasena(resultSet.getString("contrasena"));
                    usuario.setEmailRegistro(resultSet.getString("emailRegistro"));
                    usuario.setRollUsuario(resultSet.getString("Roll"));
                    usuarios.add(usuario);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener los usuarios: " + e.getMessage());
            throw e;
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (conexion != null) {
                    conexion.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar la conexión: " + ex.getMessage());
                ex.printStackTrace();
            }
        }
        return usuarios;
    }

    /**
     * Inserta un nuevo usuario en la base de datos.
     *
     * @param nombreUsuario Nombre de usuario.
     * @param cedula Cédula del usuario.
     * @param contrasena Contraseña del usuario.
     * @param emailRegistro Correo electrónico del usuario.
     * @throws SQLException Si ocurre un error de SQL durante la inserción.
     */
    public static void insertarUsuario(String nombreUsuario, String cedula, String contrasena, String emailRegistro) throws SQLException {
        Connection conexion = null;
        PreparedStatement statement = null;
        try {
            conexion = getConexion();
            if (conexion != null) {
                String sql = "INSERT INTO Usuarios (nombre_usuario, cedula, contrasena, emailRegistro) VALUES (?, ?, ?, ?)";
                statement = conexion.prepareStatement(sql);
                statement.setString(1, nombreUsuario);
                statement.setString(2, cedula);
                statement.setString(3, contrasena);
                statement.setString(4, emailRegistro);

                int filasInsertadas = statement.executeUpdate();
                if (filasInsertadas > 0) {
                    System.out.println("Usuario insertado correctamente.");
                } else {
                    System.out.println("No se pudo insertar el usuario.");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al insertar el usuario: " + e.getMessage());
            throw e;
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
    }

    /**
     * Verifica si un usuario ya existe en la base de datos.
     *
     * @param nombreUsuario Nombre de usuario.
     * @param cedula Cédula del usuario.
     * @param email Correo electrónico del usuario.
     * @return true si el usuario existe, false si no.
     * @throws SQLException Si ocurre un error de SQL al verificar la
     * existencia.
     */
    public static boolean existeUsuario(String nombreUsuario, String cedula, String email) throws SQLException {
        Connection conexion = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        boolean existe = false; // Variable para indicar si el usuario existe

        try {
            conexion = getConexion();
            if (conexion != null) {
                // Consulta SQL para verificar si ya existe un usuario con el mismo nombre de usuario, cédula o correo electrónico
                String consultaExistencia = "SELECT COUNT(*) FROM Usuarios WHERE nombre_usuario = ? OR cedula = ? OR emailRegistro = ?";
                statement = conexion.prepareStatement(consultaExistencia);
                statement.setString(1, nombreUsuario);
                statement.setString(2, cedula);
                statement.setString(3, email);

                resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    // Si el conteo es mayor que cero, significa que ya existe un usuario con esos datos
                    existe = resultSet.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al verificar la existencia del usuario: " + e.getMessage());
            throw e;
        } finally {
            // Cierre de recursos
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }

        return existe; // Devuelve true si el usuario existe, false si no
    }

    /**
     * Obtiene todas las PQRS asociadas a un usuario específico.
     *
     * @param usuarioId ID del usuario.
     * @return Lista de objetos PQRS asociadas al usuario.
     * @throws SQLException Si ocurre un error de SQL al obtener las PQRS del
     * usuario.
     */
   public List<PQRS> obtenerPQRSUsuario(int usuarioId) throws SQLException {
    List<PQRS> pqrsList = new ArrayList<>();
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            String sql = "SELECT p.*, tp.Motivo AS MotivoNombre FROM PQRS p JOIN Usuarios u ON p.usuario_id = u.id " +
                         "JOIN TipoPQRS tp ON p.TipoPQRS = tp.id WHERE u.id = ?";
            statement = conexion.prepareStatement(sql);
            statement.setInt(1, usuarioId);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                PQRS pqrs = new PQRS();
                pqrs.setId(resultSet.getInt("id"));
                pqrs.setPrimerNombre(resultSet.getString("PrimerNombre"));
                pqrs.setSegundoNombre(resultSet.getString("SegundoNombre"));
                pqrs.setPrimerApellido(resultSet.getString("PrimerApellido"));
                pqrs.setSegundoApellido(resultSet.getString("SegundoApellido"));
                pqrs.setIdMotivo(resultSet.getInt("TipoPQRS"));
                pqrs.setMotivoNombre(resultSet.getString("MotivoNombre"));
                pqrs.setEmail(resultSet.getString("email"));
                pqrs.setTelefono(resultSet.getString("Telefono"));
                pqrs.setMensaje(resultSet.getString("Mensaje"));
                pqrs.setHoraSolicitud(resultSet.getTimestamp("HoraSolicitud"));
                pqrs.setRutaPDF(resultSet.getString("RutaPDF"));
                pqrs.setEstado(resultSet.getString("Estado"));
                pqrsList.add(pqrs);
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al obtener las PQRS del usuario: " + e.getMessage());
        throw e;
    } finally {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        } catch (SQLException ex) {
            System.out.println("Error al cerrar la conexión: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
    return pqrsList;
}


    /**
     * Edita los datos de un usuario en la base de datos.
     *
     * @param id ID del usuario a editar.
     * @param nombreUsuario Nuevo nombre de usuario.
     * @param cedula Nueva cédula del usuario.
     * @param emailRegistro Nuevo correo electrónico del usuario.
     * @throws SQLException Si ocurre un error de SQL durante la actualización.
     */
    public static void editarUsuario(int id, String nombreUsuario, String cedula, String emailRegistro) throws SQLException {
        Connection conexion = null;
        PreparedStatement statement = null;
        try {
            conexion = getConexion();
            if (conexion != null) {
                String sql = "UPDATE Usuarios SET nombre_usuario = ?, cedula = ?, emailRegistro = ? WHERE id = ?";
                statement = conexion.prepareStatement(sql);
                statement.setString(1, nombreUsuario);
                statement.setString(2, cedula);
                statement.setString(3, emailRegistro);
                statement.setInt(4, id);

                int filasActualizadas = statement.executeUpdate();
                if (filasActualizadas > 0) {
                    System.out.println("Usuario actualizado correctamente.");
                } else {
                    System.out.println("No se pudo actualizar el usuario.");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al actualizar el usuario: " + e.getMessage());
            throw e;
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
    }

    /**
     * Elimina un usuario y todas sus PQRS asociadas de la base de datos.
     *
     * @param id ID del usuario a eliminar.
     * @throws SQLException Si ocurre un error de SQL durante la eliminación.
     */
    public static void eliminarUsuario(int id) throws SQLException {
        Connection conexion = null;
        PreparedStatement statement = null;
        try {
            conexion = getConexion();
            if (conexion != null) {
                // Eliminar todas las PQRS del usuario
                String sqlEliminarPQRS = "DELETE FROM PQRS WHERE usuario_id = ?";
                statement = conexion.prepareStatement(sqlEliminarPQRS);
                statement.setInt(1, id);
                int filasEliminadasPQRS = statement.executeUpdate();
                System.out.println("Se han eliminado " + filasEliminadasPQRS + " PQRS asociadas al usuario.");

                // Ahora eliminar al usuario
                String sqlEliminarUsuario = "DELETE FROM Usuarios WHERE id = ?";
                statement = conexion.prepareStatement(sqlEliminarUsuario);
                statement.setInt(1, id);
                int filasEliminadasUsuario = statement.executeUpdate();
                if (filasEliminadasUsuario > 0) {
                    System.out.println("Usuario eliminado correctamente.");
                } else {
                    System.out.println("No se pudo eliminar el usuario.");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al eliminar el usuario: " + e.getMessage());
            throw e;
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
    }

    /**
     * Recupera un usuario basado en la coincidencia de la cédula y el correo
     * electrónico proporcionados.
     *
     * @param cedula Cédula del usuario.
     * @param correo Correo electrónico del usuario.
     * @return Objeto Usuario si la coincidencia es encontrada, o null si no lo
     * es.
     * @throws SQLException Si ocurre un error de SQL durante la búsqueda.
     */
    public static Usuario recuperarUsuario(String cedula, String correo) throws SQLException {
        Connection conexion = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        Usuario usuario = null; // Inicializamos el usuario como null

        try {
            conexion = ConexionBaseDeDatos.getConexion();
            if (conexion != null) {
                String sql = "SELECT * FROM Usuarios WHERE cedula = ? AND emailRegistro = ?";
                statement = conexion.prepareStatement(sql);
                statement.setString(1, cedula);
                statement.setString(2, correo);
                resultSet = statement.executeQuery();
                System.out.println("Consulta SQL: " + sql);

                if (resultSet.next()) {
                    // Si se encuentra una coincidencia, se crea un objeto Usuario con los datos correspondientes
                    usuario = new Usuario();
                    usuario.setId(resultSet.getInt("id"));
                    usuario.setNombreUsuario(resultSet.getString("nombre_usuario"));
                    usuario.setCedula(resultSet.getString("cedula"));
                    usuario.setContrasena(resultSet.getString("contrasena"));
                    usuario.setEmailRegistro(resultSet.getString("emailRegistro"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al recuperar usuario: " + e.getMessage());
            throw e; // Relanzamos la excepción para manejarla en el contexto superior
        } finally {
            // Cierre de recursos
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (conexion != null) {
                    conexion.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar la conexión: " + ex.getMessage());
                throw ex; // Relanzamos la excepción para manejarla en el contexto superior
            }
        }

        return usuario; // Devuelve el objeto Usuario, que puede ser null si no se encuentra coincidencia
    }
     /**
     * Cambia el rol de un usuario de "usuarioNormal" a "Administrador" o viceversa.
     *
     * @param id ID del usuario cuyo rol se desea cambiar.
     * @throws SQLException Si ocurre un error de SQL durante la actualización.
     */
    public static void cambiarRolUsuario(int id) throws SQLException {
        Connection conexion = null;
        PreparedStatement statement = null;
        try {
            conexion = getConexion();
            if (conexion != null) {
                // Obtener el rol actual del usuario
                String rolActual = obtenerRolUsuario(id);

                // Determinar el nuevo rol
                String nuevoRol = "usuarioNormal";
                if (rolActual.equals("usuarioNormal")) {
                    nuevoRol = "Administrador";
                }

                // Actualizar el rol en la base de datos
                String sql = "UPDATE Usuarios SET Roll = ? WHERE id = ?";
                statement = conexion.prepareStatement(sql);
                statement.setString(1, nuevoRol);
                statement.setInt(2, id);

                int filasActualizadas = statement.executeUpdate();
                if (filasActualizadas > 0) {
                    System.out.println("Rol de usuario actualizado correctamente.");
                } else {
                    System.out.println("No se pudo actualizar el rol de usuario.");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al cambiar el rol de usuario: " + e.getMessage());
            throw e;
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
    }

    /**
     * Obtiene el rol de un usuario basado en su ID.
     *
     * @param id ID del usuario.
     * @return Rol del usuario.
     * @throws SQLException Si ocurre un error de SQL al obtener el rol.
     */
    public static String obtenerRolUsuario(int id) throws SQLException {
        Connection conexion = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String rol = null; // Inicializamos el rol como null

        try {
            conexion = getConexion();
            if (conexion != null) {
                String sql = "SELECT Roll FROM Usuarios WHERE id = ?";
                statement = conexion.prepareStatement(sql);
                statement.setInt(1, id);
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    rol = resultSet.getString("Roll");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener el rol de usuario: " + e.getMessage());
            throw e;
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }

        return rol;
    }
}
