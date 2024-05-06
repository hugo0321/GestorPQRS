
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
import java.sql.SQLException;

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
     * @return Una instancia de Connection que representa la conexión
     * establecida.
     * @throws SQLException Si ocurre un error durante la conexión a la base de
     * datos.
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
}
