/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tutorial;
import static com.mycompany.tutorial.ConexionBaseDeDatos.getConexion;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
/**
 *
 * @author Hugo
 */
public class ControladorUsuarios {
    
    /**
 * Realiza el inicio de sesión de un usuario.
 *
 * @param nombreUsuario Nombre de usuario.
 * @param contrasena    Contraseña del usuario.
 * @return Objeto Usuario si las credenciales son válidas, o null si no lo son.
 */
    public static Usuario login(String nombreUsuario, String contrasena) {
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    Usuario usuario = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            String sql = "SELECT id, nombre_usuario, cedula FROM Usuarios WHERE nombre_usuario = ? AND contrasena = ?";
            statement = conexion.prepareStatement(sql);
            statement.setString(1, nombreUsuario);
            statement.setString(2, contrasena);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                // Si las credenciales son correctas, crea un objeto Usuario con los datos correspondientes
                usuario = new Usuario();
                usuario.setId(resultSet.getInt("id"));
                usuario.setNombreUsuario(resultSet.getString("nombre_usuario"));
                usuario.setCedula(resultSet.getString("cedula"));
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al realizar el login: " + e.getMessage());
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
    return usuario; // Devuelve el objeto Usuario, que puede ser null si el inicio de sesión falla
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
 * @param cedula        Cédula del usuario.
 * @param contrasena    Contraseña del usuario.
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
 * @param cedula        Cédula del usuario.
 * @param email         Correo electrónico del usuario.
 * @return true si el usuario existe, false si no.
 * @throws SQLException Si ocurre un error de SQL al verificar la existencia.
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
 * @throws SQLException Si ocurre un error de SQL al obtener las PQRS del usuario.
 */
    public List<PQRS> obtenerPQRSUsuario(int usuarioId) throws SQLException {
    List<PQRS> pqrsList = new ArrayList<>();
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            String sql = "SELECT p.* FROM PQRS p JOIN Usuarios u ON p.usuario_id = u.id WHERE u.id = ?";
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
                pqrs.setMotivo(resultSet.getString("Motivo"));
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
 * @param id            ID del usuario a editar.
 * @param nombreUsuario Nuevo nombre de usuario.
 * @param cedula        Nueva cédula del usuario.
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
}
