import 'package:flutter/material.dart';
import '../models/regla.dart';

class ReglaCard extends StatelessWidget {
  final Regla regla;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ReglaCard({
    Key? key,
    required this.regla,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: regla.activo ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    regla.nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontFamily: 'Montserrat', 
                      fontSize: 18, 
                      color: Color(0xFF283593)
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
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
              ],
            ),
            if (regla.descripcion != null && regla.descripcion!.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                regla.descripcion!,
                style: TextStyle(
                  fontFamily: 'Montserrat', 
                  fontSize: 14, 
                  color: Colors.grey[700]
                ),
              ),
            ],
            if (regla.areas.isNotEmpty) ...[
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: regla.areas.map((area) => Chip(
                  label: Text(
                    area.nombre,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  backgroundColor: Color(0xFF283593),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )).toList(),
              ),
            ],
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  regla.activo ? Icons.check_circle : Icons.cancel,
                  color: regla.activo ? Colors.green : Colors.red,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  regla.activo ? 'Activa' : 'Inactiva',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: regla.activo ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}