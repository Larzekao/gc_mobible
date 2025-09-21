import 'package:flutter/material.dart';
import '../../models/residente.dart';
import '../../components/residente_card.dart';

class IndexResidenteScreen extends StatefulWidget {
  @override
  _IndexResidenteScreenState createState() => _IndexResidenteScreenState();
}

class _IndexResidenteScreenState extends State<IndexResidenteScreen> {
  List<Residente> residentes = [
    Residente(
      id: 1,
      nombre: 'Juan',
      apellidos: 'Perez',
      dni: '12345678',
      sexo: 'M',
      tipo: 'Propietario',
      activo: true,
      fechaNacimiento: DateTime(1990, 5, 10),
      telefono: '789456123',
      correo: 'juan.perez@email.com',
      residencia: 'Apto 101',
      fechaCreacion: DateTime.now().subtract(Duration(days: 100)),
      actualizado: DateTime.now(),
    ),
    Residente(
      id: 2,
      nombre: 'Maria',
      apellidos: 'Gonzalez',
      dni: '87654321',
      sexo: 'F',
      tipo: 'Inquilino',
      activo: false,
      fechaNacimiento: DateTime(1985, 8, 22),
      telefono: '654987321',
      correo: 'maria.gonzalez@email.com',
      residencia: 'Apto 202',
      fechaCreacion: DateTime.now().subtract(Duration(days: 200)),
      actualizado: DateTime.now(),
    ),
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
  List<Residente> filtered = residentes
    .where((r) =>
      r.nombre.toLowerCase().contains(search.toLowerCase()) ||
      r.apellidos.toLowerCase().contains(search.toLowerCase()) ||
      r.dni.toLowerCase().contains(search.toLowerCase()))
    .toList()
    ..sort((a, b) => a.nombre.compareTo(b.nombre));

    return Scaffold(
      appBar: AppBar(
        title: Text('Residentes', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
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
                  hintText: 'Buscar residente...',
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
                  final residente = filtered[index];
                  return ResidenteCard(
                    residente: residente,
                    onEdit: () {
                      Navigator.pushNamed(
                        context,
                        '/editResidente',
                        arguments: residente,
                      );
                    },
                    onDelete: () {
                      setState(() {
                        residentes.removeWhere((r) => r.id == residente.id);
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
          Navigator.pushNamed(context, '/createResidente');
        },
        icon: Icon(Icons.person_add, color: Colors.white),
        label: Text('Crear Residente', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF283593),
      ),
    );
  }
}
