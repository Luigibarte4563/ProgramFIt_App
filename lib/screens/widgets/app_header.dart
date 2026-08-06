import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// App brand header shown at the top of every screen.
///
/// The shell wraps this in a `SafeArea`, so it always starts below the system
/// status bar / display cutout.
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  static const double height = 72;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgCard,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(color: AppColors.borderUi, width: 2),
          ),
          boxShadow: neoShadow(x: 0, y: 4),
        ),
        child: Text.rich(
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
        ),
      ),
    );
  }
}
