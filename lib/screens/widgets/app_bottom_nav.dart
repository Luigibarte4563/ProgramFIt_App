import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Persistent Material 3 bottom navigation bar.
///
/// Always visible across the app's main pages. The active destination is
/// highlighted with the M3 selection indicator and a colored icon/label.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  /// Index of the currently selected destination.
  final int currentIndex;

  /// Called when the user taps a destination (its index is provided).
  final ValueChanged<int> onDestinationSelected;

  static const List<NavigationDestination> destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.assignment_outlined),
      selectedIcon: Icon(Icons.assignment_rounded),
      label: 'Assessment',
    ),
    NavigationDestination(
      icon: Icon(Icons.assessment_outlined),
      selectedIcon: Icon(Icons.assessment_rounded),
      label: 'Results',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.borderUi, width: 2),
        ),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: destinations,
      ),
    );
  }
}
