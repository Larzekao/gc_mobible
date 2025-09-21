import 'package:flutter/material.dart';
import '../models/usuario.dart';

class UserCard extends StatelessWidget {
  final Usuario usuario;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const UserCard({
    Key? key,
    required this.usuario,
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
            backgroundColor: usuario.isStaff ? Color(0xFF283593) : Color(0xFF1976d2),
            child: Text(
              usuario.nombre != null && usuario.nombre!.isNotEmpty ? usuario.nombre![0] : '?',
              style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            '${usuario.nombre ?? ''} ${usuario.apellido ?? ''}',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 18, color: Color(0xFF283593)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Correo: ${usuario.correo}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Teléfono: ${usuario.telefono ?? '-'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Text('Rol: ${usuario.rol?.nombre ?? 'Sin rol'}', style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[800], fontSize: 14)),
                Row(
                  children: [
                    Icon(usuario.isActive ? Icons.check_circle : Icons.cancel, color: usuario.isActive ? Colors.green : Colors.red, size: 18),
                    SizedBox(width: 4),
                    Text('Activo: ${usuario.isActive ? 'Sí' : 'No'}', style: TextStyle(fontFamily: 'Montserrat', color: usuario.isActive ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Icon(usuario.isStaff ? Icons.verified : Icons.person, color: usuario.isStaff ? Colors.indigo : Colors.grey, size: 18),
                    SizedBox(width: 4),
                    Text('Staff: ${usuario.isStaff ? 'Sí' : 'No'}', style: TextStyle(fontFamily: 'Montserrat', color: usuario.isStaff ? Colors.indigo : Colors.grey, fontWeight: FontWeight.bold)),
                  ],
                ),
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
