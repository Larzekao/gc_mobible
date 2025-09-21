class Residente {
  final int? id;
  String nombre;
  String apellidos;
  DateTime? fechaNacimiento;
  String? telefono;
  String? correo;
  String dni;
  String sexo;
  String tipo;
  String? residencia;
  bool activo;
  DateTime? fechaCreacion;
  DateTime? actualizado;

  Residente({
    this.id,
    required this.nombre,
    required this.apellidos,
    this.fechaNacimiento,
    this.telefono,
    this.correo,
    required this.dni,
    required this.sexo,
    required this.tipo,
    this.residencia,
    this.activo = true,
    this.fechaCreacion,
    this.actualizado,
  });

  factory Residente.fromJson(Map<String, dynamic> json) {
    return Residente(
      id: json['id'],
      nombre: json['nombre'],
      apellidos: json['apellidos'],
      fechaNacimiento: json['fecha_nacimiento'] != null ? DateTime.parse(json['fecha_nacimiento']) : null,
      telefono: json['telefono'],
      correo: json['correo'],
      dni: json['dni'],
      sexo: json['sexo'],
      tipo: json['tipo'],
      residencia: json['residencia'],
      activo: json['activo'] ?? true,
      fechaCreacion: json['fecha_creacion'] != null ? DateTime.parse(json['fecha_creacion']) : null,
      actualizado: json['actualizado'] != null ? DateTime.parse(json['actualizado']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'fecha_nacimiento': fechaNacimiento?.toIso8601String(),
      'telefono': telefono,
      'correo': correo,
      'dni': dni,
      'sexo': sexo,
      'tipo': tipo,
      'residencia': residencia,
      'activo': activo,
      'fecha_creacion': fechaCreacion?.toIso8601String(),
      'actualizado': actualizado?.toIso8601String(),
    };
  }
}
