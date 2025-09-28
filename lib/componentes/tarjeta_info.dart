import 'package:flutter/material.dart';

class TarjetaInfo extends StatelessWidget {
  const TarjetaInfo({
    super.key,
    required this.icono,
    required this.titulo,
    required this.descripcion,
    this.onTap,
  });

  final IconData icono;
  final String titulo;
  final String descripcion;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icono),
        title: Text(titulo),
        subtitle: Text(descripcion),
        onTap: onTap,
      ),
    );
  }
}
