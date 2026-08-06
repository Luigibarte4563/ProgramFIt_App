import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum NeoButtonVariant { primary, white, danger, success, dark }

/// A thick-bordered button with a hard offset shadow, mirroring the
/// Tailwind neo-brutalist button classes.
class NeoButton extends StatelessWidget {
  const NeoButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = NeoButtonVariant.primary,
    this.radius = 12,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final NeoButtonVariant variant;
  final double radius;
  final Widget? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;

    final (Color background, Color foreground, Color border) = switch (variant) {
      NeoButtonVariant.primary => (
          AppColors.brandPrimary,
          Colors.white,
          AppColors.shadowHard,
        ),
      NeoButtonVariant.white => (
          AppColors.bgCard,
          AppColors.textSecondary,
          AppColors.borderUi,
        ),
      NeoButtonVariant.danger => (
          AppColors.danger,
          Colors.white,
          AppColors.shadowHard,
        ),
      NeoButtonVariant.success => (
          AppColors.success,
          Colors.white,
          AppColors.shadowHard,
        ),
      NeoButtonVariant.dark => (
          AppColors.shadowHard,
          Colors.white,
          AppColors.shadowHard,
        ),
    };

    final Color effectiveBackground = enabled
        ? background
        : switch (variant) {
            NeoButtonVariant.primary => Colors.grey.shade300,
            NeoButtonVariant.success => Colors.grey.shade300,
            NeoButtonVariant.white => Colors.grey.shade200,
            _ => background,
          };
    final Color effectiveForeground = enabled
        ? foreground
        : Colors.grey.shade500;
    final Color effectiveBorder = enabled
        ? border
        : Colors.grey.shade400;

    return Opacity(
      opacity: enabled ? 1 : 0.7,
      child: Container(
        decoration: BoxDecoration(
          color: effectiveBackground,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: effectiveBorder, width: 2),
          boxShadow: enabled
              ? neoShadow(x: 4, y: 4, color: AppColors.shadowHard)
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(radius),
            onTap: enabled ? onPressed : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
              child: Row(
                mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 10),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      color: effectiveForeground,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
