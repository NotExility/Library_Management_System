import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddBorrowingDialog extends StatefulWidget {
  const AddBorrowingDialog({super.key});

  @override
  State<AddBorrowingDialog> createState() =>
      _AddBorrowingDialogState();
}

class _AddBorrowingDialogState
    extends State<AddBorrowingDialog> {

  final memberController =
      TextEditingController();

  final bookController =
      TextEditingController();

  Future<void> saveBorrowing() async {

    final response = await http.post(
      Uri.parse(
        'http://127.0.0.1:3000/borrowings',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'memberName': memberController.text,
        'bookTitle': bookController.text,
        'borrowDate':
            DateTime.now()
                .toString()
                .substring(0, 10),
        'status': 'Borrowed',
      }),
    );

    print(
      "STATUS CODE: ${response.statusCode}",
    );

    print(
      "BODY: ${response.body}",
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text(
        'Add Borrowing',
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          TextField(
            controller: memberController,
            decoration:
                const InputDecoration(
              labelText: 'Member Name',
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: bookController,
            decoration:
                const InputDecoration(
              labelText: 'Book Title',
            ),
          ),
        ],
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
          ),
        ),

        ElevatedButton(
          onPressed: saveBorrowing,
          child: const Text(
            'Save',
          ),
        ),
      ],
    );
  }
}