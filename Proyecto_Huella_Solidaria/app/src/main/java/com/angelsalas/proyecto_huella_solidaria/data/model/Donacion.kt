package com.angelsalas.proyecto_huella_solidaria.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "donaciones")
data class Donacion(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,
    val monto: Double = 0.0,
    val tipo: String = "",
    val albergueId: Long = 0
)
