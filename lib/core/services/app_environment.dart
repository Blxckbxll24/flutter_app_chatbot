import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static bool _isInitialized = false;

  // Inicializar configuración según el entorno
  static Future<void> initialize({bool isProduction = false}) async {
    if (_isInitialized) return;

    try {
      final envFile = isProduction ? '.env.prod' : '.env.dev';
      await dotenv.load(fileName: envFile);
      _isInitialized = true;

      if (debugMode) {
        print('🌍 Entorno cargado: $environment');
        print('🔗 API URL: $apiBaseUrl');
      }
    } catch (e) {
      print('⚠️ Error cargando configuración: $e');
      // Usar valores por defecto
      _isInitialized = true;
    }
  }

  // Getters para configuración
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? _getDefaultApiUrl();

  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

  static bool get debugMode =>
      dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true' || kDebugMode;

  static int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '') ?? 30000;

  static int get maxHistoryMessages =>
      int.tryParse(dotenv.env['MAX_HISTORY_MESSAGES'] ?? '') ?? 100;

  static bool get enableLogging =>
      dotenv.env['ENABLE_LOGGING']?.toLowerCase() == 'true';

  // Helpers
  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';

  static String _getDefaultApiUrl() {
    if (kIsWeb) {
      return 'http://localhost:8000/';
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://192.168.1.239:8000/';
    } else {
      return 'http://localhost:8000/';
    }
  }

  // Método para cambiar entorno en runtime (solo desarrollo)
  static Future<void> switchEnvironment(bool useProduction) async {
    if (kReleaseMode) return; // No permitir en producción

    _isInitialized = false;
    await initialize(isProduction: useProduction);
  }
}
