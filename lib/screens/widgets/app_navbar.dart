import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Global app navigation bar, migrated from `ProgramFit_Web`'s `Navbar.tsx`.
///
/// Renders a responsive layout: inline links on wide screens, a hamburger
/// dropdown on narrow screens.
class AppNavbar extends StatelessWidget {
  const AppNavbar({
    super.key,
    required this.currentPath,
    required this.isOpen,
    required this.onToggleMenu,
    required this.onNavigate,
  });

  final String currentPath;
  final bool isOpen;
  final VoidCallback onToggleMenu;
  final ValueChanged<String> onNavigate;

  static const double height = 80;

  bool _isActive(String path) {
    if (path == '/') return currentPath == '/';
    return currentPath == path;
  }

  Widget _brand() {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Program',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          TextSpan(
            text: 'Fit',
            style: TextStyle(
              color: AppColors.brandPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ],
      ),
      style: const TextStyle(letterSpacing: -0.5),
    );
  }

  Widget _desktopLink(String label, String path) {
    final active = _isActive(path);
    return InkWell(
      onTap: () => onNavigate(path),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.brandPrimary : AppColors.bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.shadowHard, width: 2),
          boxShadow: active
              ? neoShadow(x: 2, y: 2)
              : const [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 768;

    return Material(
      color: AppColors.bgCard,
      child: Container(
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(color: AppColors.borderUi, width: 2),
          ),
          boxShadow: neoShadow(x: 0, y: 4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: height,
        child: Row(
          children: [
            _brand(),
            if (isDesktop) ...[
              const Spacer(),
              Row(
                children: [
                  _desktopLink('Home', '/'),
                  const SizedBox(width: 12),
                  _desktopLink('Results', '/results'),
                ],
              ),
            ] else ...[
              const Spacer(),
              InkWell(
                onTap: onToggleMenu,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.shadowHard, width: 2),
                    boxShadow: neoShadow(x: 2, y: 2),
                  ),
                  child: Icon(
                    isOpen ? Icons.close : Icons.menu,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
