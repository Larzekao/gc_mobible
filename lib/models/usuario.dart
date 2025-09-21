import 'package:condominium_app/models/rol.dart';

class Usuario {
  final int? id;
  String correo;
  String? nombre;
  String? apellido;
  String? telefono;
  Rol? rol;
  bool isActive;
  bool isStaff;
  DateTime? dateJoined;
  DateTime? actualizado;

  Usuario({
    this.id,
    required this.correo,
    this.nombre,
    this.apellido,
    this.telefono,
    this.rol,
    required this.isActive,
    required this.isStaff,
    this.dateJoined,
    this.actualizado,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      correo: json['correo'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      rol: json['rol'] != null ? Rol.fromJson(json['rol']) : null,
      isActive: json['is_active'],
      isStaff: json['is_staff'],
      dateJoined: json['date_joined'] != null ? DateTime.parse(json['date_joined']) : null,
      actualizado: json['actualizado'] != null ? DateTime.parse(json['actualizado']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'correo': correo,
    'nombre': nombre,
    'apellido': apellido,
    'telefono': telefono,
    'rol': rol?.toJson(),
    'is_active': isActive,
    'is_staff': isStaff,
    'date_joined': dateJoined?.toIso8601String(),
    'actualizado': actualizado?.toIso8601String(),
  };
}