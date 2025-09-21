import 'package:flutter/material.dart';
import '../../models/rol.dart';
import '../../components/rol_card.dart';

class IndexRolScreen extends StatefulWidget {
  @override
  _IndexRolScreenState createState() => _IndexRolScreenState();
}

class _IndexRolScreenState extends State<IndexRolScreen> {
  List<Rol> roles = [
    Rol(id: 1, nombre: 'Administrador'),
    Rol(id: 2, nombre: 'Residente'),
    Rol(id: 3, nombre: 'Personal'),
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    List<Rol> filtered = roles
        .where((r) => r.nombre.toLowerCase().contains(search.toLowerCase()))
        .toList()
      ..sort((a, b) => a.nombre.compareTo(b.nombre));

    return Scaffold(
      appBar: AppBar(
        title: Text('Roles', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF283593),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white, size: 28),
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
                  hintText: 'Buscar rol...',
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
                  final rol = filtered[index];
                  return RolCard(
                    rol: rol,
                    onEdit: () {
                      Navigator.pushNamed(
                        context,
                        '/editRol',
                        arguments: rol,
                      );
                    },
                    onDelete: () {
                      setState(() {
                        roles.removeWhere((r) => r.id == rol.id);
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
          Navigator.pushNamed(context, '/createRol');
        },
        icon: Icon(Icons.add, color: Colors.white),
        label: Text('Crear Rol', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF283593),
      ),
    );
  }
}
