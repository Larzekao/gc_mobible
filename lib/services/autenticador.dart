import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Autenticador {
  final String baseUrl;

  Autenticador({required this.baseUrl});
  Future<bool> login(String correo, String password) async {
    // Simulación local
    if (correo == 'ale@ejemplo.com' && password == '123') {
      await _saveToken('token_simulado');
      return true;
    }
    return false;
  }
  /*Future<bool> login(String correo, String password) async {
    final url = Uri.parse('$baseUrl/login/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'correo': correo, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await _saveToken(token);
      return true;
    }
    return false;
  }*/

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
