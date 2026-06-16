import 'package:flutter/material.dart';
import 'albergue_detalle_page.dart';

class AlberguesPage extends StatefulWidget {
  const AlberguesPage({super.key});

  @override
  State<AlberguesPage> createState() => _AlberguesPageState();
}

class _AlberguesPageState extends State<AlberguesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // ── Mock data ─────────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> _albergues = [
    {
      'nombre': 'Patitas Felices',
      'distrito': 'Miraflores, Lima',
      'mascotas': 24,
      'telefono': '+51 987 654 321',
      'descripcion': 'Albergue sin fines de lucro con más de 10 años rescatando animales en situación de calle.',
    },
    {
      'nombre': 'Hogar Animal',
      'distrito': 'San Isidro, Lima',
      'mascotas': 18,
      'telefono': '+51 912 345 678',
      'descripcion': 'Refugio especializado en gatos y perros pequeños. Brindan atención veterinaria gratuita.',
    },
    {
      'nombre': 'Refugio Lima',
      'distrito': 'Surco, Lima',
      'mascotas': 35,
      'telefono': '+51 900 111 222',
      'descripcion': 'El albergue más grande de Lima, con capacidad para más de 50 animales.',
    },
    {
      'nombre': 'Amigos Peludos',
      'distrito': 'Pueblo Libre, Lima',
      'mascotas': 12,
      'telefono': '+51 933 222 111',
      'descripcion': 'Pequeño refugio familiar que promueve la adopción responsable.',
    },
    {
      'nombre': 'Rescate Animal Perú',
      'distrito': 'Barranco, Lima',
      'mascotas': 29,
      'telefono': '+51 955 777 888',
      'descripcion': 'ONG dedicada al rescate y rehabilitación de animales maltratados.',
    },
  ];

  List<Map<String, dynamic>> get _filtrados {
    if (_query.isEmpty) return _albergues;
    return _albergues
        .where((a) =>
            a['nombre'].toLowerCase().contains(_query.toLowerCase()) ||
            a['distrito'].toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Barra de búsqueda ──────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar albergue o distrito...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            onChanged: (value) => setState(() => _query = value),
          ),
        ),

        // ── Contador de resultados ─────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Text(
                '${_filtrados.length} albergues encontrados',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),
        ),

        // ── Lista de albergues ─────────────────────────────────────────────
        Expanded(
          child: _filtrados.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 60, color: Colors.grey),
                      SizedBox(height: 12),
                      Text('No se encontraron albergues',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filtrados.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final albergue = _filtrados[index];
                    return _AlbergueCard(
                      albergue: albergue,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AlbergueDetallePage(albergue: albergue),
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

// ─── Widget tarjeta de albergue ───────────────────────────────────────────────

class _AlbergueCard extends StatelessWidget {
  final Map<String, dynamic> albergue;
  final VoidCallback onTap;

  const _AlbergueCard({required this.albergue, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Ícono
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.business, color: Colors.teal, size: 30),
              ),
              const SizedBox(width: 14),
              // Información
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      albergue['nombre'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 2),
                        Text(
                          albergue['distrito'],
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.pets, size: 14, color: Colors.teal),
                        const SizedBox(width: 2),
                        Text(
                          '${albergue['mascotas']} mascotas',
                          style: const TextStyle(
                              color: Colors.teal,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}