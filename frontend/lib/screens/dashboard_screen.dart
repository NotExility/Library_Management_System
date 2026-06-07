import 'package:flutter/material.dart';
import '../services/dashboard_service.dart';
import '../widgets/sidebar.dart';
import 'books_screen.dart';
import 'members_screen.dart';
import '../widgets/stat_card.dart';
import 'borrowings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  int selectedIndex = 0;

  Widget getPage() {
    switch (selectedIndex) {
      case 1:
        return const BooksScreen();

      case 2:
        return const MembersScreen();

      case 3:
        return const BorrowingsScreen();

      default:
        return const DashboardContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: selectedIndex,
            onSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: getPage(),
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() =>
      _DashboardContentState();
}

class _DashboardContentState
    extends State<DashboardContent> {

  final DashboardService service =
      DashboardService();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<
        Map<String, dynamic>>(
      future: service.getStats(),

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

        final stats =
            snapshot.data ?? {};

        return Padding(
          padding:
              const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                "Library Dashboard",
                style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                    fontWeight:
                      FontWeight.bold,
                  ),
                ),

              const SizedBox(
                height: 30,
              ),

              Wrap(
                spacing: 20,
                runSpacing: 20,

                children: [

                  StatCard(
                    title: "Books",
                    value: stats[
                                'books']
                            ?.toString() ??
                        '0',
                    icon: Icons.book,
                  ),

                  StatCard(
                    title: "Members",
                    value: stats[
                                'members']
                            ?.toString() ??
                        '0',
                    icon: Icons.people,
                  ),

                  StatCard(
                    title:
                        "Borrowings",
                    value: stats[
                                'borrowings']
                            ?.toString() ??
                        '0',
                    icon: Icons.assignment,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}