package com.example.huellasolidaria.data.model

data class Albergue(
    val id: String,
    val nombre: String,
    val direccion: String,
    val telefono: String,
    val mascotasDisponibles: Int = 0
)
