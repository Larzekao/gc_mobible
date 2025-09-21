class Personal {
  final int? id;
  String nombre;
  String apellido;
  String dni;
  DateTime? fechaNacimiento;
  String? telefono;
  String? correo;
  String? direccion;
  DateTime? fechaContratacion;
  String? puesto;
  bool activo;
  DateTime? fechaSalida;
  String estado;
  DateTime? fechaCreacion;
  DateTime? actualizado;

  Personal({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.dni,
    this.fechaNacimiento,
    this.telefono,
    this.correo,
    this.direccion,
    this.fechaContratacion,
    this.puesto,
    this.activo = true,
    this.fechaSalida,
    required this.estado,
    this.fechaCreacion,
    this.actualizado,
  });

  factory Personal.fromJson(Map<String, dynamic> json) {
    return Personal(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      dni: json['dni'],
      fechaNacimiento: json['fecha_nacimiento'] != null ? DateTime.parse(json['fecha_nacimiento']) : null,
      telefono: json['telefono'],
      correo: json['correo'],
      direccion: json['direccion'],
      fechaContratacion: json['fecha_contratacion'] != null ? DateTime.parse(json['fecha_contratacion']) : null,
      puesto: json['puesto'],
      activo: json['activo'] ?? true,
      fechaSalida: json['fecha_salida'] != null ? DateTime.parse(json['fecha_salida']) : null,
      estado: json['estado'],
      fechaCreacion: json['fecha_creacion'] != null ? DateTime.parse(json['fecha_creacion']) : null,
      actualizado: json['actualizado'] != null ? DateTime.parse(json['actualizado']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'dni': dni,
      'fecha_nacimiento': fechaNacimiento?.toIso8601String(),
      'telefono': telefono,
      'correo': correo,
      'direccion': direccion,
      'fecha_contratacion': fechaContratacion?.toIso8601String(),
      'puesto': puesto,
      'activo': activo,
      'fecha_salida': fechaSalida?.toIso8601String(),
      'estado': estado,
      'fecha_creacion': fechaCreacion?.toIso8601String(),
      'actualizado': actualizado?.toIso8601String(),
    };
  }
}
