package com.example.huellasolidaria.ui.donar

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import com.example.huellasolidaria.databinding.FragmentDonarBinding

class DonarFragment : Fragment() {

    private var _binding: FragmentDonarBinding? = null
    private val binding get() = _binding!!

    private val viewModel: DonarViewModel by viewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentDonarBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.btnConfirmarDonacion.setOnClickListener {
            val montoTexto = binding.etMonto.text.toString()
            val monto = montoTexto.toDoubleOrNull() ?: 0.0
            val tipo = when (binding.rgTipoDonacion.checkedRadioButtonId) {
                binding.rbAlimento.id -> "Alimento"
                binding.rbMedicina.id -> "Medicina"
                else -> "Dinero"
            }

            viewModel.realizarDonacion(monto, tipo, albergueId = "a1")
        }

        viewModel.mensajeResultado.observe(viewLifecycleOwner) { mensaje ->
            Toast.makeText(requireContext(), mensaje, Toast.LENGTH_LONG).show()
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
