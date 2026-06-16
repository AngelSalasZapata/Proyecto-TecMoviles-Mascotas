import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _ocultarPassword = true;
  bool _ocultarConfirm = true;
  bool _cargando = false;
  String _rol = 'Adoptante';
  bool _aceptaTerminos = false;

  static const List<Map<String, dynamic>> _roles = [
    {
      'valor': 'Adoptante',
      'descripcion': 'Quiero adoptar una mascota',
      'icon': Icons.favorite,
    },
    {
      'valor': 'Voluntario',
      'descripcion': 'Quiero ayudar en un albergue',
      'icon': Icons.volunteer_activism,
    },
    {
      'valor': 'Donante',
      'descripcion': 'Quiero hacer donaciones',
      'icon': Icons.attach_money,
    },
  ];

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registrar() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_aceptaTerminos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes aceptar los términos y condiciones.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _cargando = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _cargando = false);

    if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          icon:
              const Icon(Icons.check_circle, color: Colors.teal, size: 50),
          title: const Text('¡Bienvenido/a!'),
          content: Text(
            'Tu cuenta ha sido creada exitosamente como ${_nombreController.text}. '
            'Ya puedes explorar Huella Solidaria.',
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context); // regresar al login
              },
              child: const Text('Ir al inicio'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Únete a Huella Solidaria 🐾',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Completa tus datos para registrarte.',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 24),

              // ── Nombre completo ─────────────────────────────────────────
              _CampoLabel(label: 'Nombre completo'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nombreController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecoration(
                  hint: 'Juan Pérez',
                  icon: Icons.person_outline,
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Ingresa tu nombre';
                  if (v.trim().length < 3) return 'Nombre muy corto';
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ── Correo ─────────────────────────────────────────────────
              _CampoLabel(label: 'Correo electrónico'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(
                  hint: 'ejemplo@correo.com',
                  icon: Icons.email_outlined,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ingresa tu correo';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                    return 'Correo inválido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ── Contraseña ─────────────────────────────────────────────
              _CampoLabel(label: 'Contraseña'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _passwordController,
                obscureText: _ocultarPassword,
                decoration: _inputDecoration(
                  hint: '••••••••',
                  icon: Icons.lock_outline,
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _ocultarPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _ocultarPassword = !_ocultarPassword),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ingresa una contraseña';
                  if (v.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ── Confirmar contraseña ────────────────────────────────────
              _CampoLabel(label: 'Confirmar contraseña'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _ocultarConfirm,
                decoration: _inputDecoration(
                  hint: '••••••••',
                  icon: Icons.lock_outline,
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _ocultarConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _ocultarConfirm = !_ocultarConfirm),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Confirma tu contraseña';
                  }
                  if (v != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ── Selección de rol ────────────────────────────────────────
              _CampoLabel(label: 'Soy principalmente un...'),
              const SizedBox(height: 10),
              Column(
                children: _roles
                    .map(
                      (r) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _rol = r['valor']),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: _rol == r['valor']
                                  ? Colors.teal.shade50
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _rol == r['valor']
                                    ? Colors.teal
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  r['icon'] as IconData,
                                  color: _rol == r['valor']
                                      ? Colors.teal
                                      : Colors.grey,
                                  size: 22,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      r['valor'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: _rol == r['valor']
                                            ? Colors.teal
                                            : Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      r['descripcion'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                if (_rol == r['valor'])
                                  const Icon(Icons.check_circle,
                                      color: Colors.teal, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 16),

              // ── Términos y condiciones ──────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _aceptaTerminos,
                    activeColor: Colors.teal,
                    onChanged: (v) =>
                        setState(() => _aceptaTerminos = v ?? false),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text.rich(
                        TextSpan(
                          text: 'Acepto los ',
                          style: TextStyle(fontSize: 13),
                          children: [
                            TextSpan(
                              text: 'Términos y Condiciones',
                              style: TextStyle(
                                color: Colors.teal,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: ' y la '),
                            TextSpan(
                              text: 'Política de Privacidad',
                              style: TextStyle(
                                color: Colors.teal,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: ' de Huella Solidaria.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Botón registrar ─────────────────────────────────────────
              ElevatedButton(
                onPressed: _cargando ? null : _registrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: _cargando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Crear cuenta',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),

              const SizedBox(height: 16),

              // ── Ya tienes cuenta ────────────────────────────────────────
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text.rich(
                    TextSpan(
                      text: '¿Ya tienes cuenta? ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: 'Inicia sesión',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint,
      border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.grey.shade50,
    );
  }
}

// ─── Widget label reutilizable ────────────────────────────────────────────────

class _CampoLabel extends StatelessWidget {
  final String label;
  const _CampoLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    );
  }
}