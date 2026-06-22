package com.example.huellasolidaria.ui.inicio

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.huellasolidaria.databinding.FragmentInicioBinding

class InicioFragment : Fragment() {

    private var _binding: FragmentInicioBinding? = null
    private val binding get() = _binding!!

    private val viewModel: InicioViewModel by viewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentInicioBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // Tarjeta "Donar a un albergue"
        binding.cardDonar.setOnClickListener {
            findNavController().navigate(com.example.huellasolidaria.R.id.action_inicio_to_donar)
        }

        // Tarjeta "Adoptar una mascota"
        binding.cardAdoptar.setOnClickListener {
            findNavController().navigate(com.example.huellasolidaria.R.id.action_inicio_to_adoptar)
        }

        // RecyclerView de animales destacados
        val adapter = InicioAdapter { mascota ->
            val action = com.example.huellasolidaria.R.id.action_inicio_to_detalleMascota
            val bundle = Bundle().apply { putString("mascotaId", mascota.id) }
            findNavController().navigate(action, bundle)
        }
        binding.rvDestacados.layoutManager = LinearLayoutManager(requireContext())
        binding.rvDestacados.adapter = adapter

        viewModel.animalesDestacados.observe(viewLifecycleOwner) { lista ->
            adapter.submitList(lista)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
