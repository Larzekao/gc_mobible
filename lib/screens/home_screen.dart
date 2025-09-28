import 'package:flutter/material.dart';

import '../componentes/componentes.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.session, required this.onLogout});

  final AuthSession session;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final usuario = session.user;
    final nombre = (usuario['first_name'] ?? usuario['username'] ?? 'usuario')
        .toString();
    final rol = (usuario['rol'] ?? 'No asignado').toString().toUpperCase();
    final correo = usuario['email']?.toString() ?? 'Sin correo';
    final telefono = usuario['telefono']?.toString() ?? 'No registrado';
    final vistaToken = session.accessToken.length >= 8
        ? session.accessToken.substring(0, 8)
        : session.accessToken;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel principal'),
        actions: [
          IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesion',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EncabezadoSeccion(
              titulo: 'Hola, ' + nombre,
              descripcion: 'Tu rol: ' + rol,
            ),
            const SizedBox(height: 32),
            TarjetaInfo(
              icono: Icons.person,
              titulo: nombre,
              descripcion: correo,
            ),
            const SizedBox(height: 16),
            TarjetaInfo(
              icono: Icons.phone,
              titulo: 'Telefono',
              descripcion: telefono,
            ),
            const Spacer(),
            Text(
              'Access token (primeros caracteres): ' + vistaToken + '...',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
