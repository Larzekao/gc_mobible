import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/rol.dart';

class ServicesRol {
  final String baseUrl;//url base de la API

  ServicesRol({required this.baseUrl});

  Future<List<Rol>> fetchRoles() async {
    final url = Uri.parse('$baseUrl/roles/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Rol.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los roles');
    }
  }

  Future<Rol> createRol(String nombre) async {
    final url = Uri.parse('$baseUrl/roles/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nombre': nombre}),
    );
    if (response.statusCode == 201) {
      return Rol.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear el rol');
    }
  }

  Future<Rol> editRol(int id, String nombre) async {
    final url = Uri.parse('$baseUrl/roles/$id/');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nombre': nombre}),
    );
    if (response.statusCode == 200) {
      return Rol.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al editar el rol');
    }
  }

  Future<void> deleteRol(int id) async {
    final url = Uri.parse('$baseUrl/roles/$id/');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'is_active': false}), // Estado lógico
    );
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el rol');
    }
  }
}