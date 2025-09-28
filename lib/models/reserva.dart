class Reserva {
  final int? id;
  final int residenteId; // Solo ID, no objeto
  final int areaId; // Solo ID, no objeto  
  final String nombre;
  final String? descripcion;
  
  // Campos adicionales que podrías agregar en Django
  final DateTime? fechaReserva;
  final String? horaInicio;
  final String? horaFin;
  final String? estado; // 'activa', 'cancelada', 'completada'
  final DateTime? fechaCreacion;

  Reserva({
    this.id,
    required this.residenteId,
    required this.areaId,
    required this.nombre,
    this.descripcion,
    this.fechaReserva,
    this.horaInicio,
    this.horaFin,
    this.estado,
    this.fechaCreacion,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      id: json['id'],
      residenteId: json['residente'], // Solo el ID
      areaId: json['area'], // Solo el ID
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'],
      fechaReserva: json['fecha_reserva'] != null 
        ? DateTime.parse(json['fecha_reserva']) 
        : null,
      horaInicio: json['hora_inicio'],
      horaFin: json['hora_fin'],
      estado: json['estado'] ?? 'activa',
      fechaCreacion: json['fecha_creacion'] != null 
        ? DateTime.parse(json['fecha_creacion']) 
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'residente': residenteId,
      'area': areaId,
      'nombre': nombre,
      'descripcion': descripcion,
      'fecha_reserva': fechaReserva?.toIso8601String().split('T')[0],
      'hora_inicio': horaInicio,
      'hora_fin': horaFin,
      'estado': estado,
    };
  }

  Reserva copyWith({
    int? id,
    int? residenteId,
    int? areaId,
    String? nombre,
    String? descripcion,
    DateTime? fechaReserva,
    String? horaInicio,
    String? horaFin,
    String? estado,
    DateTime? fechaCreacion,
  }) {
    return Reserva(
      id: id ?? this.id,
      residenteId: residenteId ?? this.residenteId,
      areaId: areaId ?? this.areaId,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      fechaReserva: fechaReserva ?? this.fechaReserva,
      horaInicio: horaInicio ?? this.horaInicio,
      horaFin: horaFin ?? this.horaFin,
      estado: estado ?? this.estado,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }

  // Propiedades de conveniencia
  String get estadoTexto {
    switch (estado) {
      case 'activa': return 'Activa';
      case 'cancelada': return 'Cancelada';
      case 'completada': return 'Completada';
      default: return estado ?? 'Sin estado';
    }
  }

  String get horarioTexto {
    if (horaInicio != null && horaFin != null) {
      return '$horaInicio - $horaFin';
    }
    return 'Sin horario definido';
  }

  bool get puedeSerCancelada => estado == 'activa' && 
    fechaReserva != null && 
    fechaReserva!.isAfter(DateTime.now());

  @override
  String toString() => 'Reserva: $nombre';
}