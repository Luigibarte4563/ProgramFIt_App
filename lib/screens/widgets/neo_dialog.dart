import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/neo_card.dart';

/// A neo-brutalist modal dialog with a hard offset shadow.
class NeoDialog extends StatelessWidget {
  const NeoDialog({
    super.key,
    required this.title,
    required this.message,
    required this.actions,
  });

  final String title;
  final String message;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 512),
          child: NeoCard(
            shadowX: 8,
            shadowY: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: actions,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
