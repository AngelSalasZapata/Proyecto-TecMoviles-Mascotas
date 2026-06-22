package com.angelsalas.proyecto_huella_solidaria.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "albergues")
data class Albergue(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,
    val nombre: String = "",
    val direccion: String = "",
    val telefono: String = ""
)
