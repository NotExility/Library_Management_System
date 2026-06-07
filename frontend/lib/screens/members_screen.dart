import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/member_service.dart';
import '../widgets/add_member_dialog.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final MemberService memberService = MemberService();

  Future<void> deleteMember(int id) async {
    await http.delete(
      Uri.parse(
        'http://127.0.0.1:3000/members/$id',
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: memberService.getMembers(),
      builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
            ),
          );
        }

        final members = snapshot.data ?? [];

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [

                  const Text(
                    "Member Management",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: () async {

                      await showDialog(
                        context: context,
                        builder: (_) =>
                            const AddMemberDialog(),
                      );

                      setState(() {});
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      "Add Member",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(

                    columns: const [

                      DataColumn(
                        label: Text("ID"),
                      ),

                      DataColumn(
                        label: Text("Name"),
                      ),

                      DataColumn(
                        label: Text("Email"),
                      ),

                      DataColumn(
                        label: Text("Phone"),
                      ),

                      DataColumn(
                        label: Text("Action"),
                      ),
                    ],

                    rows: members.map<DataRow>(
                      (member) {

                        return DataRow(
                          cells: [

                            DataCell(
                              Text(
                                member['id']
                                    .toString(),
                              ),
                            ),

                            DataCell(
                              Text(
                                member['name'] ?? '',
                              ),
                            ),

                            DataCell(
                              Text(
                                member['email'] ?? '',
                              ),
                            ),

                            DataCell(
                              Text(
                                member['phone'] ?? '',
                              ),
                            ),

                            DataCell(
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                ),

                                onPressed: () {

                                  deleteMember(
                                    member['id'],
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