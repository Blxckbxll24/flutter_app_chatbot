import 'package:flutter/foundation.dart';

class AppConfig {
  static String get baseUrl {
    if (kIsWeb) {
      // Para web, usar localhost
      return 'http://localhost:8000/';
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      // Para Android, usar la IP de la computadora (funciona tanto para emulador como dispositivo físico)
      return 'http://192.168.1.239:8000/';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // Para iOS simulator, usar localhost
      return 'http://localhost:8000/';
    } else {
      // Para desktop (macOS, Windows, Linux)
      return 'http://localhost:8000/';
    }
  }

  // IP alternativa para dispositivo físico Android
  static const String androidPhysicalDeviceUrl = 'http://192.168.1.239:8000/';

  // Método para alternar entre emulador y dispositivo físico
  static String getAndroidUrl({bool isPhysicalDevice = false}) {
    return isPhysicalDevice
        ? androidPhysicalDeviceUrl
        : 'http://10.0.2.2:8000/';
  }

  // Método para obtener la primera URL que funcione (para desarrollo futuro)
  static Future<String> getBestAndroidUrl() async {
    // Lista de URLs para probar en orden de prioridad
    const androidUrls = [
      'http://192.168.1.239:8000/', // IP de la computadora (WiFi)
      'http://10.0.2.2:8000/', // IP del emulador Android
      'http://localhost:8000/', // Fallback
    ];

    // Por ahora retornamos la IP que sabemos que funciona
    return androidUrls.first;
  }
}
