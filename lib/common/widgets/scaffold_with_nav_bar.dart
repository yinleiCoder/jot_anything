import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shell widget that renders a [Scaffold] with a [NavigationBar].
///
/// Uses [StatefulNavigationShell] to preserve tab state across switches
/// and to navigate between branches.
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // Navigate to the initial location when the active tab is re-tapped.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        height: 50,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.flutter_dash_outlined),
            selectedIcon: Icon(Icons.flutter_dash),
            label: 'Dash',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: '待办',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: '日程',
          ),
          NavigationDestination(
            icon: Icon(Icons.incomplete_circle),
            selectedIcon: Icon(Icons.circle),
            label: '专注',
          ),
        ],
      ),
    );
  }
}
