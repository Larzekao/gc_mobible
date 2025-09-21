import 'package:condominium_app/models/personal.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/homeAdministrador.dart';
import 'screens/usuarios/indexUsuario_screen.dart';
import 'screens/usuarios/editUsuario_screen.dart';
import 'screens/usuarios/createUsuario_screen.dart';
import 'screens/personales/indexPersonal_screen.dart';
import 'screens/personales/editPersonal_screen.dart';
import 'screens/personales/createPersonal_screen.dart';
import 'screens/residentes/indexResidente_screen.dart';
import 'screens/residentes/editResidente_screen.dart';
import 'screens/residentes/createResidente_screen.dart';
import 'screens/roles/indexRol_screen.dart';
import 'screens/roles/createRol_screen.dart';
import 'screens/roles/editRol_screen.dart';
import 'screens/tareas/indexTarea_screen.dart';
import 'screens/tareas/createTarea_screen.dart';
import 'screens/tareas/editTarea_screen.dart';
import 'screens/reglas/indexRegla_screen.dart';
import 'screens/reglas/createRegla_screen.dart';
import 'screens/reglas/editRegla_screen.dart';
import 'models/usuario.dart';
import 'models/residente.dart';
import 'models/rol.dart';
import 'models/tarea.dart';
import 'models/regla.dart';
// Importa tu archivo de LoginPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Condominium App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/homeAdministrador': (context) => HomeAdministrador(),
        
        // Rutas de Usuarios
        '/indexUsuario': (context) => IndexUsuarioScreen(),
        '/createUsuario': (context) => CreateUsuarioScreen(),
        '/editUsuario': (context) => EditUsuarioScreen(usuario: ModalRoute.of(context)!.settings.arguments as Usuario),
        
        // Rutas de Personales  
        '/indexPersonal': (context) => IndexPersonalScreen(),
        '/createPersonal': (context) => CreatePersonalScreen(),
        '/editPersonal': (context) => EditPersonalScreen(personal: ModalRoute.of(context)!.settings.arguments as Personal),
        
        // Rutas de Residentes
        '/indexResidente': (context) => IndexResidenteScreen(),
        '/createResidente': (context) => CreateResidenteScreen(),
        '/editResidente': (context) => EditResidenteScreen(residente: ModalRoute.of(context)!.settings.arguments as Residente),
        
        // Rutas de Roles
        '/indexRol': (context) => IndexRolScreen(),
        '/createRol': (context) => CreateRolScreen(),
        '/editRol': (context) => EditRolScreen(rol: ModalRoute.of(context)!.settings.arguments as Rol),
        
        // Rutas de Tareas
        '/indexTarea': (context) => IndexTareaScreen(),
        '/createTarea': (context) => CreateTareaScreen(),
        '/editTarea': (context) => EditTareaScreen(tarea: ModalRoute.of(context)!.settings.arguments as Tarea),
        
        // Rutas de Reglas
        '/indexRegla': (context) => IndexReglaScreen(),
        '/createRegla': (context) => CreateReglaScreen(),
        '/editRegla': (context) => EditReglaScreen(regla: ModalRoute.of(context)!.settings.arguments as Regla),
        
        // Rutas adicionales del menú
        '/areas': (context) => Scaffold(appBar: AppBar(title: Text('Áreas')), body: Center(child: Text('Pantalla de Áreas - Por implementar'))),
        '/reservas': (context) => Scaffold(appBar: AppBar(title: Text('Reservas')), body: Center(child: Text('Pantalla de Reservas - Por implementar'))),
        '/anuncios': (context) => Scaffold(appBar: AppBar(title: Text('Anuncios')), body: Center(child: Text('Pantalla de Anuncios - Por implementar'))),
        '/foros': (context) => Scaffold(appBar: AppBar(title: Text('Foros')), body: Center(child: Text('Pantalla de Foros - Por implementar'))),
        '/mantenimiento': (context) => Scaffold(appBar: AppBar(title: Text('Mantenimiento')), body: Center(child: Text('Pantalla de Mantenimiento - Por implementar'))),
        '/limpieza': (context) => Scaffold(appBar: AppBar(title: Text('Limpieza')), body: Center(child: Text('Pantalla de Limpieza - Por implementar'))),
        '/proveedores': (context) => Scaffold(appBar: AppBar(title: Text('Proveedores')), body: Center(child: Text('Pantalla de Proveedores - Por implementar'))),
        '/expensas': (context) => Scaffold(appBar: AppBar(title: Text('Expensas')), body: Center(child: Text('Pantalla de Expensas - Por implementar'))),
        '/pagos': (context) => Scaffold(appBar: AppBar(title: Text('Pagos')), body: Center(child: Text('Pantalla de Pagos - Por implementar'))),
        '/historial-pagos': (context) => Scaffold(appBar: AppBar(title: Text('Historial')), body: Center(child: Text('Pantalla de Historial - Por implementar'))),
        '/reportes': (context) => Scaffold(appBar: AppBar(title: Text('Reportes')), body: Center(child: Text('Pantalla de Reportes - Por implementar'))),
        '/seguridad': (context) => Scaffold(appBar: AppBar(title: Text('Seguridad')), body: Center(child: Text('Pantalla de Seguridad - Por implementar'))),
        '/acceso': (context) => Scaffold(appBar: AppBar(title: Text('Control Acceso')), body: Center(child: Text('Pantalla de Control Acceso - Por implementar'))),
        '/estacionamientos': (context) => Scaffold(appBar: AppBar(title: Text('Estacionamientos')), body: Center(child: Text('Pantalla de Estacionamientos - Por implementar'))),
        '/monitoreo': (context) => Scaffold(appBar: AppBar(title: Text('Monitoreo')), body: Center(child: Text('Pantalla de Monitoreo - Por implementar'))),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}