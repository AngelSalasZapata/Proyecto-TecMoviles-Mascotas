package com.example.huellasolidaria.ui.adoptar

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.huellasolidaria.data.model.Mascota

class AdoptarViewModel : ViewModel() {

    private val todasLasMascotas = listOf(
        Mascota("1", "Luna", "Perro", 2, "Albergue Patitas Felices"),
        Mascota("2", "Michi", "Gato", 1, "Albergue Hogar Animal"),
        Mascota("3", "Rocky", "Perro", 3, "Albergue Patitas Felices"),
        Mascota("4", "Nina", "Gato", 2, "Albergue Hogar Animal")
    )

    private val _mascotas = MutableLiveData<List<Mascota>>(todasLasMascotas)
    val mascotas: LiveData<List<Mascota>> get() = _mascotas

    fun filtrarPor(especie: String?) {
        _mascotas.value = if (especie == null) {
            todasLasMascotas
        } else {
            todasLasMascotas.filter { it.especie == especie }
        }
    }

    fun obtenerPorId(id: String): Mascota? =
        todasLasMascotas.find { it.id == id }
}
