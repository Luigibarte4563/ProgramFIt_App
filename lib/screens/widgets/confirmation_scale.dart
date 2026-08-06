import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Yes / Somewhat / No picker used by the confirmation questions for
/// single-program departments (Nursing / Criminology).
///
/// Point key: Yes = 2 | Somewhat = 1 | No = 0.
class ConfirmationScale extends StatelessWidget {
  const ConfirmationScale({
    super.key,
    required this.value,
    required this.onSelect,
  });

  /// -1 = unanswered, 0 = No, 1 = Somewhat, 2 = Yes.
  final int value;
  final ValueChanged<int> onSelect;

  static const _options = [
    (label: 'Yes', points: '2 pts', value: 2),
    (label: 'Somewhat', points: '1 pt', value: 1),
    (label: 'No', points: '0 pts', value: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final option in _options) ...[
          if (option != _options.first) const SizedBox(height: 10),
          _ConfirmationTile(
            label: option.label,
            points: option.points,
            selected: value == option.value,
            onTap: () => onSelect(option.value),
          ),
        ],
        const SizedBox(height: 14),
        const Text(
          'Point key: Yes = 2 pts  ·  Somewhat = 1 pt  ·  No = 0 pts',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ConfirmationTile extends StatelessWidget {
  const _ConfirmationTile({
    required this.label,
    required this.points,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String points;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: selected ? AppColors.brandPrimary : AppColors.bgCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.shadowHard : AppColors.borderUi,
              width: 2,
            ),
            boxShadow: neoShadow(x: 2, y: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? AppColors.bgCard : AppColors.borderUi,
                    width: 2,
                  ),
                ),
                child: selected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: selected ? Colors.white : AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                points,
                style: TextStyle(
                  color:
                      selected ? Colors.white : AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
