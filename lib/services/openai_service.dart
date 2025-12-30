import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  // IMPORTANT: Replace this with your actual API key
  final String apiKey = "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";

  Future<String> sendMessage(String message) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({
        "model": "gpt-4o-mini",   // Works and is cheap
        "messages": [
          {"role": "user", "content": message}
        ],
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
