package com.angelsalas.proyecto_huella_solidaria.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "mascotas")
data class Mascota(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,
    val nombre: String = "",
    val especie: String = "",
    val edad: String = "",
    val albergueId: Long = 0,
    val fotoUrl: String = ""
)
