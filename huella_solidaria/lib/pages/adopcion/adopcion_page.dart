import 'package:flutter/material.dart';
import 'mascota_detalle_page.dart';

class AdopcionPage extends StatefulWidget {
  const AdopcionPage({super.key});

  @override
  State<AdopcionPage> createState() => _AdopcionPageState();
}

class _AdopcionPageState extends State<AdopcionPage> {
  String _filtroTipo = 'Todos';
  String _filtroEdad = 'Todos';

  static const List<Map<String, String>> _mascotas = [
    {
      'nombre': 'Luna',
      'tipo': 'Perro',
      'edad': '2 años',
      'albergue': 'Patitas Felices',
      'descripcion': 'Muy cariñosa y activa. Le encanta jugar.',
      'tamaño': 'Mediano',
    },
    {
      'nombre': 'Michi',
      'tipo': 'Gato',
      'edad': '1 año',
      'albergue': 'Hogar Animal',
      'descripcion': 'Tranquilo y sociable. Ideal para departamento.',
      'tamaño': 'Pequeño',
    },
    {
      'nombre': 'Rocky',
      'tipo': 'Perro',
      'edad': '3 años',
      'albergue': 'Refugio Lima',
      'descripcion': 'Fiel y protector. Bueno con niños.',
      'tamaño': 'Grande',
    },
    {
      'nombre': 'Nala',
      'tipo': 'Perro',
      'edad': '1 año',
      'albergue': 'Amigos Peludos',
      'descripcion': 'Muy juguetona, le encanta correr al aire libre.',
      'tamaño': 'Mediano',
    },
    {
      'nombre': 'Pelusa',
      'tipo': 'Gato',
      'edad': '3 años',
      'albergue': 'Hogar Animal',
      'descripcion': 'Independiente pero cariñosa con su dueño.',
      'tamaño': 'Pequeño',
    },
    {
      'nombre': 'Tobi',
      'tipo': 'Perro',
      'edad': '5 años',
      'albergue': 'Patitas Felices',
      'descripcion': 'Mayor y tranquilo, perfecto para personas adultas.',
      'tamaño': 'Grande',
    },
  ];

  List<String> get _tipos => [
        'Todos',
        ..._mascotas.map((m) => m['tipo']!).toSet().toList()
      ];

  List<String> get _edades => ['Todos', 'Menos de 2 años', '2-4 años', 'Más de 4 años'];

  List<Map<String, String>> get _filtradas {
    return _mascotas.where((m) {
      final cumpleTipo = _filtroTipo == 'Todos' || m['tipo'] == _filtroTipo;
      final edadNum = int.tryParse(m['edad']!.split(' ')[0]) ?? 0;
      final cumpleEdad = _filtroEdad == 'Todos' ||
          (_filtroEdad == 'Menos de 2 años' && edadNum < 2) ||
          (_filtroEdad == '2-4 años' && edadNum >= 2 && edadNum <= 4) ||
          (_filtroEdad == 'Más de 4 años' && edadNum > 4);
      return cumpleTipo && cumpleEdad;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Encabezado con filtros ─────────────────────────────────────────
        Container(
          color: Colors.teal.shade50,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mascotas en adopción',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Filtro por tipo
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _tipos
                      .map(
                        (tipo) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(tipo),
                            selected: _filtroTipo == tipo,
                            selectedColor: Colors.teal.shade200,
                            onSelected: (_) =>
                                setState(() => _filtroTipo = tipo),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 6),
              // Filtro por edad
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _edades
                      .map(
                        (edad) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(edad),
                            selected: _filtroEdad == edad,
                            selectedColor: Colors.orange.shade200,
                            onSelected: (_) =>
                                setState(() => _filtroEdad = edad),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),

        // ── Contador ───────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
          child: Text(
            '${_filtradas.length} mascotas encontradas',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ),

        // ── Grilla de mascotas ─────────────────────────────────────────────
        Expanded(
          child: _filtradas.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pets, size: 60, color: Colors.grey),
                      SizedBox(height: 12),
                      Text('No hay mascotas con ese filtro',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.82,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _filtradas.length,
                  itemBuilder: (context, index) {
                    final m = _filtradas[index];
                    return _MascotaGridCard(
                      mascota: m,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MascotaDetallePage(
                            nombre: m['nombre']!,
                            tipo: m['tipo']!,
                            edad: m['edad']!,
                            albergue: m['albergue']!,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ─── Tarjeta en grilla ────────────────────────────────────────────────────────

class _MascotaGridCard extends StatelessWidget {
  final Map<String, String> mascota;
  final VoidCallback onTap;

  const _MascotaGridCard({required this.mascota, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final esPerro = mascota['tipo'] == 'Perro';
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen / placeholder
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: esPerro
                      ? Colors.orange.shade100
                      : Colors.purple.shade100,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                ),
                child: Icon(
                  Icons.pets,
                  size: 56,
                  color: esPerro
                      ? Colors.orange.shade600
                      : Colors.purple.shade400,
                ),
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mascota['nombre']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${mascota['tipo']} • ${mascota['edad']}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    mascota['albergue']!,
                    style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
