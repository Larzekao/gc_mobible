import 'package:flutter/material.dart';
import '../models/rol.dart';

class RolCard extends StatelessWidget {
  final Rol rol;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const RolCard({
    Key? key,
    required this.rol,
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
            backgroundColor: Color(0xFF283593),
            child: Text(
              rol.nombre.isNotEmpty ? rol.nombre[0] : '?',
              style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            rol.nombre,
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 18, color: Color(0xFF283593)),
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
