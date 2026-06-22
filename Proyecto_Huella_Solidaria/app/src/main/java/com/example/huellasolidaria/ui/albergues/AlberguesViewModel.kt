package com.example.huellasolidaria.ui.albergues

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.huellasolidaria.data.model.Albergue

class AlberguesViewModel : ViewModel() {

    private val _albergues = MutableLiveData<List<Albergue>>()
    val albergues: LiveData<List<Albergue>> get() = _albergues

    init {
        cargarAlbergues()
    }

    private fun cargarAlbergues() {
        // TODO: reemplazar por llamada real a AlbergueRepository
        _albergues.value = listOf(
            Albergue(
                id = "a1",
                nombre = "Albergue Patitas Felices",
                direccion = "Av. Los Próceres 123",
                telefono = "987654321",
                mascotasDisponibles = 12
            ),
            Albergue(
                id = "a2",
                nombre = "Albergue Hogar Animal",
                direccion = "Calle Las Begonias 456",
                telefono = "912345678",
                mascotasDisponibles = 8
            )
        )
    }
}
