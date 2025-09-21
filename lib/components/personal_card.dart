import 'package:flutter/material.dart';
import '../models/personal.dart';

class PersonalCard extends StatelessWidget {
  final Personal personal;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PersonalCard({
    Key? key,
    required this.personal,
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
            backgroundColor: personal.estado == 'ACTIVO' ? Color(0xFF283593) : Color(0xFF1976d2),
            child: Text(
              personal.nombre.isNotEmpty ? personal.nombre[0] : '?',
              style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            '${personal.nombre} ${personal.apellido}',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 18, color: Color(0xFF283593)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DNI: ${personal.dni}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Teléfono: ${personal.telefono ?? '-'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Correo: ${personal.correo ?? '-'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Dirección: ${personal.direccion ?? '-'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Puesto: ${personal.puesto ?? '-'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Estado: ${personal.estado}', style: TextStyle(fontFamily: 'Montserrat', color: personal.estado == 'ACTIVO' ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                Text('Activo: ${personal.activo ? 'Sí' : 'No'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Nacimiento: ${personal.fechaNacimiento != null ? personal.fechaNacimiento!.toLocal().toString().split(' ')[0] : '-'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Contratación: ${personal.fechaContratacion != null ? personal.fechaContratacion!.toLocal().toString().split(' ')[0] : '-'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Salida: ${personal.fechaSalida != null ? personal.fechaSalida!.toLocal().toString().split(' ')[0] : '-'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
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
}
