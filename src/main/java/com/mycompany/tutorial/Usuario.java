/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tutorial;

/**
 *
 * @author Hugo
 */
public class Usuario {
    private int id;
    private String nombreUsuario;
    private String cedula;
    private String contrasena;
    private String emailRegistro;

    // Constructor
    public Usuario() {
    }

    public Usuario(int id, String nombreUsuario, String cedula, String contrasena) {
        this.id = id;
        this.nombreUsuario = nombreUsuario;
        this.cedula = cedula;
        this.contrasena = contrasena;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
public String getEmailRegistro() {
    return emailRegistro;
}

public void setEmailRegistro(String emailRegistro) {
    this.emailRegistro = emailRegistro;
}

    // toString para representación de la clase
    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", nombreUsuario='" + nombreUsuario + '\'' +
                ", cedula='" + cedula + '\'' +
                ", contrasena='" + contrasena + '\'' +
                '}';
    }
}
