package com.example.huellasolidaria.data.model

data class Mascota(
    val id: String,
    val nombre: String,
    val especie: String,      // "Perro" o "Gato"
    val edad: Int,
    val albergueNombre: String,
    val fotoUrl: String? = null,
    val descripcion: String = ""
)
