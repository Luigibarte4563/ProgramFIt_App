import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import '../core/widgets/neo_button.dart';
import '../core/widgets/neo_card.dart';
import '../data/departments.dart';
import '../models/department.dart';
import '../services/assessment_service.dart';
import 'widgets/neo_dialog.dart';

/// Dashboard / landing view, migrated from `Home.tsx`.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _busy = false;

  Future<void> _handleStartAssessment() async {
    setState(() => _busy = true);
    try {
      final complete = await AssessmentService.isAssessmentComplete();
      if (!mounted) return;
      if (!complete) {
        context.go('/assessment');
        return;
      }
      _showCompletedModal();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showCompletedModal() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => NeoDialog(
        title: 'Assessment Completed',
        message: 'You have already completed your career assessment. Would '
            'you like to retake it and overwrite your old responses, or '
            'simply review your current recommendations?',
        actions: [
          NeoButton(
            label: 'Cancel',
            variant: NeoButtonVariant.white,
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          NeoButton(
            label: 'View Results',
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.go('/results');
            },
          ),
          NeoButton(
            label: 'Retake Assessment',
            variant: NeoButtonVariant.danger,
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              setState(() => _busy = true);
              try {
                await AssessmentService.resetAssessment();
                if (mounted) context.go('/assessment');
              } catch (e) {
                debugPrint('Failed to reset assessment: $e');
              } finally {
                if (mounted) setState(() => _busy = false);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHero(),
          _buildAbout(),
          _buildPrograms(),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: NeoCard(
              shadowX: 8,
              shadowY: 8,
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  const _BrandTile(size: 112),
                  const SizedBox(height: 24),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome to ',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'ProgramFit',
                          style: TextStyle(
                            color: AppColors.brandPrimary,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Discover which university program best matches your '
                    'interests through our Career Assessment System.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  NeoButton(
                    label: 'Start Assessment',
                    onPressed: _busy ? null : _handleStartAssessment,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAbout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: NeoCard(
              shadowX: 6,
              shadowY: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About the Assessment',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(height: 2, color: AppColors.bgMain),
                  const SizedBox(height: 16),
                  const Text(
                    'This assessment helps identify your interests across '
                    'different academic fields. Based on your responses, the '
                    'system calculates your strengths and recommends the '
                    'university programs that best match your profile.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      height: 1.5,
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

  Widget _buildPrograms() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Available Programs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 1024
                      ? 3
                      : constraints.maxWidth >= 768
                          ? 2
                          : 1;
                  const spacing = 20.0;
                  final cardWidth =
                      (constraints.maxWidth - spacing * (columns - 1)) /
                          columns;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (final school in departments)
                        SizedBox(
                          width: cardWidth,
                          child: _SchoolCard(department: school),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Rounded brand tile (a generic logo mark), used in the hero instead of a
/// user avatar since the app has no accounts.
class _BrandTile extends StatelessWidget {
  const _BrandTile({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.brandPrimary,
        borderRadius: BorderRadius.circular(size * 0.28),
        border: Border.all(color: AppColors.shadowHard, width: 2),
        boxShadow: neoShadow(x: 4, y: 4),
      ),
      child: Text(
        'PF',
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.4,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _SchoolCard extends StatelessWidget {
  const _SchoolCard({required this.department});

  final Department department;

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      shadowX: 6,
      shadowY: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            department.name,
            style: const TextStyle(
              color: AppColors.brandPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Container(height: 2, color: AppColors.bgMain),
          const SizedBox(height: 12),
          for (final program in programsForDepartment(department.code))
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text(
                      '•',
                      style: TextStyle(
                        color: AppColors.brandPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      program.name,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
