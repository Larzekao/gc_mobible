import 'package:flutter/foundation.dart';

/// Centralizes API configuration used across the app.
class AppConfig {
  AppConfig._();

  /// Returns the base URL for the backend API depending on the platform.
  ///
  /// - Android emulator uses 10.0.2.2 to reach localhost on the host machine.
  /// - iOS simulator and Flutter web can access localhost directly.
  /// Update this value if you deploy the backend elsewhere.
  static String get apiBaseUrl {
    if (kIsWeb) {
      return 'http://localhost:8000';
    }

    return 'http://10.0.2.2:8000';
  }

  /// Endpoint used to obtain JWT tokens.
  static String get tokenEndpoint => apiBaseUrl + '/api/auth/token/';
}
