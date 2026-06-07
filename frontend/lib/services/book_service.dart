import 'dart:convert';
import 'package:http/http.dart' as http;

class BookService {
  static const String baseUrl =
      'http://localhost:3000/books';

  Future<List<dynamic>> getBooks() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );

    return jsonDecode(response.body);
  }
}