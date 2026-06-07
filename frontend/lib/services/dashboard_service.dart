import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardService {

  Future<Map<String, dynamic>>
      getStats() async {

    final response =
        await http.get(
      Uri.parse(
        'http://127.0.0.1:3000/dashboard/stats',
      ),
    );

    return jsonDecode(
      response.body,
    );
  }
}