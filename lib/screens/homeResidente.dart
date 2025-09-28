import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeResidente extends StatelessWidget {
  HomeResidente({Key? key}) : super(key: key);

  Widget _buildMenuSection(BuildContext context, {
    required IconData icon,
    required String title,
    required MaterialColor color,
    required List<Map<String, dynamic>> items,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: color.withOpacity(0.1),
          colorScheme: ColorScheme.light(primary: color),
        ),
        child: ExpansionTile(
          leading: Icon(icon, color: color[700]),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color[700]),
          ),
          childrenPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          iconColor: color[700],
          collapsedIconColor: color[700],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: items.map((item) => ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  tileColor: Colors.transparent,
                  leading: Icon(item['icon'] as IconData, color: color),
                  title: Text(
                    item['title'] as String,
                    style: TextStyle(color: color[900]),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, item['route'] as String);
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Panel de Residente'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, color: Colors.white, size: 48),
                  SizedBox(height: 12),
                  Text('Panel Residente', style: TextStyle(color: Colors.white, fontSize: 22)),
                ],
              ),
            ),
            // Áreas Comunes
            _buildMenuSection(
              context,
              icon: Icons.home_work,
              title: 'Áreas Comunes',
              color: Colors.blue,
              items: [
                {'icon': Icons.search, 'title': 'Consultar Disponibilidad', 'route': '/consultarDisponibilidadArea'},
                {'icon': Icons.event_available, 'title': 'Reservar Área', 'route': '/reservarArea'},
                {'icon': Icons.cancel, 'title': 'Cancelar Reserva', 'route': '/cancelarReservaArea'},
              ],
            ),
            // IA
            _buildMenuSection(
              context,
              icon: Icons.memory,
              title: 'IA',
              color: Colors.deepPurple,
              items: [
                {'icon': Icons.face_retouching_natural, 'title': 'Reconocimiento Facial', 'route': '/ia/reconocimientoFacial'},
                {'icon': Icons.directions_car, 'title': 'Reconocimiento de Placa', 'route': '/ia/reconocimientoPlaca'},
              ],
            ),
            const Divider(thickness: 2),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Cerrar Sesión', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () async {
                // Lógica para cerrar sesión en el backend y limpiar sesión local
                try {
                  await http.get(
                    Uri.parse('https://condominium-api-staging.up.railway.app/cuenta/logout/'),
                  );//tengo que cambiar la ruta
                  // Aquí podrías limpiar el token local si es necesario
                } catch (e) {
                  // Manejo de error opcional
                }
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            color: Colors.white.withOpacity(0.95),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, size: 60, color: Colors.blue[700]),
                  SizedBox(height: 16),
                  Text(
                    'Bienvenido Residente',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Consulta, reserva y cancela áreas comunes desde este panel.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
