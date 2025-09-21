class Rol {
  final int? id;
  final String nombre;


  Rol({
    this.id,
    required this.nombre,
  });

  factory Rol.fromJson(Map<String, dynamic> json) {
    return Rol(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
  };
}