package com.angelsalas.proyecto_huella_solidaria.data.repository

import com.angelsalas.proyecto_huella_solidaria.data.model.Donacion
import com.angelsalas.proyecto_huella_solidaria.data.remote.ApiService
import com.angelsalas.proyecto_huella_solidaria.data.remote.AppDatabase

class DonacionRepository(
    private val api: ApiService,
    private val db: AppDatabase
) {
    private val dao = db.donacionDao()

    suspend fun getDonaciones(): Result<List<Donacion>> {
        return try {
            val response = api.getDonaciones()
            if (response.isSuccessful) {
                val donaciones = response.body() ?: emptyList()
                dao.deleteAll()
                donaciones.forEach { dao.insert(it) }
                Result.success(donaciones)
            } else {
                Result.success(dao.getAll())
            }
        } catch (e: Exception) {
            val cached = dao.getAll()
            Result.success(cached)
        }
    }

    suspend fun getDonacionesByAlbergue(albergueId: Long): Result<List<Donacion>> {
        val cached = dao.getByAlbergueId(albergueId)
        return Result.success(cached)
    }

    suspend fun createDonacion(donacion: Donacion): Result<Donacion> {
        return try {
            val response = api.createDonacion(donacion)
            if (response.isSuccessful) {
                response.body()?.let { dao.insert(it) }
                Result.success(response.body() ?: donacion)
            } else {
                val localId = dao.insert(donacion)
                Result.success(donacion.copy(id = localId))
            }
        } catch (e: Exception) {
            val localId = dao.insert(donacion)
            Result.success(donacion.copy(id = localId))
        }
    }

    suspend fun deleteDonacion(donacion: Donacion): Result<Unit> {
        return try {
            api.deleteDonacion(donacion.id)
            dao.delete(donacion)
            Result.success(Unit)
        } catch (e: Exception) {
            dao.delete(donacion)
            Result.success(Unit)
        }
    }
}
