import 'package:flutter/material.dart';
import '../../models/personal.dart';
import '../../components/personal_card.dart';

class IndexPersonalScreen extends StatefulWidget {
  @override
  _IndexPersonalScreenState createState() => _IndexPersonalScreenState();
}

class _IndexPersonalScreenState extends State<IndexPersonalScreen> {
  List<Personal> personales = [
    Personal(
      id: 1,
      nombre: 'Pedro',
      apellido: 'Gómez',
      dni: '12345678',
      telefono: '789456123',
      correo: 'pedro.gomez@email.com',
      direccion: 'Av. Principal 123',
      puesto: 'Portero',
      estado: 'ACTIVO',
      activo: true,
      fechaNacimiento: DateTime(1985, 5, 20),
      fechaContratacion: DateTime(2020, 1, 10),
      fechaSalida: null,
      fechaCreacion: DateTime(2020, 1, 10),
      actualizado: DateTime.now(),
    ),
    Personal(
      id: 2,
      nombre: 'Ana',
      apellido: 'López',
      dni: '87654321',
      telefono: '654987321',
      correo: 'ana.lopez@email.com',
      direccion: 'Calle Secundaria 456',
      puesto: 'Administradora',
      estado: 'INACTIVO',
      activo: false,
      fechaNacimiento: DateTime(1990, 8, 15),
      fechaContratacion: DateTime(2018, 3, 5),
      fechaSalida: DateTime(2023, 2, 1),
      fechaCreacion: DateTime(2018, 3, 5),
      actualizado: DateTime.now(),
    ),
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    List<Personal> filtered = personales
        .where((p) =>
            p.nombre.toLowerCase().contains(search.toLowerCase()) ||
            p.apellido.toLowerCase().contains(search.toLowerCase()) ||
            p.dni.toLowerCase().contains(search.toLowerCase()))
        .toList()
      ..sort((a, b) => a.nombre.compareTo(b.nombre));

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
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
                  hintText: 'Buscar personal...',
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
                  final personal = filtered[index];
                  return PersonalCard(
                    personal: personal,
                    onEdit: () {
                      Navigator.pushNamed(
                        context,
                        '/editPersonal',
                        arguments: personal,
                      );
                    },
                    onDelete: () {
                      setState(() {
                        personales.removeWhere((p) => p.id == personal.id);
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
          Navigator.pushNamed(context, '/createPersonal');
        },
        icon: Icon(Icons.person_add, color: Colors.white),
        label: Text('Crear Personal', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF283593),
      ),
    );
  }
}
