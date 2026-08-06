import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/neo_badge.dart';
import '../../core/widgets/neo_card.dart';
import '../../models/confirmation_question.dart';
import 'confirmation_scale.dart';

/// Question card for the Yes / Somewhat / No confirmation questions used by
/// single-program departments.
class ConfirmationCard extends StatelessWidget {
  const ConfirmationCard({
    super.key,
    required this.displayIndex,
    required this.question,
    required this.value,
    required this.onSelect,
  });

  final int displayIndex;
  final ConfirmationQuestion question;

  /// -1 = unanswered, 0 = No, 1 = Somewhat, 2 = Yes.
  final int value;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 768),
        child: NeoCard(
          shadowX: 5,
          shadowY: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Question ',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text: '#$displayIndex',
                            style: const TextStyle(
                              color: AppColors.brandPrimary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const NeoBadge(label: 'Confirmation'),
                ],
              ),
              const SizedBox(height: 10),
              Container(height: 2, color: AppColors.bgMain),
              const SizedBox(height: 14),
              Text(
                question.question,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: MediaQuery.sizeOf(context).width >= 768 ? 18 : 16,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 20),
              ConfirmationScale(value: value, onSelect: onSelect),
            ],
          ),
        ),
      ),
    );
  }
}
