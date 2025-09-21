import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class ServicesUsuario {
	final String baseUrl;

	ServicesUsuario({required this.baseUrl});

	Future<List<Usuario>> fetchUsuarios() async {
		final url = Uri.parse('$baseUrl/usuarios/');
		final response = await http.get(url);

		if (response.statusCode == 200) {
			final List<dynamic> data = jsonDecode(response.body);
			return data.map((json) => Usuario.fromJson(json)).toList();
		} else {
			throw Exception('Error al obtener los usuarios');
		}
	}

		Future<Usuario> createUsuario({
			required String correo,
			String? nombre,
			String? apellido,
			String? telefono,
			int? rolId,
			String? password,
		}) async {
			final url = Uri.parse('$baseUrl/usuarios/');
			final response = await http.post(
				url,
				headers: {'Content-Type': 'application/json'},
				body: jsonEncode({
					'correo': correo,
					'nombre': nombre,
					'apellido': apellido,
					'telefono': telefono,
					'rol': rolId,
					'password': password,
				}),
			);
			if (response.statusCode == 201) {
				return Usuario.fromJson(jsonDecode(response.body));
			} else {
				throw Exception('Error al crear el usuario');
			}
		}

		Future<Usuario> editUsuario({
			required int id,
			String? correo,
			String? nombre,
			String? apellido,
			String? telefono,
			int? rolId,
			String? password,
		}) async {
			final url = Uri.parse('$baseUrl/usuarios/$id/');
			final response = await http.put(
				url,
				headers: {'Content-Type': 'application/json'},
				body: jsonEncode({
					'correo': correo,
					'nombre': nombre,
					'apellido': apellido,
					'telefono': telefono,
					'rol': rolId,
					'password': password,
				}),
			);
			if (response.statusCode == 200) {
				return Usuario.fromJson(jsonDecode(response.body));
			} else {
				throw Exception('Error al editar el usuario');
			}
		}

		Future<void> deleteUsuario(int id) async {
			final url = Uri.parse('$baseUrl/usuarios/$id/');
			final response = await http.patch(
				url,
				headers: {'Content-Type': 'application/json'},
				body: jsonEncode({'is_active': false}), // Estado lógico
			);
			if (response.statusCode != 200) {
				throw Exception('Error al eliminar el usuario');
			}
		}
}
