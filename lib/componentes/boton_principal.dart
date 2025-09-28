import 'package:flutter/material.dart';

class BotonPrincipal extends StatelessWidget {
  const BotonPrincipal({
    super.key,
    required this.texto,
    required this.alPresionar,
    this.estaCargando = false,
  });

  final String texto;
  final VoidCallback? alPresionar;
  final bool estaCargando;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: estaCargando ? null : alPresionar,
      child: estaCargando
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(texto),
    );
  }
}
