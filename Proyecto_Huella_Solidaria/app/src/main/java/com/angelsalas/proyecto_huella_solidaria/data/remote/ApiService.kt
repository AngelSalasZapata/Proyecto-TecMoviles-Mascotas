package com.angelsalas.proyecto_huella_solidaria.data.remote

import com.angelsalas.proyecto_huella_solidaria.data.model.Albergue
import com.angelsalas.proyecto_huella_solidaria.data.model.Donacion
import com.angelsalas.proyecto_huella_solidaria.data.model.Mascota
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.DELETE
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.PUT
import retrofit2.http.Path

interface ApiService {

    @GET("mascotas")
    suspend fun getMascotas(): Response<List<Mascota>>

    @GET("mascotas/{id}")
    suspend fun getMascotaById(@Path("id") id: Long): Response<Mascota>

    @POST("mascotas")
    suspend fun createMascota(@Body mascota: Mascota): Response<Mascota>

    @PUT("mascotas/{id}")
    suspend fun updateMascota(@Path("id") id: Long, @Body mascota: Mascota): Response<Mascota>

    @DELETE("mascotas/{id}")
    suspend fun deleteMascota(@Path("id") id: Long): Response<Unit>

    @GET("albergues")
    suspend fun getAlbergues(): Response<List<Albergue>>

    @GET("albergues/{id}")
    suspend fun getAlbergueById(@Path("id") id: Long): Response<Albergue>

    @POST("albergues")
    suspend fun createAlbergue(@Body albergue: Albergue): Response<Albergue>

    @PUT("albergues/{id}")
    suspend fun updateAlbergue(@Path("id") id: Long, @Body albergue: Albergue): Response<Albergue>

    @DELETE("albergues/{id}")
    suspend fun deleteAlbergue(@Path("id") id: Long): Response<Unit>

    @GET("donaciones")
    suspend fun getDonaciones(): Response<List<Donacion>>

    @GET("donaciones/{id}")
    suspend fun getDonacionById(@Path("id") id: Long): Response<Donacion>

    @POST("donaciones")
    suspend fun createDonacion(@Body donacion: Donacion): Response<Donacion>

    @DELETE("donaciones/{id}")
    suspend fun deleteDonacion(@Path("id") id: Long): Response<Unit>
}
