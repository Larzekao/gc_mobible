import 'package:flutter/material.dart';
import '../models/residente.dart';

class ResidenteCard extends StatelessWidget {
  final Residente residente;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ResidenteCard({
    Key? key,
    required this.residente,
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
            backgroundColor: residente.activo ? Color(0xFF283593) : Color(0xFF1976d2),
            child: Text(
              residente.nombre.isNotEmpty ? residente.nombre[0] : '?',
              style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            '${residente.nombre} ${residente.apellidos}',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 18, color: Color(0xFF283593)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DNI: ${residente.dni}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Teléfono: ${residente.telefono ?? '-'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Correo: ${residente.correo ?? '-'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Sexo: ${residente.sexo}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Tipo: ${residente.tipo}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Estado: ${residente.activo ? 'ACTIVO' : 'INACTIVO'}', style: TextStyle(fontFamily: 'Montserrat', color: residente.activo ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
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
