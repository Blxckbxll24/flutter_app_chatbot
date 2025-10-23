import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models.dart';

class HistoryService {
  static const String _historyKey = 'chat_history';
  static const String _maxHistoryKey = 'max_history_messages';
  static const int _defaultMaxMessages = 100;

  // Guardar historial
  static Future<void> saveHistory(List<Message> messages) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final maxMessages = prefs.getInt(_maxHistoryKey) ?? _defaultMaxMessages;

      // Limitar el número de mensajes guardados
      final messagesToSave = messages.length > maxMessages
          ? messages.sublist(messages.length - maxMessages)
          : messages;

      final historyJson = messagesToSave.map((m) => m.toJson()).toList();
      final historyString = json.encode(historyJson);

      await prefs.setString(_historyKey, historyString);
    } catch (e) {
      print('Error guardando historial: $e');
    }
  }

  // Cargar historial
  static Future<List<Message>> loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyString = prefs.getString(_historyKey);

      if (historyString == null) return [];

      final historyJson = json.decode(historyString) as List;
      return historyJson.map((json) => Message.fromJson(json)).toList();
    } catch (e) {
      print('Error cargando historial: $e');
      return [];
    }
  }

  // Limpiar historial
  static Future<void> clearHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_historyKey);
    } catch (e) {
      print('Error limpiando historial: $e');
    }
  }

  // Configurar límite de mensajes
  static Future<void> setMaxMessages(int maxMessages) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_maxHistoryKey, maxMessages);
    } catch (e) {
      print('Error configurando límite de mensajes: $e');
    }
  }

  // Obtener límite de mensajes
  static Future<int> getMaxMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_maxHistoryKey) ?? _defaultMaxMessages;
    } catch (e) {
      print('Error obteniendo límite de mensajes: $e');
      return _defaultMaxMessages;
    }
  }
}
