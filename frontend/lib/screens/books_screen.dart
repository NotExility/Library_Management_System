import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/book_service.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final BookService bookService = BookService();

  Future<void> deleteBook(int id) async {
    await http.delete(
      Uri.parse(
        'http://127.0.0.1:3000/books/$id',
      ),
    );

    setState(() {});
  }

  Future<void> addBook() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Book'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Book Title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await http.post(
                  Uri.parse(
                    'http://127.0.0.1:3000/books',
                  ),
                  headers: {
                    'Content-Type':
                        'application/json',
                  },
                  body: jsonEncode({
                    'title':
                        controller.text,
                    'author': '',
                    'publisher': '',
                    'isbn': '',
                    'stock': 1,
                  }),
                );

                if (mounted) {
                  Navigator.pop(context);
                }

                setState(() {});
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: bookService.getBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child:
                CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }

        final books =
            snapshot.data ?? [];

        return Padding(
          padding:
              const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  const Text(
                    'Book Management',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: addBook,
                    icon: const Icon(
                      Icons.add,
                    ),
                    label: const Text(
                      'Add Book',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child:
                    SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text(
                          'ID',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Title',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Action',
                        ),
                      ),
                    ],
                    rows: books
                        .map<DataRow>(
                      (book) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                book['id']
                                    .toString(),
                              ),
                            ),
                            DataCell(
                              Text(
                                book['title'] ??
                                    '',
                              ),
                            ),
                            DataCell(
                              IconButton(
                                icon:
                                    const Icon(
                                  Icons.delete,
                                ),
                                onPressed: () {
                                  deleteBook(
                                    book['id'],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}