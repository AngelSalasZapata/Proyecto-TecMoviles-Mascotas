package com.example.huellasolidaria.ui.albergues

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.huellasolidaria.databinding.FragmentAlberguesBinding

class AlberguesFragment : Fragment() {

    private var _binding: FragmentAlberguesBinding? = null
    private val binding get() = _binding!!

    private val viewModel: AlberguesViewModel by viewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentAlberguesBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val adapter = AlbergueAdapter { albergue ->
            // Acción rápida: llamar al albergue
            val intent = Intent(Intent.ACTION_DIAL, Uri.parse("tel:${albergue.telefono}"))
            startActivity(intent)
        }

        binding.rvAlbergues.layoutManager = LinearLayoutManager(requireContext())
        binding.rvAlbergues.adapter = adapter

        viewModel.albergues.observe(viewLifecycleOwner) { lista ->
            adapter.submitList(lista)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
