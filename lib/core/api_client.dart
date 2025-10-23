import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(String baseUrl)
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

  Future<String> sendMessage(String message, List history) async {
    try {
      final response = await dio.post(
        '/chat',
        data: {"message": message, "history": history},
      );

      // Verificar que la respuesta sea exitosa
      if (response.statusCode != 200) {
        throw Exception('Error del servidor: ${response.statusCode}');
      }

      // Verificar que la respuesta tenga la estructura esperada
      if (response.data == null || response.data['answer'] == null) {
        throw Exception('Respuesta del servidor inválida');
      }

      final answer = response.data['answer'] as String;
      if (answer.isEmpty) {
        throw Exception('El servidor devolvió una respuesta vacía');
      }

      return answer;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Tiempo de conexión agotado');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Tiempo de respuesta agotado');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No se pudo conectar al servidor');
      } else {
        throw Exception('Error de conexión: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}
