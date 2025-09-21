class AreaComun {
  final int? id;
  String nombre;
  String? descripcion;
  bool activo;
  DateTime? creado;
  DateTime? actualizado;

  AreaComun({
    this.id,
    required this.nombre,
    this.descripcion,
    this.activo = true,
    this.creado,
    this.actualizado,
  });

  factory AreaComun.fromJson(Map<String, dynamic> json) {
    return AreaComun(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
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
      'activo': activo,
      'creado': creado?.toIso8601String(),
      'actualizado': actualizado?.toIso8601String(),
    };
  }
}
