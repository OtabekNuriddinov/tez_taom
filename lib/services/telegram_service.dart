import 'package:http/http.dart' as http;

class TelegramService {
  final String _botToken = '7572360187:AAG1CQ5P5ukQ0s1Xwz5H8uiv4Ijz0JBoY0A';
  final String _chatId = '6409605997';

  Future<http.Response> sendMessage(String message) async {
    final Uri url = Uri.parse('https://api.telegram.org/bot$_botToken/sendMessage');
    final response = await http.post(
      url,
      body: {
        'chat_id': _chatId,
        'text': message,
        'parse_mode': 'Markdown',
      },
    );
    return response;
  }
} 