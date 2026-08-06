import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import '../core/widgets/neo_badge.dart';
import '../core/widgets/neo_button.dart';
import '../core/widgets/neo_card.dart';
import '../models/assessment_outcome.dart';
import '../services/assessment_service.dart';
import 'widgets/neo_dialog.dart';
import 'widgets/result_card.dart';

/// Recommendation view for the two-phase assessment engine.
class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late Future<AssessmentOutcome?> _future;

  @override
  void initState() {
    super.initState();
    _future = AssessmentService.loadOutcome();
  }

  Future<void> _handleConfirmRetake() async {
    try {
      await AssessmentService.resetAssessment();
      if (mounted) context.go('/assessment');
    } catch (e) {
      debugPrint('Failed to reset assessment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AssessmentOutcome?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _LoadingState();
        }

        final outcome = snapshot.data;
        if (outcome == null) {
          return const _EmptyState();
        }

        return _buildContent(outcome);
      },
    );
  }

  Widget _buildContent(AssessmentOutcome outcome) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 768),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHero(outcome),
              const SizedBox(height: 8),
              for (final rec in outcome.recommendations)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: _buildRecommendation(outcome, rec),
                ),
              const SizedBox(height: 8),
              _buildDepartmentBreakdown(outcome),
              const SizedBox(height: 24),
              Center(
                child: NeoButton(
                  label: 'Retake Assessment',
                  variant: NeoButtonVariant.danger,
                  onPressed: () => _showRetakeModal(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(AssessmentOutcome outcome) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: NeoCard(
        shadowX: 8,
        shadowY: 8,
        child: Column(
          children: [
            const Text(
              'Your Recommended Programs',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Based on your assessment responses, these programs best '
              'match your interests and strengths.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Container(height: 2, color: AppColors.bgMain),
            const SizedBox(height: 16),
            const Text(
              'TOP DEPARTMENT',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              outcome.topDepartment.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.brandPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              outcome.topDepartment.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendation(
    AssessmentOutcome outcome,
    Recommendation rec,
  ) {
    final badge = rec.fitLevel?.label.toUpperCase();
    final departmentName = rec.sourceDepartment?.name;

    return ResultCard(
      rank: rec.rank,
      programName: rec.program.name,
      departmentName:
          departmentName == null ? null : 'From $departmentName',
      scoreLabel: rec.scoreLabel,
      basis: rec.basis,
      badge: badge,
    );
  }

  Widget _buildDepartmentBreakdown(AssessmentOutcome outcome) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: NeoCard(
        shadowX: 6,
        shadowY: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Department Score Breakdown',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Container(height: 2, color: AppColors.bgMain),
            const SizedBox(height: 16),
            for (final score in outcome.departmentScores)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 28,
                      child: Text(
                        '$score.rank',
                        style: const TextStyle(
                          color: AppColors.brandPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        score.department.name,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    NeoBadge(label: '${score.score} / 7'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showRetakeModal() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => NeoDialog(
        title: 'Retake Assessment?',
        message: 'Are you sure you want to retake the assessment? Your '
            'current answers and recommendations will be permanently removed.',
        actions: [
          NeoButton(
            label: 'Cancel',
            variant: NeoButtonVariant.white,
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          NeoButton(
            label: 'Yes, Reset and Retake',
            variant: NeoButtonVariant.danger,
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _handleConfirmRetake();
            },
          ),
        ],
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: NeoCard(
          shadowX: 6,
          shadowY: 6,
          child: const Text(
            'Loading your recommendations...',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: NeoCard(
          shadowX: 8,
          shadowY: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'No Results Found',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please complete the career assessment first so we can map '
                'out your recommendations.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              NeoButton(
                label: 'Start Assessment',
                onPressed: () => context.go('/assessment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
