import 'package:flutter/material.dart';
class HomeAdministrador extends StatelessWidget {
  HomeAdministrador({Key? key}) : super(key: key);

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
        title: const Text('Panel de Administrador'),
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
                  Icon(Icons.admin_panel_settings, color: Colors.white, size: 48),
                  SizedBox(height: 12),
                  Text('Panel Administrador', style: TextStyle(color: Colors.white, fontSize: 22)),
                ],
              ),
            ),
            
            // 1. AUTENTICACIÓN E IDENTIDAD
            _buildMenuSection(
              context,
              icon: Icons.person_outline,
              title: 'Autenticación e Identidad',
              color: Colors.indigo,
              items: [
                {'icon': Icons.manage_accounts, 'title': 'Gestionar Usuarios', 'route': '/indexUsuario'},
                //{'icon': Icons.badge_outlined, 'title': 'Gestionar Personal', 'route': '/indexPersonal'},
                //{'icon': Icons.people_outline, 'title': 'Gestionar Residentes', 'route': '/indexResidente'},
                {'icon': Icons.security, 'title': 'Gestionar Roles', 'route': '/indexRol'},
              ],
            ),
            
            // 2. COMUNIDAD Y RECURSOS
            _buildMenuSection(
              context,
              icon: Icons.groups,
              title: 'Comunidad y Recursos',
              color: Colors.green,
              items: [
                {'icon': Icons.people_outline, 'title': 'Gestionar Residentes', 'route': '/indexResidente'},
                //{'icon': Icons.home_work, 'title': 'Áreas Comunes', 'route': '/areas'},
                //{'icon': Icons.event_available, 'title': 'Reservas', 'route': '/reservas'},
                //{'icon': Icons.announcement, 'title': 'Anuncios', 'route': '/anuncios'},
                //{'icon': Icons.forum, 'title': 'Foros Comunidad', 'route': '/foros'},
              ],
            ),
            
            // 3. GESTIÓN DE SERVICIOS
            _buildMenuSection(
              context,
              icon: Icons.miscellaneous_services,
              title: 'Gestión de Servicios',
              color: Colors.orange,
              items: [
                {'icon': Icons.assignment, 'title': 'Gestionar Tareas', 'route': '/indexTarea'},
                {'icon': Icons.rule, 'title': 'Gestionar Reglas', 'route': '/indexRegla'},
                //{'icon': Icons.build, 'title': 'Mantenimiento', 'route': '/mantenimiento'},
                //{'icon': Icons.cleaning_services, 'title': 'Limpieza', 'route': '/limpieza'},
                //{'icon': Icons.local_shipping, 'title': 'Proveedores', 'route': '/proveedores'},
              ],
            ),
            
            // 4. GESTIÓN DE PAGOS
            _buildMenuSection(
              context,
              icon: Icons.payment,
              title: 'Gestión de Pagos',
              color: Colors.purple,
              items: [
                //{'icon': Icons.receipt_long, 'title': 'Expensas', 'route': '/expensas'},
                //{'icon': Icons.account_balance_wallet, 'title': 'Pagos Pendientes', 'route': '/pagos'},
               // {'icon': Icons.history, 'title': 'Historial Pagos', 'route': '/historial-pagos'},
               // {'icon': Icons.analytics, 'title': 'Reportes Financieros', 'route': '/reportes'},
              ],
            ),
            
            // 5. GESTIÓN DE CONTROL
            _buildMenuSection(
              context,
              icon: Icons.security_outlined,
              title: 'Gestión de Control',
              color: Colors.red,
              items: [
                {'icon': Icons.badge_outlined, 'title': 'Gestionar Personal', 'route': '/indexPersonal'},
                //{'icon': Icons.videocam, 'title': 'Seguridad', 'route': '/seguridad'},
                //{'icon': Icons.key, 'title': 'Control Acceso', 'route': '/acceso'},
                //{'icon': Icons.directions_car, 'title': 'Estacionamientos', 'route': '/estacionamientos'},
                //{'icon': Icons.visibility, 'title': 'Monitoreo', 'route': '/monitoreo'},
              ],
            ),
            
            const Divider(thickness: 2),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Cerrar Sesión', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
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
                  Icon(Icons.admin_panel_settings, size: 60, color: Colors.blue[700]),
                  SizedBox(height: 16),
                  Text(
                    'Bienvenido al Panel de Administrador',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Gestiona usuarios, áreas y tareas desde este panel.',
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
