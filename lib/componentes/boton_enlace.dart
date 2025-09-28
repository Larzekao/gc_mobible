import 'package:flutter/material.dart';

class BotonEnlace extends StatelessWidget {
  const BotonEnlace({super.key, required this.texto, this.onPressed});

  final String texto;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(texto));
  }
}
