
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tutorial;

/**
 *
 * @author Hugo
 */
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
public class ConexionBaseDeDatos {
     private static final String URL = "jdbc:mysql://localhost:3306/GestorDePQRS";
    private static final String USUARIO = "root";
    private static final String PASSWORD = "000000";
/**
 * Obtiene una conexión a la base de datos.
 * 
 * @return Una instancia de Connection que representa la conexión establecida.
 * @throws SQLException Si ocurre un error durante la conexión a la base de datos.
 */
    public static Connection getConexion() throws SQLException {
        Connection conexion = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            System.out.println("Conexión exitosa: " + conexion);
        } catch (ClassNotFoundException e) {
            System.out.println("Error: No se encontró el controlador JDBC.");
            e.printStackTrace();
            throw new SQLException("No se pudo encontrar el controlador JDBC.", e);
        } catch (SQLException e) {
            System.out.println("Error al conectar a la base de datos: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        return conexion;
    }
   public static void insertarPQRS(String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, String motivo, String email, String telefono, String mensaje, String rutaPDF) throws SQLException {
    Connection conexion = null;
    PreparedStatement statement = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            String sql = "INSERT INTO PQRS (PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, Motivo, email, Telefono, Mensaje, RutaPDF) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
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


   public static boolean login(String nombreUsuario, String contrasena) {
    Connection conexion = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    try {
        conexion = getConexion();
        if (conexion != null) {
            String sql = "SELECT * FROM Usuarios WHERE nombre_usuario = ? AND contrasena = ?";
            statement = conexion.prepareStatement(sql);
            statement.setString(1, nombreUsuario);
            statement.setString(2, contrasena);
            resultSet = statement.executeQuery();
            
            // Si es administrador fijo, retorna true
            if (nombreUsuario.equals("admin") && contrasena.equals("password")) {
                return true;
            }
            
            // Si es un usuario normal registrado en la base de datos, retorna true
            if (resultSet.next()) {
                return true;
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
    return false; // Si hubo algún problema durante el proceso, se retorna false por defecto
}

   // Método para obtener todas las PQRS con sus datos correspondientes, dándole prioridad a las de tipo "Petición"
    public List<PQRS> obtenerPQRS() throws SQLException {
        List<PQRS> pqrsList = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            conexion = getConexion();
            if (conexion != null) {
                String sql = "SELECT * FROM PQRS ORDER BY CASE WHEN Motivo = 'Petición' THEN 0 ELSE 1 END";
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
public static void enviarCorreoRegistroExitoso(String destinatario, String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, String motivo, String email, String telefono, String mensaje) {
    // Configuración del servidor de correo
    String correoRemitente = "gestorpqrs2@gmail.com";
    String passwordRemitente = "h g x n n j x w n w c b a d k i";
    String host = "smtp.gmail.com";
    int puerto = 587;

    // Propiedades de la sesión
    Properties props = new Properties();
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", puerto);

    // Autenticación
    Session session = Session.getInstance(props, new Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(correoRemitente, passwordRemitente);
        }
    });

    try {
        // Crear mensaje
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(correoRemitente));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        message.setSubject("Registro Exitoso en el Sistema de PQRS");

        // Construir el texto del mensaje con los datos del formulario
        String textoMensaje = "Estimado/a,\n\nSu PQRS ha sido registrada exitosamente en nuestro sistema.\n\n";
        textoMensaje += "<h2>Detalles de la PQRS:</h2>\n";
        textoMensaje += "<p><strong>Primer Nombre:</strong> " + primerNombre + "</p>\n";
        textoMensaje += "<p><strong>Segundo Nombre:</strong> " + segundoNombre + "</p>\n";
        textoMensaje += "<p><strong>Primer Apellido:</strong> " + primerApellido + "</p>\n";
        textoMensaje += "<p><strong>Segundo Apellido:</strong> " + segundoApellido + "</p>\n";
        textoMensaje += "<p><strong>Motivo:</strong> " + motivo + "</p>\n";
        textoMensaje += "<p><strong>Email:</strong> " + email + "</p>\n";
        textoMensaje += "<p><strong>Teléfono:</strong> " + telefono + "</p>\n";
        
        // Agregar mensaje solo si no es nulo
        if (mensaje != null) {
            textoMensaje += "<p><strong>Mensaje:</strong> " + mensaje + "</p>\n\n";
        }

        textoMensaje += "<p>Atentamente,<br>El equipo de soporte.</p>\n";
        message.setContent(textoMensaje, "text/html; charset=utf-8");

        // Enviar correo
        Transport.send(message);

        System.out.println("Correo de registro exitoso enviado a: " + destinatario);
    } catch (MessagingException e) {
        System.out.println("Error al enviar el correo de registro exitoso: " + e.getMessage());
        e.printStackTrace();
    }
}


}
