import 'dart:convert';
import 'package:http/http.dart' as http;

class MemberService {
  final String baseUrl =
      'http://127.0.0.1:3000/members';

  Future<List<dynamic>> getMembers() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Failed to load members');
  }
}