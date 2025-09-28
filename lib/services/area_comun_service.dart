import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/area_comun.dart';
import '../utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AreaComunService {
  final String baseUrl = Config.baseUrl + '/api/areas-comunes/';

  Future<List<AreaComun>> fetchAreas() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: token != null
          ? {'Authorization': 'Bearer $token'}
          : {},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => AreaComun.fromJson(e)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('No autorizado. Inicia sesión nuevamente.');
    } else {
      throw Exception('Error al cargar áreas comunes');
    }
  }

  Future<AreaComun> createArea(AreaComun area) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: json.encode(area.toJson()),
    );
    if (response.statusCode == 201) {
      return AreaComun.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('No autorizado. Inicia sesión nuevamente.');
    } else {
      throw Exception('Error al crear área común');
    }
  }

  Future<AreaComun> updateArea(int id, AreaComun area) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await http.put(
      Uri.parse('$baseUrl$id/'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: json.encode(area.toJson()),
    );
    if (response.statusCode == 200) {
      return AreaComun.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('No autorizado. Inicia sesión nuevamente.');
    } else {
      throw Exception('Error al actualizar área común');
    }
  }

  Future<void> deleteArea(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await http.delete(
      Uri.parse('$baseUrl$id/'),
      headers: token != null ? {'Authorization': 'Bearer $token'} : {},
    );
    if (response.statusCode != 204) {
      if (response.statusCode == 401) {
        throw Exception('No autorizado. Inicia sesión nuevamente.');
      }
      throw Exception('Error al eliminar área común');
    }
  }
}
