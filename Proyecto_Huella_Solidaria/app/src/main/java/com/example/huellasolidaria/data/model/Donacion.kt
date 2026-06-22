package com.example.huellasolidaria.data.model

data class Donacion(
    val id: String,
    val monto: Double,
    val tipo: String,        // "Dinero", "Alimento", "Medicina"
    val albergueId: String
)
