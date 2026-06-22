package com.angelsalas.proyecto_huella_solidaria.data.repository

import com.angelsalas.proyecto_huella_solidaria.data.model.Albergue
import com.angelsalas.proyecto_huella_solidaria.data.remote.ApiService
import com.angelsalas.proyecto_huella_solidaria.data.remote.AppDatabase

class AlbergueRepository(
    private val api: ApiService,
    private val db: AppDatabase
) {
    private val dao = db.albergueDao()

    suspend fun getAlbergues(): Result<List<Albergue>> {
        return try {
            val response = api.getAlbergues()
            if (response.isSuccessful) {
                val albergues = response.body() ?: emptyList()
                dao.deleteAll()
                albergues.forEach { dao.insert(it) }
                Result.success(albergues)
            } else {
                Result.success(dao.getAll())
            }
        } catch (e: Exception) {
            val cached = dao.getAll()
            Result.success(cached)
        }
    }

    suspend fun getAlbergueById(id: Long): Result<Albergue?> {
        return try {
            val response = api.getAlbergueById(id)
            if (response.isSuccessful) {
                Result.success(response.body())
            } else {
                Result.success(dao.getById(id))
            }
        } catch (e: Exception) {
            Result.success(dao.getById(id))
        }
    }

    suspend fun createAlbergue(albergue: Albergue): Result<Albergue> {
        return try {
            val response = api.createAlbergue(albergue)
            if (response.isSuccessful) {
                response.body()?.let { dao.insert(it) }
                Result.success(response.body() ?: albergue)
            } else {
                val localId = dao.insert(albergue)
                Result.success(albergue.copy(id = localId))
            }
        } catch (e: Exception) {
            val localId = dao.insert(albergue)
            Result.success(albergue.copy(id = localId))
        }
    }

    suspend fun deleteAlbergue(albergue: Albergue): Result<Unit> {
        return try {
            api.deleteAlbergue(albergue.id)
            dao.delete(albergue)
            Result.success(Unit)
        } catch (e: Exception) {
            dao.delete(albergue)
            Result.success(Unit)
        }
    }
}
