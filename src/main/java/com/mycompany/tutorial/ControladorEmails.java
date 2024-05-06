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
public class ControladorEmails {
    
    /**
 * Envía un correo electrónico de registro exitoso al destinatario especificado.
 *
 * @param destinatario    Dirección de correo electrónico del destinatario.
 * @param primerNombre    Primer nombre del remitente.
 * @param segundoNombre   Segundo nombre del remitente.
 * @param primerApellido  Primer apellido del remitente.
 * @param segundoApellido Segundo apellido del remitente.
 * @param motivo          Motivo del registro.
 * @param email           Dirección de correo electrónico del remitente.
 * @param telefono        Número de teléfono del remitente.
 * @param mensaje         Mensaje adicional (opcional).
 */
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
    
    /**
 * Responde a una PQRS (Petición, Queja, Reclamo o Sugerencia) especificando el destinatario, motivo ,mensaje de respuesta, primerNombre y primerApellido.
 *
 * @param destinatario      Dirección de correo electrónico del destinatario.
 * @param motivo            Motivo de la PQRS.
 * @param mensajeRespuesta  Mensaje de respuesta a la PQRS.
 * @param primerNombre      Primer nombre del usuario que realizo la PQRS.
 * @param primerApellido    Primer Apellido del usuario que realizo la PQRS.
 */
    public static void responderPQRS(String destinatario, String motivo, String mensajeRespuesta, String primerNombre, String primerApellido) {
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
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(correoRemitente));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            message.setSubject("Respuesta a su PQRS - Motivo: " + motivo);

            // Construir el texto del mensaje con la respuesta en formato HTML
            String htmlContent = "<html><body style=\"font-family: Arial, sans-serif;\">"
                    + "<p>Estimado(a) " + primerNombre + " " + primerApellido + ",</p>"
                    + "<p>Reciba un cordial saludo.</p>"
                    + "<p>Le agradecemos por su comunicación y nos complace brindarle una respuesta oportuna.</p>"
                    + "<p>Respecto al motivo de su PQRS relacionado con '<strong>" + motivo + "</strong>',</p>"
                    + "<p>" + mensajeRespuesta + "</p>"
                    + "<p>Si necesita más asistencia, no dude en ponerse en contacto con nosotros.</p>"
                    + "<p>Atentamente,<br/>Administrador</p>"
                    + "</body></html>";

            // Agregar el contenido del mensaje en formato HTML
            message.setContent(htmlContent, "text/html; charset=utf-8");

            // Enviar correo
            Transport.send(message);

            System.out.println("Respuesta a PQRS enviada exitosamente a: " + destinatario);
        } catch (MessagingException e) {
            System.out.println("Error al enviar la respuesta a la PQRS: " + e.getMessage());
            e.printStackTrace();
        }
    }

/**
 * Envía un correo electrónico de registro exitoso de usuario al destinatario especificado.
 *
 * @param destinatario    Dirección de correo electrónico del destinatario.
 * @param NombreUsuario   Nombre de usuario del nuevo usuario registrado.
 * @param Cedula          Número de cédula del nuevo usuario registrado.
 * @param contrasena      Contraseña del nuevo usuario registrado.
 * @param email           Dirección de correo electrónico del nuevo usuario registrado.
 */
    public static void enviarRegistroExitoso(String destinatario, String NombreUsuario, String Cedula, String contrasena, String email) {
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
        message.setSubject("Registro Exitoso de Usuario en el Sistema de PQRS");

        // Construir el texto del mensaje con los datos del formulario
        String textoMensaje = "Estimado/a,\n\nsu Usuario ha sido registrado en el sistema.\n\n";
        textoMensaje += "<h2>Detalles de su cuenta:</h2>\n";
        textoMensaje += "<p><strong>Usuario:</strong> " + NombreUsuario + "</p>\n";
        textoMensaje += "<p><strong>Contraseña:</strong> " + contrasena + "</p>\n";
        textoMensaje += "<p><strong>email:</strong> " + email + "</p>\n";
        textoMensaje += "<p><strong>cedula:</strong> " + Cedula + "</p>\n";
    
        

        textoMensaje += "<p>Atentamente,<br>El equipo de soporte.</p>\n";
        textoMensaje += "<p><br>Ahora puede iniciar sesión y mandar sus PQRS </p>\n";
        message.setContent(textoMensaje, "text/html; charset=utf-8");

        // Enviar correo
        Transport.send(message);

        System.out.println("Correo de registro exitoso enviado a: " + destinatario);
    } catch (MessagingException e) {
        System.out.println("Error al enviar el correo de registro exitoso: " + e.getMessage());
        e.printStackTrace();
    }
}
    /**
 * Envía un correo electrónico de recuperación de cuenta al usuario.
 *
 * @param destinatario Dirección de correo electrónico del destinatario.
 * @param NombreUsuario Nombre del usuario.
 * @param Cedula Cédula del usuario.
 * @param contrasena Contraseña del usuario.
 * @param email Correo electrónico del usuario.
 */
    public static void enviarRecuperacion(String destinatario, String NombreUsuario, String Cedula, String contrasena, String email) {
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
        message.setSubject("Recuperación de cuenta");

        // Construir el texto del mensaje con los datos del formulario
        String textoMensaje = "Estimado/a,\n\nsu Usuario ha sido registrado en el sistema.\n\n";
        textoMensaje += "<h2>Detalles de su cuenta:</h2>\n";
        textoMensaje += "<p><strong>Usuario:</strong> " + NombreUsuario + "</p>\n";
        textoMensaje += "<p><strong>Contraseña:</strong> " + contrasena + "</p>\n";
        textoMensaje += "<p><strong>email:</strong> " + email + "</p>\n";
        textoMensaje += "<p><strong>cedula:</strong> " + Cedula + "</p>\n";
    
        

        textoMensaje += "<p>Atentamente,<br>El equipo de soporte.</p>\n";
        textoMensaje += "<p><br>Ahora puede iniciar sesión y mandar sus PQRS </p>\n";
        message.setContent(textoMensaje, "text/html; charset=utf-8");

        // Enviar correo
        Transport.send(message);

        System.out.println("Correo de recuperación exitoso enviado a: " + destinatario);
    } catch (MessagingException e) {
        System.out.println("Error al enviar el correo de registro exitoso: " + e.getMessage());
        e.printStackTrace();
    }
}
}
