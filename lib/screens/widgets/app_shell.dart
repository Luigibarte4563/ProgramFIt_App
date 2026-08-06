import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import 'app_navbar.dart';

/// Wraps every route with the global navbar and a mobile dropdown menu.
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _menuOpen = false;

  void _navigate(String path) {
    setState(() => _menuOpen = false);
    context.go(path);
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return Scaffold(
      backgroundColor: AppColors.bgMain,
      body: Stack(
        children: [
          Column(
            children: [
              AppNavbar(
                currentPath: currentPath,
                isOpen: _menuOpen,
                onToggleMenu: () => setState(() => _menuOpen = !_menuOpen),
                onNavigate: _navigate,
              ),
              Expanded(child: widget.child),
            ],
          ),
          if (_menuOpen) ...[
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => _menuOpen = false),
                child: const ColoredBox(color: Colors.black26),
              ),
            ),
            Positioned(
              top: AppNavbar.height,
              left: 0,
              right: 0,
              child: _MobileMenu(
                currentPath: currentPath,
                onNavigate: _navigate,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Dropdown menu shown on narrow screens, mirroring the web navbar's mobile
/// menu. Contains only the global navigation links.
class _MobileMenu extends StatelessWidget {
  const _MobileMenu({
    required this.currentPath,
    required this.onNavigate,
  });

  final String currentPath;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final items = <_NavItem>[
      _NavItem(label: 'Home', icon: Icons.home_outlined, path: '/'),
      _NavItem(label: 'Results', icon: Icons.assessment_outlined, path: '/results'),
    ];

    return Material(
      color: AppColors.bgCard,
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderUi, width: 2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final item in items)
              _MenuRow(
                item: item,
                active: currentPath == item.path,
                onTap: () => onNavigate(item.path),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.path,
  });

  final String label;
  final IconData icon;
  final String path;
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.item,
    required this.active,
    required this.onTap,
  });

  final _NavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        color: active ? AppColors.brandPrimary : AppColors.bgCard,
        child: Row(
          children: [
            Icon(
              item.icon,
              color: active ? Colors.white : AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              item.label,
              style: TextStyle(
                color: active ? Colors.white : AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
