import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import 'app_bottom_nav.dart';
import 'app_header.dart';

/// Wraps every main route with the persistent app header and the Material 3
/// bottom navigation bar.
///
/// Layout:
///   ┌─────────────────────────┐
///   │ (SafeArea top padding)  │  <- status bar / notch inset
///   │ AppHeader               │
///   │                         │
///   │ child (active page)     │  <- scrollable body
///   │                         │
///   │ AppBottomNav            │  <- always visible, fixed at the bottom
///   └─────────────────────────┘
///
/// The body is wrapped in a `SafeArea` so content never renders underneath
/// the system status bar or a display cutout. The bottom inset is handled by
/// the `NavigationBar` itself, so no content is hidden behind it.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  /// IndexedStack shell that keeps every destination's state alive.
  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      // Re-selecting the current destination resets it to its first page.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    return Scaffold(
      backgroundColor: AppColors.bgMain,
      body: SafeArea(
        // The bottom inset is consumed by the NavigationBar below.
        bottom: false,
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              // Smooth fade-in transition when switching destinations while
              // the IndexedStack preserves each page's state.
              child: TweenAnimationBuilder<double>(
                key: ValueKey<int>(currentIndex),
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: navigationShell,
                builder: (context, value, child) =>
                    Opacity(opacity: value, child: child),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
