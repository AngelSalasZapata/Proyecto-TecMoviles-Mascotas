package com.angelsalas.proyecto_huella_solidaria.data.remote

import androidx.room.Dao
import androidx.room.Database
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.RoomDatabase
import androidx.room.Update
import com.angelsalas.proyecto_huella_solidaria.data.model.Albergue
import com.angelsalas.proyecto_huella_solidaria.data.model.Donacion
import com.angelsalas.proyecto_huella_solidaria.data.model.Mascota

@Database(
    entities = [Mascota::class, Albergue::class, Donacion::class],
    version = 1,
    exportSchema = false
)
abstract class AppDatabase : RoomDatabase() {

    abstract fun mascotaDao(): MascotaDao
    abstract fun albergueDao(): AlbergueDao
    abstract fun donacionDao(): DonacionDao

    @Dao
    interface MascotaDao {
        @Query("SELECT * FROM mascotas")
        suspend fun getAll(): List<Mascota>

        @Query("SELECT * FROM mascotas WHERE id = :id")
        suspend fun getById(id: Long): Mascota?

        @Insert(onConflict = OnConflictStrategy.REPLACE)
        suspend fun insert(mascota: Mascota): Long

        @Update
        suspend fun update(mascota: Mascota)

        @Delete
        suspend fun delete(mascota: Mascota)

        @Query("DELETE FROM mascotas")
        suspend fun deleteAll()
    }

    @Dao
    interface AlbergueDao {
        @Query("SELECT * FROM albergues")
        suspend fun getAll(): List<Albergue>

        @Query("SELECT * FROM albergues WHERE id = :id")
        suspend fun getById(id: Long): Albergue?

        @Insert(onConflict = OnConflictStrategy.REPLACE)
        suspend fun insert(albergue: Albergue): Long

        @Update
        suspend fun update(albergue: Albergue)

        @Delete
        suspend fun delete(albergue: Albergue)

        @Query("DELETE FROM albergues")
        suspend fun deleteAll()
    }

    @Dao
    interface DonacionDao {
        @Query("SELECT * FROM donaciones")
        suspend fun getAll(): List<Donacion>

        @Query("SELECT * FROM donaciones WHERE id = :id")
        suspend fun getById(id: Long): Donacion?

        @Query("SELECT * FROM donaciones WHERE albergueId = :albergueId")
        suspend fun getByAlbergueId(albergueId: Long): List<Donacion>

        @Insert(onConflict = OnConflictStrategy.REPLACE)
        suspend fun insert(donacion: Donacion): Long

        @Update
        suspend fun update(donacion: Donacion)

        @Delete
        suspend fun delete(donacion: Donacion)

        @Query("DELETE FROM donaciones")
        suspend fun deleteAll()
    }
}
