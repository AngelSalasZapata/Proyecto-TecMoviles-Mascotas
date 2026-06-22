package com.example.huellasolidaria.ui.donar

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.huellasolidaria.data.model.Donacion

class DonarViewModel : ViewModel() {

    val mensajeResultado = MutableLiveData<String>()

    fun realizarDonacion(monto: Double, tipo: String, albergueId: String) {
        if (monto <= 0) {
            mensajeResultado.value = "Ingresa un monto válido"
            return
        }

        // TODO: reemplazar por llamada real a DonacionRepository
        val donacion = Donacion(
            id = System.currentTimeMillis().toString(),
            monto = monto,
            tipo = tipo,
            albergueId = albergueId
        )

        mensajeResultado.value = "¡Gracias! Tu donación de S/ ${donacion.monto} fue registrada."
    }
}
