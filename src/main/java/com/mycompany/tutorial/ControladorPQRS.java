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
public class ControladorPQRS {
    /**
 * Inserta una nueva PQRS (Petición, Queja, Reclamo, Sugerencia) en la base de datos.
 *
 * @param primerNombre    Primer nombre del remitente.
 * @param segundoNombre   Segundo nombre del remitente.
 * @param primerApellido  Primer apellido del remitente.
 * @param segundoApellido Segundo apellido del remitente.
 * @param motivo          Motivo de la PQRS.
 * @param email           Dirección de correo electrónico del remitente.
 * @param telefono        Número de teléfono del remitente.
 * @param mensaje         Mensaje adicional (opcional).
 * @param rutaPDF         Ruta del archivo PDF adjunto (opcional).
 * @param usuario_id      ID del usuario asociado a la PQRS.
 * @throws SQLException   Si ocurre un error de SQL durante la inserción.
 */
    public static void insertarPQRS(String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, String motivo, String email, String telefono, String mensaje, String rutaPDF, int usuario_id) throws SQLException {
    Connection conexion = null;
    PreparedStatement statement = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            String sql = "INSERT INTO PQRS (PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, Motivo, email, Telefono, Mensaje, RutaPDF, usuario_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            statement = conexion.prepareStatement(sql);
            statement.setString(1, primerNombre);
            statement.setString(2, segundoNombre);
            statement.setString(3, primerApellido);
            statement.setString(4, segundoApellido);
            statement.setString(5, motivo);
            statement.setString(6, email);
            statement.setString(7, telefono);

            // Verificar si se proporcionó un mensaje o un PDF y establecer el valor correspondiente en la consulta SQL
            if (mensaje != null && !mensaje.isEmpty()) {
                statement.setString(8, mensaje);
            } else {
                statement.setNull(8, Types.VARCHAR);
            }

            if (rutaPDF != null && !rutaPDF.isEmpty()) {
                statement.setString(9, rutaPDF);
            } else {
                statement.setNull(9, Types.VARCHAR);
            }

            // Insertar el ID de usuario en la base de datos
            statement.setInt(10, usuario_id);

            int filasInsertadas = statement.executeUpdate();
            if (filasInsertadas > 0) {
                System.out.println("PQRS insertada correctamente.");
            } else {
                System.out.println("No se pudo insertar la PQRS.");
            }
          
        }
    } catch (SQLException e) {
        System.out.println("Error al insertar la PQRS: " + e.getMessage());
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
 * Obtiene todas las PQRS con sus datos correspondientes, dándole prioridad a las de tipo "Petición".
 *
 * @return Lista de objetos PQRS.
 * @throws SQLException Si ocurre un error de SQL al obtener las PQRS.
 */
    public List<PQRS> obtenerPQRS() throws SQLException {
    List<PQRS> pqrsList = new ArrayList<>();
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            String sql = "SELECT PQRS.*, Usuarios.nombre_usuario " +
                         "FROM PQRS " +
                         "INNER JOIN Usuarios ON PQRS.usuario_id = Usuarios.id " +
                         "ORDER BY CASE WHEN Motivo = 'Petición' THEN 0 ELSE 1 END";
            statement = conexion.prepareStatement(sql);
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
                pqrs.setNombreUsuario(resultSet.getString("nombre_usuario"));
                pqrs.setRutaPDF(resultSet.getString("RutaPDF")); // Agregamos la ruta PDF
                pqrs.setEstado(resultSet.getString("Estado")); // Agregamos el Estado
                pqrsList.add(pqrs);
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al obtener las PQRS: " + e.getMessage());
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
 * Verifica si ya existe una PQRS con los mismos datos para el mismo usuario en la base de datos.
 *
 * @param usuarioId       ID del usuario asociado a la PQRS.
 * @param primerNombre    Primer nombre del remitente.
 * @param segundoNombre   Segundo nombre del remitente.
 * @param primerApellido  Primer apellido del remitente.
 * @param segundoApellido Segundo apellido del remitente.
 * @param motivo          Motivo de la PQRS.
 * @param email           Dirección de correo electrónico del remitente.
 * @param telefono        Número de teléfono del remitente.
 * @param mensaje         Mensaje adicional (opcional).
 * @param rutaPDF         Ruta del archivo PDF adjunto (opcional).
 * @return true si la PQRS existe, false si no.
 * @throws SQLException   Si ocurre un error de SQL al verificar la existencia.
 */
    public static boolean existePQRS(int usuarioId, String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, String motivo, String email, String telefono, String mensaje, String rutaPDF) throws SQLException {
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    boolean existe = false; // Variable para indicar si la PQRS existe

    try {
        conexion = getConexion();
        if (conexion != null) {
            // Consulta SQL para verificar si existe una PQRS con los mismos datos para el mismo usuario
            String consultaExistencia = "SELECT COUNT(*) FROM PQRS WHERE usuario_id = ? AND PrimerNombre = ? AND SegundoNombre = ? AND PrimerApellido = ? AND SegundoApellido = ? AND Motivo = ? AND email = ? AND Telefono = ? AND Mensaje = ?";
            statement = conexion.prepareStatement(consultaExistencia);
            statement.setInt(1, usuarioId);
            statement.setString(2, primerNombre);
            statement.setString(3, segundoNombre);
            statement.setString(4, primerApellido);
            statement.setString(5, segundoApellido);
            statement.setString(6, motivo);
            statement.setString(7, email);
            statement.setString(8, telefono);
            statement.setString(9, mensaje);

            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                // Si el conteo es mayor que cero, significa que ya existe una PQRS con esos datos para el mismo usuario
                existe = resultSet.getInt(1) > 0;
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al verificar la existencia de la PQRS: " + e.getMessage());
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

    return existe; // Devuelve true si la PQRS existe, false si no
}
    
    /**
 * Cambia el estado de una PQRS en la base de datos.
 *
 * @param idPQRS         ID de la PQRS a la que se cambiará el estado.
 * @param nuevoEstado    Nuevo estado que se asignará a la PQRS.
 * @throws SQLException  Si ocurre un error de SQL al cambiar el estado.
 */
    public void cambiarEstadoPQRS(int idPQRS, String nuevoEstado) throws SQLException {
    Connection conexion = null;
    PreparedStatement statement = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            // Consulta SQL para actualizar el estado de la PQRS
            String sql = "UPDATE PQRS SET Estado = ? WHERE id = ?";
            statement = conexion.prepareStatement(sql);
            statement.setString(1, nuevoEstado);
            statement.setInt(2, idPQRS);

            int filasActualizadas = statement.executeUpdate();
            if (filasActualizadas > 0) {
                System.out.println("Estado de PQRS actualizado correctamente.");
            } else {
                System.out.println("No se pudo actualizar el estado de la PQRS.");
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al cambiar el estado de la PQRS: " + e.getMessage());
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
 * Obtiene el ID de una PQRS en la base de datos según su motivo y el correo electrónico del usuario.
 *
 * @param motivo         Motivo de la PQRS.
 * @param emailUsuario   Correo electrónico del usuario asociado a la PQRS.
 * @return ID de la PQRS, o -1 si no se encuentra.
 * @throws SQLException  Si ocurre un error de SQL al obtener el ID.
 */
    public int obtenerIdPQRS(String motivo, String emailUsuario) throws SQLException {
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    int idPQRS = -1; // Valor predeterminado en caso de que no se encuentre ninguna PQRS

    try {
        conexion = getConexion();
        if (conexion != null) {
            // Consulta SQL para obtener el ID de la PQRS con el motivo y el correo electrónico especificados
            String consulta = "SELECT id FROM PQRS WHERE Motivo = ? AND email = ?";
            statement = conexion.prepareStatement(consulta);
            statement.setString(1, motivo);
            statement.setString(2, emailUsuario);

            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                idPQRS = resultSet.getInt("id");
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al obtener el ID de la PQRS: " + e.getMessage());
        throw e;
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
            ex.printStackTrace();
        }
    }

    return idPQRS;
}
}
