import 'package:flutter/material.dart';
import '../albergues/albergues_page.dart';
import '../adopcion/adopcion_page.dart';
import '../donacion/donacion_page.dart';
import '../auth/login_page.dart';
import '../adopcion/mascota_detalle_page.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    _HomeContent(),
    AlberguesPage(),
    AdopcionPage(),
    DonacionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huella Solidaria'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Mi cuenta',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Albergues'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Adoptar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism), label: 'Donar'),
        ],
      ),
    );
  }
}

// ─── Contenido principal del Home ───────────────────────────────────────────

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  static const List<Map<String, dynamic>> _destacados = [
    {
      'nombre': 'Luna',
      'tipo': 'Perro',
      'edad': '2 años',
      'albergue': 'Patitas Felices',
    },
    {
      'nombre': 'Michi',
      'tipo': 'Gato',
      'edad': '1 año',
      'albergue': 'Hogar Animal',
    },
    {
      'nombre': 'Rocky',
      'tipo': 'Perro',
      'edad': '3 años',
      'albergue': 'Refugio Lima',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── Banner hero ──────────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade300, Colors.teal.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ayuda a un albergue o\nadopta una mascota 🐾',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Conecta con albergues registrados, realiza donaciones y encuentra mascotas disponibles.',
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ── Acciones rápidas ─────────────────────────────────────────────────
        const Text(
          '¿Qué deseas hacer?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _AccionCard(
                icon: Icons.volunteer_activism,
                label: 'Donar',
                color: Colors.orange.shade100,
                iconColor: Colors.orange.shade700,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _AccionCard(
                icon: Icons.pets,
                label: 'Adoptar',
                color: Colors.teal.shade100,
                iconColor: Colors.teal,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _AccionCard(
                icon: Icons.business,
                label: 'Albergues',
                color: Colors.blue.shade100,
                iconColor: Colors.blue.shade700,
                onTap: () {},
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        // ── Animales destacados ──────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Animales destacados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Ver todos'),
            ),
          ],
        ),
        const SizedBox(height: 8),

        ..._destacados.map(
          (m) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _MascotaDestacadaCard(
              nombre: m['nombre'],
              tipo: m['tipo'],
              edad: m['edad'],
              albergue: m['albergue'],
              onVerPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MascotaDetallePage(
                    nombre: m['nombre'],
                    tipo: m['tipo'],
                    edad: m['edad'],
                    albergue: m['albergue'],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Widgets locales ─────────────────────────────────────────────────────────

class _AccionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _AccionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MascotaDestacadaCard extends StatelessWidget {
  final String nombre;
  final String tipo;
  final String edad;
  final String albergue;
  final VoidCallback onVerPressed;

  const _MascotaDestacadaCard({
    required this.nombre,
    required this.tipo,
    required this.edad,
    required this.albergue,
    required this.onVerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: const Icon(Icons.pets, color: Colors.teal),
        ),
        title: Text(
          nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$tipo • $edad • $albergue'),
        trailing: ElevatedButton(
          onPressed: onVerPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Ver'),
        ),
      ),
    );
  }
}