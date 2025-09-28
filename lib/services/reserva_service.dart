import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reserva.dart';
import '../utils/config.dart';

class ReservaService {
  final String baseUrl = Config.baseUrl + '/api/reservas/';//cmabiar la ruta o subir 

  Future<List<Reserva>> fetchReservas() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: token != null ? {'Authorization': 'Bearer $token'} : {},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Reserva.fromJson(e)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('No autorizado. Inicia sesión nuevamente.');
    } else {
      throw Exception('Error al cargar reservas');
    }
  }

  Future<Reserva> createReserva(Reserva reserva) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: json.encode(reserva.toJson()),
    );
    if (response.statusCode == 201) {
      return Reserva.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('No autorizado. Inicia sesión nuevamente.');
    } else {
      throw Exception('Error al crear reserva');
    }
  }

  Future<Reserva> updateReserva(int id, Reserva reserva) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await http.put(
      Uri.parse('$baseUrl$id/'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: json.encode(reserva.toJson()),
    );
    if (response.statusCode == 200) {
      return Reserva.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('No autorizado. Inicia sesión nuevamente.');
    } else {
      throw Exception('Error al actualizar reserva');
    }
  }

  Future<void> deleteReserva(int id) async {
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
      throw Exception('Error al eliminar reserva');
    }
  }
}
