import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final Function(int) onSelected;
  final int selectedIndex;

  const Sidebar({
    super.key,
    required this.onSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard),
          label: Text("Dashboard"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.book),
          label: Text("Books"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.people),
          label: Text("Members"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.assignment),
          label: Text("Borrowings"),
        ),
      ],
    );
  }
}