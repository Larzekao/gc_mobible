import 'package:flutter/material.dart';

class EncabezadoSeccion extends StatelessWidget {
  const EncabezadoSeccion({
    super.key,
    required this.titulo,
    this.descripcion,
    this.centrado = false,
  });

  final String titulo;
  final String? descripcion;
  final bool centrado;

  @override
  Widget build(BuildContext context) {
    final alineacion = centrado ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: centrado
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: alineacion,
        ),
        if (descripcion != null) ...[
          const SizedBox(height: 8),
          Text(
            descripcion!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: alineacion,
          ),
        ],
      ],
    );
  }
}
