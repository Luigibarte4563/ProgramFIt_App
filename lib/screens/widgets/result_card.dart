import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/neo_badge.dart';
import '../../core/widgets/neo_card.dart';

/// A single Top-3 recommendation card.
class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required this.rank,
    required this.programName,
    this.departmentName,
    required this.scoreLabel,
    this.basis,
    this.badge,
  });

  final int rank;
  final String programName;
  final String? departmentName;

  /// Score text shown in the header chip (e.g. "5 / 8" or "16 / 16").
  final String scoreLabel;

  /// Explanation of how this recommendation was chosen.
  final String? basis;

  /// Optional tag (e.g. "STRONG FIT") shown in the header.
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      shadowX: 6,
      shadowY: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '#$rank  ',
                        style: const TextStyle(
                          color: AppColors.brandPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: programName,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.brandPrimary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.shadowHard, width: 2),
                  boxShadow: neoShadow(x: 2, y: 2),
                ),
                child: Text(
                  scoreLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          if (badge != null) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: NeoBadge(
                label: badge!,
                backgroundColor: AppColors.brandPrimary,
                foregroundColor: Colors.white,
                borderColor: AppColors.shadowHard,
              ),
            ),
          ],
          if (departmentName != null || (basis != null && basis!.isNotEmpty)) ...[
            const SizedBox(height: 16),
            Container(height: 2, color: AppColors.bgMain),
            const SizedBox(height: 12),
            if (departmentName != null) ...[
              Text(
                departmentName!,
                style: const TextStyle(
                  color: AppColors.brandPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
            ],
            if (basis != null && basis!.isNotEmpty)
              Text(
                basis!,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
