import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/services/theme_service.dart';
import '../../core/services/app_environment.dart';
import 'chat_controller.dart';
import 'widgets/message_bubble.dart';
import 'widgets/input_bar.dart';
import 'widgets/typing_indicator.dart';
import 'widgets/streaming_indicator.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChatController>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD32F2F), Color(0xFF1565C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'ChatBot RAG',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1565C0),
        elevation: 4,
        shadowColor: const Color(0xFF1565C0).withOpacity(0.5),
        actions: [
          // Botón de cambio de tema
          Consumer<ThemeService>(
            builder: (context, themeService, child) {
              return IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    themeService.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => themeService.toggleTheme(),
                tooltip: 'Cambiar tema',
              );
            },
          ),
          // Botón de streaming
          Consumer<ChatController>(
            builder: (context, controller, child) {
              return IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    controller.streamingEnabled ? Icons.stream : Icons.notes,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => controller.toggleStreaming(),
                tooltip: controller.streamingEnabled
                    ? 'Desactivar streaming'
                    : 'Activar streaming',
              );
            },
          ),
          // Menú de opciones
          PopupMenuButton<String>(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.more_vert, color: Colors.white),
            ),
            onSelected: (value) => _handleMenuAction(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'test_connection',
                child: Row(
                  children: [
                    Icon(Icons.wifi_tethering),
                    SizedBox(width: 8),
                    Text('Probar conexión'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear_chat',
                child: Row(
                  children: [
                    Icon(Icons.clear_all),
                    SizedBox(width: 8),
                    Text('Limpiar chat'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'stats',
                child: Row(
                  children: [
                    Icon(Icons.analytics),
                    SizedBox(width: 8),
                    Text('Estadísticas'),
                  ],
                ),
              ),
              if (AppEnvironment.debugMode)
                const PopupMenuItem(
                  value: 'debug_info',
                  child: Row(
                    children: [
                      Icon(Icons.bug_report),
                      SizedBox(width: 8),
                      Text('Info de debug'),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient(
            Theme.of(context).brightness == Brightness.dark,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Mostrar error si existe
              if (controller.hasError)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFD32F2F).withOpacity(0.1),
                        const Color(0xFFD32F2F).withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFD32F2F).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: const Color(0xFFD32F2F)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          controller.error!,
                          style: TextStyle(
                            color: const Color(0xFFD32F2F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: const Color(0xFFD32F2F)),
                        onPressed: controller.clearError,
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
              // Lista de mensajes
              Expanded(
                child: controller.messages.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount:
                            controller.messages.length +
                            (controller.isStreaming ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < controller.messages.length) {
                            final msg = controller.messages[index];
                            return MessageBubble(
                              role: msg.role,
                              content: msg.content,
                            );
                          } else {
                            // Mostrar indicador de streaming
                            return StreamingIndicator(
                              currentText: controller.currentStreamingText,
                            );
                          }
                        },
                      ),
              ),
              // Indicador de escritura
              if (controller.loading && !controller.isStreaming)
                const TypingIndicator(),
              // Barra de entrada
              InputBar(onSend: controller.send),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    final controller = context.read<ChatController>();

    switch (action) {
      case 'test_connection':
        controller.testConnection();
        break;
      case 'clear_chat':
        _showClearChatDialog(context, controller);
        break;
      case 'stats':
        _showStatsDialog(context, controller);
        break;
      case 'debug_info':
        _showDebugInfo(context);
        break;
    }
  }

  void _showClearChatDialog(BuildContext context, ChatController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpiar Chat'),
        content: const Text(
          '¿Estás seguro de que quieres borrar todo el historial del chat?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              controller.clearMessages();
              Navigator.of(context).pop();
            },
            child: const Text('Limpiar'),
          ),
        ],
      ),
    );
  }

  void _showStatsDialog(BuildContext context, ChatController controller) {
    final stats = controller.getChatStats();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Estadísticas del Chat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatRow('Total de mensajes:', '${stats['totalMessages']}'),
            _StatRow('Mensajes del usuario:', '${stats['userMessages']}'),
            _StatRow('Mensajes del bot:', '${stats['botMessages']}'),
            _StatRow('Mensajes del sistema:', '${stats['systemMessages']}'),
            _StatRow(
              'Longitud promedio:',
              '${stats['averageMessageLength'].toStringAsFixed(1)} chars',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showDebugInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Información de Debug'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatRow('Entorno:', AppEnvironment.environment),
            _StatRow('API URL:', AppEnvironment.apiBaseUrl),
            _StatRow('Debug Mode:', '${AppEnvironment.debugMode}'),
            _StatRow('API Timeout:', '${AppEnvironment.apiTimeout}ms'),
            _StatRow('Max History:', '${AppEnvironment.maxHistoryMessages}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFD32F2F), Color(0xFF1565C0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(Icons.smart_toy, size: 64, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Text(
            '¡Hola! Soy tu ChatBot',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1565C0),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Escribe un mensaje para comenzar',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
