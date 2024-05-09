/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tutorial;

import static com.mycompany.tutorial.ConexionBaseDeDatos.getConexion;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Hugo
 */
public class ControladorPQRS {

       /**
     * Inserta una nueva PQRS (Petición, Queja, Reclamo, Sugerencia) en la base
     * de datos.
     *
     * @param primerNombre     Primer nombre del remitente.
     * @param segundoNombre    Segundo nombre del remitente.
     * @param primerApellido   Primer apellido del remitente.
     * @param segundoApellido  Segundo apellido del remitente.
     * @param motivo           Motivo de la PQRS.
     * @param email            Dirección de correo electrónico del remitente.
     * @param telefono         Número de teléfono del remitente.
     * @param mensaje          Mensaje adicional (opcional).
     * @param rutaPDF          Ruta del archivo PDF adjunto (opcional).
     * @param usuario_id       ID del usuario asociado a la PQRS.
     * @throws SQLException Si ocurre un error de SQL durante la inserción.
     */
    public static void insertarPQRS(String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, int motivo, String email, String telefono, String mensaje, String rutaPDF, int usuario_id) throws SQLException {
        Connection conexion = null;
        PreparedStatement statement = null;
        try {
            conexion = getConexion(); // Implementa este método para obtener una conexión a la base de datos
            if (conexion != null) {
                String sql = "INSERT INTO PQRS (PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, TipoPQRS, email, Telefono, Mensaje, RutaPDF, usuario_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                statement = conexion.prepareStatement(sql);
                statement.setString(1, primerNombre);
                statement.setString(2, segundoNombre);
                statement.setString(3, primerApellido);
                statement.setString(4, segundoApellido);
                statement.setInt(5, motivo);
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
 * Obtiene todas las PQRS con sus datos correspondientes, dándole prioridad
 * a las de tipo "Petición".
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
            String sql = "SELECT PQRS.*, Usuarios.nombre_usuario, TipoPQRS.Motivo AS nombreMotivo "
                    + "FROM PQRS "
                    + "INNER JOIN Usuarios ON PQRS.usuario_id = Usuarios.id "
                    + "INNER JOIN TipoPQRS ON PQRS.TipoPQRS = TipoPQRS.id " // Cambio de "Motivos" a "TipoPQRS"
                    + "ORDER BY CASE WHEN TipoPQRS.Motivo = 'Petición' THEN 0 ELSE 1 END";
            statement = conexion.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                PQRS pqrs = new PQRS();
                pqrs.setId(resultSet.getInt("id"));
                pqrs.setPrimerNombre(resultSet.getString("PrimerNombre"));
                pqrs.setSegundoNombre(resultSet.getString("SegundoNombre"));
                pqrs.setPrimerApellido(resultSet.getString("PrimerApellido"));
                pqrs.setSegundoApellido(resultSet.getString("SegundoApellido"));
                pqrs.setIdMotivo(resultSet.getInt("TipoPQRS")); // Cambio de "Motivo" a "TipoPQRS"
                pqrs.setMotivoNombre(resultSet.getString("nombreMotivo"));
                pqrs.setEmail(resultSet.getString("email"));
                pqrs.setTelefono(resultSet.getString("Telefono"));
                pqrs.setMensaje(resultSet.getString("Mensaje"));
                pqrs.setHoraSolicitud(resultSet.getTimestamp("HoraSolicitud"));
                pqrs.setNombreUsuario(resultSet.getString("nombre_usuario"));
                pqrs.setRutaPDF(resultSet.getString("RutaPDF"));
                pqrs.setEstado(resultSet.getString("Estado"));
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
     * Verifica si ya existe una PQRS con los mismos datos para el mismo usuario
     * en la base de datos.
     *
     * @param usuarioId ID del usuario asociado a la PQRS.
     * @param primerNombre Primer nombre del remitente.
     * @param segundoNombre Segundo nombre del remitente.
     * @param primerApellido Primer apellido del remitente.
     * @param segundoApellido Segundo apellido del remitente.
     * @param motivo Motivo de la PQRS.
     * @param email Dirección de correo electrónico del remitente.
     * @param telefono Número de teléfono del remitente.
     * @param mensaje Mensaje adicional (opcional).
     * @param rutaPDF Ruta del archivo PDF adjunto (opcional).
     * @return true si la PQRS existe, false si no.
     * @throws SQLException Si ocurre un error de SQL al verificar la
     * existencia.
     */
    public static boolean existePQRS(int usuarioId, String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, int motivo, String email, String telefono, String mensaje, String rutaPDF) throws SQLException {
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
                 statement.setInt(6, motivo);
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
     * @param idPQRS ID de la PQRS a la que se cambiará el estado.
     * @param nuevoEstado Nuevo estado que se asignará a la PQRS.
     * @throws SQLException Si ocurre un error de SQL al cambiar el estado.
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
     * Obtiene el ID de una PQRS en la base de datos según sus datos.
     *
     * @param primerNombre Primer nombre de la PQRS.
     * @param segundoNombre Segundo nombre de la PQRS.
     * @param primerApellido Primer apellido de la PQRS.
     * @param segundoApellido Segundo apellido de la PQRS.
     * @param motivo Motivo de la PQRS.
     * @param emailUsuario Correo electrónico de la PQRS.
     * @param telefono Teléfono de la PQRS.
     * @param mensaje Mensaje de la PQRS.
     * @param rutaPDF Ruta del PDF adjunto de la PQRS.
     * @return ID de la PQRS, o -1 si no se encuentra.
     * @throws SQLException Si ocurre un error de SQL al obtener el ID.
     */
    public int obtenerIdPQRS(String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, String motivo, String emailUsuario, String telefono, String mensaje, String rutaPDF) throws SQLException {
        Connection conexion = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        int idPQRS = -1; // Valor predeterminado en caso de que no se encuentre ninguna PQRS

        try {
            conexion = getConexion();
            if (conexion != null) {
                // Consulta SQL para obtener el ID de la PQRS con los datos especificados
                String consulta = "SELECT id FROM PQRS WHERE PrimerNombre = ? AND SegundoNombre = ? AND PrimerApellido = ? AND SegundoApellido = ? AND Motivo = ? AND email = ? AND Telefono = ? AND Mensaje = ? AND RutaPDF = ?";
                statement = conexion.prepareStatement(consulta);
                statement.setString(1, primerNombre);
                statement.setString(2, segundoNombre);
                statement.setString(3, primerApellido);
                statement.setString(4, segundoApellido);
                statement.setString(5, motivo);
                statement.setString(6, emailUsuario);
                statement.setString(7, telefono);
                statement.setString(8, mensaje);
                statement.setString(9, rutaPDF);

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

   
/**
 * Elimina una PQRS específica de la base de datos.
 *
 * @param idPQRS El ID de la PQRS que se va a eliminar.
 * @throws SQLException Si ocurre algún error al intentar acceder a la base
 *                      de datos.
 */
public void eliminarPQRS(int idPQRS) throws SQLException {
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            String obtenerRutaSQL = "SELECT RutaPDF FROM PQRS WHERE id = ?";
            statement = conexion.prepareStatement(obtenerRutaSQL);
            statement.setInt(1, idPQRS);
            resultSet = statement.executeQuery();
            
            String rutaDocumento = null;
            if (resultSet.next()) {
                rutaDocumento = resultSet.getString("RutaPDF");
            }
            
            String eliminarPQRSSQL = "DELETE FROM PQRS WHERE id = ?";
            statement = conexion.prepareStatement(eliminarPQRSSQL);
            statement.setInt(1, idPQRS);

            int filasEliminadas = statement.executeUpdate();
            if (filasEliminadas > 0) {
                System.out.println("PQRS eliminada correctamente.");
                // Eliminar el documento asociado si existe
                if (rutaDocumento != null) {
                    File documento = new File(rutaDocumento);
                    if (documento.exists()) {
                        if (documento.delete()) {
                            System.out.println("Documento asociado eliminado correctamente.");
                        } else {
                            System.out.println("No se pudo eliminar el documento asociado.");
                        }
                    }
                }
            } else {
                System.out.println("No se pudo eliminar la PQRS.");
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al eliminar la PQRS: " + e.getMessage());
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
}

  /**
 * Edita una PQRS existente en la base de datos.
 *
 * @param idPQRS ID de la PQRS que se va a editar.
 * @param primerNombre Nuevo primer nombre del remitente.
 * @param segundoNombre Nuevo segundo nombre del remitente.
 * @param primerApellido Nuevo primer apellido del remitente.
 * @param segundoApellido Nuevo segundo apellido del remitente.
 * @param motivo Nuevo motivo de la PQRS.
 * @param email Nuevo correo electrónico del remitente.
 * @param telefono Nuevo número de teléfono del remitente.
 * @param mensaje Nuevo mensaje adicional (opcional).
 * @param nuevaRutaPDF Nueva ruta del archivo PDF adjunto.
 * @throws SQLException Si ocurre un error de SQL durante la actualización.
 */
public void editarPQRS(int idPQRS, String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, String motivo, String email, String telefono, String mensaje, String nuevaRutaPDF) throws SQLException {
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet rs = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            // Consulta SQL para obtener la ruta del PDF actual antes de la actualización
            String sqlSelect = "SELECT RutaPDF FROM PQRS WHERE id = ?";
            statement = conexion.prepareStatement(sqlSelect);
            statement.setInt(1, idPQRS);
            rs = statement.executeQuery();

            String rutaAnteriorPDF = null;
            if (rs.next()) {
                rutaAnteriorPDF = rs.getString("RutaPDF");
            }

            // Consulta SQL para actualizar los datos de la PQRS
            String sqlUpdate = "UPDATE PQRS SET PrimerNombre = ?, SegundoNombre = ?, PrimerApellido = ?, SegundoApellido = ?, TipoPQRS = ?, email = ?, Telefono = ?, Mensaje = ?, RutaPDF = ? WHERE id = ?";
            statement = conexion.prepareStatement(sqlUpdate);
            statement.setString(1, primerNombre);
            statement.setString(2, segundoNombre);
            statement.setString(3, primerApellido);
            statement.setString(4, segundoApellido);
            statement.setString(5, motivo);
            statement.setString(6, email);
            statement.setString(7, telefono);
            statement.setString(8, mensaje);
            statement.setString(9, nuevaRutaPDF);
            statement.setInt(10, idPQRS);

            int filasActualizadas = statement.executeUpdate();
            if (filasActualizadas > 0) {
                System.out.println("PQRS editada correctamente.");
                // Eliminar el PDF anterior si existe
                if (rutaAnteriorPDF != null && !rutaAnteriorPDF.isEmpty()) {
                    File archivoAnterior = new File(rutaAnteriorPDF);
                    if (archivoAnterior.exists()) {
                        archivoAnterior.delete();
                        System.out.println("Documento PDF anterior eliminado correctamente.");
                    }
                }
            } else {
                System.out.println("No se pudo editar la PQRS.");
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al editar la PQRS: " + e.getMessage());
        throw e;
    } finally {
        // Cerrar recursos
        if (rs != null) {
            rs.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (conexion != null) {
            conexion.close();
        }
    }
}
    /**
     * Obtiene todos los motivos de PQRS almacenados en la base de datos.
     *
     * @return Lista de objetos Motivo.
     * @throws SQLException Si ocurre un error de SQL al obtener los motivos.
     */
    public static List<Motivo> obtenerMotivos() throws SQLException {
        List<Motivo> motivosList = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            conexion = ConexionBaseDeDatos.getConexion(); // Implementa este método para obtener una conexión a la base de datos
            if (conexion != null) {
                String sql = "SELECT * FROM gestordepqrs.TipoPQRS ORDER BY id ASC";
                statement = conexion.prepareStatement(sql);
                resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    int idMotivo = resultSet.getInt("id");
                    String nombreMotivo = resultSet.getString("Motivo");
                    Motivo motivo = new Motivo(idMotivo, nombreMotivo);
                    motivosList.add(motivo);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener los motivos de PQRS: " + e.getMessage());
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

        return motivosList;
    }
/**
 * Obtiene el nombre del motivo basado en su ID.
 *
 * @param idMotivo ID del motivo.
 * @return Nombre del motivo, o null si no se encuentra.
 * @throws SQLException Si ocurre un error de SQL al obtener el nombre del motivo.
 */
public static String obtenerNombreMotivo(int idMotivo) throws SQLException {
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    String nombreMotivo = null;

    try {
        conexion = ConexionBaseDeDatos.getConexion(); // Implementa este método para obtener una conexión a la base de datos
        if (conexion != null) {
            String sql = "SELECT Motivo FROM TipoPQRS WHERE id = ?";
            statement = conexion.prepareStatement(sql);
            statement.setInt(1, idMotivo);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                nombreMotivo = resultSet.getString("Motivo");
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al obtener el nombre del motivo: " + e.getMessage());
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

    return nombreMotivo;
}

}
