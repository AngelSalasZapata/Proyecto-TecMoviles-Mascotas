# Proyecto-TecMoviles-Mascotas
repositorio para el proyecto de testing sección B - integrantes: montoya renzo, pozu luis, quispe yhosfer, salas angel

estructura del proyecto:

huella_solidaria/
├── lib/
│   ├── main.dart
│   │
│   ├── core/
│   │   ├── theme/
│   │   │   └── app_theme.dart              # Colores, tipografías, ThemeData
│   │   ├── constants/
│   │   │   └── app_constants.dart          # Strings, rutas, valores fijos
│   │   └── utils/
│   │       └── validators.dart             # Validaciones de formularios
│   │
│   ├── models/
│   │   ├── albergue.dart                   # id, nombre, ubicación, contacto
│   │   ├── mascota.dart                    # id, nombre, especie, edad, estado
│   │   ├── donacion.dart                   # id, tipo, monto, albergueId
│   │   └── usuario.dart                    # id, nombre, rol (adoptante/voluntario)
│   │
│   ├── services/
│   │   ├── albergue_service.dart           # CRUD de albergues
│   │   ├── mascota_service.dart            # CRUD de mascotas
│   │   ├── donacion_service.dart           # Registro de donaciones
│   │   └── auth_service.dart              # Login / registro de usuario
│   │
│   ├── providers/                          # Estado global (Provider / Riverpod)
│   │   ├── albergue_provider.dart
│   │   ├── mascota_provider.dart
│   │   └── auth_provider.dart
│   │
│   ├── pages/
│   │   ├── inicio/
│   │   │   └── inicio_page.dart            # Home con tarjetas y nav bar
│   │   ├── albergues/
│   │   │   ├── albergues_page.dart         # Listado de albergues
│   │   │   └── albergue_detalle_page.dart  # Info + mascotas del albergue
│   │   ├── adopcion/
│   │   │   ├── adopcion_page.dart          # Galería de mascotas disponibles
│   │   │   └── mascota_detalle_page.dart   # Perfil de la mascota
│   │   ├── donacion/
│   │   │   └── donacion_page.dart          # Formulario para donar
│   │   └── auth/
│   │       ├── login_page.dart
│   │       └── registro_page.dart
│   │
│   └── widgets/
│       ├── mascota_card.dart               # Tarjeta reutilizable de mascota
│       ├── albergue_card.dart              # Tarjeta reutilizable de albergue
│       └── bottom_nav_bar.dart             # Barra de navegación compartida
│
├── assets/
│   ├── images/                             # Imágenes e íconos locales
│   └── fonts/                             # Tipografías personalizadas
│
└── pubspec.yaml
