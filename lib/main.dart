import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/api_client.dart';
import 'core/theme.dart';
import 'core/services/app_environment.dart';
import 'core/services/theme_service.dart';
import 'features/chat/chat_repository.dart';
import 'features/chat/chat_controller.dart';
import 'features/chat/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar configuración de entorno
  await AppEnvironment.initialize(
    isProduction: false,
  ); // Cambiar a true para producción

  // Inicializar servicio de temas
  await ThemeService.instance.initialize();

  final client = ApiClient(AppEnvironment.apiBaseUrl);
  final repository = ChatRepository(client);

  if (AppEnvironment.debugMode) {
    print('🚀 Aplicación iniciada');
    print('🌍 Entorno: ${AppEnvironment.environment}');
    print('🔗 API URL: ${AppEnvironment.apiBaseUrl}');
    print('🎨 Tema inicial: ${ThemeService.instance.themeMode}');
  }

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final ChatRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatController(repository)),
        ChangeNotifierProvider.value(value: ThemeService.instance),
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ChatBot RAG',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeService.themeMode,
            home: const ChatScreen(),
          );
        },
      ),
    );
  }
}
