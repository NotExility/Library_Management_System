import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/borrowing_service.dart';
import '../widgets/add_borrowing_dialog.dart';

class BorrowingsScreen extends StatefulWidget {
  const BorrowingsScreen({
    super.key,
  });

  @override
  State<BorrowingsScreen> createState() =>
      _BorrowingsScreenState();
}

class _BorrowingsScreenState
    extends State<BorrowingsScreen> {

  final BorrowingService service =
      BorrowingService();

  Future<void> deleteBorrowing(
    int id,
  ) async {

    await http.delete(
      Uri.parse(
        'http://127.0.0.1:3000/borrowings/$id',
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<dynamic>>(
      future: service.getBorrowings(),

      builder: (
        context,
        snapshot,
      ) {

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

        final data =
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
                    "Borrowing Management",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: () async {

                      await showDialog(
                        context: context,
                        builder: (_) =>
                            const AddBorrowingDialog(),
                      );

                      setState(() {});
                    },

                    icon:
                        const Icon(Icons.add),

                    label: const Text(
                      "Add Borrowing",
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
                          "ID",
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          "Member",
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          "Book",
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          "Date",
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          "Status",
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          "Action",
                        ),
                      ),
                    ],

                    rows: data
                        .map<DataRow>(
                      (borrowing) {

                        return DataRow(
                          cells: [

                            DataCell(
                              Text(
                                borrowing['id']
                                    .toString(),
                              ),
                            ),

                            DataCell(
                              Text(
                                borrowing[
                                        'memberName'] ??
                                    '',
                              ),
                            ),

                            DataCell(
                              Text(
                                borrowing[
                                        'bookTitle'] ??
                                    '',
                              ),
                            ),

                            DataCell(
                              Text(
                                borrowing[
                                        'borrowDate'] ??
                                    '',
                              ),
                            ),

                            DataCell(
                              Text(
                                borrowing[
                                        'status'] ??
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

                                  deleteBorrowing(
                                    borrowing[
                                        'id'],
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