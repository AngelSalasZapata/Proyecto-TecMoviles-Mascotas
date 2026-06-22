package com.example.huellasolidaria.ui.adoptar

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.huellasolidaria.databinding.FragmentAdoptarBinding

class AdoptarFragment : Fragment() {

    private var _binding: FragmentAdoptarBinding? = null
    private val binding get() = _binding!!

    private val viewModel: AdoptarViewModel by viewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentAdoptarBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val adapter = MascotaAdapter { mascota ->
            val bundle = Bundle().apply { putString("mascotaId", mascota.id) }
            findNavController().navigate(
                com.example.huellasolidaria.R.id.action_adoptar_to_detalleMascota,
                bundle
            )
        }
        binding.rvMascotas.layoutManager = LinearLayoutManager(requireContext())
        binding.rvMascotas.adapter = adapter

        viewModel.mascotas.observe(viewLifecycleOwner) { lista ->
            adapter.submitList(lista)
        }

        // Filtros tipo chip: Todos / Perros / Gatos
        binding.chipTodos.setOnClickListener { viewModel.filtrarPor(null) }
        binding.chipPerros.setOnClickListener { viewModel.filtrarPor("Perro") }
        binding.chipGatos.setOnClickListener { viewModel.filtrarPor("Gato") }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
