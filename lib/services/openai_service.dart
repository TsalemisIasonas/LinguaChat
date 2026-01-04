import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey = "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";

  Future<String> sendMessage(String message, {List<Map<String, String>>? conversationHistory}) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    // Build messages array - use conversation history if provided, otherwise single message
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
        "model": "gpt-4o-mini", 
        "messages": messages,
      }),
    );

    // Handle network failure:
    if (response.statusCode != 200) {
      return "Error ${response.statusCode}: ${response.body}";
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    // Handle OpenAI JSON format:
    try {
      return data["choices"][0]["message"]["content"];
    } catch (e) {
      return "Invalid response format: ${response.body}";
    }
  }
}
