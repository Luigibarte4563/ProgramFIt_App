import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A compact neo-brutalist pill badge (rounded-full, bordered, hard shadow).
class NeoBadge extends StatelessWidget {
  const NeoBadge({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.bgMain,
    this.foregroundColor = AppColors.shadowHard,
    this.borderColor = AppColors.shadowHard,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: neoShadow(x: 2, y: 2, color: borderColor),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: foregroundColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
