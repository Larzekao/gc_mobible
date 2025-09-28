import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  const CampoTexto({
    super.key,
    required this.controlador,
    required this.etiqueta,
    this.ayuda,
    this.tipoTexto,
    this.accionDeTeclado,
    this.validador,
  });

  final TextEditingController controlador;
  final String etiqueta;
  final String? ayuda;
  final TextInputType? tipoTexto;
  final TextInputAction? accionDeTeclado;
  final String? Function(String?)? validador;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      decoration: InputDecoration(
        labelText: etiqueta,
        helperText: ayuda,
        border: const OutlineInputBorder(),
      ),
      keyboardType: tipoTexto,
      textInputAction: accionDeTeclado,
      validator: validador,
    );
  }
}

class CampoPassword extends StatefulWidget {
  const CampoPassword({
    super.key,
    required this.controlador,
    required this.etiqueta,
    this.validador,
    this.accionDeTeclado,
  });

  final TextEditingController controlador;
  final String etiqueta;
  final String? Function(String?)? validador;
  final TextInputAction? accionDeTeclado;

  @override
  State<CampoPassword> createState() => _CampoPasswordState();
}

class _CampoPasswordState extends State<CampoPassword> {
  bool _ocultar = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controlador,
      decoration: InputDecoration(
        labelText: widget.etiqueta,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _ocultar = !_ocultar;
            });
          },
          icon: Icon(_ocultar ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      obscureText: _ocultar,
      textInputAction: widget.accionDeTeclado,
      validator: widget.validador,
    );
  }
}
