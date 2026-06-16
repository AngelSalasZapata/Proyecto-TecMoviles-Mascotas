import 'package:flutter/material.dart';

class MascotaDetallePage extends StatelessWidget {
  final String nombre;
  final String tipo;
  final String edad;
  final String albergue;

  const MascotaDetallePage({
    super.key,
    required this.nombre,
    required this.tipo,
    required this.edad,
    required this.albergue,
  });

  bool get _esPerro => tipo.toLowerCase().contains('perro');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nombre),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            tooltip: 'Guardar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$nombre guardado en favoritos'),
                  backgroundColor: Colors.teal,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Imagen / placeholder ────────────────────────────────────────
            Container(
              width: double.infinity,
              height: 220,
              color: _esPerro
                  ? Colors.orange.shade100
                  : Colors.purple.shade100,
              child: Icon(
                Icons.pets,
                size: 90,
                color: _esPerro
                    ? Colors.orange.shade600
                    : Colors.purple.shade400,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Nombre y tipo ───────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nombre,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Chip(
                        label: Text(tipo),
                        backgroundColor: _esPerro
                            ? Colors.orange.shade100
                            : Colors.purple.shade100,
                        labelStyle: TextStyle(
                          color: _esPerro
                              ? Colors.orange.shade800
                              : Colors.purple.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(Icons.business,
                          size: 15, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        albergue,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Características ─────────────────────────────────────
                  const Text(
                    'Características',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _CaracteristicaItem(
                          icon: Icons.cake,
                          etiqueta: 'Edad',
                          valor: edad,
                        ),
                      ),
                      Expanded(
                        child: _CaracteristicaItem(
                          icon: Icons.monitor_weight,
                          etiqueta: 'Tamaño',
                          valor: 'Mediano',
                        ),
                      ),
                      Expanded(
                        child: _CaracteristicaItem(
                          icon: Icons.vaccines,
                          etiqueta: 'Vacunas',
                          valor: 'Completas',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Descripción ─────────────────────────────────────────
                  const Text(
                    'Sobre mí',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hola, soy $nombre 🐾 Soy muy cariñoso/a y me llevo bien con personas de todas las edades. '
                    'Estoy buscando un hogar donde pueda sentirme seguro/a y querido/a. '
                    'Estoy al día con mis vacunas y desparasitaciones. '
                    '¿Serás mi nueva familia?',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Requisitos de adopción ──────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline,
                                color: Colors.blue, size: 18),
                            SizedBox(width: 6),
                            Text(
                              'Requisitos de adopción',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Mayor de edad\n'
                          '• Compromiso de cuidado responsable\n'
                          '• Visita previa al albergue\n'
                          '• Firma de contrato de adopción',
                          style: TextStyle(fontSize: 13, height: 1.7),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Botón de adopción ───────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.pets),
                      label: Text('Adoptar a $nombre'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => _mostrarDialogoAdopcion(context),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Botón contactar albergue ────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.phone),
                      label: Text('Contactar a $albergue'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.teal,
                        side: const BorderSide(color: Colors.teal),
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoAdopcion(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('¿Adoptar a $nombre?'),
        content: const Text(
          'Al continuar, te pondremos en contacto con el albergue para iniciar el proceso de adopción. '
          'Recibirás instrucciones por correo electrónico.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '¡Solicitud enviada! El albergue te contactará pronto.'),
                  backgroundColor: Colors.teal,
                ),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}

// ─── Widget característica ────────────────────────────────────────────────────

class _CaracteristicaItem extends StatelessWidget {
  final IconData icon;
  final String etiqueta;
  final String valor;

  const _CaracteristicaItem({
    required this.icon,
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.teal, size: 22),
          const SizedBox(height: 6),
          Text(
            valor,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            etiqueta,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
