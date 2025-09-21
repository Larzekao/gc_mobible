import 'package:flutter/material.dart';
import '../models/tarea.dart';

class TareaCard extends StatelessWidget {
  final Tarea tarea;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const TareaCard({
    Key? key,
    required this.tarea,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getEstadoColor(tarea.estado),
            child: Text(
              tarea.nombre.isNotEmpty ? tarea.nombre[0] : '?',
              style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            tarea.nombre,
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 18, color: Color(0xFF283593)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Descripción: ${tarea.descripcion ?? 'Sin descripción'}', 
                     style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Personal: ${tarea.personal.nombre} ${tarea.personal.apellido}', 
                     style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Fecha límite: ${tarea.fechaVencimiento != null ? tarea.fechaVencimiento!.toLocal().toString().split(' ')[0] : '-'}', 
                     style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Estado: ${_getEstadoDisplay(tarea.estado)}', 
                     style: TextStyle(
                       fontFamily: 'Montserrat', 
                       fontWeight: FontWeight.bold, 
                       color: _getEstadoColor(tarea.estado)
                     )),
              ],
            ),
          ),
          trailing: Wrap(
            spacing: 8,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.orange),
                tooltip: 'Editar',
                onPressed: onEdit,
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                tooltip: 'Eliminar',
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getEstadoDisplay(String estado) {
    switch (estado) {
      case 'PENDIENTE':
        return 'Pendiente';
      case 'PROGRESO':
        return 'En Progreso';
      case 'COMPLETADO':
        return 'Completado';
      default:
        return estado;
    }
  }

  Color _getEstadoColor(String estado) {
    switch (estado) {
      case 'COMPLETADO':
        return Colors.green;
      case 'PROGRESO':
        return Colors.orange;
      case 'PENDIENTE':
        return Color(0xFF283593);
      default:
        return Colors.grey;
    }
  }
}
