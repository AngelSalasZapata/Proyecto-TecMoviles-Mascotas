package com.example.huellasolidaria.ui.albergues

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.huellasolidaria.data.model.Albergue
import com.example.huellasolidaria.databinding.ItemAlbergueBinding

class AlbergueAdapter(
    private val onItemClick: (Albergue) -> Unit
) : ListAdapter<Albergue, AlbergueAdapter.AlbergueViewHolder>(DIFF_CALLBACK) {

    override fun onCreateViewHolder(parent: ViewGroup, position: Int): AlbergueViewHolder {
        val binding = ItemAlbergueBinding.inflate(
            LayoutInflater.from(parent.context), parent, false
        )
        return AlbergueViewHolder(binding)
    }

    override fun onBindViewHolder(holder: AlbergueViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    inner class AlbergueViewHolder(
        private val binding: ItemAlbergueBinding
    ) : RecyclerView.ViewHolder(binding.root) {

        fun bind(albergue: Albergue) {
            binding.tvNombreAlbergue.text = albergue.nombre
            binding.tvDireccion.text = albergue.direccion
            binding.tvMascotasDisponibles.text =
                "${albergue.mascotasDisponibles} mascotas disponibles"
            binding.root.setOnClickListener { onItemClick(albergue) }
        }
    }

    companion object {
        private val DIFF_CALLBACK = object : DiffUtil.ItemCallback<Albergue>() {
            override fun areItemsTheSame(oldItem: Albergue, newItem: Albergue) =
                oldItem.id == newItem.id

            override fun areContentsTheSame(oldItem: Albergue, newItem: Albergue) =
                oldItem == newItem
        }
    }
}
