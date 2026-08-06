import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A white, thick-bordered card with a hard offset shadow — the core building
/// block of the Soft Neo-Brutalist design system.
class NeoCard extends StatelessWidget {
  const NeoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.color = AppColors.bgCard,
    this.borderColor = AppColors.borderUi,
    this.borderWidth = 2,
    this.radius = 16,
    this.shadowX = 6,
    this.shadowY = 6,
    this.shadowColor = AppColors.shadowHard,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final double shadowX;
  final double shadowY;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: neoShadow(x: shadowX, y: shadowY, color: shadowColor),
      ),
      child: child,
    );
  }
}
