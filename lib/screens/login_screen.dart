import 'package:flutter/material.dart';

import '../componentes/componentes.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onAuthenticated});

  final void Function(AuthSession session) onAuthenticated;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  bool _estaCargando = false;

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _enviarFormulario() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _estaCargando = true;
    });

    try {
      final session = await _authService.login(
        username: _usuarioController.text,
        password: _passwordController.text,
      );

      if (!mounted) {
        return;
      }

      widget.onAuthenticated(session);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inicio de sesion exitoso.')),
      );
    } on AuthException catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.message)));
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocurrio un error inesperado. Intentalo nuevamente.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _estaCargando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const EncabezadoSeccion(
                          titulo: 'Bienvenido',
                          descripcion: 'Inicia sesion para continuar',
                          centrado: true,
                        ),
                        const SizedBox(height: 32),
                        CampoTexto(
                          controlador: _usuarioController,
                          etiqueta: 'Usuario o correo',
                          accionDeTeclado: TextInputAction.next,
                          validador: (valor) {
                            if (valor == null || valor.trim().isEmpty) {
                              return 'Ingresa tu usuario o correo.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CampoPassword(
                          controlador: _passwordController,
                          etiqueta: 'Contrasena',
                          accionDeTeclado: TextInputAction.done,
                          validador: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'Ingresa tu contrasena.';
                            }
                            if (valor.length < 4) {
                              return 'La contrasena debe tener al menos 4 caracteres.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        BotonPrincipal(
                          texto: 'Ingresar',
                          alPresionar: _enviarFormulario,
                          estaCargando: _estaCargando,
                        ),
                        const SizedBox(height: 12),
                        BotonEnlace(
                          texto: 'Olvidaste tu contrasena?',
                          onPressed: _estaCargando
                              ? null
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Funcionalidad de recuperacion de contrasena en desarrollo.',
                                      ),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
