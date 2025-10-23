import '../../core/api_client.dart';
import '../../core/models.dart';

class ChatRepository {
  final ApiClient client;
  ChatRepository(this.client);

  Future<String> ask(String message, List<Message> history) async {
    final historyJson = history.map((m) => m.toJson()).toList();
    return await client.sendMessage(message, historyJson);
  }
}
