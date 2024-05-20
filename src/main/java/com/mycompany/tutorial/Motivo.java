/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tutorial;

/**
 *
 * @author Hugo
 */
public class Motivo {
    private int idMotivo;
    private String nombreMotivo;

    // Constructor
    public Motivo(int idMotivo, String nombreMotivo) {
        this.idMotivo = idMotivo;
        this.nombreMotivo = nombreMotivo;
    }

    // Getters y Setters
    public int getIdMotivo() {
        return idMotivo;
    }

    public void setIdMotivo(int idMotivo) {
        this.idMotivo = idMotivo;
    }

    public String getNombreMotivo() {
        return nombreMotivo;
    }

    public void setNombreMotivo(String nombreMotivo) {
        this.nombreMotivo = nombreMotivo;
    }
}
