import 'area_comun.dart';

class Regla {
  final int? id;
  String nombre;
  String? descripcion;
  List<AreaComun> areas;
  bool activo;
  DateTime? creado;
  DateTime? actualizado;

  Regla({
    this.id,
    required this.nombre,
    this.descripcion,
    this.areas = const [],
    this.activo = true,
    this.creado,
    this.actualizado,
  });

  factory Regla.fromJson(Map<String, dynamic> json) {
    return Regla(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      areas: json['areas'] != null
          ? List<AreaComun>.from(json['areas'].map((a) => AreaComun.fromJson(a)))
          : [],
      activo: json['activo'] ?? true,
      creado: json['creado'] != null ? DateTime.parse(json['creado']) : null,
      actualizado: json['actualizado'] != null ? DateTime.parse(json['actualizado']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'areas': areas.map((a) => a.toJson()).toList(),
      'activo': activo,
      'creado': creado?.toIso8601String(),
      'actualizado': actualizado?.toIso8601String(),
    };
  }
}
