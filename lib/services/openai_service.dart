import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lingua_chat/config/api_keys.dart';

class OpenAIService {
  final String apiKey = openAiApiKey;

  Future<String> sendMessage(String message, {List<Map<String, String>>? conversationHistory}) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    final messages = conversationHistory ?? [
      {"role": "user", "content": message}
    ];

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({
        "model": "gpt-4.1-mini", 
        "messages": messages,
      }),
    );

    if (response.statusCode != 200) {
      return "There was an error, please try again later.";
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    try {
      return data["choices"][0]["message"]["content"];
    } catch (e) {
      return "Invalid response format: ${response.body}";
    }
  }
}
