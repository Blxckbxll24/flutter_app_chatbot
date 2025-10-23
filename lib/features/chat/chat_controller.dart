import 'package:flutter/foundation.dart';
import '../../core/models.dart';
import '../../core/services/history_service.dart';
import '../../core/services/streaming_service.dart';
import 'chat_repository.dart';

class ChatController extends ChangeNotifier {
  final ChatRepository repository;
  List<Message> messages = [];
  bool loading = false;
  String? error;
  bool _streamingEnabled = true;
  String _currentStreamingText = '';
  bool _isStreaming = false;

  ChatController(this.repository) {
    _loadHistory();
  }

  // Getters
  bool get streamingEnabled => _streamingEnabled;
  String get currentStreamingText => _currentStreamingText;
  bool get isStreaming => _isStreaming;

  // Cargar historial al inicializar
  Future<void> _loadHistory() async {
    try {
      messages = await HistoryService.loadHistory();
      notifyListeners();
    } catch (e) {
      print('Error cargando historial: $e');
    }
  }

  // Guardar historial automáticamente
  Future<void> _saveHistory() async {
    try {
      await HistoryService.saveHistory(messages);
    } catch (e) {
      print('Error guardando historial: $e');
    }
  }

  // Método para limpiar errores
  void clearError() {
    error = null;
    notifyListeners();
  }

  // Método para obtener si hay errores
  bool get hasError => error != null;

  // Método para limpiar todo el chat
  Future<void> clearMessages() async {
    messages.clear();
    error = null;
    await HistoryService.clearHistory();
    notifyListeners();
  }

  Future<void> send(String text) async {
    if (text.trim().isEmpty) return;

    // Limpiar error anterior
    error = null;

    messages.add(Message(role: 'user', content: text));
    loading = true;
    notifyListeners();

    try {
      if (_streamingEnabled) {
        await _sendWithStreaming(text);
      } else {
        await _sendNormal(text);
      }

      // Guardar historial después de cada intercambio
      await _saveHistory();
    } catch (e) {
      error = "Error de conexión con el servidor: ${e.toString()}";
      print('Error en chat: $e'); // Para debugging
      // Agregar mensaje de error como respuesta del asistente
      messages.add(
        Message(
          role: 'assistant',
          content: 'Lo siento, hubo un error al procesar tu mensaje.',
        ),
      );
      await _saveHistory(); // Guardar incluso con errores
    } finally {
      loading = false;
      _isStreaming = false;
      _currentStreamingText = '';
      notifyListeners();
    }
  }

  Future<void> _sendNormal(String text) async {
    final answer = await repository.ask(text, messages);

    if (answer.isNotEmpty) {
      messages.add(Message(role: 'assistant', content: answer));
    } else {
      messages.add(
        Message(
          role: 'assistant',
          content: 'Lo siento, no pude generar una respuesta.',
        ),
      );
    }
  }

  Future<void> _sendWithStreaming(String text) async {
    // Obtener respuesta completa primero
    final fullAnswer = await repository.ask(text, messages);

    if (fullAnswer.isEmpty) {
      messages.add(
        Message(
          role: 'assistant',
          content: 'Lo siento, no pude generar una respuesta.',
        ),
      );
      return;
    }

    // Crear mensaje placeholder
    final messageIndex = messages.length;
    messages.add(Message(role: 'assistant', content: ''));

    _isStreaming = true;
    notifyListeners();

    // Simular streaming
    await for (final streamResponse
        in StreamingService.processStreamingResponse(fullAnswer)) {
      _currentStreamingText = streamResponse.content;

      if (streamResponse.isComplete) {
        // Actualizar mensaje final
        messages[messageIndex] = Message(
          role: 'assistant',
          content: streamResponse.content,
        );
        _isStreaming = false;
        _currentStreamingText = '';
      }

      notifyListeners();

      // Pequeña pausa para efecto visual
      if (!streamResponse.isComplete) {
        await Future.delayed(const Duration(milliseconds: 30));
      }
    }
  }

  // Método para alternar streaming
  void toggleStreaming() {
    _streamingEnabled = !_streamingEnabled;
    notifyListeners();
  }

  // Método para probar la conexión
  Future<void> testConnection() async {
    error = null;
    loading = true;
    notifyListeners();

    try {
      final answer = await repository.ask("test", []);
      messages.add(
        Message(role: 'system', content: 'Conexión exitosa: $answer'),
      );
      await _saveHistory(); // Guardar después de prueba de conexión
    } catch (e) {
      error = "Error de conexión: $e";
      messages.add(Message(role: 'system', content: 'Error de conexión: $e'));
      await _saveHistory(); // Guardar incluso con errores
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Método para exportar historial
  List<Map<String, dynamic>> exportHistory() {
    return messages.map((message) => message.toJson()).toList();
  }

  // Método para importar historial
  Future<void> importHistory(List<Map<String, dynamic>> historyData) async {
    try {
      messages = historyData.map((json) => Message.fromJson(json)).toList();
      await _saveHistory();
      notifyListeners();
    } catch (e) {
      error = "Error importando historial: $e";
      notifyListeners();
    }
  }

  // Método para obtener estadísticas del chat
  Map<String, dynamic> getChatStats() {
    final userMessages = messages.where((m) => m.role == 'user').length;
    final botMessages = messages.where((m) => m.role == 'assistant').length;
    final systemMessages = messages.where((m) => m.role == 'system').length;

    return {
      'totalMessages': messages.length,
      'userMessages': userMessages,
      'botMessages': botMessages,
      'systemMessages': systemMessages,
      'averageMessageLength': messages.isEmpty
          ? 0
          : messages.map((m) => m.content.length).reduce((a, b) => a + b) /
                messages.length,
    };
  }
}
