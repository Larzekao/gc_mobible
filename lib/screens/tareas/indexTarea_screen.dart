import 'package:flutter/material.dart';
import '../../models/tarea.dart';
import '../../models/personal.dart';
import '../../components/tarea_card.dart';

class IndexTareaScreen extends StatefulWidget {
  @override
  _IndexTareaScreenState createState() => _IndexTareaScreenState();
}

class _IndexTareaScreenState extends State<IndexTareaScreen> {
  List<Tarea> tareas = [
    Tarea(
      id: 1,
      nombre: 'Limpiar piscina',
      descripcion: 'Limpieza semanal',
      estado: 'PENDIENTE',
      fechaAsignacion: DateTime.now(),
      fechaVencimiento: DateTime.now().add(Duration(days: 7)),
      personal: Personal(
        id: 1,
        nombre: 'Juan',
        apellido: 'Perez',
        dni: '123456',
        puesto: 'Encargado de piscina',
        estado: 'Activo',
      ),
      creado: DateTime.now(),
      actualizado: DateTime.now(),
    ),
    Tarea(
      id: 2,
      nombre: 'Reparar portón',
      descripcion: 'Portón principal descompuesto',
      estado: 'PROGRESO',
      fechaAsignacion: DateTime.now(),
      fechaVencimiento: DateTime.now().add(Duration(days: 3)),
      personal: Personal(
        id: 2,
        nombre: 'Maria',
        apellido: 'Lopez',
        dni: '654321',
        puesto: 'Mantenimiento',
        estado: 'Activo',
      ),
      creado: DateTime.now(),
      actualizado: DateTime.now(),
    ),
    Tarea(
      id: 3,
      nombre: 'Pintar fachada',
      descripcion: 'Fachada principal',
      estado: 'COMPLETADO',
      fechaAsignacion: DateTime.now().subtract(Duration(days: 10)),
      fechaVencimiento: DateTime.now().subtract(Duration(days: 2)),
      personal: Personal(
        id: 3,
        nombre: 'Carlos',
        apellido: 'Gomez',
        dni: '789012',
        puesto: 'Pintor',
        estado: 'Inactivo',
      ),
      creado: DateTime.now().subtract(Duration(days: 10)),
      actualizado: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    List<Tarea> filtered = tareas
        .where((t) => t.nombre.toLowerCase().contains(search.toLowerCase()) || (t.descripcion?.toLowerCase() ?? '').contains(search.toLowerCase()))
        .toList()
      ..sort((a, b) => a.nombre.compareTo(b.nombre));

    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
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
                  hintText: 'Buscar tarea...',
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
                  final tarea = filtered[index];
                  return TareaCard(
                    tarea: tarea,
                    onEdit: () {
                      Navigator.pushNamed(
                        context,
                        '/editTarea',
                        arguments: tarea,
                      );
                    },
                    onDelete: () {
                      setState(() {
                        tareas.removeWhere((t) => t.id == tarea.id);
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
          Navigator.pushNamed(context, '/createTarea');
        },
        icon: Icon(Icons.add_task, color: Colors.white),
        label: Text('Crear Tarea', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF283593),
      ),
    );
  }
}
