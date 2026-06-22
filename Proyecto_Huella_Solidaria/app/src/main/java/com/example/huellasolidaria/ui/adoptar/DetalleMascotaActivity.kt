package com.example.huellasolidaria.ui.adoptar

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.huellasolidaria.databinding.ActivityDetalleMascotaBinding

class DetalleMascotaActivity : AppCompatActivity() {

    private lateinit var binding: ActivityDetalleMascotaBinding
    private val viewModel: AdoptarViewModel by lazy {
        androidx.lifecycle.ViewModelProvider(this)[AdoptarViewModel::class.java]
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityDetalleMascotaBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val mascotaId = intent.getStringExtra("mascotaId") ?: return
        val mascota = viewModel.obtenerPorId(mascotaId) ?: return

        binding.tvNombreDetalle.text = mascota.nombre
        binding.tvEspecieEdad.text = "${mascota.especie} • ${mascota.edad} años"
        binding.tvAlbergueDetalle.text = mascota.albergueNombre
        binding.tvDescripcion.text = mascota.descripcion.ifBlank {
            "Este peludito está esperando un hogar lleno de amor."
        }

        binding.btnSolicitarAdopcion.setOnClickListener {
            // TODO: navegar a formulario de solicitud de adopción
        }

        binding.btnVolver.setOnClickListener { finish() }
    }
}
