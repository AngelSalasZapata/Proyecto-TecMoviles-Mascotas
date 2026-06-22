package com.angelsalas.proyecto_huella_solidaria.data.repository

import com.angelsalas.proyecto_huella_solidaria.data.model.Mascota
import com.angelsalas.proyecto_huella_solidaria.data.remote.ApiService
import com.angelsalas.proyecto_huella_solidaria.data.remote.AppDatabase

class MascotaRepository(
    private val api: ApiService,
    private val db: AppDatabase
) {
    private val dao = db.mascotaDao()

    suspend fun getMascotas(): Result<List<Mascota>> {
        return try {
            val response = api.getMascotas()
            if (response.isSuccessful) {
                val mascotas = response.body() ?: emptyList()
                dao.deleteAll()
                mascotas.forEach { dao.insert(it) }
                Result.success(mascotas)
            } else {
                Result.success(dao.getAll())
            }
        } catch (e: Exception) {
            val cached = dao.getAll()
            Result.success(cached)
        }
    }

    suspend fun getMascotaById(id: Long): Result<Mascota?> {
        return try {
            val response = api.getMascotaById(id)
            if (response.isSuccessful) {
                Result.success(response.body())
            } else {
                Result.success(dao.getById(id))
            }
        } catch (e: Exception) {
            Result.success(dao.getById(id))
        }
    }

    suspend fun createMascota(mascota: Mascota): Result<Mascota> {
        return try {
            val response = api.createMascota(mascota)
            if (response.isSuccessful) {
                response.body()?.let { dao.insert(it) }
                Result.success(response.body() ?: mascota)
            } else {
                val localId = dao.insert(mascota)
                Result.success(mascota.copy(id = localId))
            }
        } catch (e: Exception) {
            val localId = dao.insert(mascota)
            Result.success(mascota.copy(id = localId))
        }
    }

    suspend fun deleteMascota(mascota: Mascota): Result<Unit> {
        return try {
            val response = api.deleteMascota(mascota.id)
            dao.delete(mascota)
            Result.success(Unit)
        } catch (e: Exception) {
            dao.delete(mascota)
            Result.success(Unit)
        }
    }
}
