import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/neo_badge.dart';
import '../../core/widgets/neo_card.dart';
import '../../models/assessment_question.dart';
import 'option_scale.dart';

/// Question card with a lettered option list (Phase 1 and Phase 2).
class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.displayIndex,
    this.badge,
    required this.question,
    required this.selectedIndex,
    required this.onSelect,
  });

  final int displayIndex;

  /// Small tag shown next to "Question #n" (e.g. "Phase 1" or the department).
  final String? badge;

  final AssessmentQuestion question;
  final int selectedIndex;
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
                  if (badge != null && badge!.isNotEmpty)
                    NeoBadge(label: badge!),
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
              OptionScale(
                options: question.options,
                selectedIndex: selectedIndex,
                onSelect: onSelect,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
