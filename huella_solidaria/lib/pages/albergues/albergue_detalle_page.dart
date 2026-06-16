import 'package:flutter/material.dart';
import '../adopcion/mascota_detalle_page.dart';
import '../donacion/donacion_page.dart';

class AlbergueDetallePage extends StatelessWidget {
  final Map<String, dynamic> albergue;

  const AlbergueDetallePage({super.key, required this.albergue});

  // ── Mock mascotas del albergue ────────────────────────────────────────────
  static const List<Map<String, String>> _mascotas = [
    {'nombre': 'Tobi', 'tipo': 'Perro', 'edad': '4 años', 'estado': 'Disponible'},
    {'nombre': 'Nala', 'tipo': 'Perra', 'edad': '2 años', 'estado': 'Disponible'},
    {'nombre': 'Pelusa', 'tipo': 'Gato', 'edad': '1 año', 'estado': 'En proceso'},
    {'nombre': 'Fido', 'tipo': 'Perro', 'edad': '5 años', 'estado': 'Disponible'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(albergue['nombre']),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Encabezado del albergue ──────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.teal.shade50,
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.business,
                        color: Colors.teal, size: 42),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    albergue['nombre'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        albergue['distrito'],
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Estadísticas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Estadistica(
                        valor: '${albergue['mascotas']}',
                        etiqueta: 'Mascotas',
                        icon: Icons.pets,
                      ),
                      _Estadistica(
                        valor: albergue['telefono'],
                        etiqueta: 'Contacto',
                        icon: Icons.phone,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Descripción ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sobre el albergue',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    albergue['descripcion'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Botón donar ────────────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.volunteer_activism),
                      label: const Text('Donar a este albergue'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DonacionPage(
                            alberguePreseleccionado: albergue['nombre'],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Mascotas del albergue ──────────────────────────────────
                  const Text(
                    'Mascotas en adopción',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _mascotas.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final m = _mascotas[index];
                      final disponible = m['estado'] == 'Disponible';
                      return Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: disponible
                                ? Colors.teal.shade100
                                : Colors.grey.shade200,
                            child: Icon(
                              Icons.pets,
                              color:
                                  disponible ? Colors.teal : Colors.grey,
                            ),
                          ),
                          title: Text(
                            m['nombre']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${m['tipo']} • ${m['edad']}',
                          ),
                          trailing: Chip(
                            label: Text(
                              m['estado']!,
                              style: TextStyle(
                                fontSize: 11,
                                color: disponible
                                    ? Colors.teal.shade800
                                    : Colors.grey.shade700,
                              ),
                            ),
                            backgroundColor: disponible
                                ? Colors.teal.shade50
                                : Colors.grey.shade200,
                          ),
                          onTap: disponible
                              ? () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MascotaDetallePage(
                                        nombre: m['nombre']!,
                                        tipo: m['tipo']!,
                                        edad: m['edad']!,
                                        albergue: albergue['nombre'],
                                      ),
                                    ),
                                  )
                              : null,
                        ),
                      );
                    },
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

// ─── Widget estadística ───────────────────────────────────────────────────────

class _Estadistica extends StatelessWidget {
  final String valor;
  final String etiqueta;
  final IconData icon;

  const _Estadistica({
    required this.valor,
    required this.etiqueta,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.teal, size: 22),
        const SizedBox(height: 4),
        Text(
          valor,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          etiqueta,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}