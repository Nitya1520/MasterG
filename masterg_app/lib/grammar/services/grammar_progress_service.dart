import 'dart:convert';
import 'package:http/http.dart' as http;

class GrammarProgressService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/grammar';

  Future<Map<String, dynamic>> getGrammarProgress(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/progress/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 8));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('Unable to fetch grammar progress');
  }

  Future<Map<String, dynamic>> completeGrammarTopic(String token, String topicId, int correctAnswers) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/complete/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'topic_id': topicId, 'correct_answers': correctAnswers}),
    ).timeout(const Duration(seconds: 8));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    final data = jsonDecode(response.body);
    throw Exception(data['message'] ?? 'Unable to save grammar progress');
  }
}
