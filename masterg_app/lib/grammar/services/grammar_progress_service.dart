import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';

typedef AuthenticatedRequest =
    Future<http.Response> Function(
      Future<http.Response> Function(String token) sendRequest,
    );

class GrammarProgressService {
  static const String _baseUrl = '${ApiConfig.apiBaseUrl}/grammar';

  Future<Map<String, dynamic>> getGrammarProgress(
    AuthenticatedRequest authenticatedRequest,
  ) async {
    final response = await authenticatedRequest(
      (token) => http
          .get(
            Uri.parse('$_baseUrl/progress/'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 8)),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('Unable to fetch grammar progress');
  }

  Future<Map<String, dynamic>> completeGrammarTopic(
    AuthenticatedRequest authenticatedRequest,
    String topicId,
    int correctAnswers,
  ) async {
    final response = await authenticatedRequest(
      (token) => http
          .post(
            Uri.parse('$_baseUrl/complete/'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              'topic_id': topicId,
              'correct_answers': correctAnswers,
            }),
          )
          .timeout(const Duration(seconds: 8)),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    final data = jsonDecode(response.body);
    throw Exception(data['message'] ?? 'Unable to save grammar progress');
  }
}
