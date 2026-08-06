import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'screens/assessment_screen.dart';
import 'screens/home_screen.dart';
import 'screens/results_screen.dart';
import 'screens/widgets/app_shell.dart';

final GoRouter _router = _createRouter();

GoRouter _createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/assessment',
                builder: (_, _) => const AssessmentScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/results',
                builder: (_, _) => const ResultsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// Main app controller.
///
/// Offline MVP: no accounts, no authentication, no backend. The app launches
/// straight into the assessment UI and persists data locally.
class ProgramFitApp extends StatelessWidget {
  const ProgramFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ProgramFit',
      theme: buildAppTheme(),
      routerConfig: _router,
    );
  }
}
