import 'dart:convert';
import 'package:http/http.dart' as http;

class BorrowingService {

  final String baseUrl =
      'http://127.0.0.1:3000/borrowings';

  Future<List<dynamic>> getBorrowings()
  async {

    final response =
        await http.get(Uri.parse(baseUrl));

    return jsonDecode(response.body);
  }
}