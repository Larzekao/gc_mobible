import 'package:flutter/material.dart';
import '../../models/regla.dart';
import '../../models/area_comun.dart';
import '../../components/regla_card.dart';

class IndexReglaScreen extends StatefulWidget {
  @override
  _IndexReglaScreenState createState() => _IndexReglaScreenState();
}

class _IndexReglaScreenState extends State<IndexReglaScreen> {
  List<Regla> reglas = [
    Regla(
      id: 1, 
      nombre: 'No mascotas en piscina',
      descripcion: 'No se permiten mascotas en el área de la piscina por motivos de higiene y seguridad.',
      areas: [
        AreaComun(id: 1, nombre: 'Piscina', descripcion: 'Área de piscina principal'),
      ],
      activo: true,
    ),
    Regla(
      id: 2, 
      nombre: 'Horario de silencio',
      descripcion: 'Se debe mantener silencio en las áreas comunes después de las 22:00 hrs.',
      areas: [
        AreaComun(id: 2, nombre: 'Salón de eventos', descripcion: 'Salón para eventos sociales'),
        AreaComun(id: 3, nombre: 'Gimnasio', descripcion: 'Área de ejercicio y fitness'),
      ],
      activo: true,
    ),
    Regla(
      id: 3, 
      nombre: 'Reserva previa requerida',
      descripcion: 'Es obligatorio hacer reserva previa para utilizar el salón de eventos.',
      areas: [
        AreaComun(id: 2, nombre: 'Salón de eventos', descripcion: 'Salón para eventos sociales'),
      ],
      activo: false,
    ),
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    List<Regla> filtered = reglas
        .where((r) => r.nombre.toLowerCase().contains(search.toLowerCase()) ||
                     (r.descripcion?.toLowerCase().contains(search.toLowerCase()) ?? false))
        .toList()
      ..sort((a, b) => a.nombre.compareTo(b.nombre));

    return Scaffold(
      appBar: AppBar(
        title: Text('Reglas', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
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
                  hintText: 'Buscar regla...',
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
                  final regla = filtered[index];
                  return ReglaCard(
                    regla: regla,
                    onEdit: () {
                      Navigator.pushNamed(
                        context,
                        '/editRegla',
                        arguments: regla,
                      );
                    },
                    onDelete: () {
                      setState(() {
                        reglas.removeWhere((r) => r.id == regla.id);
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
          Navigator.pushNamed(context, '/createRegla');
        },
        icon: Icon(Icons.add, color: Colors.white),
        label: Text('Crear Regla', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF283593),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}