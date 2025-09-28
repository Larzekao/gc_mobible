import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException: ' + message;
}

class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic> user;
}

class AuthService {
  AuthService({http.Client? httpClient})
    : _client = httpClient ?? http.Client();

  final http.Client _client;

  Future<AuthSession> login({
    required String username,
    required String password,
  }) async {
    final uri = Uri.parse(AppConfig.tokenEndpoint);

    http.Response response;
    try {
      response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username.trim(), 'password': password}),
      );
    } catch (_) {
      throw const AuthException(
        'No se pudo conectar con el servidor. Verifica tu conexion.',
      );
    }

    Map<String, dynamic> decoded;
    try {
      decoded = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw const AuthException('Respuesta invalida del servidor.');
    }

    if (response.statusCode != 200) {
      final errorDetail =
          decoded['detail'] ?? decoded['error'] ?? 'Credenciales invalidas.';
      throw AuthException(errorDetail.toString());
    }

    final accessToken = decoded['access'] as String? ?? '';
    final refreshToken = decoded['refresh'] as String? ?? '';
    final user = (decoded['user'] as Map<String, dynamic>?) ?? const {};

    if (accessToken.isEmpty || refreshToken.isEmpty) {
      throw const AuthException(
        'La respuesta del servidor no incluye los tokens requeridos.',
      );
    }

    final session = AuthSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', session.accessToken);
    await prefs.setString('refresh_token', session.refreshToken);
    await prefs.setString('user_profile', jsonEncode(session.user));

    return session;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('user_profile');
  }

  Future<AuthSession?> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final access = prefs.getString('access_token');
    final refresh = prefs.getString('refresh_token');
    final userRaw = prefs.getString('user_profile');

    if (access == null || refresh == null || userRaw == null) {
      return null;
    }

    try {
      final user = (jsonDecode(userRaw) as Map<String, dynamic>);
      return AuthSession(
        accessToken: access,
        refreshToken: refresh,
        user: user,
      );
    } catch (_) {
      await logout();
      return null;
    }
  }
}
