# Proyecto-TecMoviles-Mascotas
repositorio para el proyecto de testing sección B - integrantes: montoya renzo, pozu luis, quispe yhosfer, salas angel

estructura del proyecto:
```bash
app/
└── src/main/java/com/example/huellasolidaria/
    │
    ├── HuellaSolidariaApp.kt          // Application class (opcional, para Hilt/DI)
    │
    ├── data/
    │   ├── model/
    │   │   ├── Mascota.kt             // data class: id, nombre, especie, edad, albergue, fotoUrl
    │   │   ├── Albergue.kt            // data class: id, nombre, direccion, telefono
    │   │   └── Donacion.kt            // data class: id, monto, tipo, albergueId
    │   │
    │   ├── repository/
    │   │   ├── MascotaRepository.kt
    │   │   ├── AlbergueRepository.kt
    │   │   └── DonacionRepository.kt
    │   │
    │   └── remote/ (o local/)
    │       ├── ApiService.kt          // Retrofit interface
    │       └── AppDatabase.kt         // Room (si usas BD local)
    │
    ├── ui/
    │   ├── inicio/
    │   │   ├── InicioFragment.kt      // equivalente a tu InicioPage
    │   │   ├── InicioViewModel.kt
    │   │   └── InicioAdapter.kt       // para el RecyclerView de "Animales destacados"
    │   │
    │   ├── albergues/
    │   │   ├── AlberguesFragment.kt
    │   │   ├── AlberguesViewModel.kt
    │   │   └── AlbergueAdapter.kt
    │   │
    │   ├── adoptar/
    │   │   ├── AdoptarFragment.kt
    │   │   ├── AdoptarViewModel.kt
    │   │   ├── MascotaAdapter.kt
    │   │   └── DetalleMascotaActivity.kt
    │   │
    │   └── donar/
    │       ├── DonarFragment.kt
    │       └── DonarViewModel.kt
    │
    ├── navigation/
    │   └── MainActivity.kt            // contiene el BottomNavigationView + NavHostFragment
    │
    └── utils/
        ├── Extensions.kt
        └── Constants.kt

app/src/main/res/
    ├── layout/
    │   ├── activity_main.xml          // Bottom navigation + contenedor
    │   ├── fragment_inicio.xml
    │   ├── item_mascota.xml           // tarjeta tipo "Luna", "Michi"
    │   ├── item_albergue.xml
    │   └── fragment_donar.xml
    │
    ├── navigation/
    │   └── nav_graph.xml              // define las rutas entre fragments
    │
    ├── menu/
    │   └── bottom_nav_menu.xml        // los 4 items: Inicio, Albergues, Adoptar, Donar
    │
    ├── drawable/
    │   └── (iconos: ic_pets, ic_volunteer, ic_business...)
    │
    └── values/
        ├── colors.xml                 // tu seedColor teal equivalente
        ├── strings.xml
        └── themes.xml
```
