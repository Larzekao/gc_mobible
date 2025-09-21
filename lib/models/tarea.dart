import 'personal.dart';

const List<String> ESTADO_CHOICES = [
  'PENDIENTE',
  'PROGRESO',
  'COMPLETADO',
];

class Tarea {
  final int? id;
  String nombre;
  String? descripcion;
  DateTime? fechaAsignacion;
  DateTime? fechaVencimiento;
  Personal personal;
  String estado;
  DateTime? creado;
  DateTime? actualizado;

  Tarea({
    this.id,
    required this.nombre,
    this.descripcion,
    this.fechaAsignacion,
    this.fechaVencimiento,
    required this.personal,
    this.estado = 'PENDIENTE',
    this.creado,
    this.actualizado,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'],
      fechaAsignacion: json['fecha_asignacion'] != null ? DateTime.parse(json['fecha_asignacion']) : null,
      fechaVencimiento: json['fecha_vencimiento'] != null ? DateTime.parse(json['fecha_vencimiento']) : null,
      personal: Personal.fromJson(json['personal']),
      estado: json['estado'] ?? 'PENDIENTE',
      creado: json['creado'] != null ? DateTime.parse(json['creado']) : null,
      actualizado: json['actualizado'] != null ? DateTime.parse(json['actualizado']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'fecha_asignacion': fechaAsignacion?.toIso8601String(),
      'fecha_vencimiento': fechaVencimiento?.toIso8601String(),
      'personal': personal.toJson(),
      'estado': estado,
      'creado': creado?.toIso8601String(),
      'actualizado': actualizado?.toIso8601String(),
    };
  }
}