package com.example.huellasolidaria.ui.inicio

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.huellasolidaria.data.model.Mascota

class InicioViewModel : ViewModel() {

    private val _animalesDestacados = MutableLiveData<List<Mascota>>()
    val animalesDestacados: LiveData<List<Mascota>> get() = _animalesDestacados

    init {
        cargarDestacados()
    }

    private fun cargarDestacados() {
        // TODO: reemplazar por llamada real a MascotaRepository
        _animalesDestacados.value = listOf(
            Mascota(
                id = "1",
                nombre = "Luna",
                especie = "Perro",
                edad = 2,
                albergueNombre = "Albergue Patitas Felices"
            ),
            Mascota(
                id = "2",
                nombre = "Michi",
                especie = "Gato",
                edad = 1,
                albergueNombre = "Albergue Hogar Animal"
            )
        )
    }
}
