import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({super.key});

  @override
  State<AddMemberDialog> createState() =>
      _AddMemberDialogState();
}

class _AddMemberDialogState
    extends State<AddMemberDialog> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  Future<void> saveMember() async {

    await http.post(
      Uri.parse(
        'http://127.0.0.1:3000/members',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
      }),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text("Add Member"),

      content: SingleChildScrollView(
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone",
              ),
            ),

            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Address",
              ),
            ),
          ],
        ),
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: saveMember,
          child: const Text("Save"),
        ),
      ],
    );
  }
}