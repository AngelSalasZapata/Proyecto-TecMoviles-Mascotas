import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonacionPage extends StatefulWidget {
  final String? alberguePreseleccionado;

  const DonacionPage({super.key, this.alberguePreseleccionado});

  @override
  State<DonacionPage> createState() => _DonacionPageState();
}

class _DonacionPageState extends State<DonacionPage> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _descripcionController = TextEditingController();

  String? _albergueSeleccionado;
  String _tipoDonacion = 'Dinero';
  bool _enviando = false;

  static const List<String> _albergues = [
    'Patitas Felices',
    'Hogar Animal',
    'Refugio Lima',
    'Amigos Peludos',
    'Rescate Animal Perú',
  ];

  static const List<Map<String, dynamic>> _tiposDonacion = [
    {'tipo': 'Dinero', 'icon': Icons.attach_money, 'color': Colors.green},
    {'tipo': 'Alimento', 'icon': Icons.set_meal, 'color': Colors.orange},
    {'tipo': 'Medicina', 'icon': Icons.medical_services, 'color': Colors.blue},
    {'tipo': 'Juguetes', 'icon': Icons.toys, 'color': Colors.purple},
  ];

  @override
  void initState() {
    super.initState();
    _albergueSeleccionado = widget.alberguePreseleccionado;
  }

  @override
  void dispose() {
    _montoController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _enviarDonacion() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _enviando = true);

    // Simular envío
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _enviando = false);

    if (mounted) {
      _mostrarConfirmacion();
    }
  }

  void _mostrarConfirmacion() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.teal, size: 50),
        title: const Text('¡Gracias por donar!'),
        content: Text(
          'Tu donación de $_tipoDonacion a $_albergueSeleccionado '
          'ha sido registrada. Te enviaremos un comprobante pronto.',
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              _formKey.currentState!.reset();
              _montoController.clear();
              _descripcionController.clear();
              setState(() {
                _tipoDonacion = 'Dinero';
                _albergueSeleccionado = null;
              });
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Encabezado ─────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.volunteer_activism,
                      color: Colors.orange, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Realiza una donación',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tu aporte ayuda a mantener a los animales seguros y saludables.',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Selección de albergue ───────────────────────────────────────
            const Text(
              'Albergue a donar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _albergueSeleccionado,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.business),
                hintText: 'Selecciona un albergue',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 14),
              ),
              items: _albergues
                  .map(
                    (a) => DropdownMenuItem(value: a, child: Text(a)),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _albergueSeleccionado = v),
              validator: (v) =>
                  v == null ? 'Selecciona un albergue' : null,
            ),

            const SizedBox(height: 20),

            // ── Tipo de donación ────────────────────────────────────────────
            const Text(
              'Tipo de donación',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 8,
              childAspectRatio: 0.85,
              children: _tiposDonacion
                  .map(
                    (t) => GestureDetector(
                      onTap: () =>
                          setState(() => _tipoDonacion = t['tipo']),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _tipoDonacion == t['tipo']
                              ? (t['color'] as Color).withOpacity(0.15)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _tipoDonacion == t['tipo']
                                ? t['color'] as Color
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(t['icon'] as IconData,
                                color: t['color'] as Color, size: 26),
                            const SizedBox(height: 4),
                            Text(
                              t['tipo'],
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: t['color'] as Color,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 20),

            // ── Monto (solo si es dinero) ───────────────────────────────────
            if (_tipoDonacion == 'Dinero') ...[
              const Text(
                'Monto (S/.)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 8),
              // Montos rápidos
              Wrap(
                spacing: 8,
                children: [10, 20, 50, 100].map((monto) {
                  return ActionChip(
                    label: Text('S/. $monto'),
                    onPressed: () =>
                        _montoController.text = monto.toString(),
                    backgroundColor: Colors.teal.shade50,
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _montoController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.attach_money),
                  hintText: 'Ingresa el monto',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) {
                  if (_tipoDonacion != 'Dinero') return null;
                  if (v == null || v.isEmpty) return 'Ingresa un monto';
                  if (int.tryParse(v) == null || int.parse(v) <= 0) {
                    return 'Ingresa un monto válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],

            // ── Descripción / mensaje ───────────────────────────────────────
            const Text(
              'Mensaje (opcional)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descripcionController,
              maxLines: 3,
              maxLength: 200,
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 48),
                  child: Icon(Icons.message),
                ),
                hintText:
                    'Ej: Espero que esto ayude a los perritos...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 24),

            // ── Botón enviar ────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: _enviando
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.volunteer_activism),
                label: Text(
                    _enviando ? 'Enviando...' : 'Confirmar donación'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _enviando ? null : _enviarDonacion,
              ),
            ),
          ],
        ),
      ),
    );
  }
}