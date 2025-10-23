import 'dart:async';

class StreamingService {
  static const Duration _typingDelay = Duration(milliseconds: 50);

  // Simular streaming de tokens para una respuesta
  static Stream<String> simulateStreaming(String fullResponse) async* {
    final words = fullResponse.split(' ');
    String currentText = '';

    for (int i = 0; i < words.length; i++) {
      currentText += (i == 0 ? '' : ' ') + words[i];
      yield currentText;
      await Future.delayed(_typingDelay);
    }
  }

  // Procesar respuesta con streaming
  static Stream<StreamingResponse> processStreamingResponse(
    String response,
  ) async* {
    yield StreamingResponse(
      content: '',
      isComplete: false,
      timestamp: DateTime.now(),
    );

    await for (String chunk in simulateStreaming(response)) {
      yield StreamingResponse(
        content: chunk,
        isComplete: false,
        timestamp: DateTime.now(),
      );
    }

    // Respuesta completa
    yield StreamingResponse(
      content: response,
      isComplete: true,
      timestamp: DateTime.now(),
    );
  }
}

class StreamingResponse {
  final String content;
  final bool isComplete;
  final DateTime timestamp;

  StreamingResponse({
    required this.content,
    required this.isComplete,
    required this.timestamp,
  });
}
