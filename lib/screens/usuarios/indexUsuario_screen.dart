import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../components/user_card.dart';

class IndexUsuarioScreen extends StatefulWidget {
  @override
  _IndexUsuarioScreenState createState() => _IndexUsuarioScreenState();
}

class _IndexUsuarioScreenState extends State<IndexUsuarioScreen> {
  List<Usuario> usuarios = [
    Usuario(
      id: 1,
      correo: 'admin@admin.com',
      nombre: 'Admin',
      apellido: 'Principal',
      telefono: '123456789',
      rol: null,
      isActive: true,
      isStaff: true,
    ),
    Usuario(
      id: 2,
      correo: 'user@condominio.com',
      nombre: 'Juan',
      apellido: 'Pérez',
      telefono: '987654321',
      rol: null,
      isActive: true,
      isStaff: false,
    ),
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    List<Usuario> filtered = usuarios
        .where((u) =>
            u.correo.toLowerCase().contains(search.toLowerCase()) ||
            (u.nombre ?? '').toLowerCase().contains(search.toLowerCase()) ||
            (u.apellido ?? '').toLowerCase().contains(search.toLowerCase()))
        .toList()
      ..sort((a, b) => (a.nombre ?? '').compareTo(b.nombre ?? ''));

    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF283593),
        elevation: 0,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 175, 186, 201), size: 28),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe3f2fd), Color(0xFFbbdefb)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar usuario...',
                  hintStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[700]),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF283593)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                ),
                style: TextStyle(fontFamily: 'Montserrat'),
                onChanged: (value) => setState(() => search = value),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final usuario = filtered[index];
                  return UserCard(
                    usuario: usuario,
                    onEdit: () {
                      Navigator.pushNamed(
                        context,
                        '/editUsuario',
                        arguments: usuario,
                      );
                    },
                    onDelete: () {
                      setState(() {
                        usuario.isActive = false;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/createUsuario');
        },
        icon: Icon(Icons.person_add,color: Colors.white),
        label: Text('Crear Usuario', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF283593),
      ),
    );
  }
}