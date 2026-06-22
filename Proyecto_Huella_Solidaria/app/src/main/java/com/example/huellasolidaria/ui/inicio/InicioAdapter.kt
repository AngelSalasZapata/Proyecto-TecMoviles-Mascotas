package com.example.huellasolidaria.ui.inicio

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.huellasolidaria.data.model.Mascota
import com.example.huellasolidaria.databinding.ItemMascotaBinding

class InicioAdapter(
    private val onVerClick: (Mascota) -> Unit
) : ListAdapter<Mascota, InicioAdapter.MascotaViewHolder>(DIFF_CALLBACK) {

    override fun onCreateViewHolder(parent: ViewGroup, position: Int): MascotaViewHolder {
        val binding = ItemMascotaBinding.inflate(
            LayoutInflater.from(parent.context), parent, false
        )
        return MascotaViewHolder(binding)
    }

    override fun onBindViewHolder(holder: MascotaViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    inner class MascotaViewHolder(
        private val binding: ItemMascotaBinding
    ) : RecyclerView.ViewHolder(binding.root) {

        fun bind(mascota: Mascota) {
            binding.tvNombre.text = mascota.nombre
            binding.tvSubtitulo.text = "${mascota.especie} • ${mascota.edad} años • ${mascota.albergueNombre}"
            binding.btnVer.setOnClickListener { onVerClick(mascota) }
        }
    }

    companion object {
        private val DIFF_CALLBACK = object : DiffUtil.ItemCallback<Mascota>() {
            override fun areItemsTheSame(oldItem: Mascota, newItem: Mascota) =
                oldItem.id == newItem.id

            override fun areContentsTheSame(oldItem: Mascota, newItem: Mascota) =
                oldItem == newItem
        }
    }
}
